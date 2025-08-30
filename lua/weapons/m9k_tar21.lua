-- Variables that are used on both client and server
SWEP.Gun = "m9k_tar21" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Assault Rifles"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "TAR-21"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 2
SWEP.SlotPos                = 38
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 30
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "rpg"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_imi_tavor.mdl"
SWEP.WorldModel                = "models/weapons/w_imi_tar21.mdl"
SWEP.ShowWorldModel            = true
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "Wep_imitavor.single"
SWEP.Primary.RPM            = 900            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 30
SWEP.Primary.DefaultClip        = 60
SWEP.Primary.KickUp                = 0.3        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.3        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.3        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "ar2"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 55        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 30    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .027    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .016 -- Ironsight accuracy, should be the same for shotguns

SWEP.SelectiveFire        = true

SWEP.SightsPos = Vector(-1.825, 0.685, 0.155)
SWEP.SightsAng = Vector(0.768, 0, 0)
SWEP.RunSightsPos = Vector(3.858, 0.079, -1.025)
SWEP.RunSightsAng = Vector(-5.237, 49.648, 0)
