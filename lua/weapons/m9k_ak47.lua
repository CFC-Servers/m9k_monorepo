-- Variables that are used on both client and server
SWEP.Gun = "m9k_ak47" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Assault Rifles"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "AK-47" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2
SWEP.SlotPos                = 22
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"



SWEP.SelectiveFire          = true

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_dot_ak47.mdl"
SWEP.WorldModel             = "models/weapons/w_ak47_m9k.mdl"
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "47ak.Single"
SWEP.Primary.RPM            = 600 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 65 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 30 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .023 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .013 -- Ironsight accuracy, should be the same for shotguns

-- SWEP.IronSightsPos = Vector(4.394, -3.75, 1.48)
-- SWEP.IronSightsAng = Vector(1.419, -0.35, 0)
-- SWEP.SightsPos = Vector(4.394, -3.75, 1.48)
-- SWEP.SightsAng = Vector(1.419, -0.35, 0)

SWEP.SightsPos              = Vector( 4.539, -4.238, 1.799 )
SWEP.SightsAng              = Vector( 0.958, -0.021, 0 )
SWEP.RunSightsPos           = Vector( -1.841, -3.386, 0.708 )
SWEP.RunSightsAng           = Vector( -7.441, -41.614, 0 )
