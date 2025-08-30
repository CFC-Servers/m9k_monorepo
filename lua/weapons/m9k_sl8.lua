-- Variables that are used on both client and server
SWEP.Gun = "m9k_sl8" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Sniper Rifles"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "HK SL8"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 3
SWEP.SlotPos                = 47
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false
SWEP.XHair                    = false        -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.Weight                = 50
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.BoltAction                = false
SWEP.HoldType                 = "ar2"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_hk_sl8.mdl"
SWEP.WorldModel                = "models/weapons/w_hk_sl8.mdl"
SWEP.Base                 = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true

SWEP.Primary.Sound            = "Weapon_hksl8.Single"
SWEP.Primary.RPM                = 300        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 30
SWEP.Primary.DefaultClip            = 60
SWEP.Primary.KickUp                = .6                -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = .6            -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = .6        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = true        -- Automatic/Semi Auto
SWEP.Primary.Ammo            = "ar2"    -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets
SWEP.SelectiveFire        = true

SWEP.Secondary.ScopeZoom            = 4
SWEP.Secondary.UseACOG            = true -- Choose one scope type
SWEP.Secondary.UseMilDot        = false
SWEP.Secondary.UseSVD            = false
SWEP.Secondary.UseParabolic        = false
SWEP.Secondary.UseElcan            = false
SWEP.Secondary.UseGreenDuplex    = false
SWEP.Secondary.UseAimpoint        = false
SWEP.Secondary.UseMatador        = false

SWEP.data                 = {}
SWEP.data.ironsights        = 1
SWEP.ScopeScale             = 0.9
SWEP.ReticleScale             = 0.7

SWEP.Primary.NumShots    = 1        --how many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 60    --base damage per bullet
SWEP.Primary.SpreadHip        = .015    --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .001 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos = Vector(3.079, -1.333, 0.437)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-6.22, -5.277, 0)
SWEP.RunSightsAng = Vector(-10.671, -64.598, 0)
