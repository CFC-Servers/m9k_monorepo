-- Variables that are used on both client and server
SWEP.Gun = "m9k_amd65" -- must be the name of your swep

SWEP.Category               = "M9K Assault Rifles"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "AMD 65" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2
SWEP.SlotPos                = 24
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "ar2"

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_amd_65.mdl"
SWEP.WorldModel             = "models/weapons/w_amd_65.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "amd65.single"
SWEP.Primary.RPM            = 750 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 20
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = .7 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.2 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.4 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2"

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 31 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .021 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .011 -- Ironsight accuracy, should be the same for shotguns


SWEP.SelectiveFire = true

SWEP.SightsPos     = Vector( 3.5, -1, 2.115 )
SWEP.SightsAng     = Vector( -3.701, 0, 0 )
SWEP.RunSightsPos  = Vector( -5.198, -9.164, 0 )
SWEP.RunSightsAng  = Vector( -8.825, -70, 0 )
