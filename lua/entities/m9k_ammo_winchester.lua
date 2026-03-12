AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Winchester Ammo"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/sniper_round_box.mdl"
    ENT.AmmoType = "AirboatGun"
    ENT.AmmoCount = 100
else
    ENT.Text = "Winchester"
    ENT.TextFont = "DermaDefaultBold"
    ENT.PosOffset = Vector( 1.4, 1, -1.45 )
    ENT.AngOffset = Vector( 90, 0, 0 )
end
