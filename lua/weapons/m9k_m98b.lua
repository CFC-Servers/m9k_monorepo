-- Variables that are used on both client and server
SWEP.Gun = "m9k_m98b" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Sniper Rifles"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Barret M98B"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 3
SWEP.SlotPos                = 44
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false
SWEP.XHair                    = false        -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.Weight                = 50
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.BoltAction                = true
SWEP.HoldType                 = "rpg"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_m98bravo.mdl"
SWEP.WorldModel                = "models/weapons/w_barrett_m98b.mdl"
SWEP.Base                 = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true

SWEP.Primary.Sound            = "M98.Single"
SWEP.Primary.RPM                = 50        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 10
SWEP.Primary.DefaultClip            = 60
SWEP.Primary.KickUp                = 1                -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 1            -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 1        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic/Semi Auto
SWEP.Primary.Ammo            = "SniperPenetratedRound"    -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.ScopeZoom            = 9
SWEP.Secondary.UseACOG            = false -- Choose one scope type
SWEP.Secondary.UseMilDot        = false
SWEP.Secondary.UseSVD            = false
SWEP.Secondary.UseParabolic        = true
SWEP.Secondary.UseElcan            = false
SWEP.Secondary.UseGreenDuplex    = false
SWEP.Secondary.UseAimpoint        = false
SWEP.Secondary.UseMatador        = false

SWEP.data                 = {}
SWEP.data.ironsights        = 1
SWEP.ScopeScale             = 0.7
SWEP.ReticleScale             = 0.6

SWEP.Primary.NumShots    = 1        --how many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 90    --base damage per bullet
SWEP.Primary.SpreadHip        = .001    --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .0001 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos = Vector(-2.196, -2, 1)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(3.714, -3.714, 0.286)
SWEP.RunSightsAng = Vector(-7, 43, 0)

