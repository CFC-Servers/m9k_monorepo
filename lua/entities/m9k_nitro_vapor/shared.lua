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

if SERVER then
    AddCSLuaFile( "shared.lua" )

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

        timer.Simple( .3, function() if IsValid( self ) then self:Blammo() end end )
    end

    function ENT:Think()
        if not IsValid( self ) then return end
        if not IsValid( self ) then return end

        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end
        self:NextThink( CurTime() )
    end

    function ENT:Blammo()
        local pos = self:GetPos()
        local damage = 600
        local radius = 200
        local nitro_owner

        if IsValid( self ) then
            if IsValid( self.Owner ) then
                nitro_owner = self.Owner
            elseif IsValid( self ) then
                nitro_owner = self
            end
        end
        if not IsValid( nitro_owner ) then return end

        util.BlastDamage( self, nitro_owner, pos, radius, damage )
        util.ScreenShake( pos, 500, 500, .25, 500 )
        sound.Play( "ambient/explosions/explode_7.wav", pos, 80 )

        local scorchstart = self:GetPos() + ((Vector( 0, 0, 1 )) * 5)
        local scorchend = self:GetPos() + ((Vector( 0, 0, -1 )) * 5)
        util.Decal( "Scorch", scorchstart, scorchend )

        for k, v in pairs( ents.FindInSphere( pos, 300 ) ) do
            if IsValid( v ) then
                if IsValid( v:GetPhysicsObject() ) then
                    local pushy = {}
                    pushy.start = pos
                    pushy.endpos = v:GetPos()
                    pushy.filter = self
                    local pushtrace = util.TraceLine( pushy )
                    if not pushtrace.HitWorld then
                        local thing = v:GetPhysicsObject()
                        thing:AddVelocity( pushtrace.Normal * 400 )
                    end
                end
            end
        end

        self:Remove()
    end
end
