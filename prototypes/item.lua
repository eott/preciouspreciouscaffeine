data:extend({

  {
    type = "item",
    name = "coffee-plantation",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_plantation.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "extraction-machine",
    place_result="coffee-plantation",
    stack_size= 50,
  },

  {
    type = "item",
    name = "coffee-berries",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_berries.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "raw-material",
    stack_size= 200,
  },

  {
    type = "item",
    name = "coffee-beans",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_beans.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 200,
  },

  {
    type = "item",
    name = "roasted-coffee-beans",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_roasted_coffee_beans.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 200,
  },

  {
    type = "item",
    name = "coffee-powder",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_powder.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 50,
  },

  {
    type = "item",
    name = "mug-of-coffee",
    icon = "__PreciousPreciousCaffeine__/graphics/icon_mug_of_coffee.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 100,
  },

  {
    type = "item",
    name = "coffee-crate",
    icon = "__PreciousPreciousCaffeine__/graphics/coffee-crate.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 50,
  },

  {
    type = "item",
    name = "cryo-shipment",
    icon = "__PreciousPreciousCaffeine__/graphics/cryo-shipment.png",
    flags = { "goes-to-main-inventory" },
    subgroup = "intermediate-product",
    stack_size= 1,
  },

  {
    type = "ammo",
    name = "aaa-tank-shell",
    icon = "__PreciousPreciousCaffeine__/graphics/aaa-tank-shell.png",
    flags = {"goes-to-main-inventory"},
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