-- Variables that are used on both client and server
SWEP.Gun = "m9k_famas" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Assault Rifles"
SWEP.Author                 = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "FAMAS" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2
SWEP.SlotPos                = 29
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"



SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_tct_famas.mdl"
SWEP.WorldModel             = "models/weapons/w_tct_famas.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Weapon_FAMTC.Single"
SWEP.Primary.RPM            = 950 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 29 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .025 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( -3.34, 0, 0.24 )
SWEP.SightsAng              = Vector( 0, -0.438, 0 )
SWEP.RunSightsPos           = Vector( 0.9926, -3.6313, 0.4169 )
SWEP.RunSightsAng           = Vector( -9.1165, 43.8507, -18.2067 )
