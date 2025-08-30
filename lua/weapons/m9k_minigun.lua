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
SWEP.Slot                   = 3
SWEP.SlotPos                = 37
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "crossbow"



SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_minigunvulcan.mdl"
SWEP.WorldModel             = "models/weapons/w_m134_minigun.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.DeployDelay = 1
SWEP.Primary.Sound          = "BlackVulcan.Single"
SWEP.Primary.RPM            = 3500 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 300
SWEP.Primary.DefaultClip    = 600
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

function SWEP:Reload()
    local owner = self:GetOwner()

    self:DefaultReload( ACT_VM_RELOAD )
    if not owner:IsNPC() then
        self.ResetSights = CurTime() + owner:GetViewModel():SequenceDuration()
    end
    if (self:Clip1() < self.Primary.ClipSize) and not owner:IsNPC() then
        -- When the current clip < full clip and the rest of your ammo > 0, then
        owner:SetFOV( 0, 0.3 )
        -- Zoom = 0
        self:SetIronsights( false )
        self:SetReloading( true )
    end
    local waitdammit = (owner:GetViewModel():SequenceDuration())
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
    local owner = self:GetOwner()

    if owner:KeyDown( IN_SPEED ) and not (self:GetReloading()) then -- If you run then
        self:SetNextPrimaryFire( CurTime() + 0.5 ) -- Make it so you can't shoot for another quarter second
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true )
        owner:SetFOV( 0, 0.3 ) -- Reset FOV
    end

    if owner:KeyReleased( IN_SPEED ) then -- If you stop running then
        self:SetIronsights( false )
        owner:SetFOV( 0, 0.3 ) -- Reset FOV
    end
end
