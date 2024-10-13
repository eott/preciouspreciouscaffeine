-------------------------------------------------------------------------------
-- Control logic for the workings of the coffee and caffeine items

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

-- Entries in the global table, which is available outside the local scope and,
-- which is most important, is serialized in the save data
global.caffeine_level = {} -- Holds the current caffeine level
global.rebuild_gui = false -- Holds the status if the gui needs rebuilding (usually after a load)

-------------------------------------------------------------------------------
-- Is called in each tick and handles the caffeine level update
function onTick()
    for i, player in pairs(game.players) do
        if (player.connected and player.character ~= nil) then
            updateCaffeineLevel(player)
        end
    end
end

-------------------------------------------------------------------------------
-- Adds the speed buff to the given player
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

-------------------------------------------------------------------------------
-- Removes the speed buff from the given player
function removeBuff(player)
    if game.active_mods['death_curses'] then
        -- the Death Curses mod sets the reduced and restored modifiers to fixed
        -- values, thus we can max it with -1 here without having an accumu-
        -- lating effect due to the difference in adding and subtracting
        player.character_crafting_speed_modifier = math.max(
            -1.0,
            player.character_crafting_speed_modifier
            - buffed_crafting_speed_modifier
        )
        player.character_running_speed_modifier = math.max(
            -1.0,
            player.character_running_speed_modifier
            - buffed_running_speed_modifier
        )
    else
        player.character_crafting_speed_modifier = (
            player.character_crafting_speed_modifier
            - buffed_crafting_speed_modifier
        )
        player.character_running_speed_modifier = (
            player.character_running_speed_modifier
            - buffed_running_speed_modifier
        )
    end
end

-------------------------------------------------------------------------------
-- Checks if the given player has an auto injector equipment in any of their
-- equipped armors
function hasAutoInjector(player)
    local armor_slots = player.get_inventory(defines.inventory.character_armor)
    for i = 1, #armor_slots do

        local armor = armor_slots[i]
        if (armor ~= nil and armor.valid_for_read and armor.grid ~= nil and armor.grid.valid) then

            for i, eq in pairs(armor.grid.equipment) do
                if (eq.name == "auto-injector-equipment") then
                    return true
                end
            end
        end
    end

    return false
end

-------------------------------------------------------------------------------
-- Update the caffeine level for the given player, check if the auto injector
-- needs to be activated and do so if that is the case
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

        -- When the level falls below zero (but was positive before), remove
        -- the buff and clamp the level to zero
        if (old_level > 0.0 and new_level <= 0.0) then
            global.caffeine_level[player.index] = 0.0
            removeBuff(player)
        end

        -- Check if the autoinjector needs to be activated
        -- To avoid the display flickering between values, we update just before
        -- the level sinks below that of one item of caffeine missing
        if (
            hasAutoInjector(player)
            and global.caffeine_level[player.index] < (
                100 - caffeine_per_item["caffeine"] + decomposition_rate * 2
            )
        ) then
            tryConsume(player, true)
        end

        updateGUI(player)
    end
end

-------------------------------------------------------------------------------
-- Initialize the caffeine level for the given player as zero and add the buff
-- to them. This is necessary because otherwise the buff would be removed in
-- the first tick, but none was added yet, hence a debuff occurs.
function initCaffeineLevel(player)
    if (global.caffeine_level[player.index] == nil) then
        global.caffeine_level[player.index] = 0
        addBuff(player)
    end
end

-------------------------------------------------------------------------------
-- Initialize global collections (used for the onTick method) and register the
-- onTick handler for the first time (has to be done on every load afterwards)
function onInit()
    for i, player in pairs(game.players) do
        initCaffeineLevel(player)
    end

    script.on_event(defines.events.on_tick, onTick)
end
script.on_init(onInit)

-------------------------------------------------------------------------------
-- Register the onTick handler with the tick game event
function onLoad()
    script.on_event(defines.events.on_tick, onTick)
end
script.on_load(onLoad)

-------------------------------------------------------------------------------
-- Shows the GUI for the caffeine level, if it does not exist already. If the
-- global table entry rebuild_gui is set, destroys and rebuilds the GUI. This
-- is necessary because some research changes the icon for the button
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
end

-------------------------------------------------------------------------------
-- Updates the GUI for the caffeine level of the given player
function updateGUI(player)
    showGUI(player)
    if player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.caffeineLevelLabel.caption = string.format("%d %s",  math.ceil(global.caffeine_level[player.index]), "%")
    end
end

-------------------------------------------------------------------------------
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
-- Tries to consume as many of the given item as necessary to raise the
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

-------------------------------------------------------------------------------
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
