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
    name = "coffee-crate",
    enabled = "false",
    ingredients = 
    {
      {"coffee-powder",20},
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
})