 ENT.Type 			= "anim"      
 ENT.PrintName			= "M54 High Explosive Anti-Tank"  
 ENT.Author			= "Generic Default"  
 ENT.Contact			= "AIDS"  
 ENT.Purpose			= "SPLODE"  
 ENT.Instructions			= "LAUNCH"  
 
ENT.Spawnable			= false
ENT.AdminOnly = true 
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()  
	self.CanTool = false 

self.flightvector = self.Entity:GetUp() * ((75*52.5)/66)
self.timeleft = CurTime() + 15
self.Owner = self:GetOwner()
self.Entity:SetModel( "models/weapons/w_40mm_grenade_launched.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3     
self.InFlight = true
self.Entity:SetNWBool("smoke", true)
end   

 function ENT:Think()
	
	if not IsValid(self) then return end
	if not IsValid(self.Entity) then return end

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
	
				if tr.Hit and self.InFlight then
					if not IsValid(self.Owner) then
						self.Entity:Remove()
						return
					end
					if not (tr.MatType == 70 or tr.MatType == 50) then
						util.BlastDamage(self.Entity, self.Owner, tr.HitPos, 350, 150)
						local effectdata = EffectData()
						effectdata:SetOrigin(tr.HitPos)			// Where is hits
						effectdata:SetNormal(tr.HitNormal)		// Direction of particles
						effectdata:SetEntity(self.Entity)		// Who done it?
						effectdata:SetScale(1.3)			// Size of explosion
						effectdata:SetRadius(tr.MatType)		// What texture it hits
						effectdata:SetMagnitude(14)			// Length of explosion trails
						util.Effect( "m9k_gdcw_cinematicboom", effectdata )
						util.ScreenShake(tr.HitPos, 10, 5, 1, 3000 )
						util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
					self.Entity:Remove()
					else
						if (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then tr.Entity:TakeDamage(150, self.Owner, self.Entity)	end
						local effectdata = EffectData()
						effectdata:SetOrigin(tr.HitPos)			// Where is hits
						effectdata:SetNormal(tr.HitNormal)		// Direction of particles
						effectdata:SetEntity(self.Entity)		// Who done it?
						effectdata:SetScale(1)			// Size of explosion
						effectdata:SetRadius(tr.MatType)		// What texture it hits
						effectdata:SetMagnitude(10)			// Length of explosion trails
						tr.Entity:EmitSound(("physics/flesh/flesh_squishy_impact_hard" .. math.random(1, 4) .. ".wav"), 500, 100	)
						util.Effect("m9k_cinematic_blood_cloud", effectdata)
						self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
						self.Entity:SetPos(tr.HitPos)
						local phys = self.Entity:GetPhysicsObject()
						phys:Wake()
						phys:SetMass(3)
						self.InFlight = false
						self.Entity:SetNWBool("smoke", false)
						self.timeleft = CurTime() + 2
					end
	
				end
				
	if self.InFlight then
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector - (self.flightvector/350)  + Vector(math.Rand(-0.2,0.2), math.Rand(-0.2,0.2),math.Rand(-0.1,0.1)) + Vector(0,0,-0.111)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
	end
	
	if CurTime() > self.timeleft then
		self:Explosion()
	end
	
	self.Entity:NextThink( CurTime() )
	return true
end
 
function ENT:Explosion()

	if not IsValid(self.Owner) then
		self.Entity:Remove()
		return
	end

	util.BlastDamage(self.Entity, self.Owner, self.Entity:GetPos(), 350, 150)
	local effectdata = EffectData()
	effectdata:SetOrigin(self.Entity:GetPos())			// Where is hits
	effectdata:SetNormal(Vector(0,0,1))		// Direction of particles
	effectdata:SetEntity(self.Entity)		// Who done it?
	effectdata:SetScale(1.3)			// Size of explosion
	effectdata:SetRadius(67)		// What texture it hits
	effectdata:SetMagnitude(14)			// Length of explosion trails
	util.Effect( "m9k_gdcw_cinematicboom", effectdata )
	util.ScreenShake(self.Entity:GetPos(), 10, 5, 1, 3000 )
	self.Entity:Remove()

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
		for i=0, (4) do
			local particle = self.emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos + (self:GetUp() * -120 * i))
			if (particle) then
				particle:SetVelocity((self:GetUp() * -2000)+(VectorRand()* 100) )
				particle:SetDieTime( math.Rand( 2, 3 ) )
				particle:SetStartAlpha( math.Rand( 3, 5 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 30, 40 ) )
				particle:SetEndSize( math.Rand( 80, 90 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 150 , 150 , 150 ) 
 				particle:SetAirResistance( 200 ) 
 				particle:SetGravity( Vector( 100, 0, 0 ) ) 	
			end
		
		end
	end
end

end