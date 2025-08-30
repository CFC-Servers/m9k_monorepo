-- Variables that are used on both client and server
SWEP.Gun = "m9k_fists" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ("Right click, right jab." .. "\n" .. "Left Click, Left Jab." .. "\n" .. "Hold Reload to put up your guard.")
SWEP.PrintName              = "Fists" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0
SWEP.SlotPos                = 22
SWEP.DrawAmmo               = false -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "fist"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_punchy.mdl"
SWEP.WorldModel             = ""
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
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.Primary.Damage = 25 -- Base damage per bullet
SWEP.Primary.SpreadHip = .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .01 -- Ironsight accuracy, should be the same for shotguns

--Enter iron sight info and bone mod info below
SWEP.SightsPos              = Vector( -0.094, -6.755, 1.003 )
SWEP.SightsAng              = Vector( 36.123, 0, 0 )
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( -25.577, 0, 0 )

SWEP.Slash                  = 1

SWEP.Primary.Sound = "Weapon_Knife.Slash" --woosh
local punchtable = { "punchies/1.ogg", "punchies/2.ogg", "punchies/3.ogg", "punchies/4.ogg", "punchies/5.ogg", }
local woosh = { "punchies/miss1.ogg", "punchies/miss2.ogg" }

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    local vm = owner:GetViewModel()
    if self:CanPrimaryAttack() and owner:IsPlayer() then
        self:SendWeaponAnim( ACT_VM_IDLE )
        if not owner:KeyDown( IN_RELOAD ) then
            owner:ViewPunch( Angle( math.random( -5, 5 ), -10, 5 ) )
            vm:SetSequence( vm:LookupSequence( "punchmiss2" ) ) --left
            vm:SetPlaybackRate( 1.5 )
            self:EmitSound( Sound( table.Random( woosh ) ) ) --slash in the wind sound here

            if SERVER then
                timer.Simple( 0.1, function()
                    if not IsValid( self ) then return end

                    if IsValid( owner ) and owner:Alive() and owner:GetActiveWeapon():GetClass() == self.Gun then
                        self:Jab()
                    end
                end )
            end
            owner:SetAnimation( PLAYER_ATTACK1 )
            self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
            self:SetNextSecondaryFire( CurTime() + 1 / ( self.Primary.RPM / 20 ) )
        end
    end
end

function SWEP:Jab()
    local owner = self:GetOwner()

    local pos = owner:M9K_GetShootPos()
    local ang = owner:GetAimVector()
    local damagedice = math.Rand( 0.95, 1.05 )
    local pain = self.Primary.Damage * damagedice

    local slash = {
        start = pos,
        endpos = pos + ( ang * 50 ),
        filter = owner,
        mins = Vector( -5, -3, 0 ),
        maxs = Vector( 3, 3, 3 )
    }

    owner:LagCompensation( true )
    local slashtrace = util.TraceHull( slash )
    owner:LagCompensation( false )

    if slashtrace.Hit then
        targ = slashtrace.Entity
        if targ:IsPlayer() or targ:IsNPC() then
            self:EmitSound( Sound( table.Random( punchtable ) ) )
            local paininfo = DamageInfo()
            paininfo:SetDamage( pain )
            paininfo:SetAttacker( owner )
            paininfo:SetInflictor( self )
            paininfo:SetDamageForce( slashtrace.Normal * 5000 )

            if targ:IsPlayer() then
                local targHp = targ:Health()
                targ:TakeDamageInfo( paininfo )
                if targHp ~= targ:Health() then
                    targ:ViewPunch( Angle( math.random( -5, 5 ), math.random( -25, 25 ), math.random( -50, 50 ) ) )
                end
            else
                targ:TakeDamageInfo( paininfo )
            end
        else
            self:EmitSound( "Weapon_Crowbar.Melee_Hit" )
        end
    end
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()

    local vm = owner:GetViewModel()
    if self:CanSecondaryAttack() and owner:IsPlayer() then
        self:SendWeaponAnim( ACT_VM_IDLE )
        if not owner:KeyDown( IN_RELOAD ) then
            owner:ViewPunch( Angle( math.random( -5, 5 ), 10, -5 ) )
            vm:SetSequence( vm:LookupSequence( "punchmiss1" ) ) --right
            vm:SetPlaybackRate( 1.5 )
            self:EmitSound( Sound( table.Random( woosh ) ) ) --slash in the wind sound here

            if SERVER then
                timer.Simple( 0.1, function()
                    if not IsValid( self ) then return end
                    local owner = self:GetOwner()
                    if not IsValid( owner ) then return end
                    if not owner:Alive() then return end
                    if owner:GetActiveWeapon() ~= self then return end

                    self:Jab()
                end )
            end

            owner:SetAnimation( PLAYER_ATTACK1 )
            self:SetNextSecondaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
            self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 20 ) )
        end
    end
end

function SWEP:Reload()
end

function SWEP:Holster()
    local owner = self:GetOwner()

    if CLIENT and IsValid( owner ) and not owner:IsNPC() then
        local vm = owner:GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    owner:SetNWBool( "DukesAreUp", false )
    return true
end

function SWEP:IronSight()
    local owner = self:GetOwner()

    if not owner:IsNPC() then
        if owner:GetNWBool( "DukesAreUp" ) == nil then
            owner:SetNWBool( "DukesAreUp", false )
        end
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil
            self:SendWeaponAnim( ACT_VM_IDLE )
        end
    end

    if owner:KeyDown( IN_RELOAD ) then
        owner:SetNWBool( "DukesAreUp", false )
    end

    if not owner:KeyDown( IN_USE ) and owner:KeyPressed( IN_RELOAD ) then
        owner:SetFOV( self.Secondary.IronFOV, 0.3 )
        self.IronSightsPos = self.SightsPos -- Bring it up
        self.IronSightsAng = self.SightsAng -- Bring it up
        self:SetIronsights( true )
        owner:SetNWBool( "DukesAreUp", true )
    end

    if owner:KeyReleased( IN_RELOAD ) and not owner:KeyDown( IN_USE ) then
        -- If the right click is released, then
        owner:SetFOV( 0, 0.3 )
        self:SetIronsights( false )
        owner:SetNWBool( "DukesAreUp", false )
    end
end
