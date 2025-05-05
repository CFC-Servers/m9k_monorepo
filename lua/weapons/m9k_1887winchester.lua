-- Variables that are used on both client and server
SWEP.Gun = "m9k_1887winchester" -- must be the name of your swep but NO CAPITALS!
SWEP.Category               = "M9K Shotguns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Winchester 87" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3 -- Slot in the weapon selection menu
SWEP.SlotPos                = 30 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 3 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "shotgun" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_1887winchester.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_winchester_1887.mdl" -- Weapon world model
SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = "1887winch.Single" -- script that calls the primary fire sound
SWEP.Primary.RPM            = 70 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 4 -- Size of a clip
SWEP.Primary.DefaultClip    = 12 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.8 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.6 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "buckshot" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.ShellTime              = .67

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 10 -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage         = 10 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .042 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .042 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 4.84, 0, 1.2 )
SWEP.SightsAng              = Vector( 0, 0, 2.295 )
SWEP.RunSightsPos           = Vector( -2.3095, -3.0514, 2.3965 )
SWEP.RunSightsAng           = Vector( -19.8471, -33.9181, 10 )
SWEP.IronsightsBlowback = false
