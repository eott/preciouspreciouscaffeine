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
    consuming = "script-only"
  }
})

-- Add aaa tank shell to return items of rocket launch
table.insert(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]["result_items"], {"aaa-tank-shell", 30, "cryo-shipment"})