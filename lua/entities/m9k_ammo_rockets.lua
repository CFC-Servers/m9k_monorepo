ENT.Type           = "anim"
ENT.Base           = "base_anim"
ENT.PrintName      = "Rockets"
ENT.Category       = "M9K Ammunition"

ENT.Spawnable      = true
ENT.AdminOnly      = false
ENT.DoNotDuplicate = true

if SERVER then
    AddCSLuaFile()

    function ENT:SpawnFunction( ply, tr )
        if (not tr.Hit) then return end

        local SpawnPos = tr.HitPos + tr.HitNormal * 16

        local ent = ents.Create( "m9k_ammo_rockets" )

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

        local model = "models/items/ammocrates/craterockets.mdl"

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
        if dmginfo:IsExplosionDamage() and not self.BlowedUp then
            self:Remove()
            self.BlowedUp = true
            self:Explosion( dmginfo:GetAttacker() )
        elseif dice == 1 then
            self:Remove()
            self.BlowedUp = true
            self:Explosion( dmginfo:GetAttacker() )
        end
    end

    --[[---------------------------------------------------------
   Name: ENT:Explosion()
-----------------------------------------------------------]]
    function ENT:Explosion( attacker )
        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )
        effectdata:SetRadius( 1000 )
        effectdata:SetMagnitude( 1000 )
        util.Effect( "HelicopterMegaBomb", effectdata )

        local exploeffect = EffectData()
        exploeffect:SetOrigin( self:GetPos() )
        exploeffect:SetStart( self:GetPos() )
        util.Effect( "Explosion", exploeffect, true, true )

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() ) -- Where is hits
        effectdata:SetNormal( self:Normalizer() ) -- Direction of particles
        effectdata:SetEntity( self ) -- Who done it?
        effectdata:SetScale( 4 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 18 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        --generic default, you are a god among men

        util.BlastDamage( self, (self:OwnerCheck( attacker )), self:GetPos(), 1000, 800 )

        local shake = ents.Create( "env_shake" )
        shake:SetOwner( self:OwnerCheck( attacker ) )
        shake:SetPos( self:GetPos() )
        shake:SetKeyValue( "amplitude", "2000" ) -- Power of the shake
        shake:SetKeyValue( "radius", "1250" ) -- Radius of the shake
        shake:SetKeyValue( "duration", "2.5" ) -- Time of shake
        shake:SetKeyValue( "frequency", "255" ) -- How har should the screenshake be
        shake:SetKeyValue( "spawnflags", "4" ) -- Spawnflags(In Air)
        shake:Spawn()
        shake:Activate()
        shake:Fire( "StartShake", "", 0 )
        shake:Fire( "Kill", "", 3 )

        local push = ents.Create( "env_physexplosion" )
        push:SetOwner( self:OwnerCheck( attacker ) )
        push:SetPos( self:GetPos() )
        push:SetKeyValue( "magnitude", 100 )
        push:SetKeyValue( "radius", 1250 )
        push:SetKeyValue( "spawnflags", 2 + 16 )
        push:Spawn()
        push:Activate()
        push:Fire( "Explode", "", 0 )
        push:Fire( "Kill", "", .25 )


        self:EmitSound( "C4.Explode" )

        self:Remove()
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
            activator:GiveAmmo( 75, "RPG_Round" )
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
