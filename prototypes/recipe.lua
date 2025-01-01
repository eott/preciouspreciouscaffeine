data:extend({
  {
    type = "recipe-category",
    name = "plantation"
  },
})

data:extend({
  {
    type = "recipe",
    name = "coffee-plantation",
    enabled = false,
    energy_required = 5,
    ingredients = 
    {
      {type="item", name="iron-stick", amount=10},
      {type="item", name="stone", amount=20},
      {type="item", name="wood", amount=50},
      {type="item", name="inserter", amount=2}
    },
    results = {{type="item", name="coffee-plantation", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "coffee-berries",
    enabled = false,
    category = "plantation",
    ingredients = {
      {type="item", name="bio-mass", amount=1},
    },
    results = {{type="item", name="coffee-berries", amount=10}},
    energy_required = 20,
    always_show_made_in = true,
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "wood-growth",
    enabled = false,
    category = "plantation",
    ingredients = {
      {type="item", name="bio-mass", amount=1},
    },
    results = {{type="item", name="wood", amount=1}},
    energy_required = 20,
    always_show_made_in = true,
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "wood-growth-2",
    enabled = false,
    category = "plantation",
    ingredients = {
      {type="item", name="bio-mass", amount=4},
    },
    results = {{type="item", name="wood", amount=4}},
    energy_required = 20,
    always_show_made_in = true,
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "coffee-beans",
    enabled = false,
    ingredients = 
    {
      {type="item", name="coffee-berries", amount=1}
    },
    results = {{type="item", name="coffee-beans", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "bio-mass-from-berries",
    enabled = false,
    energy_required = 2,
    ingredients = 
    {
      {type="item", name="coffee-berries", amount=8}
    },
    results = {{type="item", name="bio-mass", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "bio-mass-from-wood",
    enabled = false,
    energy_required = 4,
    ingredients = 
    {
      {type="item", name="wood", amount=1}
    },
    results = {{type="item", name="bio-mass", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "bio-mass-from-mixed",
    enabled = false,
    energy_required = 4,
    ingredients = 
    {
      {type="item", name="bio-mass", amount=1},
      {type="item", name="wood", amount=1},
      {type="item", name="coffee-berries", amount=4},
    },
    results = {
      {type="item", name="bio-mass", amount=3}
    },
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "roasted-coffee-beans",
    enabled = false,
    category = "smelting",
    energy_required = 3.5,
    ingredients = {{type="item", name="coffee-beans", amount=5}},
    results = {{type="item", name="roasted-coffee-beans", amount=5, ignored_by_productivity=100}},
    allow_productivity = true, -- should be false to match the other steps in the production chain,
                               -- but due to a bug the flag is ignored anyway. we could also add
                               -- ignored_by_productivity=100 to the results, but the progress bar
                               -- would still show, which is confusing
  },

  {
    type = "recipe",
    name = "coffee-powder",
    enabled = false,
    energy_required = 1,
    ingredients = 
    {
      {type="item", name="roasted-coffee-beans", amount=20}
    },
    results = {{type="item", name="coffee-powder", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "coffee-brewing",
    enabled = false,
    energy_required = 5,
    category = "crafting-with-fluid",
    ingredients = {
      {type="item", name="coffee-powder", amount=1},
      {type="fluid", name="water", amount=10},
    },
    results = {
      {type="fluid", name="fluid-coffee", amount=10}
    },
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "mug-of-coffee",
    enabled = false,
    energy_required = 5,
    category = "crafting-with-fluid",
    ingredients = {
      {type="fluid", name="fluid-coffee", amount=10},
      {type="item", name="stone", amount=4}
    },
    results = {{type="item", name="mug-of-coffee", amount=4}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "air-compression",
    enabled = false,
    category = "chemistry",
    ingredients = {},
    energy_required = 0.5,
    results = {
      {type="fluid", name="fluid-compressed-air", amount=10},
    },
    allow_productivity = true,
  },

  {
    type = "recipe",
    name = "co2-from-air",
    enabled = false,
    category = "chemistry",
    energy_required = 5,
    ingredients = {
      {type="fluid", name="fluid-compressed-air", amount=500},
    },
    results = {
      {type="fluid", name="fluid-liquid-co2", amount=1},
      {type="fluid", name="fluid-compressed-air", amount=300},
    },
    main_product = "fluid-liquid-co2",
    allow_productivity = true,
  },

  {
    type = "recipe",
    name = "co2-from-coal",
    enabled = false,
    category = "chemistry",
    energy_required = 5,
    ingredients = {
      {type="fluid", name="fluid-compressed-air", amount=100},
      {type="item", name="coal", amount=2},
    },
    results = {
      {type="fluid", name="fluid-liquid-co2", amount=2},
    },
    main_product = "fluid-liquid-co2",
    allow_productivity = true,
  },

  {
    type = "recipe",
    name = "caffeine-extraction",
    enabled = false,
    category = "chemistry",
    energy_required = 10,
    ingredients = {
      {type="fluid", name="fluid-liquid-co2", amount=100},
      {type="item", name="coffee-beans", amount=24},
    },
    results = {
      {type="fluid", name="fluid-liquid-co2", amount=99},
      {type="item", name="caffeine", amount=2},
      {type="item", name="bio-mass", amount=3},
    },
    main_product = "caffeine",
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "coffee-crate",
    enabled = false,
    energy_required = 2,
    ingredients = 
    {
      {type="item", name="roasted-coffee-beans",amount=400},
      {type="item", name="wood", amount=6}
    },
    results = {{type="item", name="coffee-crate", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "cryo-shipment",
    energy_required = 10,
    enabled = false,
    ingredients = 
    {
      {type="item", name="coffee-crate", amount=50},
      {type="item", name="fission-reactor-equipment", amount=1},
      {type="item", name="battery", amount=100},
      {type="item", name="advanced-circuit", amount=100},
      {type="item", name="plastic-bar", amount=200},
      {type="item", name="copper-cable", amount=1000}
    },
    results = {{type="item", name="cryo-shipment", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "auto-injector",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type="item", name="advanced-circuit", amount=10},
      {type="item", name="plastic-bar", amount=2},
      {type="item", name="steel-plate", amount=1}
    },
    results = {{type="item", name="auto-injector-item", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "3a-tank-shell",
    enabled = false,
    energy_required = 8,
    ingredients = {
      {type="item", name="explosives", amount=2},
      {type="item", name="caffeine", amount=20},
      {type="item", name="plastic-bar", amount=1},
      {type="item", name="iron-plate", amount=2}
    },
    results = {{type="item", name="3a-tank-shell", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "3a-rocket",
    enabled = false,
    energy_required = 8,
    ingredients = {
      {type="item", name="explosives", amount=2},
      {type="item", name="caffeine", amount=20},
      {type="item", name="plastic-bar", amount=1},
      {type="item", name="iron-plate", amount=2}
    },
    results = {{type="item", name="3a-rocket", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "caffeine-rounds-magazine",
    enabled = false,
    energy_required = 4,
    ingredients = {
      {type="item", name="copper-plate", amount=5},
      {type="item", name="caffeine", amount=3},
      {type="item", name="steel-plate", amount=1}
    },
    results = {{type="item", name="caffeine-rounds-magazine", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "caffeine-shotgun-shell",
    enabled = false,
    energy_required = 4,
    ingredients = {
      {type="item", name="copper-plate", amount=2},
      {type="item", name="caffeine", amount=3},
      {type="item", name="iron-plate", amount=2}
    },
    results = {{type="item", name="caffeine-shotgun-shell", amount=1}},
    allow_productivity = false,
  },

  {
    type = "recipe",
    name = "golden-bean",
    enabled = false,
    energy_required = 1,
    ingredients = {
      {type="item", name="star-buck", amount=25000}
    },
    results = {{type="item", name="golden-bean", amount=1}},
    allow_productivity = false,
  },
})