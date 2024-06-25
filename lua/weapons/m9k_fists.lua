-- Variables that are used on both client and server
SWEP.Gun = ("m9k_fists") -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ("Right click, right jab." .. "\n" .. "Left Click, Left Jab." .. "\n" .. "Hold Reload to put up your guard.")
SWEP.PrintName              = "Fists" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0 -- Slot in the weapon selection menu
SWEP.SlotPos                = 22 -- Position in the slot
SWEP.DrawAmmo               = false -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "fist" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_punchy.mdl" -- Weapon view model
SWEP.WorldModel             = "" -- Weapon world model
SWEP.ShowWorldModel         = true
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.RPM            = 180 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 30 -- Size of a clip
SWEP.Primary.DefaultClip    = 60 -- Bullets you start with
SWEP.Primary.KickUp         = 0.4 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.Damage         = 25 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .01 -- Ironsight accuracy, should be the same for shotguns

--Enter iron sight info and bone mod info below
SWEP.IronSightsPos          = Vector( -0.094, -6.755, 1.003 )
SWEP.IronSightsAng          = Vector( 36.123, 0, 0 )
SWEP.SightsPos              = Vector( -0.094, -6.755, 1.003 )
SWEP.SightsAng              = Vector( 36.123, 0, 0 )
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( -25.577, 0, 0 )

SWEP.Slash                  = 1

SWEP.Primary.Sound          = "Weapon_Knife.Slash" --woosh
local punchtable            = { "punchies/1.mp3", "punchies/2.mp3", "punchies/3.mp3", "punchies/4.mp3", "punchies/5.mp3", }
local woosh                 = { "punchies/miss1.mp3", "punchies/miss2.mp3" }


function SWEP:PrimaryAttack()
    vm = self:GetOwner():GetViewModel()
    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        self:SendWeaponAnim( ACT_VM_IDLE )
        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
            self:GetOwner():ViewPunch( Angle( math.random( -5, 5 ), -10, 5 ) )
            vm:SetSequence( vm:LookupSequence( "punchmiss2" ) ) --left
            vm:SetPlaybackRate( 1.5 )
            self:EmitSound( Sound( table.Random( woosh ) ) ) --slash in the wind sound here
            timer.Create( "LeftJab", .1, 1, function()
                if not IsValid( self ) then return end

                if IsValid( self:GetOwner() ) and

                    IsValid( self ) then
                    if self:GetOwner():Alive() and self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                        self:LeftJab()
                    end
                end
            end )
            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            self:SetNextSecondaryFire( (CurTime() + 1 / (self.Primary.RPM / 60)) )
        end
    end
end

function SWEP:LeftJab()
    local pos = self:GetOwner():GetShootPos()
    local ang = self:GetOwner():GetAimVector()
    local damagedice = math.Rand( 0.95, 1.05 )
    local pain = self.Primary.Damage * damagedice

    self:GetOwner():LagCompensation( true )
    if SERVER and IsValid( self:GetOwner() ) and IsValid( self ) then
        if self:GetOwner():Alive() then
            if self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                local slash = {}
                slash.start = pos
                slash.endpos = pos + (ang * 30)
                slash.filter = self:GetOwner()
                slash.mins = Vector( -5, -3, 0 )
                slash.maxs = Vector( 3, 3, 3 )
                local slashtrace = util.TraceHull( slash )
                if slashtrace.Hit then
                    targ = slashtrace.Entity
                    if targ:IsPlayer() or targ:IsNPC() then
                        --find a way to splash a little blood

                        self:EmitSound( Sound( table.Random( punchtable ) ) ) --stab noise
                        paininfo = DamageInfo()
                        paininfo:SetDamage( pain )
                        paininfo:SetDamageType( DMG_CLUB )
                        paininfo:SetAttacker( self:GetOwner() )
                        paininfo:SetInflictor( self )
                        paininfo:SetDamageForce( slashtrace.Normal * 5000 )
                        if SERVER then
                            targ:TakeDamageInfo( paininfo )
                            if targ:IsPlayer() then targ:ViewPunch( Angle( math.random( -5, 5 ), math.random( -25, 25 ), math.random( -50, 50 ) ) ) end
                        end
                    else
                        self:EmitSound( "Weapon_Crowbar.Melee_Hit" ) --thunk
                    end
                end
            end
        end
    end
    self:GetOwner():LagCompensation( false )
end

