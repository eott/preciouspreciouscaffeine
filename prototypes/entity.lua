data:extend({
  {
    type = "assembling-machine",
    name = "coffee-plantation",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_plantation.png",
    icon_size = 128,
    icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "coffee-plantation"},
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
          filename = "__PreciousPreciousCaffeine__/graphics/entity_coffee_plantation.png",
          priority = "high",
          width = 463,
          height = 256,
          scale = 0.44921875,
          frame_count = 1,
          line_length = 1,
          shift = {1.35, 0.0},
          animation_speed = 0.1,
        },
      },
    },
  },

  {
    type = "simple-entity-with-owner",
    name = "golden-bean",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_golden_bean.png",
    icon_size = 64,
    icon_mipmaps = 1,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.5, result = "golden-bean"},
    max_health = 1000,
    corpse = "small-remnants",
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    render_layer = "object",
    animations = {
      layers = {
        {
          filename = "__PreciousPreciousCaffeine__/graphics/entity_golden_bean.png",
          priority = "high",
          width = 64,
          height = 115,
          scale = 1.0,
          frame_count = 1,
          line_length = 1,
          shift = {0.0, -0.5},
          animation_speed = 0.1,
        },
      },
    },
  },
})