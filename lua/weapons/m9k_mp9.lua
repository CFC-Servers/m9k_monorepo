-- Variables that are used on both client and server
SWEP.Gun = "m9k_mp9" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Submachine Guns"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "MP9"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 2
SWEP.SlotPos                = 49
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 30
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "ar2"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_b_t_mp9.mdl"
SWEP.WorldModel                = "models/weapons/w_brugger_thomet_mp9.mdl"
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "Weapon_mp9.Single"
SWEP.Primary.RPM            = 900            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 30
SWEP.Primary.DefaultClip        = 60
SWEP.Primary.KickUp                = 0.2        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.1        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.2        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "ar2"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire        = true

SWEP.Secondary.IronFOV            = 55        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 20    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .023    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .014 -- Ironsight accuracy, should be the same for shotguns

SWEP.NoMuzzleFlash = true
SWEP.SightsPos = Vector(4.073, -3.438, 1.273)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-3.708, -6.172, 0)
SWEP.RunSightsAng = Vector(-7.661, -62.523, 0)
SWEP.HasBuiltInSilencer = true
