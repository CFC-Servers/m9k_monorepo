AddCSLuaFile()

ENT.Type = "anim"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.CanTool = false
ENT.InFlight = true
ENT.GiveClassType = "m9k_harpoon"
ENT.GiveAmmoType = "Harpoon"
ENT.WorldModel = "models/props_junk/harpoon002a.mdl"
ENT.ExtraPenDepth = 25

local hitSounds = { "physics/metal/metal_grenade_impact_hard1.wav", "physics/metal/metal_grenade_impact_hard2.wav", "physics/metal/metal_grenade_impact_hard3.wav" };
local fleshHitSounds = { "physics/flesh/flesh_impact_bullet1.wav", "physics/flesh/flesh_impact_bullet2.wav", "physics/flesh/flesh_impact_bullet3.wav" }

if SERVER then
    function ENT:DamageFunction( target, damager, physData )
        local damage = physData.Speed / 4
        target:TakeDamage( damage, damager, self )
    end

    function ENT:Initialize()
        self:SetModel( self.WorldModel )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        local phys = self:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
            phys:SetMass( 10 )
        end

        self:GetPhysicsObject():SetMass( 2 )

        self:SetUseType( SIMPLE_USE )
    end

    function ENT:Think()
        self.lifetime = self.lifetime or CurTime() + 20

        if CurTime() > self.lifetime then
            self:Remove()
        end

        if self.InFlight and self:GetAngles().pitch <= 55 then
            self:GetPhysicsObject():AddAngleVelocity( Vector( 0, 10, 0 ) )
        end
    end

    function ENT:Disable()
        self.PhysicsCollide = function() end
        self.lifetime = CurTime() + 30
        self.InFlight = false

        timer.Simple( 0, function()
            if not IsValid( self ) then return end
            self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
        end )
    end

    function ENT:PhysicsCollide( data )
        local damager
        if IsValid( self:GetOwner() ) then
            damager = self:GetOwner()
        else
            return
        end

        local ent = data.HitEntity
        if not (ent:IsValid() or ent:IsWorld()) then return end

        if data.TheirSurfaceProps == 76 then
            self:Remove()
            return
        end

        if ent:IsWorld() and self.InFlight then
            if data.Speed > 500 then
                self:EmitSound( "weapons/blades/impact.mp3" )
                timer.Simple( 0, function()
                    if not IsValid( self ) then return end
                    self:GetPhysicsObject():SetPos( self:GetPos() + self:GetForward() * self.ExtraPenDepth )
                end )
                self:SetAngles( self:GetAngles() )
                self:GetPhysicsObject():EnableMotion( false )
            else
                self:EmitSound( hitSounds[math.random( 1, #hitSounds )] )
            end

            self:Disable()
        elseif ent.Health then
            if not ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll" then
                util.Decal( "ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal )
                self:EmitSound( hitSounds[math.random( 1, #hitSounds )] )
                self:Disable()
            end

            if ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll" then
                local effectdata = EffectData()
                effectdata:SetStart( data.HitPos )
                effectdata:SetOrigin( data.HitPos )
                effectdata:SetScale( 1 )
                util.Effect( "BloodImpact", effectdata )

                self:EmitSound( fleshHitSounds[math.random( 1, #fleshHitSounds )] )
                self:Disable()
                self:GetPhysicsObject():SetVelocity( data.OurOldVelocity / 4 )

                self:DamageFunction( ent, damager, data )
            end
        end

        timer.Simple( 0, function()
            if not IsValid( self ) then return end
            self:SetOwner( NULL )
        end )
    end

    function ENT:Use( activator )
        if activator:IsPlayer() then
            if activator:GetWeapon( self.GiveClassType ) == NULL then
                activator:Give( self.GiveClassType )
                self:Remove()
            elseif self.GiveAmmoType then
                activator:GiveAmmo( 1, self.GiveAmmoType )
                self:Remove()
            end
        end
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
