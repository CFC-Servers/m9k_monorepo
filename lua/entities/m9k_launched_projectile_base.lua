ENT.Type              = "anim"
ENT.PrintName         = "M9k Launched Projectile Base"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

ENT.FlightDrop = ( 80 * 52.5 ) / 66

ENT.ExplosionEffectMagnitude = 14 -- Length of explosion trails
ENT.ExplosionEffectScale = 2 -- Size of the explosion

ENT.ExplosionRadius = 150
ENT.ExplosionDamage = 350

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self.CanTool = false

        self.Flightvector = self:GetUp() * self.FlightDrop * M9K.TickspeedMult
        self.timeleft = CurTime() + 15
        self:SetModel( "models/weapons/w_40mm_grenade_launched.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS ) -- Make us work with physics,
        self:SetMoveType( MOVETYPE_NONE ) --after all, gmod is a physics
        self:SetSolid( SOLID_VPHYSICS ) -- CHEESECAKE!    >:3
        self.InFlight = true
        self:SetNWBool( "smoke", true )
    end

    function ENT:Think()
        local owner = self:GetOwner()

        local trace = {
            start = self:GetPos(),
            endpos = self:GetPos() + self.Flightvector,
            filter = { owner, self }
        }
        local tr = util.TraceLine( trace )

        if tr.HitSky then
            self:Remove()
            return true
        end

        if tr.Hit and self.InFlight then
            if not IsValid( owner ) then
                self:Remove()
                return
            end

            if not ( tr.MatType == 70 or tr.MatType == 50 ) then
                self:Explosion( tr.HitPos, tr.HitNormal, tr.MatType )
            else
                self:DirectHit( tr )
            end
        end

        if self.InFlight then
            self:SetPos( self:GetPos() + self.Flightvector )
            self.Flightvector = self.Flightvector - ( self.Flightvector / 350 ) + self:GetFlightRand()
            self:SetAngles( self.Flightvector:Angle() + Angle( 90, 0, 0 ) )
        end

        if CurTime() > self.timeleft then
            self:Explosion()
        end

        self:NextThink( CurTime() )
        return true
    end

    function ENT:GetFlightRand()
        return Vector( math.Rand( -0.2, 0.2 ), math.Rand( -0.2, 0.2 ), math.Rand( -0.1, 0.1 ) ) + Vector( 0, 0, -0.111 )
    end

    function ENT:DirectHit( tr )
        if ( tr.Entity:IsPlayer() or tr.Entity:IsNPC() ) then
            tr.Entity:TakeDamage( 150, self:GetOwner(), self )
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( tr.HitPos ) -- Where is hits
        effectdata:SetNormal( tr.HitNormal ) -- Direction of particles
        effectdata:SetEntity( self ) -- Who done it?
        effectdata:SetScale( 1 ) -- Size of explosion
        effectdata:SetRadius( tr.MatType ) -- What texture it hits
        effectdata:SetMagnitude( 10 ) -- Length of explosion trails

        tr.Entity:EmitSound( "physics/flesh/flesh_squishy_impact_hard" .. math.random( 1, 4 ) .. ".wav", 500, 100 )
        util.Effect( "m9k_cinematic_blood_cloud", effectdata )

        if ( tr.Entity:IsPlayer() and tr.Entity:Alive() ) or tr.Entity:IsNPC() and tr.Entity:Health() > 0 then
            self:SetParent( tr.Entity )
            self:SetMoveType( MOVETYPE_NONE )
            self:SetPos( tr.HitPos )
            self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
        else
            self:SetMoveType( MOVETYPE_VPHYSICS )
            self:SetPos( tr.HitPos )
        end

        local phys = self:GetPhysicsObject()
        phys:Wake()
        phys:SetMass( 3 )

        self.InFlight = false
        self:SetNWBool( "smoke", false )
        self.timeleft = CurTime() + 2
    end

    function ENT:Explosion( pos, normal, mattype )
        local owner = self:GetOwner()

        if not IsValid( owner ) then
            self:Remove()
            return
        end

        if self.Exploded then return end
        self.Exploded = true

        pos = pos or self:GetPos()
        normal = normal or Vector( 0, 0, 1 )
        mattype = mattype or 67

        util.BlastDamage( self, owner, pos, self.ExplosionRadius, self.ExplosionDamage )
        local effectdata = EffectData()
        effectdata:SetOrigin( pos )
        effectdata:SetNormal( normal )
        effectdata:SetEntity( self )
        effectdata:SetScale( self.ExplosionEffectScale )
        effectdata:SetRadius( mattype )
        effectdata:SetMagnitude( self.ExplosionEffectMagnitude )
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        util.ScreenShake( self:GetPos(), 10 * self.ExplosionEffectScale, 5, 1, self.ExplosionRadius * 3 )
        util.Decal( "Scorch", pos + normal, pos - normal )
        self:Remove()
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel() -- Draw the model.
    end

    function ENT:Initialize()
        local pos = self:GetPos()
        self.emitter = ParticleEmitter( pos )
    end

    function ENT:Think()
        if self:GetNWBool( "smoke" ) then
            pos = self:GetPos()
            for i = 0, 4 do
                local particle = self.emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + (self:GetUp() * -120 * i) )
                if particle then
                    particle:SetVelocity( ( self:GetUp() * -2000 ) + ( VectorRand() * 100 ) )
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
