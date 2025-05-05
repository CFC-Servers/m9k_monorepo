ENT.Type           = "anim"
ENT.Base           = "base_anim"
ENT.PrintName      = "Buckshot"
ENT.Category       = "M9K Ammunition"

ENT.Spawnable      = true
ENT.AdminOnly      = false
ENT.DoNotDuplicate = true

if SERVER then
    AddCSLuaFile()

    function ENT:SpawnFunction( ply, tr )
        if (not tr.Hit) then return end

        local SpawnPos = tr.HitPos + tr.HitNormal * 16

        local ent = ents.Create( "m9k_ammo_buckshot" )

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
        local model = "models/Items/BoxBuckshot.mdl"

        self:SetModel( model )

        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )

        self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

        local phys = self:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:Wake()
        end

        self:SetUseType( SIMPLE_USE )
    end

    --[[---------------------------------------------------------
   Name: PhysicsCollide
-----------------------------------------------------------]]
    function ENT:PhysicsCollide( data, physobj )
        -- Play sound on bounce
        if (data.Speed > 80 and data.DeltaTime > 0.2) then
            self:EmitSound( "Default.ImpactSoft" )
        end
    end

    --[[---------------------------------------------------------
   Name: OnTakeDamage
-----------------------------------------------------------]]
    function ENT:OnTakeDamage( dmginfo )
        if dmginfo:GetAttacker():GetClass() == "m9k_ammo_explosion" then return end

        self:TakePhysicsDamage( dmginfo )
        if GetConVar( "M9KAmmoDetonation" ) == nil then return end
        if not (GetConVar( "M9KAmmoDetonation" ):GetBool()) then return end
        blaster = dmginfo:GetAttacker()
        pos = self:GetPos() + Vector( 0, 0, 10 )

        local dice = math.random( 1, 5 )

        if dmginfo:GetDamage() > 75 or dice == 1 then
            self:Remove()

            local effectdata = EffectData()
            effectdata:SetOrigin( self:GetPos() )
            util.Effect( "ThumperDust", effectdata )
            util.Effect( "Explosion", effectdata )

            timer.Simple( 0.01, function()
                for _ = 1, 300 do
                    local trace = util.TraceLine( {
                        start = pos,
                        endpos = pos + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( 0, 1 ) ) * 64000
                    } )

                    if trace.Hit and not trace.HitSky then
                        util.Decal( "Impact.Concrete", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal )
                        trace.Entity:TakeDamage( 30 * math.Rand( 0.85, 1.15 ), blaster, self )
                    end
                end
            end )
        end
    end

    --[[---------------------------------------------------------
   Name: Use
-----------------------------------------------------------]]
    function ENT:Use( activator, caller )
        if (activator:IsPlayer()) and not self.Planted then
            -- Give the collecting player some free health
            activator:GiveAmmo( 100, "buckshot" )
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

        local ledcolor = Color( 230, 45, 45, 255 )

        local TargetPos = self:GetPos() + (self:GetUp() * 3) + (self:GetRight() * 2) + (self:GetForward() * 3.54)

        local FixAngles = self:GetAngles()
        local FixRotation = Vector( 0, 90, 90 )

        FixAngles:RotateAroundAxis( FixAngles:Right(), FixRotation.x )
        FixAngles:RotateAroundAxis( FixAngles:Up(), FixRotation.y )
        FixAngles:RotateAroundAxis( FixAngles:Forward(), FixRotation.z )

        self.Text = "Buckshot"

        cam.Start3D2D( TargetPos, FixAngles, .07 )
        draw.SimpleText( self.Text, "DermaLarge", 31, -22, ledcolor, 1, 1 )
        cam.End3D2D()
    end
end
