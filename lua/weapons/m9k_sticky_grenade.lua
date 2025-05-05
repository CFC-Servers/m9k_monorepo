-- Variables that are used on both client and server
SWEP.Gun = "m9k_sticky_grenade" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Specialties"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Sticky Grenade"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 4                -- Slot in the weapon selection menu
SWEP.SlotPos                = 24            -- Position in the slot
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false        -- set false if you want no crosshair
SWEP.Weight                = 2            -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo            = true        -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom            = true        -- Auto switch from if you pick up a better weapon
SWEP.HoldType                 = "grenade"        -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_sticky_grenade.mdl"    -- Weapon view model
SWEP.WorldModel                = "models/weapons/w_sticky_grenade.mdl"    -- Weapon world model
SWEP.ShowWorldModel            = false
SWEP.Base                = "bobs_nade_base" --just fixing some junk, trying to isolate a bug
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater         = true

SWEP.Primary.Sound            = Sound("")        -- Script that calls the primary fire sound
SWEP.Primary.RPM                = 30        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 1        -- Size of a clip
SWEP.Primary.DefaultClip        = 1        -- Bullets you start with
SWEP.Primary.KickUp                = 0        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "StickyGrenade"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round             = "m9k_thrown_sticky_grenade"    --NAME OF ENTITY GOES HERE

--  none of this matters for IEDs and other ent-tossing sweps, but here it is anyway
SWEP.Secondary.IronFOV            = 0        -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots    = 0        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 0    -- Base damage per bullet
SWEP.Primary.SpreadHip        = 0    -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = 0 -- Ironsight accuracy, should be the same for shotguns

-- enter bone mod and other custom stuff below. Irons aren't used for grenades

-- SWEP.WElements = {
    -- ["mr blue"] = { type = "Model", model = "models/weapons/w_sticky_grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.213, 1.845, -1.851), angle = Angle(-2.809, -93.604, -157.971), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
-- }

SWEP.ViewModelBoneMods = {
    ["v_weapon.Flashbang_Parent"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.391), angle = Angle(0, 0, 0) },
    ["v_weapon.Root17"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.864, 11.555, 0) }
}

SWEP.WElements = {
    ["mr blue"] = { type = "Model", model = "models/weapons/w_sticky_grenade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.322, 2.828, -1.349), angle = Angle(180, -3.81, 5.743), size = Vector(1.376, 1.376, 1.376), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
