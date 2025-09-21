GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
     "living_artifact",
     "living_suit_explode_fx",
     "laser_ring",
     "laserhit",
     "ancient_hulk_orb",
     "infused_iron",
     "waterdrop",
     "floweroflife",
}

Assets = {
     Asset("ANIM", "anim/livingartifact_meter.zip"),
     Asset("ANIM", "anim/player_lifeplant.zip"),
     
     Asset("ATLAS", "images/fx_living_artifact.xml"),
     Asset("IMAGE", "images/fx_living_artifact.tex"),
     Asset("ATLAS", "images/minimap_data_livingartifact.xml"),
     Asset("IMAGE", "images/minimap_atlas_livingartifact.tex"),

     Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"),
     Asset("SOUND", "sound/DLC003_sfx.fsb"),
}

TUNING.IRON_LORD_TIME = 60 * GetModConfigData("duration")
TUNING.SMALL_LASER_BURN = GetModConfigData("laserfire")
TUNING.IRON_LORD_BGM = GetModConfigData("bgm")

local import_files = {
     "AddStrings",
     "AddActions",
     "AddHandlers",
     "AddPostinit",
     "AddStategraph",
     "AddStategraph_client",
}
for _,v in ipairs(import_files) do modimport("scripts/"..v) end

AddMinimapAtlas("images/minimap_data_livingartifact.xml")

AddRecipe2("living_artifact", 
     {
          Ingredient("infused_iron", 6, "images/inventoryimages/Infused_Iron.xml"),
          Ingredient("waterdrop", 1, "images/inventoryimages/waterdrop.xml")
     }, 
     GLOBAL.TECH.MAGIC_THREE, -- GLOBAL.TECH.LOST (blueprint)?
     {atlas = "images/inventoryimages/living_artifact.xml", image = "living_artifact.tex"},
     {"MODS", "MAGIC"}
)