AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Sticky Grenades"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/cratestickys.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoGiveWeapon = "m9k_sticky_grenade"
    ENT.AmmoType = "StickyGrenade"
    ENT.AmmoCount = 48
end
