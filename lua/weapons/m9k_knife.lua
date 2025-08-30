-- Variables that are used on both client and server
SWEP.Gun = "m9k_knife" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ("Left click to slash" .. "\n" .. "Right click to stab.")
SWEP.PrintName              = "Knife" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0
SWEP.SlotPos                = 24
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "knife"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_knife_x.mdl"
SWEP.WorldModel             = "models/weapons/w_extreme_ratio.mdl"
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.RPM            = 180 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun

SWEP.PrimaryDamage = 35
SWEP.SecondaryDamage = 80
SWEP.AttackRange = 55
SWEP.MinBox = Vector( -10, -5, -5 )
SWEP.MaxBox = Vector( 10, 5, 5 )

SWEP.Slash = 1

SWEP.Primary.Sound = "weapons/blades/woosh.ogg"
SWEP.KnifeShink = "weapons/blades/hitwall.ogg"
SWEP.KnifeSlash = "weapons/blades/slash.ogg"
SWEP.KnifeStab = "weapons/blades/nastystab.ogg"

function SWEP:Deploy()
    self:SetHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 1 )
    self:EmitSound( "weapons/knife/knife_draw_x.ogg", 50, 100 )
    return true
end

function SWEP:IsBackStab( targ )
    if not targ:IsPlayer() and not targ:IsNPC() then return false end

    local oEye = self:GetOwner():EyeAngles()
    oEye.p = 0
    oEye = oEye:Forward()

    local tEye = targ:EyeAngles()
    tEye.p = 0
    tEye = tEye:Forward()

    return tEye:Dot( oEye ) >= 0.7
end

function SWEP:SlashTrace()
    local owner = self:GetOwner()
    local eyeAngles = owner:EyeAngles()
    local forward = eyeAngles:Forward()
    local shootPos = owner:M9K_GetShootPos()
    local trace = {
        start = shootPos,
        endpos = shootPos + forward * self.AttackRange,
        mins = self.MinBox:Rotate( eyeAngles ),
        maxs = self.MaxBox:Rotate( eyeAngles ),
        filter = owner,
    }

    owner:LagCompensation( true )
    local slashtrace = util.TraceHull( trace )
    owner:LagCompensation( false )

    if IsValid( slashtrace.Entity ) and self:IsBackStab( slashtrace.Entity ) then
        slashtrace.BackStab = true
    else
        slashtrace.BackStab = false
    end

    return slashtrace
end

SWEP.AttackTimeStart = 0
SWEP.AttackTimeEnd = 0
SWEP.AttackDamage = 0
SWEP.ShouldAttack = false
SWEP.AttackSound = ""
SWEP.AttackBackstabSound = ""
function SWEP:Think()
    if not self.ShouldAttack then return end

    local curtime = CurTime()
    if curtime > self.AttackTimeStart and curtime < self.AttackTimeEnd then
        local slashtrace = self:SlashTrace()
        if slashtrace.Hit then
            self.ShouldAttack = false
            local targ = slashtrace.Entity

            local owner = self:GetOwner()

            if targ:IsPlayer() or targ:IsNPC() then
                local damagedice = math.Rand( 0.98, 1.02 )
                local pain = self.AttackDamage * damagedice
                if slashtrace.BackStab then
                    pain = pain * 2
                end

                if slashtrace.BackStab then
                    self:EmitSound( self.AttackBackstabSound )
                else
                    self:EmitSound( self.AttackSound )
                end

                if SERVER then
                    local paininfo = DamageInfo()
                    paininfo:SetDamage( pain )
                    paininfo:SetDamageType( DMG_SLASH )
                    paininfo:SetAttacker( owner )
                    paininfo:SetInflictor( self )
                    paininfo:SetDamageForce( slashtrace.Normal * 20000 )
                    targ:TakeDamageInfo( paininfo )
                end
            else
                self:EmitSound( self.KnifeShink )
                look = owner:GetEyeTrace()
                util.Decal( "ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
            end
        end
    end
end

function SWEP:StartAttack( attackTime, damageWindow, damage, stabSound, backstabSound )
    self.AttackTimeStart = attackTime + CurTime()
    self.AttackTimeEnd = self.AttackTimeStart + damageWindow
    self.AttackDamage = damage
    self.AttackSound = stabSound
    self.AttackBackstabSound = backstabSound
    self.ShouldAttack = true
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire( CurTime() + 0.35 )

    if IsFirstTimePredicted() then
        self.Slash = self.Slash == 1 and 2 or 1
    end

    local owner = self:GetOwner()

    local vm = owner:GetViewModel()
    self:SendWeaponAnim( ACT_VM_IDLE )
    if self.Slash == 1 then
        vm:SetSequence( vm:LookupSequence( "midslash1" ) )
    else
        vm:SetSequence( vm:LookupSequence( "midslash2" ) )
    end

    self:EmitSound( self.Primary.Sound )
    owner:SetAnimation( PLAYER_ATTACK1 )

    self:StartAttack( 0.05, 0.15, self.PrimaryDamage, self.KnifeSlash, self.KnifeSlash )
end

function SWEP:SecondaryAttack()
    if not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire( CurTime() + 1.25 )
    self:SetNextSecondaryFire( CurTime() + 1.25 )

    local owner = self:GetOwner()
    local vm = owner:GetViewModel()

    self:SendWeaponAnim( ACT_VM_IDLE )
    vm:SetSequence( vm:LookupSequence( "stab" ) )
    owner:SetAnimation( PLAYER_ATTACK1 )

    self:StartAttack( 0.33, 0.15, self.SecondaryDamage, self.KnifeSlash, self.KnifeStab )
end

function SWEP:Reload()
    if self:GetNextPrimaryFire() > CurTime() then return end
    self:ThrowKnife()
end

function SWEP:ThrowKnife()
    if self:GetNextPrimaryFire() > CurTime() then return end

    if IsFirstTimePredicted() then
        self:EmitSound( self.Primary.Sound )
        if SERVER then
            local owner = self:GetOwner()

            local knife = ents.Create( "m9k_thrown_spec_knife" )
            knife:SetAngles( owner:EyeAngles() )
            knife:SetPos( owner:M9K_GetShootPos() )
            knife:SetOwner( owner )
            knife:SetPhysicsAttacker( owner )
            knife:Spawn()
            knife:Activate()
            owner:SetAnimation( PLAYER_ATTACK1 )

            local phys = knife:GetPhysicsObject()
            phys:SetVelocity( owner:GetAimVector() * 1500 )
            phys:AddAngleVelocity( Vector( 0, 500, 0 ) )
            owner:StripWeapon( self.Gun )
        end
    end
end
