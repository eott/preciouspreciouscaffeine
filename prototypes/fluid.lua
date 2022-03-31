local fluid_coffee = table.deepcopy(data.raw.fluid.water)
fluid_coffee.name = "fluid-coffee"
fluid_coffee.icon = "__PreciousPreciousCaffeine__/graphics/fluid_coffee.png"
fluid_coffee.base_color = {r=0.22, g=0, b=0}
fluid_coffee.flow_color = {r=0.93, g=0.055, b=0}
fluid_coffee.subgroup = "coffee-intermediates"
fluid_coffee.always_show_made_in = true
fluid_coffee.enabled = true
fluid_coffee.order = "z-a"

data:extend({
    fluid_coffee,
    {
      type = "fluid",
      name = "fluid-compressed-air",
      default_temperature = 20,
      max_temperature = 1000,
      heat_capacity = "0.1KJ",
      icon = "__PreciousPreciousCaffeine__/graphics/fluid_compressed_air.png",
      icon_size = 64,
      icon_mipmaps = 1,
      base_color = {r=0.5, g=0.5, b=0.5},
      flow_color = {r=0.5, g=0.5, b=0.5},
      order = "a[fluid]-b[steam]",
      gas_temperature = 20,
      auto_barrel = false
    },
    {
      type = "fluid",
      name = "fluid-liquid-co2",
      default_temperature = 20,
      max_temperature = 60,
      heat_capacity = "0.1KJ",
      icon = "__PreciousPreciousCaffeine__/graphics/fluid_co2.png",
      icon_size = 64,
      icon_mipmaps = 1,
      base_color = {r=0.5, g=0.5, b=0.5},
      flow_color = {r=0.5, g=0.5, b=0.5},
      order = "a[fluid]-b[steam]",
      gas_temperature = -50,
      auto_barrel = false
    },
})