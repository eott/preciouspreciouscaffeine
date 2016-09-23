require("prototypes.item")
require("prototypes.recipe")
require("prototypes.entity")

data:extend({
  {
    type = "custom-input",
    name = "ppc-consume",
    key_sequence = "CONTROL + R",
    consuming = "script-only"
  }
})