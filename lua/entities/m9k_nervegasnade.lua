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
    AddCSLuaFile()

    function ENT:Initialize()
        self.CanTool = false

        self:SetModel( "models/healthvial.mdl" )
        self:SetMaterial( "models/weapons/gv/nerve_vial.vmt" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        self:DrawShadow( false )

        self.backflightvector = self:GetForward() * (-5)

        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then
            phys:SetMass( 4 )
            phys:Wake()
        end
        self:Think()
    end

    function ENT:Think()
        if not IsValid( self ) then return end

        self:NextThink( CurTime() )
        return true
    end

    --[[---------------------------------------------------------
PhysicsCollide
-----------------------------------------------------------]]
    function ENT:PhysicsCollide( data, phys )
        --self.timeleft = CurTime() + 20

        if data.Speed > 50 then
            self:EmitSound( "GlassBottle.Break" )
        end

        self:BreakVial()
    end

    function ENT:BreakVial()
        if self.Broken then return end
        self.Broken = true

        local owner = self._m9kOwner

        if not IsValid( owner ) then
            self:Remove()
            return
        end

        local pos = self:GetPos()

        if GetConVar( "M9KExplosiveNerveGas" ) == nil or GetConVar( "M9KExplosiveNerveGas" ):GetBool() then
            local poison = ents.Create( "m9k_released_poison" )
            poison:SetPos( pos )
            poison:SetOwner( owner )
            poison.Owner = owner
            poison.Big = false
            poison.PosToKeep = pos
            poison:Spawn()
        else
            local painParent = ents.Create( "m9k_poison_parent" )
            painParent:SetPos( pos )
            painParent:SetOwner( owner )
            painParent.Lifetime = CurTime() + 20
            painParent.Big = false
            painParent:Spawn()
        end

        local gas = EffectData()
        gas:SetOrigin( pos )
        gas:SetEntity( owner ) --i dunno, just use it!
        gas:SetScale( 1 ) --otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
        util.Effect( "m9k_released_nerve_gas", gas )

        self:Remove()
    end

    --[[---------------------------------------------------------
OnTakeDamage
-----------------------------------------------------------]]
    function ENT:OnTakeDamage( dmginfo )
        if not IsValid( dmginfo ) then return end
        if not IsValid( dmginfo:GetInflictor() ) then return end
        if dmginfo:GetInflictor() == "m9k_released_poison" then return end
        self:BreakVial()
        self:EmitSound( "GlassBottle.Break" )
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel() -- Draw the model.
    end
end
