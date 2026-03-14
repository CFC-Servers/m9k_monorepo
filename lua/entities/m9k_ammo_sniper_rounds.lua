AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Sniper Rounds"
ENT.Category = "M9K Ammunition"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/sniper_round_box.mdl"
    ENT.AmmoType = "SniperPenetratedRound"
    ENT.AmmoCount = 50
else
    ENT.Text = "Sniper Rounds"
    ENT.TextFont = "DermaDefaultBold"
    ENT.PosOffset = Vector( 1.4, 1, -1.45 )
    ENT.AngOffset = Vector( 90, 0, 0 )
end
