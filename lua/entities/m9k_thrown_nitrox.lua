ENT.Type              = "anim"
ENT.PrintName         = "Nitro Glycerine"
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
ENT.ExplosionEffectScale = 1.5
ENT.ExplosionEffectMagnitude = 5

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self.CanTool = false

        self:SetModel( "models/weapons/w_nitro.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )

        self:DrawShadow( false )

        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:SetMass( 5 )
            phys:Wake()
            phys:AddAngleVelocity( Vector( 0, 500, 0 ) )
        end
        self:Think()
    end

    function ENT:Think()
        self:NextThink( CurTime() )
        return true
    end

    --[[---------------------------------------------------------
PhysicsCollide
-----------------------------------------------------------]]
    function ENT:PhysicsCollide()
        self:EmitSound( "GlassBottle.Break" )

        timer.Simple( 0, function()
            if IsValid( self ) then
                self:QueueExplosion()
            end
        end )
    end

    function ENT:QueueExplosion()
        if self.Exploded then return end
        self.Exploded = true

        local owner = self._m9kOwner

        if not IsValid( owner ) then
            self:Remove()
            return
        end

        local pos = self:LocalToWorld( self:OBBCenter() )
        local normal = Vector( 0, 0, 1 )

        local effectdata = EffectData()
        effectdata:SetOrigin( pos )
        effectdata:SetNormal( normal )
        effectdata:SetEntity( self )
        effectdata:SetScale( self.ExplosionEffectScale )
        effectdata:SetRadius( 67 )
        effectdata:SetMagnitude( self.ExplosionEffectMagnitude )
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        util.BlastDamage( self, owner, pos, self.ExplosionRadius, self.ExplosionDamage )
        util.ScreenShake( pos, 500, 500, .25, 500 )
        sound.Play( "ambient/explosions/explode_7.wav", pos, 75 )

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

    --[[---------------------------------------------------------
OnTakeDamage
-----------------------------------------------------------]]
    function ENT:OnTakeDamage( dmginfo )
        if not IsValid( dmginfo ) then return end
        if not IsValid( dmginfo:GetInflictor() ) then return end
        if dmginfo:GetInflictor() == "m9k_released_poison" then return end
        self:QueueExplosion()
        self:EmitSound( "GlassBottle.Break" )
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel() -- Draw the model.
    end
end
