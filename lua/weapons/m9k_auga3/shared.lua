-- Variables that are used on both client and server
SWEP.Gun = ("m9k_auga3") -- must be the name of your swep but NO CAPITALS!
if (GetConVar( SWEP.Gun .. "_allowed" )) ~= nil then
    if not (GetConVar( SWEP.Gun .. "_allowed" ):GetBool()) then
        SWEP.Base = "bobs_blacklisted"
        SWEP.PrintName = SWEP.Gun
        return
    end
end
SWEP.Category                 = "M9K Assault Rifles"
SWEP.Author                   = ""
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Steyr AUG A3" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 2 -- Slot in the weapon selection menu
SWEP.SlotPos                  = 26 -- Position in the slot
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox        = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon         = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair            = true -- Set false if you want no crosshair from hip
SWEP.Weight                   = 30 -- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo             = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom           = true -- Auto switch from if you pick up a better weapon
SWEP.XHair                    = true -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.BoltAction               = false -- Is this a bolt action rifle?
SWEP.HoldType                 = "smg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                = "models/weapons/v_auga3sa.mdl" -- Weapon view model
SWEP.WorldModel               = "models/weapons/w_auga3.mdl" -- Weapon world model
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = Sound( "aug_a3.Single" ) -- script that calls the primary fire sound
SWEP.Primary.RPM              = 700 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 30 -- Size of a clip
SWEP.Primary.DefaultClip      = 60 -- Bullets you start with
SWEP.Primary.KickUp           = .4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = .4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = .5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.SelectiveFire            = true

SWEP.Secondary.ScopeZoom      = 4
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = false -- I mean it, only one
SWEP.Secondary.UseSVD         = false -- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint    = true
SWEP.Secondary.UseMatador     = false

SWEP.data                     = {}
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.5
SWEP.ReticleScale             = 0.6

SWEP.Primary.NumShots         = 1 --how many bullets to shoot per trigger pull
SWEP.Primary.Damage           = 22 --base damage per bullet
SWEP.Primary.Spread           = .025 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy     = .02 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos            = Vector( 2.275, -2.9708, 0.5303 )
SWEP.IronSightsAng            = Vector( 0, 0, 0 )
SWEP.SightsPos                = Vector( 2.275, -2.9708, 0.5303 )
SWEP.SightsAng                = Vector( 0, 0, 0 )
SWEP.RunSightsPos             = Vector( -3.0328, 0, 1.888 )
SWEP.RunSightsAng             = Vector( -24.2146, -36.522, 10 )

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

