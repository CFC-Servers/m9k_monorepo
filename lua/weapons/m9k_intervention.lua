-- Variables that are used on both client and server
SWEP.Gun = "m9k_intervention" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                 = "M9K Sniper Rifles"
SWEP.Author                   = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Intervention" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 3 -- Slot in the weapon selection menu
SWEP.SlotPos                  = 42 -- Position in the slot
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false -- Set false if you want no crosshair from hip
SWEP.XHair                    = false -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.Weight                   = 50 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo             = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom           = true -- Auto switch from if you pick up a better weapon
SWEP.BoltAction               = true -- Is this a bolt action rifle?
SWEP.HoldType                 = "rpg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_snip_int.mdl" -- Weapon view model
SWEP.WorldModel               = "models/weapons/w_snip_int.mdl" -- Weapon world model
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = "Weapon_INT.Single" -- script that calls the primary fire sound
SWEP.Primary.RPM              = 35 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 5 -- Size of a clip
SWEP.Primary.DefaultClip      = 60 -- Bullets you start with
SWEP.Primary.KickUp           = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = .6 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = .4 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = false -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "SniperPenetratedRound" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.ScopeZoom      = 10
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = true -- I mean it, only one
SWEP.Secondary.UseSVD         = false -- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint    = false
SWEP.Secondary.UseMatador     = false

SWEP.data                     = {}
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.7

SWEP.Primary.NumShots         = 1 --how many bullets to shoot per trigger pull
SWEP.Primary.Damage           = 95 --base damage per bullet
SWEP.Primary.SpreadHip           = .01 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights     = .0001 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos                = Vector( 2.2263, -0.0007, 0.115 )
SWEP.SightsAng                = Vector( 0, 0, 0 )
SWEP.RunSightsPos             = Vector( -2.3095, -3.0514, 1.3965 )
SWEP.RunSightsAng             = Vector( -19.8471, -33.9181, 10 )
