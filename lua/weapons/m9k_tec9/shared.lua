-- Variables that are used on both client and server
SWEP.Gun = ("m9k_tec9") -- must be the name of your swep but NO CAPITALS!
if (GetConVar( SWEP.Gun .. "_allowed" )) ~= nil then
    if not (GetConVar( SWEP.Gun .. "_allowed" ):GetBool()) then
        SWEP.Base = "bobs_blacklisted"
        SWEP.PrintName = SWEP.Gun
        return
    end
end
SWEP.Category               = "M9K Submachine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "TEC-9" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2 -- Slot in the weapon selection menu
SWEP.SlotPos                = 53 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox      = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon       = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "ar2" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 60
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_tec_9_smg.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_intratec_tec9.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "Weapon_Tec9.Single" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 825 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 32 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.1 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "smg1" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 17 -- Base damage per bullet
SWEP.Primary.Spread         = .029 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy   = .019 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos          = Vector( 4.314, -1.216, 2.135 )
SWEP.IronSightsAng          = Vector( 0, 0, 0 )
SWEP.SightsPos              = Vector( 4.314, -1.216, 2.135 )
SWEP.SightsAng              = Vector( 0, 0, 0 )
SWEP.RunSightsPos           = Vector( -5.434, -1.181, 0.393 )
SWEP.RunSightsAng           = Vector( -6.89, -42.166, 0 )

if GetConVar( "M9KDefaultClip" ) == nil then
    print( "M9KDefaultClip is missing! You may have hit the lua limit!" )
else
    if GetConVar( "M9KDefaultClip" ):GetInt() ~= -1 then
        SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar( "M9KDefaultClip" ):GetInt()
    end
end

if GetConVar( "M9KUniqueSlots" ) ~= nil then
    if not (GetConVar( "M9KUniqueSlots" ):GetBool()) then
        SWEP.SlotPos = 2
    end
end

