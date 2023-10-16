ENT.Type = "anim"
ENT.PrintName			= "Prox mine"
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

	self.Entity:SetModel("models/weapons/w_px_planted.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
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
 	for k, v in pairs ( ents.FindInSphere( self.Entity:GetPos(), 200 ) ) do		
		if v:IsPlayer() || v:IsNPC() then					// If its alive then
		local trace = {}						// Make sure there's not a wall in between
		trace.start = self.Entity:GetPos()
		trace.endpos = v:GetPos()			// Trace to the torso
		trace.filter = self.Entity
		local tr = util.TraceLine( trace )				// If the trace hits a living thing then
		if tr.Entity:IsPlayer() || tr.Entity:IsNPC() then self:Explosion() end 
		end
	end	
	end

	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:Explosion()

	if not IsValid(self) then return end 
	if not IsValid(self.Owner) then 
		self.Entity:Remove()
	return
	end 
	
	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("ThumperDust", effectdata)
	util.Effect("Explosion", effectdata)

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())			// Where is hits
		effectdata:SetNormal(self:VectorGet())		// Direction of particles
		effectdata:SetEntity(self.Entity)		// Who done it?
		effectdata:SetScale(1)			// Size of explosion
		effectdata:SetRadius(67)		// What texture it hits
		effectdata:SetMagnitude(18)			// Length of explosion trails
		util.Effect( "m9k_gdcw_cinematicboom", effectdata )	
	if not IsValid(self) then return end if not IsValid(self.Owner) then return end if not IsValid(self.Entity) then return end 
	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 200, 250	)
	util.ScreenShake(self.Entity:GetPos(), 2000, 255, 2.5, 1250		)

	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", self.Pos, 100, 100 )

	self.Entity:Remove()


end

function ENT:VectorGet()
	local startpos = self.Entity:GetPos()
	
	local downtrace = {}
	downtrace.start = startpos
	downtrace.endpos = startpos + self.Entity:GetUp()*-5
	downtrace.filter = self.Entity
	tracedown = util.TraceLine(downtrace) 
	
	if (tracedown.Hit) then
		return (tracedown.HitNormal)
	else
		return(Vector(0,0,1))
	end
	
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
local GoodLuck = math.random(1,5)
	if GoodLuck == 1 then
		self:Explosion()
	end
end

end
