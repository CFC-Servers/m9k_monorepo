ENT.Type 		= "anim"
ENT.PrintName	= "Explosive C4"
ENT.Author		= "Worshipper"
ENT.Contact		= "Josephcadieux@hotmail.com"
ENT.Purpose		= ""
ENT.Instructions	= ""
ENT.Spawnable			= false
ENT.AdminOnly = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

/*---------------------------------------------------------
   Name: ENT:SetupDataTables()
   Desc: Setup the data tables.
---------------------------------------------------------*/
function ENT:SetupDataTables()

	self:DTVar("Int", 0, "Timer")
end

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
	self.CanTool = false

	self.C4CountDown = self:GetDTInt(0)
	self:CountDown()
//	self.Entity:EmitSound("C4.Plant")
end

/*---------------------------------------------------------
   Name: ENT:CountDown()
---------------------------------------------------------*/
function ENT:CountDown()

	if self.C4CountDown > 1 then
		//self.Entity:EmitSound("C4.PlantSound")

		self.C4CountDown = self.C4CountDown - 1

		timer.Create("countdown", 1, 0, function()
			self:CountDown()
		end)
	else
		self.C4CountDown = 0
		timer.Destroy("CountDown")
	end
end

/*---------------------------------------------------------
   Name: ENT:OnRemove()
---------------------------------------------------------*/
function ENT:OnRemove()

	timer.Destroy("countdown")
end

if SERVER then

AddCSLuaFile("shared.lua")

/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()

	self.Owner = self.Entity.Owner

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	self.Entity:SetModel("models/weapons/w_sb_planted.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)

	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	local phys = self.Entity:GetPhysicsObject()

	if phys:IsValid() then
		phys:Wake()
	end

	self.Used = false

	self:SetDTInt(0, self.Timer)
	self.ThinkTimer = CurTime() + self:GetDTInt(0)
end

/*---------------------------------------------------------
   Name: ENT:Use()
---------------------------------------------------------*/
function ENT:Use(activator, caller)

end

/*---------------------------------------------------------
   Name: ENT:Think()
---------------------------------------------------------*/
function ENT:Think()

	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end

	--self.Entity:SetColor(255, 255 * (1 - self.Defuse), 255 * (1 - self.Defuse), 255)

	if self.ThinkTimer < CurTime() then
		self:Explosion()
	end

end

/*---------------------------------------------------------
   Name: ENT:Explosion()
---------------------------------------------------------*/
function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("ThumperDust", effectdata)
	util.Effect("Explosion", effectdata)

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())			// Where is hits
		effectdata:SetNormal(self:VectorGet())		// Direction of particles
		effectdata:SetEntity(self.Entity)		// Who done it?
		effectdata:SetScale(2)			// Size of explosion
		effectdata:SetRadius(67)		// What texture it hits
		effectdata:SetMagnitude(18)			// Length of explosion trails
		util.Effect( "m9k_gdcw_cinematicboom", effectdata )

	util.ScreenShake(self.Entity:GetPos(), 2000, 255, 2.5, 1250		)
	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 500, 500	)

	self.Owner:EmitSound(Sound("C4.Explode"))

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

end

if CLIENT then

/*---------------------------------------------------------
   Name: ENT:Draw()
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel()

	local FixAngles = self.Entity:GetAngles()
	local FixRotation = Vector(0, 278.5, 0)

	FixAngles:RotateAroundAxis(FixAngles:Right(), FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)

 	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 7) + (self.Entity:GetRight() * -.5) + (self.Entity:GetForward() * 1.15)

	local m, s = self:FormatTime(self.C4CountDown)

	self.Text = string.format("%02d", m) .. ":" .. string.format("%02d", s)

	cam.Start3D2D(TargetPos, FixAngles, .07)
		draw.SimpleText(self.Text, "CloseCaption_Normal", 31, -22, Color(165, 0, 0, 255), 1, 1)
	cam.End3D2D()
end

/*---------------------------------------------------------
   Name: ENT:FormatTime()
---------------------------------------------------------*/
function ENT:FormatTime(seconds)

	local m = seconds % 604800 % 86400 % 3600 / 60
	local s = seconds % 604800 % 86400 % 3600 % 60

	return math.floor(m), math.floor(s)
end

end