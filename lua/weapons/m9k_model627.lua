-- Variables that are used on both client and server
SWEP.Gun = "m9k_model627" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Pistols"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "S&W Model 627"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 1
SWEP.SlotPos                = 29
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 3
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "revolver"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_swmodel_627.mdl"
SWEP.WorldModel                = "models/weapons/w_sw_model_627.mdl"
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater = false

SWEP.Primary.Sound            = "model_627perf.Single"
SWEP.Primary.RPM            = 120            -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 6
SWEP.Primary.DefaultClip        = 30
SWEP.Primary.KickUp                = 0.3        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0.3        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0.3        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "357"            -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 60        -- How much you 'zoom' in. Less is more!

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 20    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .01    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .001 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector(2.68, 0.019, 1.521)
SWEP.SightsAng = Vector(-0.141, -0.139, 0)
SWEP.RunSightsPos = Vector(-2.419, -4.467, -4.693)
SWEP.RunSightsAng = Vector(56.766, 0, 0)

