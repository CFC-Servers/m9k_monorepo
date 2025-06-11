ENT.Type              = "anim"
ENT.PrintName         = "sticky grenade test"
ENT.Author            = ""
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = ""
ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

if SERVER then
    AddCSLuaFile()

    function ENT:Initialize()
        self:SetModel( "models/weapons/w_sticky_grenade_thrown.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        self.timeleft = CurTime() + 3
        self:Think()
        self.CanTool = false
    end

    function ENT:Think()
        local parent = self:GetParent()
        if IsValid( parent ) and parent:IsPlayer() and not parent:Alive() then
            self:Explosion()
            return
        end

        if self.timeleft < CurTime() then
            self:Explosion()
            return
        end

        self:NextThink( CurTime() )
        return true
    end

    local parentme = {
        "m9k_ammo_40mm",
        "m9k_ammo_c4",
        "m9k_ammo_frags",
        "m9k_ammo_ieds",
        "m9k_ammo_nervegas",
        "m9k_ammo_nuke",
        "m9k_ammo_proxmines",
        "m9k_ammo_rockets",
        "m9k_ammo_stickynades",
        "m9k_ammo_357",
        "m9k_ammo_ar2",
        "m9k_ammo_buckshot",
        "m9k_ammo_pistol",
        "m9k_ammo_smg",
        "m9k_ammo_sniper_rounds",
        "m9k_ammo_winchester"
    }

    function ENT:PhysicsCollide( data, phys )
        if data.HitEntity ~= nil and data.HitEntity:IsValid() then
            for _, v in ipairs( parentme ) do
                if data.HitEntity:GetClass() == v then
                    local box = data.HitEntity
                    box.Planted = true
                end
            end
        end

        if not self.Hit then self.Hit = false end
        if self.Hit then return end

        self.Hit = true

        phys:EnableMotion( false )
        phys:Sleep()

        if data.HitEntity:IsValid() then
            timer.Simple( 0, function()
                if not IsValid( self ) then return end
                self:SetParent( data.HitEntity )
                self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
            end )

            phys:EnableMotion( true )
            phys:Wake()
        end
    end

    function ENT:Explosion()
        if self.Exploded then return end
        self.Exploded = true

        local owner = self._m9kOwner
        if not IsValid( owner ) then
            self:Remove()
            return
        end

        self.Scale       = 1.5
        self.EffectScale = self.Scale ^ 0.65

        local effectdata = EffectData()
        effectdata:SetOrigin( self:GetPos() )
        util.Effect( "ThumperDust", effectdata )
        util.Effect( "Explosion", effectdata )

        local blastPos = self:WorldSpaceCenter()
        local parent = self:GetParent()
        if IsValid( parent ) and parent:IsPlayer() then
            blastPos = parent:WorldSpaceCenter()
        end
        util.BlastDamage( self, owner, blastPos, 220, 220 )
        util.ScreenShake( self:GetPos(), 1000, 255, 2.5, 1200 )

        self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 4 ) .. ".wav", self.Pos, 100, 100 )
        self:Remove()
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
