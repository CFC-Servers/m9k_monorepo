AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Pistol Rounds"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/boxsrounds.mdl"
    ENT.AmmoType = "pistol"
    ENT.AmmoCount = 100
else
    ENT.Text = "Pistol Rounds"
    ENT.TextFont = "DermaLarge"
    ENT.PosOffset = Vector( 11.6, 2, 1.5 )
    ENT.AngOffset = Vector( 90, 90, 90 )
end
