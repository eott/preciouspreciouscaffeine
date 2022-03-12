data:extend({
  {
      type = "technology",
      name = "ppc-coffee-production",
      icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_production.png",
      icon_size = 128,
      effects =
      {
        {
            type = "unlock-recipe",
            recipe = "coffee-plantation"
        },
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
        {
            type = "unlock-recipe",
            recipe = "coffee-crate"
        },
        {
            type = "unlock-recipe",
            recipe = "cryo-shipment"
        }
      },
      prerequisites = {"automation-2"},
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
      name = "ppc-auto-consumption",
      icon = "__PreciousPreciousCaffeine__/graphics/icon_auto_consumption.png",
      icon_size = 128,
      effects =
      {
        
      },
      prerequisites = {"ppc-coffee-production"},
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