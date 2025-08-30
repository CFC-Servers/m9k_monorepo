-- Variables that are used on both client and server
SWEP.Gun = "m9k_m3" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Shotguns"
SWEP.Author                 = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Benelli M3" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3
SWEP.SlotPos                = 24
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "shotgun"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_benelli_m3_s90.mdl"
SWEP.WorldModel             = "models/weapons/w_benelli_m3.mdl"
SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = "BenelliM3.Single"
SWEP.Primary.RPM            = 70 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 8
SWEP.Primary.DefaultClip    = 30 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 0.8 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "buckshot" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.ShellTime              = .45

SWEP.Primary.NumShots       = 9 -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage         = 10 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .0326 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .0326 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 2.279, -1.007, 1.302 )
SWEP.SightsAng              = Vector( 0.47, -0.024, 0 )
SWEP.RunSightsPos           = Vector( -7.639, -7.796, 0.865 )
SWEP.RunSightsAng           = Vector( -17.362, -69.724, 0 )
SWEP.IronsightsBlowback = false
