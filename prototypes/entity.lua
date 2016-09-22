data:extend({
  {
    type = "container",
    name = "coffee-plantation",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_plantation.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "coffee-plantation"},
    max_health = 150,
    corpse = "medium-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    inventory_size = 1,
    energy_source =
    {
      type = "electric",
      -- will produce this much * energy pollution units per tick
      emissions = 0.04,
      usage_priority = "secondary-input"
    },
    render_layer = "object",
    picture = 
    {
      filename = "__PreciousPreciousCaffeine__/graphics/coffee_plantation.png",
      width = 208,
      height = 115,
      shift = {1.35, 0.0}
    },
    energy_usage = "10kW",
    module_specification =
    {
      module_slots = 2
    }
  }
})