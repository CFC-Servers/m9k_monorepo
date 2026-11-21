ENT.Type              = "anim"
ENT.PrintName         = ""
ENT.Author            = ""
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = "LAUNCH"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DisableDuplicator = true

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

        self.flightvector = self:GetUp() * self.FlightSpeed * M9K.TickspeedMult
        self.timeleft = CurTime() + 5
        self:SetModel( "models/failure/mk6/m62.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS ) -- Make us work with physics,
        self:SetMoveType( MOVETYPE_NONE ) --after all, gmod is a physics
        self:SetSolid( SOLID_VPHYSICS ) -- CHEESECAKE!    >:3
        self:SetColor( Color( 82, 102, 39, 254 ) )

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
            if not IsValid( self.Owner ) then
                self:Remove()
                return
            end

            local nuke = ents.Create( "m9k_davy_crockett_explo" )
            nuke:SetPos( self:GetPos() )
            nuke:SetOwner( self.Owner )
            nuke:Spawn()
            nuke:Activate()
            self:Remove()
        end

        local trace = {}
        trace.start = self:GetPos()
        trace.endpos = self:GetPos() + self.flightvector
        trace.filter = { self:GetOwner(), self }
        local tr = util.TraceLine( trace )


        if tr.HitSky then
            if not IsValid( self.Owner ) then
                self:Remove()
                return
            end
            local nuke = ents.Create( "m9k_davy_crockett_explo" )
            nuke:SetPos( self:GetPos() )
            nuke:SetOwner( self.Owner )
            nuke.Owner = self.Owner
            nuke:Spawn()
            nuke:Activate()
            self:Remove()
            self:SetNWBool( "smoke", false )
        end

        if tr.Hit then
            if not IsValid( self.Owner ) then
                self:Remove()
                return
            end
            local nuke = ents.Create( "m9k_davy_crockett_explo" )
            nuke:SetPos( self:GetPos() )
            nuke:SetOwner( self.Owner )
            nuke.Owner = self.Owner
            nuke:Spawn()
            nuke:Activate()
            self:Remove()
            self:SetNWBool( "smoke", false )
        end

        self:SetPos( self:GetPos() + self.flightvector )
        self.flightvector = self.flightvector - self.flightvector / self.FlightDragDivisor + self:GetUp() * self.FlightAcceleration + Vector( math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterVertical, self.FlightJitterVertical ) ) +
            Vector( 0, 0, -self.FlightGravity )
        self:SetAngles( self.flightvector:Angle() + Angle( 90, 0, 0 ) )
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
            local up = self:GetUp()
            local pos = self:GetPos()
            local emitter = self.emitter

            if not emitter then
                emitter = ParticleEmitter( pos )
                self.emitter = emitter
            end

            for i = 0, 10 do
                local particle = emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + ( up * -100 * i ) )

                if particle then
                    particle:SetVelocity( up * -2000 )
                    particle:SetDieTime( math.Rand( 2, 5 ) )
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
