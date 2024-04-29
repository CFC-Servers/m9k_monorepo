ENT.Type              = "anim"
ENT.PrintName         = "Nerve Gas Grenade pain parent"
ENT.Author            = "Generic Default did most of this, i just modified it"
ENT.Contact           = ""
ENT.Purpose           = "this is here to tell the point hurt entity who owns it, becaus point_hurts can't have parents set on their own. dammit"
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
    end
end
