ENT.Type              = "anim"
ENT.PrintName         = "90mm High Explosive"
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

        self.flightvector = self:GetUp() * ((250 * 52.5) / 66)
        self.timeleft = CurTime() + 10
        self.Owner = self:GetOwner()
        self:SetModel( "models/props_junk/garbage_glassbottle001a.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS ) -- Make us work with physics,
        self:SetMoveType( MOVETYPE_NONE ) --after all, gmod is a physics
        self:SetSolid( SOLID_VPHYSICS ) -- CHEESECAKE!    >:3
        self:SetColor( Color( 45, 55, 40, 255 ) )

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
        if not IsValid( self ) then return end

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
            util.BlastDamage( self, self.Owner, tr.HitPos, 450, 150 )
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
        self.flightvector = self.flightvector - (self.flightvector / 200) + Vector( math.Rand( -0.1, 0.1 ), math.Rand( -0.1, 0.1 ), math.Rand( -0.05, 0.05 ) ) + Vector( 0, 0, -0.111 )
        self:SetAngles( self.flightvector:Angle() + Angle( 90, 0, 0 ) )
        self:NextThink( CurTime() )
        return true
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
            for i = 0, (5) do
                local particle = self.emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + (self:GetUp() * -100 * i) )
                if (particle) then
                    particle:SetVelocity( (self:GetUp() * -2000) + (VectorRand() * 100) )
                    particle:SetDieTime( math.Rand( 2, 5 ) )
                    particle:SetStartAlpha( math.Rand( 5, 7 ) )
                    particle:SetEndAlpha( 0 )
                    particle:SetStartSize( math.Rand( 30, 40 ) )
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

