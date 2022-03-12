require("prototypes.item")
require("prototypes.recipe")
require("prototypes.entity")
require("prototypes.technology")
require("prototypes.projectiles")

-- Assign hotkey
data:extend({
  {
    type = "custom-input",
    name = "ppc-consume",
    key_sequence = "CONTROL + R",
    consuming = "game-only"
  }
})
