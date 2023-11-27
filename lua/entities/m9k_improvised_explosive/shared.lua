ENT.Type              = "anim"
ENT.PrintName         = "IED"
ENT.Author            = ""
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = ""

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile( "shared.lua" )

    function ENT:Initialize()
        self.CanTool = false

        self:SetModel( "models/props_junk/cardboard_box004a.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

        self:SetNWBool( "Activated", true )
        self.Boom = false

        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:Wake()
        end

        self:Think()
    end

    function ENT:Think()
        if not IsValid( self ) then return end
        if not IsValid( self ) then return end

        if self.Boom then
            self:Explosion()
        end

        self:NextThink( CurTime() )
        return true
    end

    function ENT:Explosion()
        if not IsValid( self ) then return end
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() ) -- Where is hits
        effectdata:SetNormal( Vector( 0, 0, 1 ) ) -- Direction of particles
        effectdata:SetEntity( self ) -- Who done it?
        effectdata:SetScale( 1 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 18 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_tpaboom", effectdata )
        util.Effect( "HelicopterMegaBomb", effectdata )
        util.Effect( "ThumperDust", effectdata )

        util.BlastDamage( self, self.Owner, self:GetPos(), 500, 170 )
        util.ScreenShake( self:GetPos(), 3000, 255, 2.25, 2000 )

        self.IEDSounds = {}
        self.IEDSounds[1] = "ambient/explosions/explode_1.wav"
        self.IEDSounds[2] = "ambient/explosions/explode_2.wav"
        self.IEDSounds[3] = "ambient/explosions/explode_3.wav"
        self.IEDSounds[4] = "ambient/explosions/explode_4.wav"

        self:EmitSound( self.IEDSounds[(math.random( 1, 4 ))], 100, 100, 100 )
        local scorchstart = self:GetPos() + ((Vector( 0, 0, 1 )) * 5)
        local scorchend = self:GetPos() + ((Vector( 0, 0, -1 )) * 5)
        self:Remove()
        util.Decal( "Scorch", scorchstart, scorchend )
    end

    function ENT:TinyExplo()
        if not IsValid( self ) then return end
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() ) -- Where is hits
        effectdata:SetNormal( Vector( 0, 0, 1 ) ) -- Direction of particles
        effectdata:SetEntity( self ) -- Who done it?
        effectdata:SetScale( 1 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 8 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        util.Effect( "HelicopterMegaBomb", effectdata )
        util.Effect( "ThumperDust", effectdata )

        util.BlastDamage( self, self.Owner, self:GetPos(), 100, 60 )
        util.ScreenShake( self:GetPos(), 1500, 255, 2.25, 800 )

        self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 4 ) .. ".wav", self:GetPos(), 35, 100 )

        self:Remove()
    end

    --[[---------------------------------------------------------
OnTakeDamage
-----------------------------------------------------------]]
    function ENT:OnTakeDamage( dmginfo )
        if (dmginfo:GetInflictor() ~= self)
            and (dmginfo:GetInflictor():GetClass() ~= "m9k_improvised_explosive") then
            local GoodLuck = math.random( 1, 10 )
            if GoodLuck == 1 then
                self:Explosion()
            end
            if GoodLuck == 5 then
                self:TinyExplo()
            end
        end
    end

    --[[---------------------------------------------------------
Use
-----------------------------------------------------------]]
    function ENT:Use( activator, caller, type, value )
    end

    --[[---------------------------------------------------------
StartTouch
-----------------------------------------------------------]]
    function ENT:StartTouch( entity )
    end

    --[[---------------------------------------------------------
EndTouch
-----------------------------------------------------------]]
    function ENT:EndTouch( entity )
    end

    --[[---------------------------------------------------------
Touch
-----------------------------------------------------------]]
    function ENT:Touch( entity )
    end

    --[[---------------------------------------------------------
OnRemove
-----------------------------------------------------------]]
    function ENT:OnRemove()
    end

    --[[---------------------------------------------------------
PhysicsUpdate
-----------------------------------------------------------]]
    function ENT:PhysicsUpdate()
    end

    --[[---------------------------------------------------------
PhysicsCollide
-----------------------------------------------------------]]
    function ENT:PhysicsCollide( data, phys )
        local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
        phys:ApplyForceCenter( impulse )
    end
end

if CLIENT then
    --[[---------------------------------------------------------
Draw
-----------------------------------------------------------]]
    function ENT:Draw()
        self:DrawModel()
    end
end
