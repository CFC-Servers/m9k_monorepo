-- Variables that are used on both client and server
SWEP.Gun = "m9k_ied_detonator" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = "Fire to drop ied." .. "\n" .. "Alt fire to detonate"
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "IED Detonator" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4
SWEP.SlotPos                = 25
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 2
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "pistol"



SWEP.ViewModelFOV           = 75
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_invisib.mdl"
SWEP.WorldModel             = "models/weapons/w_camphon2.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = ""
SWEP.Primary.RPM            = 60 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Improvised_Explosive"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round = "m9k_improvised_explosive"

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!
SWEP.Secondary.ClipSize     = 1
SWEP.Secondary.DefaultClip  = 1 -- Default number of bullets in a clip
SWEP.Secondary.Automatic    = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo         = ""

SWEP.Primary.NumShots = 0
SWEP.Primary.Damage = 0
SWEP.Primary.SpreadHip = 0
SWEP.Primary.SpreadIronSights = 0

SWEP.ViewModel = "models/weapons/v_invisib.mdl"
SWEP.ViewModelBoneMods = {
    ["r-ring-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.148, 0 ), angle = Angle( 14.43, 0, 0 ) },
    ["r-middle-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -77.495, 0, 0 ) },
    ["r-pinky-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -101.027, 0, 0 ) },
    ["r-ring-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -86.765, 0, 0 ) },
    ["r-index-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -3.405, 0, 0 ) },
    ["r-forearm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 3.042, 100.974 ) },
    ["r-thumb-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 38.379, 0, 0 ) },
    ["r-index-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -108.598, 0, 0 ) },
    ["r-middle-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 4.488, 0, 0 ) },
    ["r-pinky-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 25.802, 0, 0 ) },
    ["r-thumb-tip"] = { scale = Vector( 1, 0.845, 0.989 ), pos = Vector( 0, 0, 0 ), angle = Angle( -17.769, 0, 0 ) },
    ["r-thumb-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -13.4, 32.006, -34.099 ) }
}
SWEP.VElements         = {
    ["phone"] = { type = "Model", model = "models/weapons/w_camphon2.mdl", bone = "Da Machete", rel = "", pos = Vector( -4.327, 6.361, 15.64 ), angle = Angle( 141.658, -25.886, -28.254 ), size =
        Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:PrimaryAttack()
    if self:Clip1() <= 0 then
        self:Reload()
        return false
    end

    self:TakePrimaryAmmo( 1 )
    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )

    if CLIENT then return end

    local aim = self:GetOwner():GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = self:GetOwner():M9K_GetShootPos() + side * -5 + up * -10

    local rocket = ents.Create( self.Primary.Round )
    if not rocket:IsValid() then return false end

    rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
    rocket:SetPos( pos )
    rocket.BombOwner = self:GetOwner()
    rocket:Spawn()

    local phys = rocket:GetPhysicsObject()
    phys:ApplyForceCenter( self:GetOwner():GetAimVector() * 1500 )
    self:SendWeaponAnim( ACT_VM_DRAW )

    timer.Simple( 1 / ( self.Primary.RPM / 60 ), function()
        if not IsValid( self ) then return end
        self:Reload()
    end )
end

function SWEP:Reload()
    if self:Clip1() >= 1 then return end

    local ammo = self:GetOwner():GetAmmoCount( self.Primary.Ammo )
    if ammo <= 0 then return end

    self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo )
    self:SetClip1( 1 )
end

if SERVER then
    function SWEP:SecondaryAttack()
        for _, v in pairs( ents.FindByClass( "m9k_improvised_explosive" ) ) do
            if v.BombOwner == self:GetOwner() then
                v.Boom = true
            end
        end

        self:CheckWeaponsAndAmmo()
    end
end
