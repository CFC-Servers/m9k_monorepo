ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Nerve Gas Vials"
ENT.Category		= "M9K Ammunition"

ENT.Spawnable		= true
ENT.AdminOnly = false
ENT.DoNotDuplicate = true

if SERVER then

AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("m9k_ammo_nervegas")
	
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

	local model = ("models/items/ammocrates/cratenervegas.mdl")
	
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
		self.Entity:EmitSound(Sound("Wood.ImpactHard"))
	end
end

/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage(dmginfo)

	// React physically when shot/getting blown
	self.Entity:TakePhysicsDamage(dmginfo)
	local dice = math.random(1,10)
	local pos = self.Entity:GetPos()
	local attacker
	if GetConVar("M9KAmmoDetonation") == nil then return end
	if not (GetConVar("M9KAmmoDetonation"):GetBool()) then return end
	if IsValid(dmginfo:GetAttacker()) then 
		attacker = dmginfo:GetAttacker()
	else
		attacker = self.Entity
	end
	
	if not IsValid(dmginfo:GetInflictor()) then return end
	if dmginfo:GetInflictor():GetClass() == "m9k_poison_parent" or dmginfo:GetInflictor():GetClass() == "m9k_released_poison" then return end
	
	if dice == 1 then
	
		if GetConVar("M9KExplosiveNerveGas") == nil or GetConVar("M9KExplosiveNerveGas"):GetBool() then
	
			local poison = ents.Create("m9k_released_poison")
			poison:SetPos(pos )
			poison:SetOwner(attacker)
			poison.Owner = attacker
			poison.Big = true
			poison.PosToKeep = pos
			poison:Spawn()
		
		else
	
			local painParent = ents.Create("m9k_poison_parent")
			painParent:SetPos(pos)
			painParent:SetOwner(attacker)
			painParent.Owner = attacker
			painParent:Spawn()
			painParent.Big = true
	
			local hurt1 = ents.Create("POINT_HURT")
			hurt1:SetPos(pos)
			hurt1:SetKeyValue("DamageRadius", 550)
			hurt1:SetKeyValue("DamageType", 262144)
			hurt1:SetKeyValue("Damage", 14)
			hurt1:Fire("TurnOn", "", 0)
			hurt1:Fire ( "Kill" , "", 25 )
			hurt1:SetParent(painParent)
			hurt1:Spawn()
	
			local hurt2 = ents.Create("POINT_HURT")
			hurt2:SetPos(pos)
			hurt2:SetKeyValue("DamageRadius", 600)
			hurt2:SetKeyValue("DamageType", 262144)
			hurt2:SetKeyValue("Damage", 1)
			hurt2:Fire("TurnOn", "", 0)
			hurt2:Fire ( "Kill" , "", 27 )
			hurt2:SetParent(painParent)
			hurt2:Spawn()
		end	
	
		self.Entity:Remove()
		local gas = EffectData()
		gas:SetOrigin(pos)
		gas:SetEntity(attacker) //i dunno, just use it!
		gas:SetScale(2)//otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
		util.Effect("m9k_released_nerve_gas", gas)
		
	end
end


/*---------------------------------------------------------
   Name: Use
---------------------------------------------------------*/
function ENT:Use(activator, caller)
	
	if (activator:IsPlayer()) and not self.Planted then
		if activator:GetWeapon("m9k_nerve_gas") == NULL then
			activator:Give("m9k_nerve_gas")
			activator:GiveAmmo(47, "NerveGas")
		else		
			activator:GiveAmmo(48, "NerveGas")
		end
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