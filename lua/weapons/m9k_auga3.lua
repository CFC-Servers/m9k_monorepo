-- Variables that are used on both client and server
SWEP.Gun = "m9k_auga3" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                 = "M9K Assault Rifles"
SWEP.Author                   = ""
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Steyr AUG A3" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 2
SWEP.SlotPos                  = 26
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true
SWEP.Weight                   = 30
SWEP.AutoSwitchTo             = true
SWEP.AutoSwitchFrom           = true
SWEP.XHair                    = true -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction               = false
SWEP.HoldType                 = "smg"



SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_auga3sa.mdl"
SWEP.WorldModel               = "models/weapons/w_auga3.mdl"
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = "aug_a3.Single"
SWEP.Primary.RPM              = 700 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 30
SWEP.Primary.DefaultClip      = 60
SWEP.Primary.KickUp           = .4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = .4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = .5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets
SWEP.SelectiveFire            = true

SWEP.Secondary.ScopeZoom      = 4
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = false
SWEP.Secondary.UseSVD         = false
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint    = true
SWEP.Secondary.UseMatador     = false

SWEP.data                     = {}
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.5
SWEP.ReticleScale             = 0.6

SWEP.Primary.NumShots         = 1 --how many bullets to shoot per trigger pull
SWEP.Primary.Damage           = 22 --base damage per bullet
SWEP.Primary.SpreadHip           = .025 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights     = .02 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos                = Vector( 2.275, -2.9708, 0.5303 )
SWEP.SightsAng                = Vector( 0, 0, 0 )
SWEP.RunSightsPos             = Vector( -3.0328, 0, 1.888 )
SWEP.RunSightsAng             = Vector( -24.2146, -36.522, 10 )
