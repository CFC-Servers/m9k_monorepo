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

	self.Owner = self.Entity.Owner

	self.Entity:SetModel("models/weapons/w_sticky_grenade_thrown.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end

	self.timeleft = CurTime() + 3
	self:Think()
	self.CanTool = false
end

 function ENT:Think()
	
	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end
	
	if self.timeleft < CurTime() then
		self:Explosion()	
	end
	
	if (self.Entity.HitWeld) then  
		self.HitWeld = false  
		constraint.Weld(self.Entity.HitEnt, self.Entity, 0, 0, 0, true)  
	end 
	
	self.Entity:NextThink( CurTime() )
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
	
	if data.HitEntity != nil and data.HitEntity:IsValid() then
		for k, v in pairs (parentme) do
			if data.HitEntity:GetClass() == v then
				boxes = data.HitEntity
				boxes.Planted = true
			end
		end
	end

	if not self.Entity.Hit then self.Entity.Hit = false end
	if self.Entity.Hit then return end

	self.Entity.Hit = true

	phys:EnableMotion(false)
	phys:Sleep()
	
	if data.HitEntity:IsValid() then
		if data.HitEntity:IsNPC() or data.HitEntity:IsPlayer() then
			self.Entity:SetParent(data.HitEntity)
		else
			self.Entity.HitEnt = data.HitEntity
			self.Entity.HitWeld = true
		end

		phys:EnableMotion(true)
		phys:Wake()
	end
	
end


function ENT:Explosion()

	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end
	
	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local trace = {}
	trace.start = self.Entity:GetPos() + Vector(0, 0, 32)
	trace.endpos = self.Entity:GetPos() - Vector(0, 0, 128)
	trace.Entity = self.Entity
	trace.mask  = 16395
	local Normal = util.TraceLine(trace).HitNormal

	self.Scale = 1.5
	self.EffectScale = self.Scale ^ 0.65

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("ThumperDust", effectdata)
	util.Effect("Explosion", effectdata)
	
	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 220, 220 )
	util.ScreenShake(self.Entity:GetPos(), 1000, 255, 2.5, 1200)

	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", self.Pos, 100, 100 )

	self.Entity:Remove()

end

end

if CLIENT then

function ENT:Draw()
	self.Entity:DrawModel()
end

end