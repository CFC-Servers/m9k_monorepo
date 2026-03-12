AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Nerve Gas Vials"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/cratenervegas.mdl"
    ENT.AmmoGiveWeapon = "m9k_nerve_gas"
    ENT.AmmoType = "NerveGas"
    ENT.AmmoCount = 48

    local ammo_detonation = GetConVar( "M9KAmmoDetonation" )
    local ammo_explosivegas = GetConVar( "M9KExplosiveNerveGas" )

    function ENT:OnTakeDamage( dmg )
        self:TakePhysicsDamage( dmg )

        if not ammo_detonation:GetBool() or not ammo_explosivegas:GetBool() then
            return
        end

        local inflictor = dmg:GetInflictor()
        if inflictor:IsValid() and ( inflictor:GetClass() == "m9k_poison_parent" or inflictor:GetClass() == "m9k_released_poison" ) then return end

        if math.random( 1, 10 ) == 1 then
            local poison = ents.Create( "m9k_released_poison" )
            local attacker = dmg:GetAttacker()
            local pos = self:GetPos()

            poison:SetPos( pos )
            poison:SetOwner( attacker )
            poison.Owner = attacker
            poison.Big = true
            poison.PosToKeep = pos
            poison:Spawn()

            local gas = EffectData()
            gas:SetOrigin( pos )
            gas:SetEntity( attacker )
            gas:SetScale( 2 )
            util.Effect( "m9k_released_nerve_gas", gas )

            self:Remove()
        end
    end
end
