---------------------------------------------------------
-- Constants, local to the scope
local berry_plucking_timespan = 240 -- Defines how many ticks 
                                    -- pass for an update in the
                                    -- coffee plantation
local growth_amount = 1 -- Defines how many berries grow in one
                        -- cycle
local decomposition_rate = 0.1 -- Defines how quickly the caffeine
                               -- level decreases (per tick)
local decomposition_timespan = 10 -- Defines how often (in ticks)
                                  -- the caffeine level is updated
local level_per_mug = 20 -- Defines by how much the caffeine level
                         -- is raised for each mug
local buffed_speed_modifier = 0.5 -- Defines by how much the crafting
                                  -- speed is buffed (additional to 100%)

-- Variables, local to the scope
local caffeine_level = 0.0 -- Holds the current caffeine level
local initial_modifier = 0.0 -- Holds the initial crafting speed modifier
local autoinjector_enabled = nil -- Holds the status if the autoinjector is enabled

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

    -- The first time the caffeine level is zero (usually at game start), we save the
    -- initial modifier
    if (caffeine_level == 0.0) then
        initial_modifier = game.forces.player.manual_crafting_speed_modifier
    end

    -- Update caffeine level, but only every decomposition_timespan ticks
    if (game.tick % decomposition_timespan == 0) then
        if (caffeine_level > decomposition_rate * decomposition_timespan) then
            caffeine_level = caffeine_level - decomposition_rate * decomposition_timespan
            game.forces.player.manual_crafting_speed_modifier = initial_modifier + buffed_speed_modifier
        else
            caffeine_level = 0.0
            game.forces.player.manual_crafting_speed_modifier = initial_modifier
        end

        -- Check status of autoinjector if not read yet
        if (autoinjector_enabled == nil) then
            autoinjector_enabled = game.forces.player.technologies["ppc-auto-consumption"].researched
        end

        -- Check if the autoinjector needs to be activated
        local player = game.players[1]
        if (
            player.gui.left.ppcRoot
            and player.gui.left.ppcRoot.autoInjector
            and player.gui.left.ppcRoot.autoInjector.state
            and autoinjector_enabled
            and caffeine_level <= 81
        ) then
            tryConsume()
        end

        updateGUI()
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
    script.on_event(defines.events.on_tick, onTick)
end
script.on_init(onInit)

---------------------------------------------------------
-- Register the onTick handler with the tick game event
-- and initialize global collections if not done already
function onLoad()
    if not global.plantations then
        global.plantations = {}
    end
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
function showGUI()
    local player = game.players[1]
    if player.gui.left.ppcRoot == nil then
        player.gui.left.add{type = "frame", name = "ppcRoot", direction = "horizontal"}
        player.gui.left.ppcRoot.add{type = "sprite-button", name = "drinkButton", sprite = "item/mug-of-coffee"}
        player.gui.left.ppcRoot.add{type = "label", name = "caffeineLevelLabel", caption = "0%"}

        player.gui.left.ppcRoot.style.minimal_width = 100

        player.gui.left.ppcRoot.drinkButton.style.minimal_width = 32
        player.gui.left.ppcRoot.drinkButton.style.minimal_height = 32

        player.gui.left.ppcRoot.caffeineLevelLabel.style.top_padding = 5
    end

    if (autoinjector_enabled and player.gui.left.ppcRoot.autoInjector == nil) then
        player.gui.left.ppcRoot.add{type = "label", name = "autoInjectorLabel", caption = "Auto"}
        player.gui.left.ppcRoot.add{type = "checkbox", name = "autoInjector", state = false}
        player.gui.left.ppcRoot.autoInjectorLabel.style.top_padding = 5
        player.gui.left.ppcRoot.autoInjector.style.top_padding = 10
    end
end

---------------------------------------------------------
-- Updates the GUI for the caffeine level
function updateGUI()
    showGUI()

    local player = game.players[1]
    if player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.caffeineLevelLabel.caption = string.format("%d %s",  math.ceil(caffeine_level), "%")
    end
end

---------------------------------------------------------
-- Handles a click event on the GUI button for "drinking"
function onGUIClick(event)
    if (event.element.name == "drinkButton") then
        tryConsume()
        updateGUI()
    end
end
script.on_event(defines.events.on_gui_click, onGUIClick)


---------------------------------------------------------
-- Tries to consume as many mugs as necessary to raise the
-- caffeine level back to 100, where partial multiples
-- count as a full mug. E.g if the level is 85 and every
-- mug gives 20, then it's still two full mugs
function tryConsume()
    local nrToConsume = math.ceil((100 - caffeine_level) / level_per_mug)

    -- Check quickbar first
    local inv = game.players[1].get_inventory(defines.inventory.player_quickbar)
    local count = inv.get_item_count("mug-of-coffee")

    if (count > 0) then
        if (count >= nrToConsume) then
            inv.remove({name = "mug-of-coffee", count = nrToConsume})
            caffeine_level = 100.0
            nrToConsume = 0
        elseif (count > 0) then
            inv.remove({name = "mug-of-coffee", count = count})
            nrToConsume = nrToConsume - count
            caffeine_level = caffeine_level + count * level_per_mug
        end
    end

    -- Now check main inv
    local inv = game.players[1].get_inventory(defines.inventory.player_main)
    local count = inv.get_item_count("mug-of-coffee")

    if (count > 0 and nrToConsume > 0) then
        if (count >= nrToConsume) then
            inv.remove({name = "mug-of-coffee", count = nrToConsume})
            caffeine_level = 100.0
            nrToConsume = 0
        elseif (count > 0) then
            inv.remove({name = "mug-of-coffee", count = count})
            nrToConsume = nrToConsume - count
            caffeine_level = caffeine_level + count * level_per_mug
        end
    end
end

---------------------------------------------------------
-- Handles the custom hotkey for consuming coffee
function onHotkey(event)
    tryConsume()
    updateGUI()
end
script.on_event("ppc-consume", onHotkey)

---------------------------------------------------------
-- Handles the research finished event and employs custom
-- functionality for research effects, namely the auto
-- injector
function onResearchFinished(event)
    if (event.research.name == "ppc-auto-consumption") then
        autoinjector_enabled = true
    end

    showGUI()
end
script.on_event(defines.events.on_research_finished, onResearchFinished)