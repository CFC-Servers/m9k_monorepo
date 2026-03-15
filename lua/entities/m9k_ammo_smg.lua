AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "SMG Rounds"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/boxsrounds.mdl"
    ENT.AmmoType = "smg1"
    ENT.AmmoCount = 100
else
    ENT.Text = "SMG Rounds"
    ENT.TextFont = "DermaLarge"
    ENT.PosOffset = Vector( 11.6, 2, 1.5 )
    ENT.AngOffset = Vector( 90, 90, 90 )
end
