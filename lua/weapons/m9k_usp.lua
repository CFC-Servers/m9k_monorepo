-- Variables that are used on both client and server
SWEP.Gun = "m9k_usp" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Pistols"
SWEP.Author                = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "HK USP"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 1
SWEP.SlotPos                = 34
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 3
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "pistol"



SWEP.ViewModelFOV            = 65
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_pist_fokkususp.mdl"
SWEP.WorldModel                = "models/weapons/w_pist_fokkususp.mdl"
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "Weapon_fokkususp.Single"
SWEP.Primary.RPM            = 750            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 15
SWEP.Primary.DefaultClip        = 45
SWEP.Primary.KickUp                = 0.3        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.3        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.3        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "pistol"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 55        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 16    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .02    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .01 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector (-2.5944, 20, 1.1433)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector(3.444, -7.823, -6.27)
SWEP.RunSightsAng = Vector(60.695, 0, 0)
-- SWEP.RunSightsPos = Vector (-1.0917, 0, 1.496)
-- SWEP.RunSightsAng = Vector (-9.6507, -2.5621, 0)
