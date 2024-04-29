ENT.Type              = "anim"
ENT.PrintName         = "Nerve Gas Grenade"
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
        self:PhysicsInit( MOVETYPE_NONE )
        self:SetMoveType( MOVETYPE_VPHYSICS ) --the way it was
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        self:SetRenderMode( RENDERMODE_TRANSALPHA )
        self:SetColor( Color( 0, 0, 0, 0 ) ) --fix this later

        if self.Big then
            self.timeleft = CurTime() + 28
        else
            self.timeleft = CurTime() + 18
        end
        self.CanTool = false
    end

    function ENT:Think()
        if not IsValid( self ) then return end

        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        if self.timeleft < CurTime() then
            self:Remove()
        end

        self:MakePoison()
        self:NextThink( CurTime() )
    end

    function ENT:MakePoison()
        local pos = self.PosToKeep
        if pos == nil then pos = self:GetPos() end
        local damage = 70
        local radius = 225

        if self.Big then
            radius = 600
            damage = 70
        else
            radius = 225
            damage = 70
        end

        local poisonowner
        if IsValid( self ) then
            if IsValid( self.Owner ) then
                poisonowner = self.Owner
            elseif IsValid( self ) then
                poisonowner = self
            end
        end
        if not IsValid( poisonowner ) then return end

        util.BlastDamage( self, poisonowner, pos, radius, damage )
        -- an explosion for making poison. Sure, must be one hell of a nerve agent to light wood on fire
        -- and to shatter windows. Guess i'll just have to deal with it.
    end
end
