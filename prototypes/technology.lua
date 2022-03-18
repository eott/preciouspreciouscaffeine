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
      "rocket-silo",
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
      icon = "__PreciousPreciousCaffeine__/graphics/tech_auto_consumption.png",
      icon_size = 128,
      effects =
      {
        
      },
      prerequisites = {
        "ppc-coffee-production",
        "chemical-science-pack",
      },
      unit =
      {
        count = 30,
        ingredients =
        {
          {"automation-science-pack", 2},
          {"logistic-science-pack", 2},
          {"chemical-science-pack", 1},
        },
        time = 20
      }
  }
})