---------------------------------------------------------
-- Constants, local to the scope
local berry_plucking_timespan = 240 -- Defines how many ticks
                                    -- pass for an update in the
                                    -- coffee plantation
local growth_amount = 1 -- Defines how many berries grow in one
                        -- cycle
local decomposition_rate = 0.025  -- Defines how quickly the caffeine
                                  -- level decreases (per tick)
local decomposition_timespan = 5 -- Defines how often (in ticks)
                                 -- the caffeine level is updated
local level_per_mug = 5 -- Defines by how much the caffeine level
                        -- is raised for each mug
local buffed_running_speed_modifier = 0.4 -- Defines by how much the
                                          -- running speed is buffed (additional to 100%)
local buffed_crafting_speed_modifier = 0.8 -- Defines by how much the crafting
                                           -- speed is buffed (additional to 100%)

-- Variables, global to the global table provided by factorio for each mod
global.caffeine_level = {} -- Holds the current caffeine level
global.initial_crafting_speed_modifier = 0.0 -- Holds the initial crafting speed modifier
global.initial_running_speed_modifier = 0.0 -- Holds the initial running speed modifier
global.rebuild_gui = false -- Holds the status if the gui needs rebuilding (usually after a load)

---------------------------------------------------------
-- Is called in each tick and handles the "mining" process of berries
-- as well as the caffeine level update
function onTick()
    -- Check if the necessary timespan has passed
    if (game.tick % berry_plucking_timespan == 0) then
        -- Iterate over the saved entity references and update each
        for index, plantation in pairs(global.plantations) do
            if plantation and plantation.valid then
                local inventory = plantation.get_inventory(defines.inventory.item_main)
                inventory.insert({name = "coffee-berries", count = growth_amount})
            else
                table.remove(global.plantations, index)
            end
        end
    end

    for i, player in pairs(game.players) do
        if (player.connected and player.character ~= nil) then
            updateCaffeineLevel(player)
        end
    end
end

function updateCaffeineLevel(player)
    if (global.caffeine_level[player.index] == nil) then
        global.caffeine_level[player.index] = 0.0
    end

    -- The first time the caffeine level is zero (usually during game start) we
    -- save the speed modifiers as their base level
    -- @todo Figure out if this breaks in conjunction with other mods that
    -- change the speed modifiers. For this mod alone it's fine
    -- @todo Figure out if this breaks when player join with different caffeine
    -- levels, so they overwrite the initial modifiers. Maybe a per-player approach?
    if (global.caffeine_level[player.index] == 0.0) then
        global.initial_crafting_speed_modifier = player.character_crafting_speed_modifier
        global.initial_running_speed_modifier = player.character_running_speed_modifier
    end


    -- Update caffeine level, but only every decomposition_timespan ticks
    if (game.tick % decomposition_timespan == 0) then
        if (global.caffeine_level[player.index] > decomposition_rate * decomposition_timespan) then
            global.caffeine_level[player.index] = global.caffeine_level[player.index] - decomposition_rate * decomposition_timespan

            player.character_crafting_speed_modifier = global.initial_crafting_speed_modifier + buffed_crafting_speed_modifier
            player.character_running_speed_modifier = global.initial_running_speed_modifier + buffed_running_speed_modifier
        else
            global.caffeine_level[player.index] = 0.0
            player.character_crafting_speed_modifier = global.initial_crafting_speed_modifier
            player.character_running_speed_modifier = global.initial_running_speed_modifier
        end

        -- Check if the autoinjector needs to be activated
        -- To avoid the display flickering between values, we update just before
        -- the level sinks below that of one full cup missing
        if (
            player.gui.left.ppcRoot
            and player.gui.left.ppcRoot.autoInjector
            and player.gui.left.ppcRoot.autoInjector.state
            and game.forces.player.technologies["ppc-auto-consumption"].researched
            and global.caffeine_level[player.index] < (100 - level_per_mug + decomposition_rate * 2)
        ) then
            tryConsume(player)
        end

        updateGUI(player)
    end
end



---------------------------------------------------------
-- Initialize global collections (used for the onTick method)
-- and register the onTick handler for the first time (has to
-- be done on every load afterwards)
function onInit()
    if not global.plantations then
        global.plantations = {}
    end

    for i, player in pairs(game.players) do
        global.caffeine_level[player.index] = 0.0
    end

    script.on_event(defines.events.on_tick, onTick)
end
script.on_init(onInit)

