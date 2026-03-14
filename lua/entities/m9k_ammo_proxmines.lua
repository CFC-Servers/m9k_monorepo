AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Prox Mines"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/ammocrates/crateprox.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoGiveWeapon = "m9k_proxy_mine"
    ENT.AmmoType = "ProxMine"
    ENT.AmmoCount = 24
end
