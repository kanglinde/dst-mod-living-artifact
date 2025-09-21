local assets=
{
    Asset("ANIM", "anim/infused_iron.zip"),
    Asset("ATLAS", "images/inventoryimages/Infused_Iron.xml"),
    Asset("IMAGE", "images/inventoryimages/Infused_Iron.tex"),
}

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    
    inst.AnimState:SetBank("infused_iron")
    inst.AnimState:SetBuild("infused_iron")
    inst.AnimState:PlayAnimation("idle")

    inst.pickupsound = "metal"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.ELEMENTAL
    inst.components.edible.hungervalue = 2

    inst:AddComponent("tradable")
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetSinks(true)
    inst.components.inventoryitem.atlasname = "images/inventoryimages/Infused_Iron.xml"
    inst.components.inventoryitem.imagename = "Infused_Iron"

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("infused_iron", fn, assets)