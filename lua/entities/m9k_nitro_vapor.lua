ENT.Type              = "anim"
ENT.PrintName         = "Nitro vapor"
ENT.Author            = "Generic Default did most of this, i just modified it"
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = ""
ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true
ENT.ExplosionDamage = 600
ENT.ExplosionRadius = 200

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self:SetModel( "models/maxofs2d/hover_classic.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS ) --the way it was
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        self:SetRenderMode( RENDERMODE_TRANSALPHA )
        self:SetColor( Color( 0, 0, 0, 0 ) ) --fix this later
        self.CanTool = false

        timer.Simple( .3, function()
            if IsValid( self ) then
                self:Blammo()
            end
        end )
    end

    function ENT:Think()
        if not IsValid( self:GetOwner() ) then
            self:Remove()
            return
        end
        self:NextThink( CurTime() )
    end

    function ENT:Blammo()
        local pos = self:GetPos()
        local owner = self:GetOwner()
        if not IsValid( owner ) then return end

        util.BlastDamage( self, owner, pos, self.ExplosionRadius, self.ExplosionDamage )
        util.ScreenShake( pos, 500, 500, .25, 500 )
        sound.Play( "ambient/explosions/explode_7.wav", pos, 80 )

        local scorchstart = self:GetPos() + ( ( Vector( 0, 0, 1 ) ) * 5 )
        local scorchend = self:GetPos() + ( ( Vector( 0, 0, -1 ) ) * 5 )
        util.Decal( "Scorch", scorchstart, scorchend )

        for _, ent in ipairs( ents.FindInSphere( pos, 300 ) ) do
            if IsValid( ent:GetPhysicsObject() ) then
                local pushy = {}
                pushy.start = pos
                pushy.endpos = ent:GetPos()
                pushy.filter = self
                local pushtrace = util.TraceLine( pushy )
                if not pushtrace.HitWorld then
                    local thing = ent:GetPhysicsObject()
                    thing:AddVelocity( pushtrace.Normal * 400 )
                end
            end
        end

        self:Remove()
    end
end
