local assets =
{
    Asset("ANIM", "anim/waterdrop.zip"),
    Asset("ANIM", "anim/lifeplant.zip"),
    Asset("ATLAS", "images/inventoryimages/waterdrop.xml"),
    Asset("IMAGE", "images/inventoryimages/waterdrop.tex"),
}

local function ondeploy (inst, pos) 
    local plant = SpawnPrefab("lifeplant")
    plant.Transform:SetPosition(pos:Get())
    plant.AnimState:PlayAnimation("grow")
    plant.AnimState:PushAnimation("idle_loop", true)
    plant.SoundEmitter:PlaySound("dontstarve_DLC003/common/crafted/flower_of_life/plant")
    
    inst:Remove()
end

local function OnEaten(inst, eater)
    eater.components.health:SetPenalty(0)
    eater.components.health:SetPercent(1)
    eater.components.sanity:SetPercent(1)
    eater.components.hunger:SetPercent(1)
    if eater.components.thirst then   -- Compatible with "Don't Starve: Dehydrated"
        eater.components.thirst:SetPercent(1)
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst)

    inst.AnimState:SetBank("waterdrop")
    inst.AnimState:SetBuild("waterdrop")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("waterdrop")
    inst:AddTag("deployedplant")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GOODIES
    inst.components.edible:SetOnEatenFn(OnEaten)

    inst:AddComponent("tradable")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/waterdrop.xml"
    inst.components.inventoryitem.imagename = "waterdrop"
    
    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable.ondeploy = ondeploy    

    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("waterdrop", fn, assets),
       MakePlacer("waterdrop_placer", "lifeplant", "lifeplant", "idle_loop" )