-- Variables that are used on both client and server
SWEP.Gun = "m9k_jackhammer" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Shotguns"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Pancor Jackhammer"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 3
SWEP.SlotPos                = 23
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 30
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "ar2"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_jackhammer2.mdl"
SWEP.WorldModel                = "models/weapons/w_pancor_jackhammer.mdl"
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "Weapon_Jackhammer.Single"
SWEP.Primary.RPM            = 240            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 10
SWEP.Primary.DefaultClip        = 30
SWEP.Primary.KickUp                = 1        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.5        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.4        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "buckshot"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 60        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 6        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 10    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .045    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .045 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector(4.026, -2.296, 0.917)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-3.116, -3.935, 0.492)
SWEP.RunSightsAng = Vector(-19.894, -47.624, 10.902)
