ENT.Type = "anim"
ENT.PrintName = "Prox mine"
ENT.Author = "Bob"
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.CanTool = false

if CLIENT then return end

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()
    self:SetModel( "models/weapons/w_px_planted.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:DrawShadow( false )
    self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self.TimeLeft = CurTime() + 3
    self.BombHealth = 100
end

function ENT:Think()
    if self.TimeLeft < CurTime() then
        for _, v in pairs ( ents.FindInSphere( self:WorldSpaceCenter(), 150 ) ) do
            if v:IsPlayer() or v:IsNPC() then
                local trace = {
                    start = self:WorldSpaceCenter(),
                    endpos = v:WorldSpaceCenter(),
                    filter = self
                }
                local tr = util.TraceLine( trace )
                if tr.Entity:IsPlayer() or tr.Entity:IsNPC() then
                    self:Explosion()
                end
            end
        end
    end

    self:NextThink( CurTime() + 0.1 )
    return true
end

function ENT:Explosion()
    if not IsValid( self.ProxyBombOwner ) then
        self:Remove()
        return
    end

    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect( "HelicopterMegaBomb", effectdata )
    util.Effect( "ThumperDust", effectdata )
    util.Effect( "Explosion", effectdata )

    local effectBoom = EffectData()
    effectBoom:SetOrigin( self:GetPos() )
    effectBoom:SetNormal( self:VectorGet() )
    effectBoom:SetEntity( self )
    effectBoom:SetScale( 1 )
    effectBoom:SetRadius( 67 )
    effectBoom:SetMagnitude( 18 )
    util.Effect( "m9k_gdcw_cinematicboom", effectBoom )

    util.BlastDamage( self, self.ProxyBombOwner, self:GetPos(), 200, 250	)
    util.ScreenShake( self:GetPos(), 2000, 255, 2.5, 1250		)

    self:EmitSound( "ambient/explosions/explode_" .. math.random( 1, 4 ) .. ".wav", self.Pos, 100, 100 )
    self:Remove()
end

function ENT:VectorGet()
    local startpos = self:GetPos()

    local downtrace = {}
    downtrace.start = startpos
    downtrace.endpos = startpos + self:GetUp() * -5
    downtrace.filter = self
    tracedown = util.TraceLine( downtrace )

    if tracedown.Hit then
        return tracedown.HitNormal
    else
        return Vector( 0, 0, 1 )
    end

end

function ENT:OnTakeDamage( dmginfo )
    if self.Exploded then return end

    local dmg = dmginfo:GetDamage()
    self.BombHealth = self.BombHealth - dmg
    if self.BombHealth <= 0 then
        self.Exploded = true
        self:Explosion()
    end
end
