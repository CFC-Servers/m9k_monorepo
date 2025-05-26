-- Variables that are used on both client and server
SWEP.Gun = "m9k_an94" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Assault Rifles"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "AN-94" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 2 -- Slot in the weapon selection menu
SWEP.SlotPos                = 25 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "ar2" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 55
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_rif_an_94.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_rif_an_94.mdl" -- Weapon world model
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "an94.Single" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 600 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.1 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "ar2" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.SelectiveFire          = true

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 31 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .015 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .005 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 4.552, 0, 2.95 )
SWEP.SightsAng              = Vector( 0.93, -0.5, 0 )
SWEP.RunSightsPos           = Vector( -5.277, -8.584, 2.598 )
SWEP.RunSightsAng           = Vector( -12.954, -52.088, 0 )

SWEP.Primary.Burst          = false

function SWEP:SelectFireMode()
    if self.Primary.Burst then
        self.Primary.Burst = false
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            self:GetOwner():PrintMessage( HUD_PRINTTALK, "Automatic selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
        self.Primary.NumShots  = 1
        self.Primary.Sound     = "an94.single"
        self.Primary.Automatic = true
        self.Primary.RPM       = 600
    else
        self.Primary.Burst = true
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            self:GetOwner():PrintMessage( HUD_PRINTTALK, "Burst fire selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
        self.Primary.NumShots  = 2
        self.Primary.Sound     = "an94.double"
        self.Primary.Automatic = false
        self.Primary.RPM       = 300
    end
end

SWEP.Primary.PrevShots = SWEP.Primary.NumShots

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        self.ShootThese = self.Primary.NumShots

        if self.Primary.Burst then
            if self.Primary.NumShots > self:GetOwner():GetActiveWeapon():Clip1() then
                self.Primary.NumShots = 1
                self.ShootThese       = 1
                self.Primary.Sound    = "an94.single"
            else
                self.Primary.NumShots = 2
                self.ShootThese       = 2
                self.Primary.Sound    = "an94.double"
            end
        end

        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
            self:ShootBulletInformation()
            self:TakePrimaryAmmo( self.ShootThese )
            self:FireAnimation()

            local fx = EffectData()
            fx:SetEntity( self )
            fx:SetOrigin( self:GetOwner():M9K_GetShootPos() )
            fx:SetNormal( self:GetOwner():GetAimVector() )
            fx:SetAttachment( self.MuzzleAttachment )

            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:GetOwner():MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            self:CheckWeaponsAndAmmo()
            self.RicochetCoin = (math.random( 1, 4 ))
            if self.BoltAction then self:BoltBack() end
        end
    elseif self:CanPrimaryAttack() and self:GetOwner():IsNPC() then
        self:ShootBulletInformation()
        self:TakePrimaryAmmo( self.ShootThese )
        self:EmitSound( self.Primary.Sound )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:GetOwner():MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        self.RicochetCoin = (math.random( 1, 4 ))
    end
end
