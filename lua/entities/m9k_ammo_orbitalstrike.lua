ENT.Type           = "anim"
ENT.Base           = "base_anim"
ENT.PrintName      = "Orbital Strike ammo"
ENT.Category       = "M9K Ammunition"

ENT.Spawnable      = true
ENT.AdminOnly      = false
ENT.DoNotDuplicate = true

if SERVER then
    AddCSLuaFile()

    function ENT:SpawnFunction( ply, tr )
        if (not tr.Hit) then return end

        local SpawnPos = tr.HitPos + tr.HitNormal * 16

        local ent = ents.Create( "m9k_ammo_orbitalstrike" )

        ent:SetPos( SpawnPos )
        ent:Spawn()
        ent:Activate()
        ent.Planted = false

        return ent
    end

    --[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]
    function ENT:Initialize()
        self.CanTool = false

        local model = "models/Items/item_item_crate.mdl"

        self:SetModel( model )

        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )

        self:SetCollisionGroup( COLLISION_GROUP_NONE )

        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
            phys:SetMass( 40 )
        end

        self:SetUseType( SIMPLE_USE )
    end

    --[[---------------------------------------------------------
   Name: PhysicsCollide
-----------------------------------------------------------]]
    function ENT:PhysicsCollide( data, physobj )
        if (data.Speed > 80 and data.DeltaTime > 0.2) then
            self:EmitSound( "Wood.ImpactHard" )
        end
    end

    --[[---------------------------------------------------------
   Name: OnTakeDamage
-----------------------------------------------------------]]
    function ENT:OnTakeDamage( dmginfo )
        self:TakePhysicsDamage( dmginfo )
        if GetConVar( "M9KAmmoDetonation" ) == nil then return end
        if not (GetConVar( "M9KAmmoDetonation" ):GetBool()) then return end
        local dice = math.random( 1, 15 )
        if dice == 1 then
        end
    end

    function ENT:OwnerCheck( attacker )
        if IsValid( attacker ) then
            return attacker
        else
            return self
        end
    end

    function ENT:Normalizer()
        local startpos = self:GetPos()

        local downtrace = {}
        downtrace.start = startpos
        downtrace.endpos = startpos + self:GetUp() * -5
        downtrace.filter = self
        tracedown = util.TraceLine( downtrace )

        if (tracedown.Hit) then
            return (tracedown.HitNormal)
        else
            return (Vector( 0, 0, 1 ))
        end
    end

    --[[---------------------------------------------------------
   Name: Use
-----------------------------------------------------------]]
    function ENT:Use( activator, caller )
        if (activator:IsPlayer()) and not self.Planted then
            if activator:GetWeapon( "m9k_orbital_strike" ) == NULL then
                activator:Give( "m9k_orbital_strike" )
            else
                activator:GiveAmmo( 1, "SatCannon" )
            end
            self:Remove()
        end
    end
end

if CLIENT then
    --[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]
    function ENT:Initialize()
    end

    --[[---------------------------------------------------------
   Name: DrawPre
-----------------------------------------------------------]]
    function ENT:Draw()
        self:DrawModel()
    end
end
