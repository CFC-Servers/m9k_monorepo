-- Variables that are used on both client and server
SWEP.Gun = "m9k_pkm" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Machine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "PKM" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3
SWEP.SlotPos                = 38
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"



SWEP.ViewModelFOV           = 55
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_mach_russ_pkm.mdl"
SWEP.WorldModel             = "models/weapons/w_mach_russ_pkm.mdl"
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.DeployDelay = 1
SWEP.Primary.Sound          = "pkm.Single"
SWEP.Primary.RPM            = 750 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 100
SWEP.Primary.DefaultClip    = 200
SWEP.Primary.KickUp         = 0.6 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 33 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .035 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .02 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( -2.19, 13, 0.35 )
SWEP.SightsAng              = Vector( -0.13, 0.054, 0 )
SWEP.RunSightsPos           = Vector( 5.276, -3.859, 0 )
SWEP.RunSightsAng           = Vector( -14.606, 52.087, 0 )
