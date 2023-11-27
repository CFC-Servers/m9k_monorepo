ENT.Type              = "point"

ENT.PrintName         = "Nuclear Radiation"
ENT.Author            = "Teta_Bonita"

ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile( "shared.lua" )

    function ENT:Initialize()
        --variables
        self.Yield = (GetConVarNumber( "nuke_yield" ) or 100) / 100
        self.YieldSlow = self.Yield ^ 0.75
        self.YieldSlowest = self.Yield ^ 0.5
        self.Pos = self:GetPos() + Vector( 0, 0, 4 )

        self.Damage = (GetConVarNumber( "nuke_radiation_damage" ) or 100) * 3e5 * self.YieldSlow
        self.Duration = (GetConVarNumber( "nuke_radiation_duration" ) or 100) * 0.40 * self.YieldSlowest
        self.Radius = 12000 * self.YieldSlow

        self.Weapon = self
        self.lastThink = CurTime() + 3
        self.RadTime = CurTime() + self.Duration

        --We need to init physics properties even though this entity isn't physically simulated
        self:SetMoveType( MOVETYPE_NONE )
        self:DrawShadow( false )

        self:SetCollisionBounds( Vector( -20, -20, -10 ), Vector( 20, 20, 10 ) )
        self:PhysicsInitBox( Vector( -20, -20, -10 ), Vector( 20, 20, 10 ) )

        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:EnableCollisions( false )
        end

        self:SetNotSolid( true )

        --remove this ent after awhile
        self:Fire( "kill", "", self.Duration )
        self.CanTool = false
    end

    function ENT:LOS( ent, entpos )
        local trace = {}
        trace.start = self.Pos
        trace.filter = { self }
        trace.endpos = entpos
        local traceRes = util.TraceLine( trace )

        if (traceRes.Entity ~= ent) and math.abs( self.Pos.z - entpos.z ) < 800 * self.Yield then
            trace.start = Vector( self.Pos.x, self.Pos.y, entpos.z )
            traceRes = util.TraceLine( trace )
        end

        return (traceRes.Entity == ent)
    end

    function ENT:Think()
        if not IsValid( self ) then return end
        if not IsValid( self ) then return end

        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        local CurrentTime = CurTime()
        local FTime = CurrentTime - self.lastThink

        if FTime < 0.3 then return end

        self.lastThink = CurrentTime
        local RadIntensity = (self.RadTime - CurrentTime) / self.Duration

        for key, found in pairs( ents.FindInSphere( self.Pos, self.Radius ) ) do
            local entpos
            local entdist

            if found:IsValid() then
                if found:IsNPC() then
                    entpos = found:LocalToWorld( found:OBBCenter() )
                    if self:LOS( found, entpos ) then
                        entdist = ((entpos - self.Pos):Length()) ^ -2
                        util.BlastDamage( self.Weapon, self.Owner, entpos, 8, self.Damage * RadIntensity * entdist )
                    end
                elseif found:IsPlayer() then
                    entpos = found:LocalToWorld( found:OBBCenter() )
                    if self:LOS( found, entpos ) then
                        entdist = ((entpos - self.Pos):Length()) ^ -2
                        found:TakeDamage( self.Damage * RadIntensity * entdist, self.Owner )
                    end
                end
            end
        end
    end
end

