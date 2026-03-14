AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Nuclear Warhead"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/failure/mk6/mk6.mdl"
    ENT.AmmoType = "Nuclear_Warhead"
    ENT.AmmoCount = 1

    local ammo_detonation = GetConVar( "M9KAmmoDetonation" )
    local ammo_detonation_nuke = GetConVar( "DavyCrockettAllowed" )

    function ENT:OnTakeDamage( dmg )
        self:TakePhysicsDamage( dmg )

        if not ammo_detonation:GetBool() or not ammo_detonation_nuke:GetBool() then
            return
        end

        if math.random( 1, 30 ) == 1 then
            local nuke = ents.Create( "m9k_davy_crockett_explo" )
            nuke:SetPos( self:GetPos() )
            nuke:SetOwner( dmg:GetAttacker() )
            nuke:Spawn()
            self:Remove()
        end
    end
end
