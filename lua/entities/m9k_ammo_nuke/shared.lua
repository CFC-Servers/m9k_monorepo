if (GetConVar("DavyCrockettAllowed")) == nil then 
	print("M9K Specialties Convar is missing! You may have hit the lua limit, or incorrectly modified the autorun file!")
elseif not (GetConVar("DavyCrockettAllowed"):GetBool()) then return end
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Nuclear Warhead"
ENT.Category		= "M9K Ammunition"

ENT.Spawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = true

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("m9k_ammo_nuke")
	
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()
	ent.Planted = false
	
	return ent
end


/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
	self.CanTool = false

	local model = ("models/failure/mk6/mk6.mdl")
	
	self.Entity:SetModel(model)
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NONE)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(40)
	end

	self.Entity:SetUseType(SIMPLE_USE)
end


/*---------------------------------------------------------
   Name: PhysicsCollide
---------------------------------------------------------*/
function ENT:PhysicsCollide(data, physobj)

	if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound(Sound("EpicMetal.ImpactHard"))
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(dmginfo)

	// React physically when shot/getting blown
	self.Entity:TakePhysicsDamage(dmginfo)
	if GetConVar("M9KAmmoDetonation") == nil then return end
	local dice = math.random(1,30)
	local att
	if not (GetConVar("M9KAmmoDetonation"):GetBool()) then return end
	if IsValid(dmginfo:GetAttacker()) then 
		att = dmginfo:GetAttacker()
	else
		att = self.Entity
	end
	
	if dice == 1 then//you stupid son of a bitch, what did you just do!
		local nuke = ents.Create("m9k_davy_crockett_explo")
		nuke:SetPos( self.Entity:GetPos() )
		nuke:SetOwner(att)
		nuke:Spawn()
		nuke:Activate()
		self.Entity:Remove()	
	end
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use(activator, caller)
	
	if (activator:IsPlayer()) and not self.Planted then
		activator:GiveAmmo(1, "Nuclear_Warhead")
		self.Entity:Remove()
	end
end

end

if CLIENT then

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/
function ENT:Draw()
	
	self.Entity:DrawModel()
	
end

end