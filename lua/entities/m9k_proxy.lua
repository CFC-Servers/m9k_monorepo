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

AddCSLuaFile()

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

local maxDistVec = Vector( 100, 100, 100 )
function ENT:Think()
    if self.TimeLeft < CurTime() then
        for _, ent in ipairs( ents.FindInBox( self:GetPos() - maxDistVec, self:GetPos() + maxDistVec ) ) do
            if ent:IsPlayer() or ent:IsNPC() then
                local canTrigger = hook.Run( "M9k_ProxyMineCanTrigger", self, ent, self.ProxyBombOwner )
                if canTrigger == false then continue end

                local trace = {
                    start = self:WorldSpaceCenter(),
                    endpos = ent:WorldSpaceCenter(),
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

    util.BlastDamage( self, self.ProxyBombOwner, self:GetPos(), 200, 250 )
    util.ScreenShake( self:GetPos(), 2000, 255, 2.5, 1250 )

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
