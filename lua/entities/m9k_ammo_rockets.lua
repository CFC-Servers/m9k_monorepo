AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Rockets"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/craterockets.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoType = "RPG_Round"
    ENT.AmmoCount = 75
end
