---------------------------------------------------------
-- Constants, local to the scope
local berry_plucking_timespan = 120 -- Defines how many ticks 
                                    -- pass for an update in the
                                    -- coffee plantation
local growth_amount = 1

---------------------------------------------------------
-- Is called in each tick and handles the "mining" process of berries
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