data:extend({
  {
    type = "assembling-machine",
    name = "coffee-plantation",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_plantation.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "coffee-plantation"},
    crafting_categories = {"plantation"},
    crafting_speed = 1,
    max_health = 150,
    corpse = "medium-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source =
    {
      type = "electric",
      -- will produce this much * energy pollution units per tick
      emissions = 0.04,
      usage_priority = "secondary-input"
    },
    render_layer = "object",
    energy_usage = "10kW",
    module_specification = {
      module_slots = 0
    },
    animation = {
      layers = {
        {
          filename = "__PreciousPreciousCaffeine__/graphics/coffee_plantation.png",
          priority = "high",
          width = 208,
          height = 115,
          frame_count = 1,
          line_length = 1,
          shift = {1.35, 0.0},
          animation_speed = 0.1,
        },
      },
    },
  },
})