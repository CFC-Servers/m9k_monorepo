AddCSLuaFile()

ENT.Base = "m9k_thrown_weapon_base"
ENT.GiveClassType = "m9k_harpoon"
ENT.GiveAmmoType = "Harpoon"
ENT.WorldModel = "models/props_junk/harpoon002a.mdl"
ENT.ExtraPenDepth = 25

ENT.ImpactDamageDivisor = 10

if SERVER then
    function ENT:DamageFunction( target, damager, physData )
        local damage = physData.Speed / self.ImpactDamageDivisor
        target:TakeDamage( damage, damager, self )
    end
end
