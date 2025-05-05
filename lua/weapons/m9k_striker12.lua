-- Variables that are used on both client and server
SWEP.Gun = "m9k_striker12" -- must be the name of your swep

SWEP.Category               = "M9K Shotguns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Striker 12" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3 -- Slot in the weapon selection menu
SWEP.SlotPos                = 28 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "ar2"

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_striker_12g.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_striker_12g.mdl" -- Weapon world model
SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = "ShotStriker12.Single" -- script that calls the primary fire sound
SWEP.Primary.RPM            = 365 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 12 -- Size of a clip
SWEP.Primary.DefaultClip    = 36 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = .6 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "buckshot"

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.ShellTime              = .3

SWEP.Primary.NumShots       = 6 -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage         = 8 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .04 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .04 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 3.805, -1.045, 1.805 )
SWEP.SightsAng              = Vector( 2.502, 3.431, 0 )
SWEP.RunSightsPos           = Vector( -3.237, -6.376, 1.167 )
SWEP.RunSightsAng           = Vector( -8.391, -63.543, 0 )

