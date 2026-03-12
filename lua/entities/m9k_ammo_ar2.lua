AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Assault Ammo"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/boxmrounds.mdl"
    ENT.AmmoType = "ar2"
    ENT.AmmoCount = 100
else
    ENT.Text = "Assault Rifle Ammo"
    ENT.TextFont = "DermaLarge"
    ENT.PosOffset = Vector( 13.3, 2, 1.5 )
    ENT.AngOffset = Vector( 90, 90, 90 )
end
