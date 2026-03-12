AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Buckshot"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/boxbuckshot.mdl"
    ENT.AmmoType = "buckshot"
    ENT.AmmoCount = 100
else
    ENT.Text = "Buckshot"
    ENT.TextFont = "DermaLarge"
    ENT.PosOffset = Vector( 3, 2, 3.54 )
    ENT.AngOffset = Vector( 0, 90, 90 )
end
