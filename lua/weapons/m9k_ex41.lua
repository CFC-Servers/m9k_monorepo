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
SWEP.Slot                   = 4
SWEP.SlotPos                = 28
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "shotgun"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_ex41.mdl"
SWEP.WorldModel             = "models/weapons/w_ex41.mdl"
SWEP.ShowWorldModel         = true

SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "40mmGrenade.Single"
SWEP.Primary.RPM            = 45 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 3
SWEP.Primary.DefaultClip    = 6
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
    if not self:CanPrimaryAttack() then return end
    local owner = self:GetOwner()
    if not IsValid( owner ) then return end

    if not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_RELOAD ) then
        self:FireRocket()
        self:EmitSound( self.Primary.Sound )
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        owner:SetAnimation( PLAYER_ATTACK1 )
        owner:MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
    else
        self:Reload()
    end
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    local owner = self:GetOwner()

    local aim = owner:GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = owner:M9K_GetShootPos() + side * 6 + up * -5

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( owner )
        rocket:Spawn()
        rocket:Activate()
    end
end
