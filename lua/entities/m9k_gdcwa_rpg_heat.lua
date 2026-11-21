ENT.Type              = "anim"
ENT.PrintName         = "High Explosive Anti-Tank RPG"
ENT.Author            = "Generic Default"
ENT.Contact           = "AIDS"
ENT.Purpose           = "SPLODE"
ENT.Instructions      = "LAUNCH"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DisableDuplicator = true

ENT.ExplosionRadius = 600
ENT.ExplosionDamage = 150

ENT.FlightSpeed = ( 115 * 52.5 ) / 66
ENT.FlightJitterHorizontal = 0.3
ENT.FlightJitterVertical = 0.1
ENT.FlightGravity = 0.111
ENT.FlightDragDivisor = ((147 * 39.37) / 66)
ENT.FlightAcceleration = 2

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self.CanTool = false

        self.flightvector = self:GetForward() * self.FlightSpeed * M9K.TickspeedMult
        self.timeleft = CurTime() + 10
        self.Owner = self:GetOwner()
        self:SetModel( "models/Weapons/W_missile_closed.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS ) -- Make us work with physics,
        self:SetMoveType( MOVETYPE_NONE ) --after all, gmod is a physics
        self:SetSolid( SOLID_VPHYSICS ) -- CHEESECAKE!    >:3
        self:SetMaterial( "models/debug/debugwhite.vmt" )
        self:SetColor( Color( 55, 67, 44, 255 ) )

        local Glow = ents.Create( "env_sprite" )
        Glow:SetKeyValue( "model", "orangecore2.vmt" )
        Glow:SetKeyValue( "rendercolor", "255 150 100" )
        Glow:SetKeyValue( "scale", "0.3" )
        Glow:SetPos( self:GetPos() )
        Glow:SetParent( self )
        Glow:Spawn()
        Glow:Activate()
        self:SetNWBool( "smoke", true )
    end

    function ENT:Think()
        if self.timeleft < CurTime() then
            self:Remove()
        end

        local trace = {}
        trace.start = self:GetPos()
        trace.endpos = self:GetPos() + self.flightvector
        trace.filter = { self:GetOwner(), self }
        local tr = util.TraceLine( trace )


        if tr.HitSky then
            self:Remove()
            return true
        end

        if tr.Hit then
            if not IsValid( self.Owner ) then
                self:Remove()
                return
            end
            util.BlastDamage( self, self.Owner, tr.HitPos, self.ExplosionRadius, self.ExplosionDamage )
            local effectdata = EffectData()
            effectdata:SetOrigin( tr.HitPos ) -- Where is hits
            effectdata:SetNormal( tr.HitNormal ) -- Direction of particles
            effectdata:SetEntity( self ) -- Who done it?
            effectdata:SetScale( 1.8 ) -- Size of explosion
            effectdata:SetRadius( tr.MatType ) -- What texture it hits
            effectdata:SetMagnitude( 18 ) -- Length of explosion trails
            util.Effect( "m9k_gdcw_cinematicboom", effectdata )
            util.ScreenShake( tr.HitPos, 10, 5, 1, 3000 )
            util.Decal( "Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )
            self:SetNWBool( "smoke", false )
            self:Remove()
        end

        self:SetPos( self:GetPos() + self.flightvector )
        self.flightvector = self.flightvector - self.flightvector / self.FlightDragDivisor + self:GetForward() * self.FlightAcceleration + Vector( math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterVertical, self.FlightJitterVertical ) ) +
            Vector( 0, 0, -self.FlightGravity )
        self:SetAngles( self.flightvector:Angle() + Angle( 0, 0, 0 ) )
        self:NextThink( CurTime() )
        return true
    end
end

if CLIENT then
    function ENT:OnRemove()
        if self.emitter then
            self.emitter:Finish()
        end
    end

    function ENT:Think()
        if self:GetNWBool( "smoke" ) then
            local forward = self:GetForward()
            local pos = self:GetPos()
            local emitter = self.emitter

            if not emitter then
                emitter = ParticleEmitter( pos )
                self.emitter = emitter
            end

            for i = 0, 10 do
                if IsValid( emitter ) then
                    local particle = emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + ( forward * -100 * i ) )
                    if particle then
                        particle:SetVelocity( forward * -2000 )
                        particle:SetDieTime( math.Rand( 1.5, 3 ) )
                        particle:SetStartAlpha( math.Rand( 5, 8 ) )
                        particle:SetEndAlpha( 0 )
                        particle:SetStartSize( math.Rand( 40, 50 ) )
                        particle:SetEndSize( math.Rand( 130, 150 ) )
                        particle:SetRoll( math.Rand( 0, 360 ) )
                        particle:SetRollDelta( math.Rand( -1, 1 ) )
                        particle:SetColor( 200, 200, 200 )
                        particle:SetAirResistance( 200 )
                        particle:SetGravity( Vector( 100, 0, 0 ) )
                    end
                end
            end
        end
    end
end
