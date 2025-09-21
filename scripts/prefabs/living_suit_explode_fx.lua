local assets = 
{
     Asset("ANIM", "anim/living_suit_explode_fx.zip"),
}

local function fn()
     local inst = CreateEntity()
     inst.entity:AddTransform()
     inst.entity:AddAnimState()
     inst.entity:AddNetwork()

     inst.Transform:SetFourFaced()

     inst.AnimState:SetBank("living_suit_explode_fx")
     inst.AnimState:SetBuild("living_suit_explode_fx")
     inst.AnimState:PlayAnimation("idle", false)

     inst:AddTag("FX")
     inst:AddTag("NOBLOCK")

     inst.persists = false

     inst:ListenForEvent("animover", inst.Remove)

     return inst
end

return Prefab("living_suit_explode_fx", fn, assets)