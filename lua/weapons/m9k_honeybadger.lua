-- Variables that are used on both client and server
SWEP.Gun = "m9k_honeybadger" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                 = "M9K Submachine Guns"
SWEP.Author                   = ""
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "AAC Honey Badger" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 2
SWEP.SlotPos                  = 43
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true
SWEP.Weight                   = 50
SWEP.AutoSwitchTo             = true
SWEP.AutoSwitchFrom           = true
SWEP.XHair                    = true -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction               = false
SWEP.HoldType                 = "ar2"



SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_aacbadger.mdl"
SWEP.WorldModel               = "models/weapons/w_aac_honeybadger.mdl"
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = "Weapon_HoneyB.single"
SWEP.Primary.RPM              = 791 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 30
SWEP.Primary.DefaultClip      = 60
SWEP.Primary.KickUp           = .5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = .3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = .5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire            = true

SWEP.Secondary.ScopeZoom      = 3.5
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = false
SWEP.Secondary.UseSVD         = false
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint    = true

SWEP.data                     = {}
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.7

SWEP.Primary.NumShots         = 1 --how many bullets to shoot per trigger pull
SWEP.Primary.Damage           = 24 --base damage per bullet
SWEP.Primary.SpreadHip           = .023 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights     = .014 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos                = Vector( -3.096, -3.695, 0.815 )
SWEP.SightsAng                = Vector( 0.039, 0, 0 )
SWEP.RunSightsPos             = Vector( 4.094, -2.454, -0.618 )
SWEP.RunSightsAng             = Vector( -8.957, 53.188, -9.195 )

SWEP.HasBuiltInSilencer = true