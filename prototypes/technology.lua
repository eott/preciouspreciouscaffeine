data:extend({
  {
      type = "technology",
      name = "ppc-coffee-production",
      icon = "__PreciousPreciousCaffeine__/graphics/icon_coffee_production.png",
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
        }
      },
      prerequisites = {"automation-2"},
      unit =
      {
        count = 30,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
        },
        time = 20
      }
  }
})