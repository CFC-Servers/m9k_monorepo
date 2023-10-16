ENT.Type = "anim"
ENT.PrintName			= "Nitro vapor"
ENT.Author			= "Generic Default did most of this, i just modified it"
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

	self.Entity:SetModel("models/maxofs2d/hover_classic.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )  
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS ) --the way it was
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Entity:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Entity:SetColor( Color(0,0,0,0) ) --fix this later
	self.Owner = self.Entity.Owner
	self.CanTool = false
	
	timer.Simple(.3, function() if IsValid(self) then self:Blammo() end end)
	
end

function ENT:Think()
	
	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end
	self.Entity:NextThink( CurTime() )
end


function ENT:Blammo()

	local pos = self.Entity:GetPos()
	local damage = 600
	local radius = 200
	local nitro_owner
	
	if IsValid(self) then 
		if IsValid(self.Owner) then 
			nitro_owner = self.Owner
		elseif IsValid(self.Entity) then
			nitro_owner = self.Entity
		end 
	end
	if not IsValid(nitro_owner) then return end
	
	util.BlastDamage(self, nitro_owner, pos, radius, damage)
	util.ScreenShake(pos, 500, 500, .25, 500)
	sound.Play("ambient/explosions/explode_7.wav", pos, 95)
	
	local scorchstart = self.Entity:GetPos() + ((Vector(0,0,1)) * 5)
	local scorchend = self.Entity:GetPos() + ((Vector(0,0,-1)) * 5)
	util.Decal("Scorch", scorchstart, scorchend)
	
	for k, v in pairs(ents.FindInSphere(pos,300)) do
		if IsValid(v) then
			if IsValid(v:GetPhysicsObject()) then
				local pushy = {}
				pushy.start = pos
				pushy.endpos = v:GetPos()
				pushy.filter = self.Entity
				local pushtrace = util.TraceLine(pushy)
				if not pushtrace.HitWorld then
					local thing = v:GetPhysicsObject()
					thing:AddVelocity(pushtrace.Normal * 400)
				end
			
			end
		end
	
	
	end
	 
	self.Entity:Remove()

end
	
end
