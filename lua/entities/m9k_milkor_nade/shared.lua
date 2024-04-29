ENT.Type              = "anim"
ENT.PrintName         = "M54 High Explosive Anti-Tank"
ENT.Author            = "Generic Default"
ENT.Contact           = "AIDS"
ENT.Purpose           = "SPLODE"
ENT.Instructions      = "LAUNCH"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile( "shared.lua" )

    function ENT:Initialize()
        self.CanTool = false

        self.flightvector = self:GetUp() * ((75 * 52.5) / 66)
        self.timeleft = CurTime() + 15
        self.Owner = self:GetOwner()
        self:SetModel( "models/weapons/w_40mm_grenade_launched.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS ) -- Make us work with physics,
        self:SetMoveType( MOVETYPE_NONE ) --after all, gmod is a physics
        self:SetSolid( SOLID_VPHYSICS ) -- CHEESECAKE!    >:3
        self.InFlight = true
        self:SetNWBool( "smoke", true )
    end

    function ENT:Think()
        if not IsValid( self ) then return end

        local trace = {}
        trace.start = self:GetPos()
        trace.endpos = self:GetPos() + self.flightvector
        trace.filter = { self:GetOwner(), self }
        local tr = util.TraceLine( trace )


        if tr.HitSky then
            self:Remove()
            return true
        end

        if tr.Hit and self.InFlight then
            if not IsValid( self.Owner ) then
                self:Remove()
                return
            end
            if not (tr.MatType == 70 or tr.MatType == 50) then
                util.BlastDamage( self, self.Owner, tr.HitPos, 175, 200 )
                local effectdata = EffectData()
                effectdata:SetOrigin( tr.HitPos ) -- Where is hits
                effectdata:SetNormal( tr.HitNormal ) -- Direction of particles
                effectdata:SetEntity( self ) -- Who done it?
                effectdata:SetScale( 1.1 ) -- Size of explosion
                effectdata:SetRadius( tr.MatType ) -- What texture it hits
                effectdata:SetMagnitude( 12 ) -- Length of explosion trails
                util.Effect( "m9k_gdcw_cinematicboom", effectdata )
                util.ScreenShake( tr.HitPos, 12, 4, .75, 300 )
                util.Decal( "Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
                self:Remove()
            else
                if (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then tr.Entity:TakeDamage( 150, self.Owner, self ) end
                local effectdata = EffectData()
                effectdata:SetOrigin( tr.HitPos ) -- Where is hits
                effectdata:SetNormal( tr.HitNormal ) -- Direction of particles
                effectdata:SetEntity( self ) -- Who done it?
                effectdata:SetScale( 1 ) -- Size of explosion
                effectdata:SetRadius( tr.MatType ) -- What texture it hits
                effectdata:SetMagnitude( 10 ) -- Length of explosion trails
                tr.Entity:EmitSound( ("physics/flesh/flesh_squishy_impact_hard" .. math.random( 1, 4 ) .. ".wav"), 500, 100 )
                util.Effect( "m9k_cinematic_blood_cloud", effectdata )
                self:SetMoveType( MOVETYPE_VPHYSICS )
                self:SetPos( tr.HitPos )
                local phys = self:GetPhysicsObject()
                phys:Wake()
                phys:SetMass( 3 )
                self.InFlight = false
                self:SetNWBool( "smoke", false )
                self.timeleft = CurTime() + 2
            end
        end

        if self.InFlight then
            self:SetPos( self:GetPos() + self.flightvector )
            self.flightvector = self.flightvector - (self.flightvector / 350) + Vector( math.Rand( -0.1, 0.1 ), math.Rand( -0.1, 0.1 ), math.Rand( -0.1, 0.1 ) ) + Vector( 0, 0, -0.035 )
            self:SetAngles( self.flightvector:Angle() + Angle( 90, 0, 0 ) )
        end

        if CurTime() > self.timeleft then
            self:Explosion()
        end

        self:NextThink( CurTime() )
        return true
    end

    function ENT:Explosion()
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        util.BlastDamage( self, self.Owner, self:GetPos(), 175, 200 )
        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() ) -- Where is hits
        effectdata:SetNormal( Vector( 0, 0, 1 ) ) -- Direction of particles
        effectdata:SetEntity( self ) -- Who done it?
        effectdata:SetScale( 1.1 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 12 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        util.ScreenShake( self:GetPos(), 12, 4, .75, 300 )
        self:Remove()
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel() -- Draw the model.
    end

    function ENT:Initialize()
        pos = self:GetPos()
        self.emitter = ParticleEmitter( pos )
    end

    function ENT:Think()
        if (self:GetNWBool( "smoke" )) then
            pos = self:GetPos()
            for i = 0, (4) do
                local particle = self.emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + (self:GetUp() * -120 * i) )
                if (particle) then
                    particle:SetVelocity( (self:GetUp() * -2000) + (VectorRand() * 100) )
                    particle:SetDieTime( math.Rand( 2, 3 ) )
                    particle:SetStartAlpha( math.Rand( 3, 5 ) )
                    particle:SetEndAlpha( 0 )
                    particle:SetStartSize( math.Rand( 30, 40 ) )
                    particle:SetEndSize( math.Rand( 80, 90 ) )
                    particle:SetRoll( math.Rand( 0, 360 ) )
                    particle:SetRollDelta( math.Rand( -1, 1 ) )
                    particle:SetColor( 150, 150, 150 )
                    particle:SetAirResistance( 200 )
                    particle:SetGravity( Vector( 100, 0, 0 ) )
                end
            end
        end
    end
end

