AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Single 40mm Grenade"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/weapons/w_40mm_grenade_launched.mdl"
    ENT.ExplosionEffect = true
    ENT.AmmoType = "40mmGrenade"
    ENT.AmmoCount = 1
end
