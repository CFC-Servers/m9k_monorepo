-- Variables that are used on both client and server
SWEP.Gun = "m9k_ak74" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Assault Rifles"
SWEP.Author                = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "AK-74"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 2
SWEP.SlotPos                = 23
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 30
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "ar2"



SWEP.SelectiveFire        = true

SWEP.ViewModelFOV            = 65
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_tct_ak47.mdl"
SWEP.WorldModel                = "models/weapons/w_tct_ak47.mdl"
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "Tactic_AK47.Single"
SWEP.Primary.RPM            = 600            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 30
SWEP.Primary.DefaultClip        = 60
SWEP.Primary.KickUp                = 0.4        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.4        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.4        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "ar2"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 55        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 31    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .02    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .01 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector (2.0378, 1, 0.8809)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965)
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)
