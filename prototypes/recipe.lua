data:extend({
  {
    type = "recipe",
    name = "coffee-plantation",
    enabled = "true",
    ingredients = 
    {
      {"iron-stick",10},
      {"stone",20},
      {"raw-wood",50},
      {"inserter",2}
    },
    result = "coffee-plantation"
  },

  {
    type = "recipe",
    name = "coffee-beans",
    enabled = "true",
    ingredients = 
    {
      {"coffee-berries",1}
    },
    result = "coffee-beans"
  },
  
  {
    type = "recipe",
    name = "roasted-coffee-beans",
    enabled = "true",
    category = "smelting",
    energy_required = 3.5,
    ingredients = 
    {
      {"coffee-beans",1}
    },
    result = "roasted-coffee-beans"
  },

  {
    type = "recipe",
    name = "coffee-powder",
    enabled = "true",
    ingredients = 
    {
      {"roasted-coffee-beans",20}
    },
    result = "coffee-powder"
  },

  {
    type = "recipe",
    name = "mug-of-coffee",
    enabled = "true",
    energy_required = 3,
    category = "crafting-with-fluid",
    ingredients = 
    {
      {"coffee-powder",1},
      {type="fluid", name="water", amount=2.5},
      {"stone", 5}
    },
    result = "mug-of-coffee",
    result_count = 5
  },
})