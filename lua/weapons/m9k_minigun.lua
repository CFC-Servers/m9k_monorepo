-- Variables that are used on both client and server
SWEP.Gun = "m9k_minigun" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Machine Guns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "M134 Minigun" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3 -- Slot in the weapon selection menu
SWEP.SlotPos                = 37 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "crossbow" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_minigunvulcan.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_m134_minigun.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.DeployDelay = 1
SWEP.Primary.Sound          = "BlackVulcan.Single" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 3500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 100 -- Size of a clip
SWEP.Primary.DefaultClip    = 200 -- Bullets you start with
SWEP.Primary.KickUp         = 2 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 1 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 25 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .035 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .035 -- Ironsight accuracy, should be the same for shotguns

SWEP.RunSightsPos           = Vector( 0, -11.148, -8.033 )
SWEP.RunSightsAng           = Vector( 55.082, 0, 0 )
SWEP.Primary.ClipSize       = 300 -- Size of a clip
SWEP.Primary.DefaultClip    = 600 -- Bullets you start with

function SWEP:Reload()
    self:DefaultReload( ACT_VM_RELOAD )
    if not self:GetOwner():IsNPC() then
        self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    end
    if (self:Clip1() < self.Primary.ClipSize) and not self:GetOwner():IsNPC() then
        -- When the current clip < full clip and the rest of your ammo > 0, then
        self:GetOwner():SetFOV( 0, 0.3 )
        -- Zoom = 0
        self:SetIronsights( false )
        self:SetReloading( true )
    end
    local waitdammit = (self:GetOwner():GetViewModel():SequenceDuration())
    self:MiniGunIdle( waitdammit )
end

function SWEP:MiniGunIdle( wait )
    timer.Simple( wait + .05, function()
        if not IsValid( self ) then return end
        self:SetReloading( false )
        if SERVER then
            self:SendWeaponAnim( ACT_VM_IDLE )
        else
            return
        end
    end )
end

function SWEP:IronSight()
    if self:GetOwner():KeyDown( IN_SPEED ) and not (self:GetReloading()) then -- If you run then
        self:SetNextPrimaryFire( CurTime() + 0.5 ) -- Make it so you can't shoot for another quarter second
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true )
        self:GetOwner():SetFOV( 0, 0.3 ) -- Reset FOV
    end

    if self:GetOwner():KeyReleased( IN_SPEED ) then -- If you stop running then
        self:SetIronsights( false )
        self:GetOwner():SetFOV( 0, 0.3 ) -- Reset FOV
    end
end
