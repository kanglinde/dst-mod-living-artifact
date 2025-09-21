local function OnRemoveHit(inst)
     if inst.target and inst.target:IsValid() then
          if not inst.target.components.colouradder then
               if inst.target.components.freezable then
                    inst.target.components.freezable:UpdateTint()
               else
                    inst.target.AnimState:SetAddColour(0, 0, 0, 1)
               end
          end
          if not inst.target.components.bloomer then
               inst.target.AnimState:ClearBloomEffectHandle()
          end
     end
end

local function UpdateHit(inst, target)
     if target:IsValid() then
          local oldflash = inst.flash
          inst.flash = math.max(0, inst.flash - .075)
          if inst.flash > 0 then
               local c = math.min(1, inst.flash)
               if target.components.colouradder then
                    target.components.colouradder:PushColour(inst, c, 0, 0, 0)
               else
                    target.AnimState:SetAddColour(c, 0, 0, 1)
               end
               if inst.flash < .3 and oldflash >= .3 then
                    if target.components.bloomer then
                         target.components.bloomer:PopBloom(inst)
                    else
                         target.AnimState:ClearBloomEffectHandle()
                    end
               end
               return
          end
     end
     inst:Remove()
end

local function SetTarget(inst, target)
     if inst.inittask then
          inst.inittask:Cancel()
          inst.inittask = nil
     
          inst.target = target
          inst.OnRemoveEntity = OnRemoveHit
     
          if target.components.bloomer then
               target.components.bloomer:PushBloom(inst, "shaders/anim.ksh", -1)
          else
               target.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
          end
          inst.flash = .8 + math.random() * .4
          inst:DoPeriodicTask(0, UpdateHit, nil, target)
          UpdateHit(inst, target)
     end
end

local function hitfn()
     local inst = CreateEntity()

     inst:AddTag("CLASSIFIED")
     --[[Non-networked entity]]
     inst.persists = false
 
     inst.SetTarget = SetTarget
     inst.inittask = inst:DoTaskInTime(0, inst.Remove)
 
     return inst
end

return Prefab("laserhit", hitfn) 