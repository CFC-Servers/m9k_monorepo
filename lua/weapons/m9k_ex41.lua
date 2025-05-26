-- Variables that are used on both client and server
SWEP.Gun = "m9k_ex41" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "EX41" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 28 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "shotgun" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_ex41.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_ex41.mdl" -- Weapon world model
SWEP.ShowWorldModel         = true

SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "40mmGrenade.Single" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 45 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 3 -- Size of a clip
SWEP.Primary.DefaultClip    = 6 -- Bullets you start with
SWEP.Primary.KickUp         = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "40mmGrenade"

SWEP.Secondary.IronFOV      = 70 -- How much you 'zoom' in. Less is more!
SWEP.Primary.Round          = "m9k_launched_ex41" --NAME OF ENTITY GOES HERE
SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.ShellTime              = .5

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 30 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .025 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( -2.85, -3, 1.3 )
SWEP.SightsAng              = Vector( 2, -1.1, 0 )
SWEP.RunSightsPos           = Vector( 3.279, -5.574, 0 )
SWEP.RunSightsAng           = Vector( -1.721, 49.917, 0 )


function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() then
        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
            self:FireRocket()
            self:EmitSound( self.Primary.Sound )
            self:TakePrimaryAmmo( 1 )
            self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:GetOwner():MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        else
            self:Reload()
        end
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
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket:Spawn()
        rocket:Activate()
    end
end
