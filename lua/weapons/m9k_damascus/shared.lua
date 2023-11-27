-- Variables that are used on both client and server
SWEP.Gun = ("m9k_damascus") -- must be the name of your swep but NO CAPITALS!
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
SWEP.Instructions           = ("Left click to slash" .. "\n" .. "Hold right mouse to put up guard.")
SWEP.PrintName              = "Damascus Sword" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 0 -- Slot in the weapon selection menu
SWEP.SlotPos                = 21 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox      = true -- Should draw the weapon info box
SWEP.BounceWeaponIcon       = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
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

SWEP.Primary.RPM            = 250 -- This is in Rounds Per Minute
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

SWEP.Primary.Damage         = 75 -- Base damage per bullet
SWEP.Primary.Spread         = .02 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy   = .01 -- Ironsight accuracy, should be the same for shotguns

--Enter iron sight info and bone mod info below
SWEP.IronSightsPos          = Vector( -1.267, -15.895, -7.205 )
SWEP.IronSightsAng          = Vector( 70, -27.234, 70 )
SWEP.SightsPos              = Vector( -1.267, -15.895, -7.205 )
SWEP.SightsAng              = Vector( 70, -27.234, 70 )
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( -25.577, 0, 0 )

SWEP.Slash                  = 1

SWEP.Primary.Sound          = Sound( "weapons/blades/woosh.mp3" ) --woosh
SWEP.KnifeShink             = Sound( "weapons/blades/hitwall.mp3" )
SWEP.KnifeSlash             = Sound( "weapons/blades/slash.mp3" )
SWEP.KnifeStab              = Sound( "weapons/blades/nastystab.mp3" )

SWEP.SwordChop              = Sound( "weapons/blades/swordchop.mp3" )
SWEP.SwordClash             = Sound( "weapons/blades/clash.mp3" )


function SWEP:PrimaryAttack()
    if not self:GetOwner():IsPlayer() then return end
    local pos = self:GetOwner():GetShootPos()
    local ang = self:GetOwner():GetAimVector()
    local vm = self:GetOwner():GetViewModel()
    local damagedice = math.Rand( .85, 1.25 )
    local pain = self.Primary.Damage * damagedice

    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        self:SendWeaponAnim( ACT_VM_IDLE )
        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) and not self:GetOwner():KeyDown( IN_ATTACK2 ) then
            if self.Slash == 1 then
                --if CLIENT then return end
                vm:SetSequence( vm:LookupSequence( "midslash1" ) )
                self.Slash = 2
            else
                --if CLIENT then return end
                vm:SetSequence( vm:LookupSequence( "midslash2" ) )
                self.Slash = 1
            end --if it looks stupid but works, it aint stupid!
            self:EmitSound( self.Primary.Sound ) --slash in the wind sound here
            if SERVER and IsValid( self:GetOwner() ) then
                if self:GetOwner():Alive() then
                    if self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                        local slash = {}
                        slash.start = pos
                        slash.endpos = pos + (ang * 52)
                        slash.filter = self:GetOwner()
                        slash.mins = Vector( -15, -5, 0 )
                        slash.maxs = Vector( 15, 5, 5 )
                        local slashtrace = util.TraceHull( slash )
                        if slashtrace.Hit then
                            targ = slashtrace.Entity
                            if targ:IsPlayer() or targ:IsNPC() then
                                self:EmitSound( self.SwordChop )
                                paininfo = DamageInfo()
                                paininfo:SetDamage( pain )
                                paininfo:SetDamageType( DMG_SLASH )
                                paininfo:SetAttacker( self:GetOwner() )
                                paininfo:SetInflictor( self )
                                paininfo:SetDamageForce( slashtrace.Normal * 35000 )
                                if SERVER then targ:TakeDamageInfo( paininfo ) end
                            else
                                self:EmitSound( self.KnifeShink ) --SHINK!
                                look = self:GetOwner():GetEyeTrace()
                                util.Decal( "ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
                            end
                        end
                    end
                end
            end

            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        end
    end
end

--[[ function GuardUp(victim, info)

    if !IsValid(victim) then return end
    if not IsValid(info) then return end
    if not IsValid(info:GetInflictor()) then return end

    if info:GetInflictor():GetClass() ~= nil then
        if info:GetInflictor():GetClass() == "m9k_damascus" then
            if victim:IsPlayer() and victim:Alive() then
                if victim:GetNWBool("GuardIsUp", false) then
                    victim:SetHealth(victim:Health() + info:GetDamage())
                    victim:EmitSound(Sound("weapons/blades/clash.mp3"))
                else
                    victim:EmitSound(Sound("weapons/blades/swordchop.mp3"))
                end
            else
                victim:EmitSound(Sound("weapons/blades/swordchop.mp3"))
            end
        end
    end

end
hook.Add("EntityTakeDamage", "GuardUp", GuardUp ) ]]

--I'm moving this to the autorun file, where the server will pick it up and run it... automatically.
--it shouldnt change anything.

function SWEP:Holster()
    if CLIENT and IsValid( self:GetOwner() ) and not self:GetOwner():IsNPC() then
        local vm = self:GetOwner():GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    self:GetOwner():SetNWBool( "GuardIsUp", false )
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

    --copy this...

    if self:GetOwner():KeyPressed( IN_SPEED ) then
        self:GetOwner():SetNWBool( "GuardIsUp", false )
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

    --down to this
    if not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- If the key E (Use Key) is not pressed, then

        if self:GetOwner():KeyPressed( IN_ATTACK2 ) and not (self:GetNWBool( "Reloading" )) then
            self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true, self:GetOwner() )
            self.DrawCrosshair = false
            self:GetOwner():SetNWBool( "GuardIsUp", true )
            -- Set the ironsight true

            if CLIENT then return end
        end
    end

    if self:GetOwner():KeyReleased( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- If the right click is released, then
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = true
        self:SetIronsights( false, self:GetOwner() )
        -- Set the ironsight false

        self:GetOwner():SetNWBool( "GuardIsUp", false )

        if CLIENT then return end
    end

    if self:GetOwner():KeyDown( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end

if GetConVar( "M9KUniqueSlots" ) ~= nil then
    if not (GetConVar( "M9KUniqueSlots" ):GetBool()) then
        SWEP.SlotPos = 2
    end
end

