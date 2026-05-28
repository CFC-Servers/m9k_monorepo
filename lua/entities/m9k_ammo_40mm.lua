AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "40mm Grenades"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/crate40mm.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoType = "40mmGrenade"
    ENT.AmmoCount = 64
end
