ENT.Type = "anim"
ENT.PrintName			= "sticky grenade test"
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

	self.Owner = self.Owner

	self:SetModel("models/weapons/w_sticky_grenade_thrown.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )

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

	if (self.HitWeld) then
		self.HitWeld = false
		constraint.Weld(self.HitEnt, self, 0, 0, 0, true)
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:PhysicsCollide(data, phys)

	local boxes
	parentme = {}
	parentme[1] = "m9k_ammo_40mm"
	parentme[2] = "m9k_ammo_c4"
	parentme[3] = "m9k_ammo_frags"
	parentme[4] = "m9k_ammo_ieds"
	parentme[5] = "m9k_ammo_nervegas"
	parentme[6] = "m9k_ammo_nuke"
	parentme[7] = "m9k_ammo_proxmines"
	parentme[8] = "m9k_ammo_rockets"
	parentme[9] = "m9k_ammo_stickynades"
	parentme[10] = "m9k_ammo_357"
	parentme[11] = "m9k_ammo_ar2"
	parentme[12] = "m9k_ammo_buckshot"
	parentme[13] = "m9k_ammo_pistol"
	parentme[14] = "m9k_ammo_smg"
	parentme[15] = "m9k_ammo_sniper_rounds"
	parentme[16] = "m9k_ammo_winchester"

	if data.HitEntity ~= nil and data.HitEntity:IsValid() then
		for k, v in pairs (parentme) do
			if data.HitEntity:GetClass() == v then
				boxes = data.HitEntity
				boxes.Planted = true
			end
		end
	end

	if not self.Hit then self.Hit = false end
	if self.Hit then return end

	self.Hit = true

	phys:EnableMotion(false)
	phys:Sleep()

	if data.HitEntity:IsValid() then
		if data.HitEntity:IsNPC() or data.HitEntity:IsPlayer() then
			self:SetParent(data.HitEntity)
		else
			self.HitEnt = data.HitEntity
			self.HitWeld = true
		end

		phys:EnableMotion(true)
		phys:Wake()
	end

end


function ENT:Explosion()

	if not IsValid(self) then return end
	if not IsValid(self) then return end

	if not IsValid(self.Owner) then
		self:Remove()
		return
	end

	local trace = {}
	trace.start = self:GetPos() + Vector(0, 0, 32)
	trace.endpos = self:GetPos() - Vector(0, 0, 128)
	trace.Entity = self
	trace.mask  = 16395
	local Normal = util.TraceLine(trace).HitNormal

	self.Scale = 1.5
	self.EffectScale = self.Scale ^ 0.65

	local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
	util.Effect("ThumperDust", effectdata)
	util.Effect("Explosion", effectdata)

	util.BlastDamage(self, self.Owner, self:GetPos(), 220, 220 )
	util.ScreenShake(self:GetPos(), 1000, 255, 2.5, 1200)

	self:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", self.Pos, 100, 100 )

	self:Remove()

end

end

if CLIENT then

function ENT:Draw()
	self:DrawModel()
end

end