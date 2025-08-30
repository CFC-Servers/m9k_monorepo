-- Variables that are used on both client and server
SWEP.Gun = "m9k_winchester73" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Assault Rifles"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "73 Winchester Carbine"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 2
SWEP.SlotPos                = 41
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = true        -- set false if you want no crosshair
SWEP.Weight                = 3
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "ar2"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_winchester1873.mdl"
SWEP.WorldModel                = "models/weapons/w_winchester_1873.mdl"
SWEP.Base                 = "bobs_shotty_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true

SWEP.Primary.Sound            = "Weapon_73.Single"
SWEP.Primary.RPM                = 66        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 8
SWEP.Primary.DefaultClip            = 30    -- Default number of bullets in a clip
SWEP.Primary.KickUp            = .2                -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal            = 0.1    -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic/Semi Auto
SWEP.Primary.Ammo            = "AirboatGun"    -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV            = 60        -- How much you 'zoom' in. Less is more!
SWEP.ShellTime            = .54

SWEP.data                 = {}                --The starting firemode
SWEP.data.ironsights            = 1

SWEP.Primary.NumShots    = 1        -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage        = 85    -- Base damage per bullet
SWEP.Primary.SpreadHip        = .01    -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .001    -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos = Vector(4.356, 0, 2.591)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.GSightsPos = Vector (0, 0, 0)
SWEP.GSightsAng = Vector (0, 0, 0)
SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965)
SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)
SWEP.IronsightsBlowback = false

SWEP.ViewModelBoneMods = {
    ["shell"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
