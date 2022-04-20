data:extend({
  {
    type = "technology",
    name = "ppc-coffee-plantations",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_coffee_plantations.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "coffee-plantation"
      },
      {
        type = "unlock-recipe",
        recipe = "coffee-berries"
      },
      {
        type = "unlock-recipe",
        recipe = "wood-growth"
      },
      {
        type = "unlock-recipe",
        recipe = "bio-mass-from-berries"
      },
      {
        type = "unlock-recipe",
        recipe = "bio-mass-from-wood"
      },
    },
    prerequisites = {},
    unit =
    {
      count = 10,
      ingredients =
      {
        {"automation-science-pack", 1},
      },
      time = 20
    }
  },

  {
    type = "technology",
    name = "ppc-improved-fertilizer",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_improved_fertilizer.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "wood-growth-2"
      },
      {
        type = "unlock-recipe",
        recipe = "bio-mass-from-mixed"
      },
    },
    prerequisites = {
      "ppc-coffee-plantations",
      "chemical-science-pack",
    },
    unit =
    {
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 2},
        {"logistics-science-pack", 1},
        {"chemical-science-pack", 2},
      },
      time = 15
    }
  },

  {
    type = "technology",
    name = "ppc-coffee-production",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_coffee_production.png",
    icon_size = 128,
    effects =
    {
      {
          type = "unlock-recipe",
          recipe = "coffee-beans"
      },
      {
          type = "unlock-recipe",
          recipe = "roasted-coffee-beans"
      },
      {
          type = "unlock-recipe",
          recipe = "coffee-powder"
      },
      {
          type = "unlock-recipe",
          recipe = "coffee-brewing"
      },
      {
          type = "unlock-recipe",
          recipe = "mug-of-coffee"
      },
    },
    prerequisites = {
      "automation-2",
      "ppc-coffee-plantations",
    },
    unit =
    {
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 20
    }
  },

  {
    type = "technology",
    name = "ppc-caffeine-extraction",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_caffeine_extraction.png",
    icon_size = 128,
    effects =
    {
      {
          type = "unlock-recipe",
          recipe = "air-compression"
      },
      {
          type = "unlock-recipe",
          recipe = "co2-from-air"
      },
      {
          type = "unlock-recipe",
          recipe = "co2-from-coal"
      },
      {
          type = "unlock-recipe",
          recipe = "caffeine-extraction"
      },
    },
    prerequisites = {
      "chemical-science-pack",
      "ppc-coffee-production",
    },
    unit =
    {
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 3},
      },
      time = 30
    }
  },

  {
    type = "technology",
    name = "ppc-interstellar-coffee",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_interstellar_coffee.png",
    icon_size = 128,
    effects =
    {
      {
          type = "unlock-recipe",
          recipe = "coffee-crate"
      },
      {
          type = "unlock-recipe",
          recipe = "cryo-shipment"
      }
    },
    prerequisites = {
      "space-science-pack",
      "ppc-coffee-production",
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1},
      },
      time = 20
    }
  },

  {
    type = "technology",
    name = "ppc-auto-consumption",
    icon = "__PreciousPreciousCaffeine__/graphics/equipment_auto_injector.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "auto-injector"
      },
    },
    prerequisites = {
      "ppc-caffeine-extraction",
      "chemical-science-pack",
    },
    unit =
    {
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 2},
      },
      time = 20
    }
  },

  {
    type = "technology",
    name = "ppc-3a-tech",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_3a_tech.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "3a-tank-shell"
      },
      {
        type = "unlock-recipe",
        recipe = "3a-rocket"
      },
    },
    prerequisites = {
      "ppc-caffeine-extraction",
      "explosive-rocketry",
    },
    unit =
    {
      count = 30,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 3},
      },
      time = 20
    }
  },

  {
    type = "technology",
    name = "ppc-caffeine-ammo",
    icon = "__PreciousPreciousCaffeine__/graphics/tech_caffeine_ammo.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "caffeine-rounds-magazine"
      },
      {
        type = "unlock-recipe",
        recipe = "caffeine-shotgun-shell"
      },
    },
    prerequisites = {
      "ppc-caffeine-extraction",
      "military-science-pack",
      "military-2",
    },
    unit =
    {
      count = 25,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 4},
      },
      time = 30
    }
  },
})