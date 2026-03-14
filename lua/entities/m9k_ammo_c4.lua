AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "C4"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/cratec4.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoGiveWeapon = "m9k_suicide_bomb"
    ENT.AmmoType = "C4Explosive"
    ENT.AmmoCount = 8
end
