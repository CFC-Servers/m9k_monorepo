-- Variables that are used on both client and server
SWEP.Gun = "m9k_machete" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.PrintName              = "Machete" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0
SWEP.SlotPos                = 25
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "melee"



SWEP.ViewModelFOV           = 60
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_machete.mdl"
SWEP.WorldModel             = "models/weapons/w_fc2_machete.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.RPM            = 75 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30
SWEP.Primary.DefaultClip    = 60
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 55 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.Damage         = 150 -- Base damage per bullet

--Enter iron sight info and bone mod info below
-- SWEP.IronSightsPos = Vector(-2.652, 0.187, -0.003)
-- SWEP.IronSightsAng = Vector(2.565, 0.034, 0)         --not for the knife
-- SWEP.SightsPos = Vector(-2.652, 0.187, -0.003)        --just lower it when running
-- SWEP.SightsAng = Vector(2.565, 0.034, 0)
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( -25.577, 0, 0 )

-- SWEP.Primary.Sound    = "Weapon_Knife.Slash" --woosh
-- SWEP.KnifeShink = "Weapon_Knife.HitWall"
-- SWEP.KnifeSlash = "Weapon_Knife.Hit"
-- SWEP.KnifeStab = "Weapon_Knife.Stab"

SWEP.Primary.Sound          = "weapons/blades/woosh.ogg" --woosh
SWEP.KnifeShink             = "weapons/blades/hitwall.ogg"
SWEP.KnifeSlash             = "weapons/blades/slash.ogg"
SWEP.KnifeStab              = "weapons/blades/nastystab.ogg"

function SWEP:Deploy()
    self:SetHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 1 )
    self:EmitSound( "weapons/knife/knife_draw_x.ogg", 50, 100 )
    return true
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    local vm = owner:GetViewModel()
    self:SendWeaponAnim( ACT_VM_IDLE )
    owner:ViewPunch( Angle( -10, 0, 0 ) )

    if self:CanPrimaryAttack() and owner:IsPlayer() then
        self:EmitSound( self.Primary.Sound )
        if SERVER then
            vm:SetSequence( vm:LookupSequence( "stab" ) )
            timer.Create( "hack-n-slash", .23, 1, function()
                if not IsValid( self ) then return end
                if not IsValid( owner ) then return end
                if owner:Alive() and owner:GetActiveWeapon():GetClass() == self.Gun then
                    self:HackNSlash()
                end
            end )
            owner:SetAnimation( PLAYER_ATTACK1 )
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        end
    end
end

function SWEP:HackNSlash()
    local owner = self:GetOwner()
    local pos = owner:M9K_GetShootPos()
    local ang = owner:GetAimVector()
    local damagedice = math.Rand( 0.95, 1.05 )
    local pain = self.Primary.Damage * damagedice

    if owner:Alive() then
            local slash = {
                start = pos,
                endpos = pos + ( ang * 42 ),
                filter = owner,
                mins = Vector( -8, -10, 0 ),
                maxs = Vector( 8, 10, 5 )
            }

            owner:LagCompensation( true )
            local slashtrace = util.TraceHull( slash )
            owner:LagCompensation( false )

            owner:ViewPunch( Angle( 20, 0, 0 ) )
            if slashtrace.Hit then
                targ = slashtrace.Entity
                if targ:IsPlayer() or targ:IsNPC() then
                    --find a way to splash a little blood
                    self:EmitSound( self.KnifeSlash ) --stab noise
                    paininfo = DamageInfo()
                    paininfo:SetDamage( pain )
                    paininfo:SetDamageType( DMG_SLASH )
                    paininfo:SetAttacker( owner )
                    paininfo:SetInflictor( self )
                    paininfo:SetDamageForce( slashtrace.Normal * 35000 )
                    targ:TakeDamageInfo( paininfo )
                else
                    self:EmitSound( self.KnifeShink ) --SHINK!
                    local look = owner:GetEyeTrace()
                    util.Decal( "ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
                end
            end
    end
end

function SWEP:SecondaryAttack()
    if self:GetNextPrimaryFire() > CurTime() then return end

    local owner = self:GetOwner()

    if not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_RELOAD ) then
        self:EmitSound( "Weapon_Knife.Slash" )

        if SERVER then
            local knife = ents.Create( "m9k_thrown_knife" )
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

function SWEP:IronSight()
end