---------------------------------------------------------
-- Register the onTick handler with the tick game event
function onLoad()
    script.on_event(defines.events.on_tick, onTick)
end
script.on_load(onLoad)


---------------------------------------------------------
-- Register the buildEntity handler with the built_entity and
-- robot_built_entity game events.
-- Checks if a plantation was built and if so, saves a reference
-- in the global collection so it can be handled in the onTick
-- method.
function builtEntity(event)
    local ent = event.created_entity
    local name = ent.name
    if name == "coffee-plantation" then
        table.insert(global.plantations, ent)
    end
end
script.on_event(defines.events.on_built_entity, builtEntity)
script.on_event(defines.events.on_robot_built_entity, builtEntity)

---------------------------------------------------------
-- Shows the GUI for the caffeine level, if it does not
-- exist already
function showGUI(player)
    if global.rebuild_gui and player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.destroy()
        global.rebuild_gui = false
    end

    if player.gui.left.ppcRoot == nil then
        player.gui.left.add{type = "frame", name = "ppcRoot", direction = "horizontal"}
        player.gui.left.ppcRoot.add{type = "sprite-button", name = "drinkButton", sprite = "item/mug-of-coffee"}
        player.gui.left.ppcRoot.add{type = "label", name = "caffeineLevelLabel", caption = "0%"}

        player.gui.left.ppcRoot.style.minimal_width = 100

        player.gui.left.ppcRoot.drinkButton.style.minimal_width = 32
        player.gui.left.ppcRoot.drinkButton.style.minimal_height = 32

        player.gui.left.ppcRoot.caffeineLevelLabel.style.top_padding = 5
        player.gui.left.ppcRoot.caffeineLevelLabel.style.minimal_width = 35
    end

    if (
        game.forces.player.technologies["ppc-auto-consumption"].researched
        and player.gui.left.ppcRoot.autoInjector == nil
    ) then
        player.gui.left.ppcRoot.add{type = "label", name = "autoInjectorLabel", caption = "Auto"}
        player.gui.left.ppcRoot.add{type = "checkbox", name = "autoInjector", state = false}
        player.gui.left.ppcRoot.autoInjectorLabel.style.top_padding = 5
        player.gui.left.ppcRoot.autoInjector.style.top_padding = 10
        player.gui.left.ppcRoot.style.minimal_width = 160
    end
end

---------------------------------------------------------
-- Updates the GUI for the caffeine level
function updateGUI(player)
    showGUI(player)
    if player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.caffeineLevelLabel.caption = string.format("%d %s",  math.ceil(global.caffeine_level[player.index]), "%")
    end
end

---------------------------------------------------------
-- Handles a click event on the GUI button for "drinking"
function onGUIClick(event)
    local player = game.players[event.player_index]
    if (event.element.name == "drinkButton") then
        tryConsume(player)
        updateGUI(player)
    end
end
script.on_event(defines.events.on_gui_click, onGUIClick)


---------------------------------------------------------
-- Tries to consume as many mugs as necessary to raise the
-- caffeine level back to 100, where partial multiples
-- count as a full mug. E.g if the level is 85 and every
-- mug gives 20, then it's still two full mugs
function tryConsume(player)
    local nrToConsume = math.ceil((100 - global.caffeine_level[player.index]) / level_per_mug)

    -- Now check main inv
    local inv = player.get_inventory(defines.inventory.character_main)
    local count = inv.get_item_count("mug-of-coffee")

    if (count > 0 and nrToConsume > 0) then
        if (count >= nrToConsume) then
            inv.remove({name = "mug-of-coffee", count = nrToConsume})
            global.caffeine_level[player.index] = 100.0
            nrToConsume = 0
        elseif (count > 0) then
            inv.remove({name = "mug-of-coffee", count = count})
            nrToConsume = nrToConsume - count
            global.caffeine_level[player.index] = global.caffeine_level[player.index] + count * level_per_mug
        end
    end
end

---------------------------------------------------------
-- Handles the custom hotkey for consuming coffee
function onHotkey(event)
    local player = game.players[event.player_index]

    tryConsume(player)
    updateGUI(player)
end
script.on_event("ppc-consume", onHotkey)

-------------------------------------------------------------------------------
-- Force rebuild the PPC GUI when the auto injector research is finished
function onResearchFinished(event)
    if (event.research.name == "ppc-auto-consumption") then
        global.rebuild_gui = true
    end
end
script.on_event(defines.events.on_research_finished, onResearchFinished)
