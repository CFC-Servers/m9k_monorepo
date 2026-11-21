AddCSLuaFile()

ENT.Base = "m9k_thrown_weapon_base"
ENT.GiveClassType = "m9k_knife"
ENT.GiveAmmoType = false
ENT.WorldModel = "models/weapons/w_extreme_ratio.mdl"
ENT.ExtraPenDepth = 5

if SERVER then
    function ENT:DamageFunction( target, damager )
        target:TakeDamage( 80, damager, self )
    end
end
