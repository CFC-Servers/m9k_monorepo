-- Variables that are used on both client and server
SWEP.Gun = ("m9k_machete") -- must be the name of your swep but NO CAPITALS!
if (GetConVar( SWEP.Gun .. "_allowed" )) ~= nil then
    if not (GetConVar( SWEP.Gun .. "_allowed" ):GetBool()) then
        SWEP.Base = "bobs_blacklisted"
        SWEP.PrintName = SWEP.Gun
        return
    end
end
SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.PrintName              = "Machete" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0 -- Slot in the weapon selection menu
SWEP.SlotPos                = 25 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox      = false -- Should draw the weapon info box
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "melee" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 60
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_machete.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_fc2_machete.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.RPM            = 75 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

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

-- SWEP.Primary.Sound    = Sound("Weapon_Knife.Slash") --woosh
-- SWEP.KnifeShink = ("Weapon_Knife.HitWall")
-- SWEP.KnifeSlash = ("Weapon_Knife.Hit")
-- SWEP.KnifeStab = ("Weapon_Knife.Stab")

SWEP.Primary.Sound          = "weapons/blades/woosh.mp3" --woosh
SWEP.KnifeShink             = "weapons/blades/hitwall.mp3"
SWEP.KnifeSlash             = "weapons/blades/slash.mp3"
SWEP.KnifeStab              = "weapons/blades/nastystab.mp3"

function SWEP:Deploy()
    self:SetHoldType( self.HoldType )
    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetNextPrimaryFire( CurTime() + 1 )
    self:EmitSound( "weapons/knife/knife_draw_x.mp3", 50, 100 )
    return true
end

function SWEP:PrimaryAttack()
    vm = self:GetOwner():GetViewModel()
    self:SendWeaponAnim( ACT_VM_IDLE )
    self:GetOwner():ViewPunch( Angle( -10, 0, 0 ) )

    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        self:EmitSound( self.Primary.Sound )
        if SERVER then
            if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
                vm:SetSequence( vm:LookupSequence( "stab" ) )
                timer.Create( "hack-n-slash", .23, 1, function()
                    if not IsValid( self ) then return end
                    if IsValid( self:GetOwner() ) and
                        IsValid( self ) then
                        if self:GetOwner():Alive() and self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                            self:HackNSlash()
                        end
                    end
                end )
                self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
                self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            end
        end
    end
end

function SWEP:HackNSlash()
    local pos = self:GetOwner():GetShootPos()
    local ang = self:GetOwner():GetAimVector()
    local damagedice = math.Rand( 0.95, 1.05 )
    local pain = self.Primary.Damage * damagedice

    self:GetOwner():LagCompensation( true )
    if self:GetOwner():Alive() then
            local slash = {}
            slash.start = pos
            slash.endpos = pos + (ang * 42)
            slash.filter = self:GetOwner()
            slash.mins = Vector( -8, -10, 0 )
            slash.maxs = Vector( 8, 10, 5 )
            local slashtrace = util.TraceHull( slash )
            self:GetOwner():ViewPunch( Angle( 20, 0, 0 ) )
            if slashtrace.Hit then
                targ = slashtrace.Entity
                if targ:IsPlayer() or targ:IsNPC() then
                    --find a way to splash a little blood
                    self:EmitSound( self.KnifeSlash ) --stab noise
                    paininfo = DamageInfo()
                    paininfo:SetDamage( pain )
                    paininfo:SetDamageType( DMG_SLASH )
                    paininfo:SetAttacker( self:GetOwner() )
                    paininfo:SetInflictor( self )
                    paininfo:SetDamageForce( slashtrace.Normal * 35000 )
                    targ:TakeDamageInfo( paininfo )
                else
                    self:EmitSound( self.KnifeShink ) --SHINK!
                    local look = self:GetOwner():GetEyeTrace()
                    util.Decal( "ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
                end
            end
    end
    self:GetOwner():LagCompensation( false )
end

function SWEP:SecondaryAttack()
    if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
        self:EmitSound( "Weapon_Knife.Slash" )

        if (SERVER) then
            local knife = ents.Create( "m9k_thrown_knife" )
            knife:SetAngles( self:GetOwner():EyeAngles() )
            knife:SetPos( self:GetOwner():GetShootPos() )
            knife:SetOwner( self:GetOwner() )
            knife:SetPhysicsAttacker( self:GetOwner() )
            knife:Spawn()
            knife:Activate()
            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            local phys = knife:GetPhysicsObject()
            phys:SetVelocity( self:GetOwner():GetAimVector() * 1500 )
            phys:AddAngleVelocity( Vector( 0, 500, 0 ) )
            self:GetOwner():StripWeapon( self.Gun )
        end
    end
end

function SWEP:IronSight()
    if not self:GetOwner():IsNPC() then
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil

            if self.Silenced then
                self:SendWeaponAnim( ACT_VM_IDLE_SILENCED )
            else
                self:SendWeaponAnim( ACT_VM_IDLE )
            end
        end
    end

    if self.CanBeSilenced and self.NextSilence < CurTime() then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_ATTACK2 ) then
            self:Silencer()
        end
    end

    if self.SelectiveFire and self.NextFireSelect < CurTime() then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_RELOAD ) then
            self:SelectFireMode()
        end
    end

    if self:GetOwner():KeyDown( IN_SPEED ) and not (self:GetNWBool( "Reloading" )) then -- If you are running
        self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.3 )
    end

    if self:GetOwner():KeyReleased( IN_SPEED ) then -- If you release run then
        self:SetIronsights( false, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.3 )
    end -- Shoulder the gun
end

if GetConVar( "M9KUniqueSlots" ) ~= nil then
    if not (GetConVar( "M9KUniqueSlots" ):GetBool()) then
        SWEP.SlotPos = 2
    end
end

