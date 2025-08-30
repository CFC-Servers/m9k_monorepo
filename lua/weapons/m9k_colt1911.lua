-- Variables that are used on both client and server
SWEP.Gun = "m9k_colt1911" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Pistols"
SWEP.Author                 = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Colt 1911" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 1
SWEP.SlotPos                = 43
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 3
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "pistol"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/f_dmgf_co1911.mdl"
SWEP.WorldModel             = "models/weapons/s_dmgf_co1911.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Dmgfok_co1911.Single"
SWEP.Primary.RPM            = 700 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 7
SWEP.Primary.DefaultClip    = 45
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "pistol" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 17 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .025 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( -2.6004, -1.3877, 1.1892 )
SWEP.SightsAng              = Vector( 0.3756, -0.0032, 0.103 )
SWEP.RunSightsPos           = Vector( 3.444, -7.823, -6.27 )
SWEP.RunSightsAng           = Vector( 60.695, 0, 0 )
-- SWEP.RunSightsPos = Vector (-0.7883, 0, 2.4235)
-- SWEP.RunSightsAng = Vector (-14.417, -0.7137, 0)
