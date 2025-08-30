-- Variables that are used on both client and server
SWEP.Gun = "m9k_contender" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                 = "M9K Sniper Rifles"
SWEP.Author                   = ""
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Thompson Contender G2" -- Weapon name (Shown on HUD)
SWEP.Slot                     = 3
SWEP.SlotPos                  = 40
SWEP.DrawAmmo                 = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false
SWEP.XHair                    = false -- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.Weight                   = 50
SWEP.AutoSwitchTo             = true
SWEP.AutoSwitchFrom           = true
SWEP.BoltAction               = true
SWEP.HoldType                 = "rpg"



SWEP.ViewModelFOV             = 70
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_contender2.mdl"
SWEP.WorldModel               = "models/weapons/w_g2_contender.mdl"
SWEP.Base                     = "bobs_scoped_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable           = true

SWEP.Primary.Sound            = "contender_g2.Single"
SWEP.Primary.RPM              = 35 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize         = 1
SWEP.Primary.DefaultClip      = 60
SWEP.Primary.KickUp           = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = 1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = 1 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = false -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.ScopeZoom      = 9
SWEP.Secondary.UseACOG        = false -- Choose one scope type
SWEP.Secondary.UseMilDot      = true
SWEP.Secondary.UseSVD         = false
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false
SWEP.Secondary.UseAimpoint    = false
SWEP.Secondary.UseMatador     = false

SWEP.data                     = {}
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.7
SWEP.ReticleScale             = 0.6

SWEP.Primary.NumShots         = 1 --how many bullets to shoot per trigger pull
SWEP.Primary.Damage           = 85 --base damage per bullet
SWEP.Primary.SpreadHip           = .01 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights     = .00015 -- ironsight accuracy, should be the same for shotguns

SWEP.SightsPos                = Vector( -3, -0.857, 0.36 )
SWEP.SightsAng                = Vector( 0, 0, 0 )
SWEP.RunSightsPos             = Vector( 3.714, -1.429, 0 )
SWEP.RunSightsAng             = Vector( -11, 31, 0 )

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    if owner:IsNPC() then return end
    if not self:CanPrimaryAttack() then return end
    if owner:KeyDown( IN_SPEED ) then return end

    self.RicochetCoin = math.random( 1, 4 )
    self:ShootBulletInformation()
    self:EmitSound( self.Primary.Sound )
    self:TakePrimaryAmmo( 1 )
    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

    local fx = EffectData()
    fx:SetEntity( self )
    fx:SetOrigin( owner:M9K_GetShootPos() )
    fx:SetNormal( owner:GetAimVector() )
    fx:SetAttachment( self.MuzzleAttachment )
    util.Effect( "rg_muzzle_rifle", fx )

    owner:SetAnimation( PLAYER_ATTACK1 )
    owner:MuzzleFlash()
    self:SetNextPrimaryFire( CurTime() + 10 )

    self:UseBolt()
end

function SWEP:UseBolt()
    if CLIENT then return end

    local owner = self:GetOwner()

    if owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 then
        if not IsValid( self ) or not IsValid( owner ) then return end
        self:SetReloading( true )

        owner:SetFOV( 0, 0.3 )
        self:SetIronsights( false )
        owner:DrawViewModel( true )

        local boltactiontime = owner:GetViewModel():SequenceDuration()
        timer.Simple( boltactiontime, function()
            if not IsValid( self ) or not IsValid( owner ) then return end
            self:SetReloading( false )
            if owner:KeyDown( IN_ATTACK2 ) then
                owner:SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
                self.IronSightsPos = self.SightsPos -- Bring it up
                self.IronSightsAng = self.SightsAng -- Bring it up
                self.DrawCrosshair = false
                self:SetIronsights( true )
                owner:DrawViewModel( false )
                owner:RemoveAmmo( 1, self.Primary.Ammo, false ) -- out of the frying pan
                self:SetClip1( self:Clip1() + 1 ) --  into the fire
                self:SetNextPrimaryFire( CurTime() + .1 )
            elseif not owner:KeyDown( IN_ATTACK2 ) then
                owner:RemoveAmmo( 1, self.Primary.Ammo, false ) -- out of the frying pan
                self:SetClip1( self:Clip1() + 1 ) --  into the fire
                self:SetNextPrimaryFire( CurTime() + .1 )
            end
        end )
    else
        self:CheckWeaponsAndAmmo()
    end
end

function SWEP:Reload()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end

    if self:GetNextPrimaryFire() > (CurTime() + 1) then
        return
    else
        if owner:IsNPC() then
            self:DefaultReload( ACT_VM_RELOAD )
            return
        end

        if owner:KeyDown( IN_USE ) then return end

        if self.SilencerAttached then
            self:DefaultReload( ACT_VM_RELOAD_SILENCED )
        else
            self:DefaultReload( ACT_VM_RELOAD )
        end

        if not owner:IsNPC() then
            if owner:GetViewModel() == nil then
                self.ResetSights = CurTime() + 3
            else
                self.ResetSights = CurTime() + owner:GetViewModel():SequenceDuration()
            end
        end

        if SERVER then
            if (self:Clip1() < self.Primary.ClipSize) and not owner:IsNPC() then
                -- --When the current clip < full clip and the rest of your ammo > 0, then
                owner:SetFOV( 0, 0.3 )
                -- --Zoom = 0
                self:SetIronsights( false )
                self:SetReloading( true )
            end
            local waitdammit = owner:GetViewModel():SequenceDuration()
            timer.Simple( waitdammit, function()
                if not IsValid( self ) then return end
                self:SetReloading( false )

                if owner:KeyDown( IN_ATTACK2 ) then
                    if CLIENT then return end
                    if self.Scoped == false then
                        owner:SetFOV( self.Secondary.IronFOV, 0.3 )
                        self.IronSightsPos = self.SightsPos -- Bring it up
                        self.IronSightsAng = self.SightsAng -- Bring it up
                        self:SetIronsights( true )
                        self.DrawCrosshair = false
                    end
                elseif owner:KeyDown( IN_SPEED ) then
                    if self:GetNextPrimaryFire() <= (CurTime() + .03) then
                        self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
                    end
                    self.IronSightsPos = self.RunSightsPos -- Hold it down
                    self.IronSightsAng = self.RunSightsAng -- Hold it down
                    self:SetIronsights( true )
                    owner:SetFOV( 0, 0.3 )
                end
            end )
        end
    end
end
