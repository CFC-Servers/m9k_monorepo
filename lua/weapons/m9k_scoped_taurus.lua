-- Variables that are used on both client and server
SWEP.Gun = "m9k_scoped_taurus" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Pistols"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.PrintName                = "Raging Bull - Scoped"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 1
SWEP.SlotPos                = 32
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true
SWEP.Weight                = 30
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.XHair                    = true        -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction                = false
SWEP.HoldType                 = "revolver"



SWEP.ViewModelFOV            = 65
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_raging_bull_scoped.mdl"
SWEP.WorldModel                = "models/weapons/w_raging_bull_scoped.mdl"
SWEP.ShowWorldModel            = true
SWEP.Base                 = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true

SWEP.Primary.Sound            = "weapon_r_bull.single"
SWEP.Primary.RPM                = 115        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 6
SWEP.Primary.DefaultClip            = 30
SWEP.Primary.KickUp            = 10                -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = .5            -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal            = 1        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic/Semi Auto
SWEP.Primary.Ammo            = "357"    -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.ScopeZoom            = 3
SWEP.Secondary.UseACOG            = false -- Choose one scope type
SWEP.Secondary.UseMilDot        = true
SWEP.Secondary.UseSVD            = false
SWEP.Secondary.UseParabolic        = false
SWEP.Secondary.UseElcan            = false
SWEP.Secondary.UseGreenDuplex    = false
SWEP.Secondary.UseAimpoint        = false

SWEP.data                 = {}
SWEP.data.ironsights            = 1
SWEP.ScopeScale             = 0.7
SWEP.ReticleScale                 = 0.6

SWEP.Primary.Damage        = 31    --base damage per bullet
SWEP.Primary.SpreadHip        = .02    --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .0001 -- ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector(2.773, 0, 0.846)
SWEP.SightsAng = Vector(-0.157, 0, 0)
SWEP.RunSightsPos = Vector(0, 2.95, 0)
SWEP.RunSightsAng = Vector(-13.197, 5.737, 0)
