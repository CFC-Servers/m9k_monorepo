 ENT.Type 			= "anim"  
 ENT.PrintName			= "M74 Incindiary"  
 ENT.Author			= "Generic Default"  
 ENT.Contact			= "AIDS"  
 ENT.Purpose			= "SPLODE"  
 ENT.Instructions		= "LAUNCH"  
 
ENT.Spawnable			= false
ENT.AdminOnly = true 
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()   
	self.CanTool = false

self.flightvector = self.Entity:GetForward() * ((115*52.5)/66)
self.timeleft = CurTime() + 15
self.Owner = self:GetOwner()
self.Entity:SetModel( "models/Weapons/W_missile.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3           
--self.Entity:SetColor(Color(45,55,40,255))

Glow = ents.Create("env_sprite")
Glow:SetKeyValue("model","orangecore2.vmt")
Glow:SetKeyValue("rendercolor","255 150 100")
Glow:SetKeyValue("scale","0.3")
Glow:SetPos(self.Entity:GetPos())
Glow:SetParent(self.Entity)
Glow:Spawn()
Glow:Activate()
self.Entity:SetNWBool("smoke", true)
end   

 function ENT:Think()
	
	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end

		if self.timeleft < CurTime() then
		self.Entity:Remove()				
		end

	Table	={} 			//Table name is table name
	Table[1]	=self.Owner 		//The person holding the gat
	Table[2]	=self.Entity 		//The cap

	local trace = {}
		trace.start = self.Entity:GetPos()
		trace.endpos = self.Entity:GetPos() + self.flightvector
		trace.filter = Table
	local tr = util.TraceLine( trace )
	

		if tr.HitSky then
			self.Entity:Remove()
			return true
		end
	
		if tr.Hit then
			if not IsValid(self.Owner) then
				self.Entity:Remove()
				return
			end
				local effectdata = EffectData()
					effectdata:SetOrigin(tr.HitPos)			// Where is hits
					effectdata:SetNormal(tr.HitNormal)		// Direction of particles
					effectdata:SetEntity(self.Entity)		// Who done it?
					effectdata:SetScale(1.3)			// Size of explosion
					effectdata:SetRadius(tr.MatType)		// What texture it hits
					effectdata:SetMagnitude(18)			// Length of explosion trails
					util.Effect( "m9k_gdcw_tpaboom", effectdata )
					util.BlastDamage(self.Entity, self:OwnerGet(), tr.HitPos, 600, 170)
					util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
					self.Entity:SetNWBool("smoke", false)
					
			self:Explosion()
			self.Entity:Remove()	
		end
	
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector - (self.flightvector/500)  + Vector(math.Rand(-0.2,0.2), math.Rand(-0.2,0.2),math.Rand(-0.1,0.1)) + Vector(0,0,-0.111)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(0,0,0))
	self.Entity:NextThink( CurTime() )
	return true
	
end
 
 function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
	util.Effect("HelicopterMegaBomb", effectdata)

	local shake = ents.Create("env_shake")
		shake:SetOwner(self.Owner)
		shake:SetPos(self.Entity:GetPos())
		shake:SetKeyValue("amplitude", "2000")	// Power of the shake
		shake:SetKeyValue("radius", "900")		// Radius of the shake
		shake:SetKeyValue("duration", "2.5")	// Time of shake
		shake:SetKeyValue("frequency", "255")	// How har should the screenshake be
		shake:SetKeyValue("spawnflags", "4")	// Spawnflags(In Air)
		shake:Spawn()
		shake:Activate()
		shake:Fire("StartShake", "", 0)
		shake:Fire ( "Kill" , "", 3 )
	
	local ar2Explo = ents.Create("env_ar2explosion")
		ar2Explo:SetOwner(self.Owner)
		ar2Explo:SetPos(self.Entity:GetPos())
		ar2Explo:Spawn()
		ar2Explo:Activate()
		ar2Explo:Fire("Explode", "", 0)
		ar2Explo:Fire ( "Kill" , "", 1 )

end

function ENT:OwnerGet()
	if IsValid(self.Owner) then
		return self.Owner
	else
		return self.Entity
	end
end

end

if CLIENT then
 function ENT:Draw()             
 self.Entity:DrawModel()       // Draw the model.   
 end
 
   function ENT:Initialize()
	pos = self:GetPos()
	self.emitter = ParticleEmitter( pos )
 end
 
 function ENT:Think()
	if (self.Entity:GetNWBool("smoke")) then
	pos = self:GetPos()
		for i=1, (1) do
			local particle = self.emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos + (self:GetForward() * -120 * i))
			if (particle) then
				particle:SetVelocity((self:GetForward() * -2000)+(VectorRand()* 100) )
				particle:SetDieTime( math.Rand( 2, 5 ) )
				particle:SetStartAlpha( math.Rand( 7, 10 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 30, 40 ) )
				particle:SetEndSize( math.Rand( 130, 150 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 200 , 200 , 200 ) 
 				particle:SetAirResistance( 200 ) 
 				particle:SetGravity( Vector( 100, 0, 0 ) ) 	
			end
		
		end
	end
end


end