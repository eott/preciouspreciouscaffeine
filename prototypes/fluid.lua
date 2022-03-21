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
    fluid_coffee
})