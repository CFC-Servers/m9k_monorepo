-- Variables that are used on both client and server
SWEP.Gun = "m9k_coltpython" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Pistols"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Colt Python" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 1
SWEP.SlotPos                = 57
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 3
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "revolver"



SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_pist_python.mdl"
SWEP.WorldModel             = "models/weapons/w_colt_python.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Weapon_ColtPython.Single"
SWEP.Primary.RPM            = 115 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 6
SWEP.Primary.DefaultClip    = 30
SWEP.Primary.KickUp         = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "357" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 65 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 --how many bullets to shoot, use with shotguns
SWEP.Primary.Damage         = 29 --base damage, scaled by game
SWEP.Primary.SpreadHip         = .02 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .01 -- has to be the same as Primary.SpreadHip

SWEP.SightsPos              = Vector( -2.7, -1.676, 1.796 )
SWEP.SightsAng              = Vector( 0.611, 0.185, 0 )
SWEP.RunSightsPos           = Vector( 2.124, -9.365, -3.987 )
SWEP.RunSightsAng           = Vector( 48.262, -8.214, 0 )
