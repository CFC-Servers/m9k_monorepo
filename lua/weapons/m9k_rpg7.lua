-- Variables that are used on both client and server
SWEP.Gun = "m9k_rpg7" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "RPG-7" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 34 -- Position in the slot
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
SWEP.ViewModel              = "models/weapons/v_RL7.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_rl7.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 30 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1 -- Size of a clip
SWEP.Primary.DefaultClip    = 4 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "rpg_rocket"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_gdcwa_rpg_heat" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 40 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( -3.7384, -5.7481, -0.2713 )
SWEP.SightsAng              = Vector( 1.1426, 0.0675, 0 )
SWEP.RunSightsPos           = Vector( 2.4946, -1.5644, 1.699 )
SWEP.RunSightsAng           = Vector( -20.1104, 35.1164, -12.959 )

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() and not self:GetOwner():KeyDown( IN_SPEED ) then
        self:FireRocket()
        self:EmitSound( "RPGF.single" )
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:GetOwner():MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
    end
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    local aim = self:GetOwner():GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = self:GetOwner():M9K_GetShootPos() + side * 6 + up * -5

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 0, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket:Spawn()
        rocket:Activate()
    end
end

function SWEP:SecondaryAttack()
end
