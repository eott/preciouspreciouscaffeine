data:extend({
  {
    type = "item-subgroup",
    name = "plantation",
    group = "intermediate-products",
    order = "z-a-plantation"
  },

  {
    type = "item-subgroup",
    name = "coffee-intermediates",
    group = "intermediate-products",
    order = "z-b-coffee-intermediates"
  },
})

data:extend({
  {
    type = "item",
    name = "coffee-plantation",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_plantation.png",
    icon_size = 32,
    flags = {},
    subgroup = "extraction-machine",
    place_result="coffee-plantation",
    stack_size= 50,
  },

  {
    type = "item",
    name = "coffee-berries",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_berries.png",
    icon_size = 32,
    flags = {},
    subgroup = "plantation",
    stack_size= 200,
  },

  {
    type = "item",
    name = "bio-mass",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_bio_mass.png",
    icon_size = 32,
    flags = {},
    subgroup = "plantation",
    stack_size= 200,
  },

  {
    type = "item",
    name = "coffee-beans",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_beans.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 200,
  },

  {
    type = "item",
    name = "roasted-coffee-beans",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_roasted_coffee_beans.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 200,
  },

  {
    type = "item",
    name = "coffee-powder",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_powder.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 50,
  },

  {
    type = "item",
    name = "mug-of-coffee",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_mug_of_coffee.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 100,
  },

  {
    type = "item",
    name = "coffee-crate",
    icon = "__PreciousPreciousCaffeine__/graphics/coffee-crate.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 50,
  },

  {
    type = "item",
    name = "caffeine",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_caffeine.png",
    icon_size = 128,
    icon_mipmaps = 4,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 200,
  },

  {
    type = "item",
    name = "cryo-shipment",
    icon = "__PreciousPreciousCaffeine__/graphics/cryo-shipment.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 1,
    rocket_launch_product = {
      name = "3a-tank-shell",
      amount = 30,
    }
  },

  {
    type = "ammo",
    name = "3a-tank-shell",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_3a_tank_shell.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {},
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "3a-tank-shell-flying",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 50,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    subgroup = "ammo",
    order = "d[cannon-shell]-c[caffeine]",
    stack_size = 200
  },

  {
    type = "ammo",
    name = "3a-rocket",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_3a_rocket.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {},
    ammo_type =
    {
      category = "rocket",
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "3a-rocket-flying",
          starting_speed = 0.25,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 50,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
        }
      },
    },
    subgroup = "ammo",
    order = "d[rocket]-c[caffeine]",
    stack_size = 200
  },

  {
    type = "item",
    name = "auto-injector-item",
    icon = "__PreciousPreciousCaffeine__/graphics/equipment_auto_injector.png",
    icon_size = 128,
    icon_mipmaps = 1,
    flags = {},
    subgroup = "equipment",
    stack_size= 1,
    placed_as_equipment_result = "auto-injector-equipment"
  },

  {
    type = "movement-bonus-equipment",
    name = "auto-injector-equipment",
    categories = {"armor"},
    energy_consumption = "50W",
    movement_bonus = 0,
    energy_source = {
      type = "electric",
      buffer_capacity = "500J",
      usage_priority = "secondary-input",
      input_flow_limit = "100W",
      output_flow_limit = "100W",
      drain = "50W",
    },
    shape = {
      type = "full",
      width = 1,
      height = 1,
    },
    sprite = {
      filename = "__PreciousPreciousCaffeine__/graphics/equipment_auto_injector.png",
      size = 128,
    },
    take_result = "auto-injector-item"
  },
})