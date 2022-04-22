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
    enabled = "false",
    ingredients = 
    {
      {"iron-stick",10},
      {"stone",20},
      {"wood",50},
      {"inserter",2}
    },
    result = "coffee-plantation"
  },

  {
    type = "recipe",
    name = "coffee-berries",
    enabled = "false",
    category = "plantation",
    ingredients = {
      {"bio-mass", 1},
    },
    result = "coffee-berries",
    energy_required = 20,
    result_count = 10,
    always_show_made_in = true,
  },

  {
    type = "recipe",
    name = "wood-growth",
    enabled = "false",
    category = "plantation",
    ingredients = {
      {"bio-mass", 1},
    },
    result = "wood",
    energy_required = 20,
    result_count = 1,
    always_show_made_in = true,
  },

  {
    type = "recipe",
    name = "wood-growth-2",
    enabled = "false",
    category = "plantation",
    ingredients = {
      {"bio-mass", 4},
    },
    result = "wood",
    energy_required = 20,
    result_count = 4,
    always_show_made_in = true,
  },

  {
    type = "recipe",
    name = "coffee-beans",
    enabled = "false",
    ingredients = 
    {
      {"coffee-berries",1}
    },
    result = "coffee-beans"
  },

  {
    type = "recipe",
    name = "bio-mass-from-berries",
    enabled = "false",
    energy_required = 2,
    ingredients = 
    {
      {"coffee-berries", 8}
    },
    result = "bio-mass",
  },

  {
    type = "recipe",
    name = "bio-mass-from-wood",
    enabled = "false",
    energy_required = 4,
    ingredients = 
    {
      {"wood", 1}
    },
    result = "bio-mass"
  },

  {
    type = "recipe",
    name = "bio-mass-from-mixed",
    enabled = "false",
    energy_required = 4,
    ingredients = 
    {
      {"bio-mass", 1},
      {"wood", 1},
      {"coffee-berries", 4},
    },
    results = {
      {type="item", name="bio-mass", amount=3}
    },
  },

  {
    type = "recipe",
    name = "roasted-coffee-beans",
    enabled = "false",
    category = "smelting",
    energy_required = 3.5,
    ingredients = 
    {
      {"coffee-beans",5}
    },
    result = "roasted-coffee-beans",
    result_count = 5
  },

  {
    type = "recipe",
    name = "coffee-powder",
    enabled = "false",
    ingredients = 
    {
      {"roasted-coffee-beans",20}
    },
    result = "coffee-powder"
  },

  {
    type = "recipe",
    name = "coffee-brewing",
    enabled = "false",
    energy_required = 5,
    category = "crafting-with-fluid",
    ingredients = {
      {"coffee-powder", 1},
      {type="fluid", name="water", amount=10},
    },
    results = {
      {type="fluid", name="fluid-coffee", amount=10}
    },
  },

  {
    type = "recipe",
    name = "mug-of-coffee",
    enabled = "false",
    energy_required = 5,
    category = "crafting-with-fluid",
    ingredients = {
      {type="fluid", name="fluid-coffee", amount=10},
      {"stone", 4}
    },
    result = "mug-of-coffee",
    result_count = 4
  },

  {
    type = "recipe",
    name = "air-compression",
    enabled = "false",
    category = "chemistry",
    ingredients = {},
    energy_required = 0.5,
    results = {
      {type="fluid", name="fluid-compressed-air", amount=10},
    },
  },

  {
    type = "recipe",
    name = "co2-from-air",
    enabled = "false",
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
  },

  {
    type = "recipe",
    name = "co2-from-coal",
    enabled = "false",
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
  },

  {
    type = "recipe",
    name = "caffeine-extraction",
    enabled = "false",
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
  },

  {
    type = "recipe",
    name = "coffee-crate",
    enabled = "false",
    ingredients = 
    {
      {"roasted-coffee-beans",400},
      {"wood",6}
    },
    result = "coffee-crate"
  },

  {
    type = "recipe",
    name = "cryo-shipment",
    enabled = "false",
    ingredients = 
    {
      {"coffee-crate",50},
      {"fusion-reactor-equipment",1},
      {"battery",100},
      {"advanced-circuit",100},
      {"plastic-bar",200},
      {"copper-cable",1000}
    },
    result = "cryo-shipment"
  },

  {
    type = "recipe",
    name = "auto-injector",
    enabled = "false",
    ingredients = {
      {"advanced-circuit", 10},
      {"plastic-bar", 2},
      {"steel-plate", 1}
    },
    result = "auto-injector-item"
  },

  {
    type = "recipe",
    name = "3a-tank-shell",
    enabled = "false",
    energy_required = 8,
    ingredients = {
      {"explosives", 2},
      {"caffeine", 20},
      {"plastic-bar", 1},
      {"iron-plate", 2}
    },
    result = "3a-tank-shell"
  },

  {
    type = "recipe",
    name = "3a-rocket",
    enabled = "false",
    energy_required = 8,
    ingredients = {
      {"explosives", 2},
      {"caffeine", 20},
      {"plastic-bar", 1},
      {"iron-plate", 2}
    },
    result = "3a-rocket"
  },

  {
    type = "recipe",
    name = "caffeine-rounds-magazine",
    enabled = "false",
    energy_required = 4,
    ingredients = {
      {"copper-plate", 2},
      {"caffeine", 3},
      {"steel-plate", 1}
    },
    result = "caffeine-rounds-magazine"
  },

  {
    type = "recipe",
    name = "caffeine-shotgun-shell",
    enabled = "false",
    energy_required = 4,
    ingredients = {
      {"copper-plate", 2},
      {"caffeine", 3},
      {"iron-plate", 2}
    },
    result = "caffeine-shotgun-shell"
  },

  {
    type = "recipe",
    name = "golden-bean",
    enabled = "false",
    energy_required = 1,
    ingredients = {
      {"star-buck", 25000}
    },
    result = "golden-bean",
  },
})