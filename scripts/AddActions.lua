AddAction("IRONTURNON", STRINGS.ACTIONS.IRONTURNON, function(act)
     local inst = act.invobject
     if inst and inst.components.ironmachine and not inst.components.ironmachine:IsOn() then
          inst.components.ironmachine:TurnOn()
          return true
     end
end)

AddAction("IRONTURNOFF", STRINGS.ACTIONS.IRONTURNOFF, function(act)
     local inst = act.invobject
     if inst and inst.components.ironmachine and inst.components.ironmachine:IsOn() then
          inst.components.ironmachine:TurnOff()
          return true
     end
end)

AddAction("CHARGE_UP", STRINGS.ACTIONS.CHARGE_UP, function(act)
     if act.doer:HasTag("ironlord") then
          return true
     end
end)
ACTIONS.CHARGE_UP.do_not_locomote = true

local ARTIFACT_FORBIDDEN = {"beaver", "weremoose", "weregoose", "wonkey"}

AddComponentAction("INVENTORY", "ironmachine", function(inst, doer, actions)
     if (doer.replica.rider and doer.replica.rider:IsRiding()) or 
          not (inst.replica.inventoryitem and inst.replica.inventoryitem:IsHeldBy(doer)) then
          return
     end

     for _,v in pairs(ARTIFACT_FORBIDDEN) do
          if doer:HasTag(v) then return end
     end
     
     if inst:HasTag("ironmachineon") then
          table.insert(actions, ACTIONS.IRONTURNOFF)
     elseif not doer:HasTag("ironlord") then
          table.insert(actions, ACTIONS.IRONTURNON)
     end
end)