-- Variables that are used on both client and server
SWEP.Gun = "m9k_m16a4_acog" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Assault Rifles"
SWEP.Author                = "iron angles and models hexed and converted to gmod my Mr Fokkusu"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "M16A4 ACOG"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 2                -- Slot in the weapon selection menu
SWEP.SlotPos                = 35            -- Position in the slot
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- Set false if you want no crosshair from hip
SWEP.Weight                = 30            -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo            = true        -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom            = true        -- Auto switch from if you pick up a better weapon
SWEP.XHair                    = true        -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction                = false        -- Is this a bolt action rifle?
SWEP.HoldType                 = "ar2"        -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_M16_acog.mdl"    -- Weapon view model
SWEP.WorldModel                = "models/weapons/w_dmg_m16ag.mdl"    -- Weapon world model
SWEP.Base                 = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true

SWEP.Primary.Sound            = "Dmgfok_M16A4.Single"        -- script that calls the primary fire sound
SWEP.Primary.RPM                = 850        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 30        -- Size of a clip
SWEP.Primary.DefaultClip            = 60    -- Bullets you start with
SWEP.Primary.KickUp            = .4                -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = .4            -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal            = .6        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic/Semi Auto
SWEP.Primary.Ammo            = "ar2"    -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets
SWEP.SelectiveFire        = true

SWEP.Secondary.ScopeZoom            = 4
SWEP.Secondary.UseACOG            = true -- Choose one scope type
SWEP.Secondary.UseMilDot        = false    -- I mean it, only one
SWEP.Secondary.UseSVD            = false    -- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic        = false
SWEP.Secondary.UseElcan            = false
SWEP.Secondary.UseGreenDuplex    = false

SWEP.data                 = {}
SWEP.data.ironsights            = 1
SWEP.ScopeScale             = 0.5
SWEP.ReticleScale                 = 0.6

SWEP.Primary.NumShots    = 1        --how many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 30    --base damage per bullet
SWEP.Primary.SpreadHip        = .015    --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .01 -- ironsight accuracy, should be the same for shotguns


SWEP.SightsPos = Vector (2.275, -2.9708, 0.5303)
SWEP.SightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (-3.0328, 0, 1.888)
SWEP.RunSightsAng = Vector (-24.2146, -36.522, 10)
