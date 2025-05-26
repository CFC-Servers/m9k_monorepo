SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Harpoon" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0 -- Slot in the weapon selection menu
SWEP.SlotPos                = 23 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 1 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "grenade" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV           = 40
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_pistol.mdl"
SWEP.WorldModel             = "models/weapons/w_harpooner.mdl"
SWEP.ShowViewModel          = false
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false
SWEP.ShowWorldModel         = true

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 40 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1 -- Size of a clip
SWEP.Primary.DefaultClip    = 2 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Harpoon"
SWEP.Primary.Round          = "m9k_thrown_harpoon" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.VElements = {
    ["javelin"] = {
        type = "Model",
        model = "models/props_junk/harpoon002a.mdl",
        bone = "ValveBiped.square",
        rel = "",
        pos = Vector( -2, -7, 12 ),
        angle = Angle( 90, 10, 10 ),
        size = Vector( 0.9, 0.5, 0.5 ),
        color = Color( 255, 255, 255, 255 ),
    }
}

SWEP.ViewModelBoneMods = {
    ["ValveBiped.Bip01_R_Hand"] = {
        scale = Vector( 0.009, 0.009, 0.009 ),
        pos = Vector( 0, 0, 0 ),
        angle = Angle( 0, 0, 0 )
    },
}

function SWEP:Deploy()
    self:SetHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 0.8 )
    return true
end

if SERVER then
    function SWEP:FireRocket()
        local pos = self:GetOwner():M9K_GetShootPos()
        local rocket = ents.Create( self.Primary.Round )
        rocket:SetAngles( self:GetOwner():GetAimVector():Angle() )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket:Spawn()
        rocket:Activate()

        local phys = rocket:GetPhysicsObject()
        phys:SetVelocity( self:GetOwner():GetAimVector() * 2000 )

        if not self:GetOwner():IsNPC() then
            local anglo = Angle( 3, 5, 0 )
            self:GetOwner():ViewPunch( anglo )
        end
    end
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    if self:GetNextPrimaryFire() > CurTime() then return end

    local shootPos = self:GetOwner():M9K_GetShootPos()
    local tracedata = {
        start = shootPos,
        endpos = shootPos + self:GetForward() * 40,
        filter = self:GetOwner()
    }
    local trace = util.TraceLine( tracedata )
    if trace.Hit then return end

    if SERVER then
        self:FireRocket()
    end

    self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
    self:EmitSound( "Weapon_Knife.Slash" )
    self:TakePrimaryAmmo( 1 )
    self:SendWeaponAnim( ACT_VM_HITCENTER )

    if SERVER then
        if self:GetOwner():GetAmmoCount( self.Primary.Ammo ) == 0 then
            self:GetOwner():StripWeapon( self:GetClass() )
        else
            self:Reload()
        end
    end

    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
end

function SWEP:Reload()
    if not IsValid( self:GetOwner() ) then return end

    if self:GetOwner():IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
        return
    end

    self:DefaultReload( ACT_VM_DRAW )

    if not self:GetOwner():IsNPC() then
        if self:GetOwner():GetViewModel() == nil then
            self.ResetSights = CurTime() + 3
        else
            self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
        end
    end
end

function SWEP:SecondaryAttack()
    return false
end

function SWEP:Think()
end
