-- Variables that are used on both client and server
SWEP.Gun = "m9k_luger" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Pistols"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "P08 Luger" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 1 -- Slot in the weapon selection menu
SWEP.SlotPos                = 24 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 3 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "pistol" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_p08_luger.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_luger_p08.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "weapon_luger.single" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 825 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 8 -- Size of a clip
SWEP.Primary.DefaultClip    = 45 -- Bullets you start with
SWEP.Primary.KickUp         = 0.35 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "pistol"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 23 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .021 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .011 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 2.71, -2.122, 2.27 )
SWEP.SightsAng              = Vector( 0.563, -0.013, 0 )
SWEP.RunSightsPos           = Vector( 0, 0, 2.575 )
SWEP.RunSightsAng           = Vector( -14.657, 0, 0 )
