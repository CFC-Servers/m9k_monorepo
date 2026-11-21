AddCSLuaFile()

ENT.Base = "m9k_thrown_weapon_base"
ENT.GiveClassType = "m9k_machete"
ENT.GiveAmmoType = false
ENT.WorldModel = "models/weapons/w_machete.mdl"
ENT.ExtraPenDepth = 2

if SERVER then
    function ENT:DamageFunction( target, damager )
        target:TakeDamage( 100, damager, self )
    end
end
