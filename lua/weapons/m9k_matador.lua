-- Variables that are used on both client and server
SWEP.Gun = "m9k_matador" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Matador" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 33 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "rpg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_MAT.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_GDCW_MATADOR_RL.mdl" -- Weapon world model
SWEP.Base                   = "bobs_scoped_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 60 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1 -- Size of a clip
SWEP.Primary.DefaultClip    = 4 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "matador_rocket"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_gdcwa_matador_90mm" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!
SWEP.Secondary.UseMatador   = true
SWEP.Secondary.ScopeZoom    = 4
SWEP.Boltaction             = false

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.ScopeScale             = 1
SWEP.ReticleScale           = 0.5
SWEP.SightsPos              = Vector( -3.0556, -8.6664, 1.4751 )
SWEP.SightsAng              = Vector( 0, 0, 0 )
SWEP.RunSightsPos           = Vector( 2.4946, -1.5644, 1.699 )
SWEP.RunSightsAng           = Vector( -20.1104, 35.1164, -12.959 )

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if self:CanPrimaryAttack() and not owner:KeyDown( IN_SPEED ) then
        self:FireRocket()
        self:EmitSound( "MATADORF.single" )
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        owner:SetAnimation( PLAYER_ATTACK1 )
        owner:MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
    end
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    local aim = self:GetOwner():GetAimVector()
    local pos = self:GetOwner():M9K_GetShootPos()

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket:Spawn()
        rocket:Activate()
        util.ScreenShake( self:GetOwner():M9K_GetShootPos(), 1000, 10, 0.3, 500 )
    end
end

function SWEP:SecondaryAttack()
end
