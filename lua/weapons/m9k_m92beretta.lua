-- Variables that are used on both client and server
SWEP.Gun = "m9k_m92beretta" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Pistols"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "M92 Beretta" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 1
SWEP.SlotPos                = 26
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 3
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "pistol"



SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_pistberettam92.mdl"
SWEP.WorldModel             = "models/weapons/w_beretta_m92.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Weapon_m92b.Single"
SWEP.Primary.RPM            = 500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 15
SWEP.Primary.DefaultClip    = 45
SWEP.Primary.KickUp         = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "pistol" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 65 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 --how many bullets to shoot, use with shotguns
SWEP.Primary.Damage         = 14 --base damage, scaled by game
SWEP.Primary.SpreadHip         = .027 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .019 -- has to be the same as Primary.SpreadHip

SWEP.SightsPos              = Vector( -2.379, 0, 1.205 )
SWEP.SightsAng              = Vector( 0.05, 0, 0 )
SWEP.RunSightsPos           = Vector( 3.444, -7.823, -6.27 )
SWEP.RunSightsAng           = Vector( 60.695, 0, 0 )
-- SWEP.RunSightsPos = Vector(0, 0, 0)
-- SWEP.RunSightsAng = Vector(-10.903, 6.885, 0)
