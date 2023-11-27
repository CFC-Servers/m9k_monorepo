ENT.Type              = "anim"
ENT.PrintName         = "Explosive C4"
ENT.Author            = "Worshipper"
ENT.Contact           = "Josephcadieux@hotmail.com"
ENT.Purpose           = ""
ENT.Instructions      = ""
ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true
ENT.CanTool           = false

function ENT:SetupDataTables()
    self:DTVar( "Int", 0, "Timer" )
end

function ENT:Initialize()
    self.C4CountDown = self:GetDTInt( 0 )
    self:CountDown()
end

function ENT:CountDown()
    if self.C4CountDown > 1 then
        self:EmitSound( "C4.PlantSound" )

        self.C4CountDown = self.C4CountDown - 1

        timer.Create( "m9kC4CountDown" .. self:EntIndex(), 1, 0, function()
            self:CountDown()
        end )
    else
        self.C4CountDown = 0
        timer.Remove( "m9kC4CountDown" .. self:EntIndex() )
    end
end

function ENT:OnRemove()
    timer.Remove( "m9kC4CountDown" .. self:EntIndex() )
end

if SERVER then
    AddCSLuaFile( "shared.lua" )

    function ENT:Initialize()
        if not IsValid( self.BombOwner ) then
            self:Remove()
            return
        end

        self:SetModel( "models/weapons/w_sb_planted.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )

        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

        local phys = self:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
        end

        self.Used = false

        self:SetDTInt( 0, self.Timer )
        self.ThinkTimer = CurTime() + self:GetDTInt( 0 )
    end

    function ENT:Think()
        if self.ThinkTimer < CurTime() then
            self:Explosion()
        end
    end

    function ENT:Explosion()
        if not IsValid( self.BombOwner ) then
            self:Remove()
            return
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )
        util.Effect( "ThumperDust", effectdata )
        util.Effect( "Explosion", effectdata )

        local boomEffect = EffectData()
        boomEffect:SetOrigin( self:GetPos() )
        boomEffect:SetNormal( self:VectorGet() )
        boomEffect:SetEntity( self )
        boomEffect:SetScale( 2 )
        boomEffect:SetRadius( 67 )
        boomEffect:SetMagnitude( 18 )
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )

        util.ScreenShake( self:WorldSpaceCenter(), 2000, 255, 2.5, 1250 )
        util.BlastDamage( self, self.BombOwner, self:WorldSpaceCenter(), 500, 500 )

        self:EmitSound( Sound( "C4.Explode" ) )

        self:Remove()
    end

    function ENT:VectorGet()
        local startpos = self:GetPos()

        local downtrace = {}
        downtrace.start = startpos
        downtrace.endpos = startpos + self:GetUp() * -5
        downtrace.filter = self
        tracedown = util.TraceLine( downtrace )

        if tracedown.Hit then
            return tracedown.HitNormal
        else
            return Vector( 0, 0, 1 )
        end
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()

        local FixAngles = self:GetAngles()
        local FixRotation = Vector( 0, 278.5, 0 )

        FixAngles:RotateAroundAxis( FixAngles:Right(), FixRotation.x )
        FixAngles:RotateAroundAxis( FixAngles:Up(), FixRotation.y )
        FixAngles:RotateAroundAxis( FixAngles:Forward(), FixRotation.z )

        local TargetPos = self:GetPos() + (self:GetUp() * 7) + (self:GetRight() * -.5) + (self:GetForward() * 1.15)

        local m, s = self:FormatTime( self.C4CountDown )

        self.Text = string.format( "%02d", m ) .. ":" .. string.format( "%02d", s )

        cam.Start3D2D( TargetPos, FixAngles, .07 )
        draw.SimpleText( self.Text, "CloseCaption_Normal", 31, -22, Color( 165, 0, 0, 255 ), 1, 1 )
        cam.End3D2D()
    end

    function ENT:FormatTime( seconds )
        local m = seconds % 604800 % 86400 % 3600 / 60
        local s = seconds % 604800 % 86400 % 3600 % 60

        return math.floor( m ), math.floor( s )
    end
end
