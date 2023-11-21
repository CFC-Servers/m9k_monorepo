ENT.Type = "anim"
ENT.PrintName			= "explosive Grenade"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions			= ""
ENT.Spawnable			= false
ENT.AdminOnly = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()
	self:SetModel("models/weapons/w_m61_fraggynade_thrown.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end

	self.timeleft = CurTime() + 3
	self:Think()
	self.CanTool = false
end

 function ENT:Think()

	if not IsValid(self) then return end
	if not IsValid(self) then return end

	if self.timeleft < CurTime() then
		self:Explosion()
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	if not IsValid(self.Owner) then
		self:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetEntity(self)
		effectdata:SetStart(self:GetPos())
		effectdata:SetNormal(Vector(0,0,1))
		--util.Effect("ManhackSparks", effectdata)
		util.Effect("cball_explode", effectdata)
		util.Effect("Explosion", effectdata)

	local thumper = effectdata
		thumper:SetOrigin(self:GetPos())
		thumper:SetScale(500)
		thumper:SetMagnitude(500)
		util.Effect("ThumperDust", effectdata)

	local sparkeffect = effectdata
		sparkeffect:SetMagnitude(3)
		sparkeffect:SetRadius(8)
		sparkeffect:SetScale(5)
		util.Effect("Sparks", sparkeffect)

	local scorchstart = self:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self:GetPos() + ((Vector(0,0,-1)) * 5)

	util.BlastDamage(self, self.Owner, self:GetPos(), 350, 100)
	util.ScreenShake(self:GetPos(), 500, 500, 1.25, 500)
	self:Remove()
	util.Decal("Scorch", scorchstart, scorchend)
end

/*---------------------------------------------------------
PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data,phys)
	if data.Speed > 50 then
		self:EmitSound(Sound("HEGrenade.Bounce"))
	end

	local impulse = -data.Speed * data.HitNormal * .4 + (data.OurOldVelocity * -.6)
	phys:ApplyForceCenter(impulse)

end

end

if CLIENT then
function ENT:Draw()
	self:DrawModel()
end
end