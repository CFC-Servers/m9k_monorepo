ENT.Type              = "anim"
ENT.PrintName         = ""
ENT.Author            = ""
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = "LAUNCH"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self.CanTool = false

        self.flightvector = self:GetUp() * ((115 * 52.5) / 66)
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
        if not IsValid( self ) then return end

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
        self.flightvector = self.flightvector - self.flightvector / ((147 * 39.37) / 66) + self:GetUp() * 2 + Vector( math.Rand( -0.3, 0.3 ), math.Rand( -0.3, 0.3 ), math.Rand( -0.1, 0.1 ) ) +
            Vector( 0, 0, -0.111 )
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
            for i = 0, (10) do
                local particle = self.emitter:Add( "particle/smokesprites_000" .. math.random( 1, 9 ), pos + (self:GetUp() * -100 * i) )
                if (particle) then
                    particle:SetVelocity( (self:GetUp() * -2000) )
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

