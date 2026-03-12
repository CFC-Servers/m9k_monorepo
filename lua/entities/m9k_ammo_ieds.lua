AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "IEDs"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/crateieds.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoGiveWeapon = "m9k_ied_detonator"
    ENT.AmmoType = "Improvised_Explosive"
    ENT.AmmoCount = 12
end
