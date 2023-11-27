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
            self:EmitSound( Sound( "GlassBottle.Break" ) )
        end

        self:BreakVial()
    end

    function ENT:BreakVial()
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        local pos = self:GetPos()

        if GetConVar( "M9KExplosiveNerveGas" ) == nil or GetConVar( "M9KExplosiveNerveGas" ):GetBool() then
            local poison = ents.Create( "m9k_released_poison" )
            poison:SetPos( pos )
            poison:SetOwner( self.Owner )
            poison.Owner = self.Owner
            poison.Big = false
            poison.PosToKeep = pos
            poison:Spawn()
        else
            local painParent = ents.Create( "m9k_poison_parent" )
            painParent:SetPos( pos )
            painParent:SetOwner( self.Owner )
            painParent.Owner = self.Owner
            painParent:Spawn()
            painParent.Big = false

            local hurt1 = ents.Create( "POINT_HURT" )
            hurt1:SetPos( pos )
            hurt1:SetKeyValue( "DamageRadius", 100 )
            hurt1:SetKeyValue( "DamageType", 262144 )
            hurt1:SetKeyValue( "Damage", 14 )
            hurt1:Fire( "TurnOn", "", 0 )
            hurt1:Fire( "Kill", "", 17 )
            hurt1:SetParent( painParent )
            hurt1:Spawn()

            local hurt2 = ents.Create( "POINT_HURT" )
            hurt2:SetPos( pos )
            hurt2:SetKeyValue( "DamageRadius", 150 )
            hurt2:SetKeyValue( "DamageType", 262144 )
            hurt2:SetKeyValue( "Damage", 1 )
            hurt2:Fire( "TurnOn", "", 0 )
            hurt2:Fire( "Kill", "", 19 )
            hurt2:SetParent( painParent )
            hurt2:Spawn()
        end

        local gas = EffectData()
        gas:SetOrigin( pos )
        gas:SetEntity( self.Owner ) --i dunno, just use it!
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
        self:EmitSound( Sound( "GlassBottle.Break" ) )
    end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel() -- Draw the model.
    end
end
