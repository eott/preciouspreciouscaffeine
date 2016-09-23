---------------------------------------------------------
-- Constants, local to the scope
local berry_plucking_timespan = 120 -- Defines how many ticks 
                                    -- pass for an update in the
                                    -- coffee plantation
local growth_amount = 1 -- Defines how many berries grow in one
                        -- cycle
local decomposition_rate = 0.1 -- Defines how quickly the caffeine
                               -- level decreases (per tick)
local decomposition_timespan = 10 -- Defines how often (in ticks)
                                  -- the caffeine level is updated

-- Variables, local to the scope
local caffeine_level = 0.0 -- Holds the current caffeine level

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

    -- Update caffeine level, but only every decomposition_timespan ticks
    if (game.tick % decomposition_timespan == 0) then
        if (caffeine_level > decomposition_rate * decomposition_timespan) then
            caffeine_level = caffeine_level - decomposition_rate * decomposition_timespan
        else
            caffeine_level = 0.0
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
        player.gui.left.add{type = "frame", name = "ppcRoot", direction = "vertical"}
        player.gui.left.ppcRoot.add{type = "label", name = "caffeineLevelLabel", caption = "0%"}
    end
end

-- Updates the GUI for the caffeine level
function updateGUI()
    showGUI()

    local player = game.players[1]
    if player.gui.left.ppcRoot ~= nil then
        player.gui.left.ppcRoot.caffeineLevelLabel.caption = string.format("%d %s",  math.ceil(caffeine_level), "%")
    end
end