function SWEP:SecondaryAttack()
    vm = self:GetOwner():GetViewModel()
    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        self:SendWeaponAnim( ACT_VM_IDLE )
        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
            self:GetOwner():ViewPunch( Angle( math.random( -5, 5 ), 10, -5 ) )
            vm:SetSequence( vm:LookupSequence( "punchmiss1" ) ) --right
            vm:SetPlaybackRate( 1.5 )
            self:EmitSound( Sound( table.Random( woosh ) ) ) --slash in the wind sound here

            timer.Create( "RightJab", .1, 1, function()
                if not IsValid( self ) then return end
                local owner = self:GetOwner()
                if not IsValid( owner ) then return end
                if not owner:Alive() then return end
                if owner:GetActiveWeapon() ~= self then return end

                self:RightJab()
            end )
            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:SetNextSecondaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
            self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
        end
    end
end

function SWEP:RightJab()
    rpos = self:GetOwner():GetShootPos()
    rang = self:GetOwner():GetAimVector()
    damagedice = math.Rand( .95, 1.95 )
    pain = self.Primary.Damage * damagedice
    self:GetOwner():LagCompensation( true )
    if SERVER and IsValid( self:GetOwner() ) and IsValid( self ) then
        if self:GetOwner():Alive() then
            if self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                local rslash = {}
                rslash.start = rpos
                rslash.endpos = rpos + (rang * 30)
                rslash.filter = self:GetOwner()
                rslash.mins = Vector( -3, -3, 0 )
                rslash.maxs = Vector( 3, 5, 3 )
                local rslashtrace = util.TraceHull( rslash )
                if rslashtrace.Hit then
                    rtarg = rslashtrace.Entity
                    if rtarg:IsPlayer() or rtarg:IsNPC() then
                        --find a way to splash a little blood
                        self:EmitSound( Sound( table.Random( punchtable ) ) ) --stab noise
                        paininfo = DamageInfo()
                        paininfo:SetDamage( pain )
                        paininfo:SetDamageType( DMG_CLUB )
                        paininfo:SetAttacker( self:GetOwner() )
                        paininfo:SetInflictor( self )
                        paininfo:SetDamageForce( rslashtrace.Normal * 5000 )
                        if SERVER then
                            rtarg:TakeDamageInfo( paininfo )
                            if rtarg:IsPlayer() then rtarg:ViewPunch( Angle( math.random( -5, 5 ), math.random( -25, 25 ), math.random( -50, 50 ) ) ) end
                        end
                    else
                        self:EmitSound( "Weapon_Crowbar.Melee_Hit" ) --thunk
                    end
                end
            end
        end
    end
    self:GetOwner():LagCompensation( false )
end

function SWEP:Reload()
end

--[[ function DukesUp(victim, info)

    if !IsValid(victim) then return end
    if victim:IsPlayer() and victim:Alive() then
        -- if victim:GetActiveWeapon() ~= nil then
            -- if victim:GetActiveWeapon():GetClass() == "m9k_fists" then
                if victim:GetNWBool("DukesAreUp", false) and info:GetDamageType() == DMG_CLUB then
                    victim:SetHealth(victim:Health() + (info:GetDamage()))
                    victim:SetHealth(victim:Health() - (info:GetDamage()/4))
                end
            --end
        --end
    end
end
hook.Add("EntityTakeDamage", "DukesUp", DukesUp ) ]]
--This hook has been moved to Autorun

function SWEP:Holster()
    if CLIENT and IsValid( self:GetOwner() ) and not self:GetOwner():IsNPC() then
        local vm = self:GetOwner():GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    self:GetOwner():SetNWBool( "DukesAreUp", false )
    return true
end

function SWEP:IronSight()
    if not self:GetOwner():IsNPC() then
        if self:GetOwner():GetNWBool( "DukesAreUp" ) == nil then
            self:GetOwner():SetNWBool( "DukesAreUp", false )
        end
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil
            self:SendWeaponAnim( ACT_VM_IDLE )
        end
    end

    if self:GetOwner():KeyDown( IN_RELOAD ) and self:GetOwner():KeyPressed( IN_SPEED ) then
        self:GetOwner():SetNWBool( "DukesAreUp", false )
    end

    if self:GetOwner():KeyDown( IN_SPEED ) and not (self:GetReloading()) then -- If you are running
        self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true )
        self:GetOwner():SetFOV( 0, 0.3 )
    end

    if self:GetOwner():KeyReleased( IN_SPEED ) then -- If you release run then
        self:SetIronsights( false )
        self:GetOwner():SetFOV( 0, 0.3 )
    end -- Shoulder the gun

    if not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- If the key E (Use Key) is not pressed, then

        if self:GetOwner():KeyPressed( IN_RELOAD ) then
            self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true )
            self:GetOwner():SetNWBool( "DukesAreUp", true )
            if CLIENT then return end
        end
    end

    if self:GetOwner():KeyReleased( IN_RELOAD ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- If the right click is released, then
        self:GetOwner():SetFOV( 0, 0.3 )
        self:SetIronsights( false )
        self:GetOwner():SetNWBool( "DukesAreUp", false )

        if CLIENT then return end
    end
end
