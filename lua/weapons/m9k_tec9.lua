-- Variables that are used on both client and server
SWEP.Gun = "m9k_tec9" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Submachine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "TEC-9" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2
SWEP.SlotPos                = 53
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"



SWEP.ViewModelFOV           = 60
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_tec_9_smg.mdl"
SWEP.WorldModel             = "models/weapons/w_intratec_tec9.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Weapon_Tec9.Single"
SWEP.Primary.RPM            = 825 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 32
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.1 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "smg1" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 17 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .029 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .019 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 4.314, -1.216, 2.135 )
SWEP.SightsAng              = Vector( 0, 0, 0 )
SWEP.RunSightsPos           = Vector( -5.434, -1.181, 0.393 )
SWEP.RunSightsAng           = Vector( -6.89, -42.166, 0 )
