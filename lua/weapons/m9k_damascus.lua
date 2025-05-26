-- Variables that are used on both client and server
SWEP.Gun = "m9k_damascus" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = "Left click to slash" .. "\n" .. "Hold right mouse to put up guard."
SWEP.PrintName              = "Damascus Sword" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0 -- Slot in the weapon selection menu
SWEP.SlotPos                = 21 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "melee2" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_dmascus.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_damascus_sword.mdl" -- Weapon world model
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.RPM            = 150 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.Damage         = 75 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .01 -- Ironsight accuracy, should be the same for shotguns

--Enter iron sight info and bone mod info below
SWEP.SightsPos              = Vector( -1.267, -15.895, -7.205 )
SWEP.SightsAng              = Vector( 70, -27.234, 70 )
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( -25.577, 0, 0 )

SWEP.Slash                  = 1

SWEP.Primary.Sound          = "weapons/blades/woosh.mp3" --woosh
SWEP.KnifeShink             = "weapons/blades/hitwall.mp3"
SWEP.KnifeSlash             = "weapons/blades/slash.mp3"
SWEP.KnifeStab              = "weapons/blades/nastystab.mp3"

SWEP.SwordChop              = "weapons/blades/swordchop.mp3"
SWEP.SwordClash             = "weapons/blades/clash.mp3"


function SWEP:PrimaryAttack()
    if not self:GetOwner():IsPlayer() then return end
    if not self:CanPrimaryAttack() then return end

    local owner = self:GetOwner()
    local pos = owner:M9K_GetShootPos()
    local ang = owner:GetAimVector()
    local vm = owner:GetViewModel()
    local damagedice = math.Rand( 0.95, 1.05 )
    local pain = self.Primary.Damage * damagedice

    self:SendWeaponAnim( ACT_VM_IDLE )
    if owner:KeyDown( IN_RELOAD ) then return end
    if owner:KeyDown( IN_ATTACK2 ) then return end

    if self.Slash == 1 then
        vm:SetSequence( vm:LookupSequence( "midslash1" ) )
        self.Slash = 2
    else
        vm:SetSequence( vm:LookupSequence( "midslash2" ) )
        self.Slash = 1
    end

    self:EmitSound( self.Primary.Sound )

    if owner:Alive() then
        local slash = {
            start = pos,
            endpos = pos + ( ang * 52 ),
            filter = owner,
            mins = Vector( -15, -5, 0 ),
            maxs = Vector( 15, 5, 5 )
        }
        self:GetOwner():LagCompensation( true )
        local slashtrace = util.TraceHull( slash )
        self:GetOwner():LagCompensation( false )

        if slashtrace.Hit then
            targ = slashtrace.Entity
            if targ:IsPlayer() or targ:IsNPC() then
                self:EmitSound( self.SwordChop )
                if SERVER then
                    local paininfo = DamageInfo()
                    paininfo:SetDamage( pain )
                    paininfo:SetDamageType( DMG_SLASH )
                    paininfo:SetAttacker( owner )
                    paininfo:SetInflictor( self )
                    paininfo:SetDamageForce( slashtrace.Normal * 35000 )
                    targ:TakeDamageInfo( paininfo )
                end
            else
                self:EmitSound( self.KnifeShink )
                local look = owner:GetEyeTrace()
                util.Decal( "ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
            end
        end
    end

    owner:SetAnimation( PLAYER_ATTACK1 )
    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
end

function SWEP:Holster()
    local owner = self:GetOwner()
    if not IsValid( owner ) then return end

    if CLIENT then
        local vm = owner:GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    owner:SetNWBool( "GuardIsUp", false )
    return true
end

function SWEP:IronSight()
    if not self:GetOwner():IsNPC() then
        if self:GetOwner():GetNWBool( "GuardIsUp" ) == nil then
            self:GetOwner():SetNWBool( "GuardIsUp", false )
        end

        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil
            self:SendWeaponAnim( ACT_VM_IDLE )
        end
    end

    if not self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_ATTACK2 ) and not (self:GetReloading()) then
        self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
        self.IronSightsPos = self.SightsPos -- Bring it up
        self.IronSightsAng = self.SightsAng -- Bring it up
        self:SetIronsights( true )
        self.DrawCrosshair = false
        self:GetOwner():SetNWBool( "GuardIsUp", true )

        if CLIENT then return end
    end

    if self:GetOwner():KeyReleased( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) then
        -- If the right click is released, then
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = true
        self:SetIronsights( false )
        self:GetOwner():SetNWBool( "GuardIsUp", false )

        if CLIENT then return end
    end

    if self:GetOwner():KeyDown( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end
