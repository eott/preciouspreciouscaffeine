---------------------------------------------------------
-- Constants, local to the scope
local decomposition_rate = 0.0625  -- Defines how quickly the caffeine
                                   -- level decreases (per tick)
local decomposition_timespan = 5 -- Defines how often (in ticks)
                                 -- the caffeine level is updated

-- Defines by how much the caffeine level is raised
-- for each consumable item
local caffeine_per_item = {}
caffeine_per_item["coffee-berries"] = 5
caffeine_per_item["mug-of-coffee"] = 25
caffeine_per_item["caffeine"] = 40

local buffed_running_speed_modifier = 0.4 -- Defines by how much the
                                          -- running speed is buffed (additional to 100%)
local buffed_crafting_speed_modifier = 0.8 -- Defines by how much the crafting
                                           -- speed is buffed (additional to 100%)

-- Variables, global to the global table provided by factorio for each mod
global.caffeine_level = {} -- Holds the current caffeine level
global.rebuild_gui = false -- Holds the status if the gui needs rebuilding (usually after a load)

---------------------------------------------------------
-- Is called in each tick and handles the caffeine level update
function onTick()
    for i, player in pairs(game.players) do
        if (player.connected and player.character ~= nil) then
            updateCaffeineLevel(player)
        end
    end
end

function addBuff(player)
    player.character_crafting_speed_modifier = (
        player.character_crafting_speed_modifier
        + buffed_crafting_speed_modifier
    )
    player.character_running_speed_modifier = (
        player.character_running_speed_modifier
        + buffed_running_speed_modifier
    )
end

function removeBuff(player)
    player.character_crafting_speed_modifier = (
        player.character_crafting_speed_modifier
        - buffed_crafting_speed_modifier
    )
    player.character_running_speed_modifier = (
        player.character_running_speed_modifier
        - buffed_running_speed_modifier
    )
end

function updateCaffeineLevel(player)
    initCaffeineLevel(player)

    -- Update caffeine level, but only every decomposition_timespan ticks
    if (game.tick % decomposition_timespan == 0) then
        local old_level = global.caffeine_level[player.index]
        global.caffeine_level[player.index] = math.max(0,
            global.caffeine_level[player.index]
            - decomposition_rate * decomposition_timespan
        )
        local new_level = global.caffeine_level[player.index]

        if (old_level > 0.0 and new_level <= 0.0) then
            global.caffeine_level[player.index] = 0.0
            removeBuff(player)
        end

        -- Check if the autoinjector needs to be activated
        -- To avoid the display flickering between values, we update just before
        -- the level sinks below that of one item of caffeine missing
        if (
            player.gui.left.ppcRoot
            and player.gui.left.ppcRoot.autoInjector
            and player.gui.left.ppcRoot.autoInjector.state
            and game.forces.player.technologies["ppc-auto-consumption"].researched
            and global.caffeine_level[player.index] < (
                100 - caffeine_per_item["caffeine"] + decomposition_rate * 2
            )
        ) then
            tryConsume(player, true)
        end

        updateGUI(player)
    end
end

function initCaffeineLevel(player)
    if (global.caffeine_level[player.index] == nil) then
        global.caffeine_level[player.index] = 0
        addBuff(player)
    end
end

---------------------------------------------------------
-- Initialize global collections (used for the onTick method)
-- and register the onTick handler for the first time (has to
-- be done on every load afterwards)
function onInit()
    for i, player in pairs(game.players) do
        initCaffeineLevel(player)
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
-- Shows the GUI for the caffeine level, if it does not
-- exist already
function showGUI(player)
    if global.rebuild_gui and player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.destroy()
        global.rebuild_gui = false
    end

    if (game.forces.player.technologies["ppc-coffee-production"].researched) then
        sprite = "item/mug-of-coffee"
    else
        sprite = "item/coffee-berries"
    end

    if player.gui.left.ppcRoot == nil then
        player.gui.left.add{type = "frame", name = "ppcRoot", direction = "horizontal"}
        player.gui.left.ppcRoot.add{type = "sprite-button", name = "drinkButton", sprite = sprite}
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
        tryConsume(player, false)
        updateGUI(player)
    end
end
script.on_event(defines.events.on_gui_click, onGUIClick)


-------------------------------------------------------------------------------
-- Tries to consume as many of the given item as necessary to raise
-- caffeine level back to 100, where partial multiples count as a full item.
-- E.g if the level is 75 and every mug gives 20, then it's still two full mugs
function consume(player, item_name)
    local nrToConsume = math.ceil(
        (100 - global.caffeine_level[player.index])
        / caffeine_per_item[item_name]
    )

    local inv = player.get_inventory(defines.inventory.character_main)
    local count = inv.get_item_count(item_name)

    if (count > 0 and nrToConsume > 0) then
        if (count >= nrToConsume) then
            inv.remove({name = item_name, count = nrToConsume})
            global.caffeine_level[player.index] = 100.0
            nrToConsume = 0

        elseif (count > 0) then
            inv.remove({name = item_name, count = count})
            nrToConsume = nrToConsume - count
            global.caffeine_level[player.index] = (
                global.caffeine_level[player.index]
                + count * caffeine_per_item[item_name]
            )
        end
    end
end

-------------------------------------------------------------------------------
-- Tries to consume as many caffeine-giving items as necessary to raise the
-- caffeine level back to 100, where partial multiples count as a full item.
-- E.g if the level is 75 and every mug gives 20, then it's still two full mugs
-- The function tries caffeine first, then mugs of coffee and finally berries
function tryConsume(player, auto_injector)
    local old_level = global.caffeine_level[player.index]

    consume(player, "caffeine")

    if (not auto_injector and global.caffeine_level[player.index] < 100.0) then
        consume(player, "mug-of-coffee")
    end

    if (not auto_injector and global.caffeine_level[player.index] < 100.0) then
        consume(player, "coffee-berries")
    end

    if (global.caffeine_level[player.index] > 0.0 and old_level <= 0.0) then
        addBuff(player)
    end
end

---------------------------------------------------------
-- Handles the custom hotkey for consuming coffee
function onHotkey(event)
    local player = game.players[event.player_index]

    tryConsume(player, false)
    updateGUI(player)
end
script.on_event("ppc-consume", onHotkey)

-------------------------------------------------------------------------------
-- Force rebuild the PPC GUI when a research is finished that unlocks a new
-- item with caffeine
function onResearchFinished(event)
    if (
        event.research.name == "ppc-auto-consumption"
        or event.research.name == "ppc-coffee-production"
    ) then
        global.rebuild_gui = true
    end
end
script.on_event(defines.events.on_research_finished, onResearchFinished)
