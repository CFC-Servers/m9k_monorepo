-- Variables that are used on both client and server
SWEP.Gun = "m9k_minigun" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Machine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "M134 Minigun" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3
SWEP.SlotPos                = 37
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "shotgun"

SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_minigunvulcan.mdl"
SWEP.WorldModel             = "models/weapons/w_m134_minigun.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.DeployDelay = 1
SWEP.Primary.Sound          = "BlackVulcan.Single"
SWEP.Primary.RPM            = 3500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 300
SWEP.Primary.DefaultClip    = 600
SWEP.Primary.KickUp         = 1.5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 25 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .035 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .035 -- Ironsight accuracy, should be the same for shotguns

SWEP.RunSightsPos           = Vector( 0, -11.148, -8.033 )
SWEP.RunSightsAng           = Vector( 55.082, 0, 0 )

function SWEP:IronSight()
end