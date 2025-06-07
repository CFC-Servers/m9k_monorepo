ENT.Type              = "anim"
ENT.PrintName         = "Nerve Gas Grenade pain parent"
ENT.Author            = "Generic Default did most of this, i just modified it"
ENT.Contact           = ""
ENT.Purpose           = "this is here to tell the point hurt entity who owns it, because point_hurts can't have parents set on their own. dammit"
ENT.Instructions      = ""
ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

ENT.Big = false
ENT.TimeLeft = 0

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self:SetModel( "models/maxofs2d/hover_classic.mdl" )
        self:SetMoveType( MOVETYPE_VPHYSICS ) --the way it was
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )
        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        self:SetRenderMode( RENDERMODE_TRANSALPHA )
        self:SetColor( Color( 0, 0, 0, 0 ) ) --fix this later

        if self.Big then
            self.TimeLeft = CurTime() + 28
        else
            self.TimeLeft = CurTime() + 18
        end
        self.CanTool = false
    end

    function ENT:Think()
        local owner = self:GetOwner()

        if not IsValid( owner ) then
            self:Remove()
            return
        end

        if self.TimeLeft < CurTime() then
            self:Remove()
        end

        local nearby = ents.FindInSphere( self:GetPos(), self.Big and 600 or 150 )
        for _, ent in ipairs( nearby ) do
            if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
                local trace = util.TraceLine( {
                    start = self:GetPos(),
                    endpos = ent:WorldSpaceCenter(),
                    filter = { self, ent }
                } )

                if not trace.Hit then
                    local dmg = DamageInfo()
                    dmg:SetDamage( math.random( 20, 30 ) )
                    dmg:SetDamageType( DMG_POISON )
                    dmg:SetInflictor( self )
                    dmg:SetAttacker( owner )
                    dmg:SetDamagePosition( self:WorldSpaceCenter() )
                    ent:TakeDamageInfo( dmg )
                end
            end
        end

        self:NextThink( CurTime() )
    end
end
