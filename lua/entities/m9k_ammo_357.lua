AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "357"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/357ammo.mdl"
    ENT.AmmoType = "357"
    ENT.AmmoCount = 100
else
    ENT.Text = "357"
    ENT.TextFont = "DermaLarge"
    ENT.PosOffset = Vector( 4, -2.5, -3.3 )
    ENT.AngOffset = Vector( 48, -90, 0 )
end
