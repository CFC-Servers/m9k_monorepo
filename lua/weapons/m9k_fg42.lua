-- Variables that are used on both client and server
SWEP.Gun = "m9k_fg42" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Machine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "FG 42" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3
SWEP.SlotPos                = 33
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_rif_fg42.mdl"
SWEP.WorldModel             = "models/weapons/w_fg42.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "FG42_weapon.Single"
SWEP.Primary.RPM            = 900 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 20
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2"
SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 33 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .035 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .01 -- Ironsight accuracy, should be the same for shotguns
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1


SWEP.SightsPos = Vector( 3.47, -6.078, 1.93 )
SWEP.SightsAng = Vector( 0.216, -0.082, 0 )
SWEP.RunSightsPos = Vector( -5.738, -1.803, 0 )
SWEP.RunSightsAng = Vector( -7.46, -47.624, 0 )
