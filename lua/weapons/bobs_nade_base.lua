-- Variables that are used on both client and server
-- this is almost all code from Generic Default, I just decided to streamline it for new sweps.
-- so thanks GD! your stuff rocks! :D
SWEP.Gun                    = ("") -- must be the name of your swep but NO CAPITALS!
SWEP.Category               = ""
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4
SWEP.SlotPos                = 3
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 2
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "grenade"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_eq_FragGrenade.mdl"
SWEP.WorldModel             = "models/weapons/w_eq_FragGrenade.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = ""
SWEP.Primary.RPM            = 60 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Grenade"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = ("") --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( 0, 0, 0 ) -- These are the same as IronSightPos and IronSightAng
SWEP.SightsAng              = Vector( 0, 0, 0 ) -- No, I don't know why
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( 0, 0, 0 )

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    if owner:IsNPC() then return end
    if not self:CanPrimaryAttack() then return end
    self:SendWeaponAnim( ACT_VM_PULLPIN )

    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
    if CLIENT then return end

    timer.Simple( 0.6, function()
        if not IsValid( self ) then return end
        if IsValid( owner ) then
            self:Throw()
        end
    end )
end

function SWEP:Throw()
    local owner = self:GetOwner()

    self:SendWeaponAnim( ACT_VM_THROW )
    timer.Simple( 0.35, function()
        if not IsValid( self ) then return end
        if not IsValid( owner ) then return end

        owner:SetAnimation( PLAYER_ATTACK1 )

        local aim = owner:GetAimVector()
        local side = aim:Cross( Vector( 0, 0, 1 ) )
        local up = side:Cross( aim )
        local pos = owner:M9K_GetShootPos() + side * 5 + up * -1

        local grenade = ents.Create( self.Primary.Round )
        if not grenade:IsValid() then return end

        grenade._m9kOwner = owner
        grenade.DoNotDuplicate = true
        grenade:SetOwner( owner )
        grenade:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        grenade:SetPos( pos )
        grenade:Spawn()

        local phys = grenade:GetPhysicsObject()
        if owner:KeyDown( IN_ATTACK2 ) and phys:IsValid() then
            phys:ApplyForceCenter( owner:GetAimVector() * 2000 )
        else
            phys:ApplyForceCenter( owner:GetAimVector() * 5500 )
        end

        self:TakePrimaryAmmo( 1 )

        timer.Simple( 0.15, function()
            if not IsValid( self ) then return end
            if not IsValid( owner ) then return end

            if self:Clip1() == 0 and owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 then
                owner:StripWeapon( self.Gun )
            else
                self:DefaultReload( ACT_VM_DRAW )
            end
        end )
    end )
end

function SWEP:Think()
end

function SWEP:SecondaryAttack()
end
