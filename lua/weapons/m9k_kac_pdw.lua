-- Variables that are used on both client and server
SWEP.Gun = ("m9k_kac_pdw") -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Submachine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "KAC PDW" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2 -- Slot in the weapon selection menu
SWEP.SlotPos                = 44 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "smg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_kac_pdw1.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_kac_pdw.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "KAC_PDW.Single" -- Script that calls the primary fire sound
SWEP.Primary.SilencedSound  = "KAC_PDW.SilentSingle"
SWEP.Primary.RPM            = 600 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.2 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "smg1" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.CanBeSilenced          = true

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 15 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .025 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 3.342, 0, 0.514 )
SWEP.SightsAng              = Vector( 2.46, -0.025, 0 )
SWEP.RunSightsPos           = Vector( -4.646, -4.173, 0 )
SWEP.RunSightsAng           = Vector( -10.197, -53.189, 0 )
