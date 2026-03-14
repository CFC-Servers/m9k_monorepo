AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Frag Grenades"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/cratefrags.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoGiveWeapon = "m9k_m61_frag"
    ENT.AmmoType = "Grenade"
    ENT.AmmoCount = 48
end
