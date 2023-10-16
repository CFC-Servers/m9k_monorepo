 ENT.Type 			= "anim"  
 ENT.PrintName			= "High Explosive Anti-Tank RPG"  
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

self.flightvector = self.Entity:GetForward() * ((115*52.5)/66)
self.timeleft = CurTime() + 10
self.Owner = self:GetOwner()
self.Entity:SetModel( "models/Weapons/W_missile_closed.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3        
self.Entity:SetMaterial("models/debug/debugwhite.vmt")   
self.Entity:SetColor(Color(55,67,44,255))

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
					util.BlastDamage(self.Entity, self.Owner, tr.HitPos, 600, 150)
					local effectdata = EffectData()
					effectdata:SetOrigin(tr.HitPos)			// Where is hits
					effectdata:SetNormal(tr.HitNormal)		// Direction of particles
					effectdata:SetEntity(self.Entity)		// Who done it?
					effectdata:SetScale(1.8)			// Size of explosion
					effectdata:SetRadius(tr.MatType)		// What texture it hits
					effectdata:SetMagnitude(18)			// Length of explosion trails
					util.Effect( "m9k_gdcw_cinematicboom", effectdata )
					util.ScreenShake(tr.HitPos, 10, 5, 1, 3000 )
					util.Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
					self.Entity:SetNWBool("smoke", false)
					self.Entity:Remove()	
				end
	
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector - self.flightvector/((147*39.37)/66) + self.Entity:GetForward()*2 + Vector(math.Rand(-0.3,0.3), math.Rand(-0.3,0.3),math.Rand(-0.1,0.1)) + Vector(0,0,-0.111)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(0,0,0))
	self.Entity:NextThink( CurTime() )
	return true
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
		for i=0, (10) do
			local particle = self.emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos + (self:GetForward() * -100 * i))
			if (particle) then
				particle:SetVelocity((self:GetForward() * -2000) )
				particle:SetDieTime( math.Rand( 1.5, 3 ) )
				particle:SetStartAlpha( math.Rand( 5, 8 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 40, 50 ) )
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