-- Variables that are used on both client and server
SWEP.Gun = "m9k_mp7" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                 = "M9K Submachine Guns"
SWEP.Author                   = ""
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "HK MP7" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 2 -- Slot in the weapon selection menu
SWEP.SlotPos                  = 48 -- Position in the slot
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true -- Set false if you want no crosshair from hip
SWEP.Weight                   = 50 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo             = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom           = true -- Auto switch from if you pick up a better weapon
SWEP.XHair                    = true -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction               = false -- Is this a bolt action rifle?
SWEP.HoldType                 = "ar2" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_mp7_silenced.mdl" -- Weapon view model
SWEP.WorldModel               = "models/weapons/w_mp7_silenced.mdl" -- Weapon world model
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = "Weapon_MP7.single" -- script that calls the primary fire sound
SWEP.Primary.RPM              = 950 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 30 -- Size of a clip
SWEP.Primary.DefaultClip      = 60 -- Bullets you start with
SWEP.Primary.KickUp           = .5 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = .4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = .4 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "smg1" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets
SWEP.SelectiveFire            = true

SWEP.Secondary.ScopeZoom      = 4
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = false -- I mean it, only one
SWEP.Secondary.UseSVD         = false -- If you choose more than one, your scope will not show up at all
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


SWEP.SightsPos                = Vector( 3, -5, 1.5 )
SWEP.SightsAng                = Vector( 0, 0, 0 )
SWEP.RunSightsPos             = Vector( -3.1731, -5.3573, 1.4608 )
SWEP.RunSightsAng             = Vector( -18.7139, -48.1596, 0 )
SWEP.HasBuiltInSilencer = true
