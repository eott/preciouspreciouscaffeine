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
    name = "cryo-shipment",
    icon = "__PreciousPreciousCaffeine__/graphics/cryo-shipment.png",
    icon_size = 32,
    flags = {},
    subgroup = "coffee-intermediates",
    stack_size= 1,
    rocket_launch_product = {
      name = "aaa-tank-shell",
      amount = 30,
    }
  },

  {
    type = "ammo",
    name = "aaa-tank-shell",
    icon = "__PreciousPreciousCaffeine__/graphics/aaa-tank-shell.png",
    icon_size = 32,
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
          projectile = "aaa-tank-shell-flying",
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
    order = "d[cannon-shell]-c[explosive]",
    stack_size = 200
  },
})