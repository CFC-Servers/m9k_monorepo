 ENT.Type 			= "anim"     
 ENT.PrintName			= ""  
 ENT.Author			= ""  
 ENT.Contact			= ""  
 ENT.Purpose			= ""  
 ENT.Instructions			= "LAUNCH"  
 
ENT.Spawnable			= false
ENT.AdminOnly = true 
ENT.DoNotDuplicate = true 
ENT.DisableDuplicator = true

if SERVER then

AddCSLuaFile( "shared.lua" )

function ENT:Initialize()  
	self.CanTool = false 

self.flightvector = self.Entity:GetUp() * ((115*52.5)/66)
self.timeleft = CurTime() + 5
self.Owner = self.Entity.Owner
self.Entity:SetModel( "models/failure/mk6/m62.mdl" )
self.Entity:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,  	
self.Entity:SetMoveType( MOVETYPE_NONE )   --after all, gmod is a physics  	
self.Entity:SetSolid( SOLID_VPHYSICS )        -- CHEESECAKE!    >:3           
self.Entity:SetColor(Color(82,102,39,254))

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
			if not IsValid(self.Owner) then
				self.Entity:Remove()
				return
			end
		
		local nuke = ents.Create("m9k_davy_crockett_explo")
		nuke:SetPos( self.Entity:GetPos() )
		nuke:SetOwner(self.Owner)
		nuke:Spawn()
		nuke:Activate()
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
				if not IsValid(self.Owner) then
					self.Entity:Remove()
					return
				end			
					local nuke = ents.Create("m9k_davy_crockett_explo")
					nuke:SetPos( self.Entity:GetPos() )
					nuke:SetOwner(self.Entity.Owner)
					nuke.Owner = self.Entity.Owner
					nuke:Spawn()
					nuke:Activate()
					self.Entity:Remove()
					self.Entity:SetNWBool("smoke", false)
			end
	
					if tr.Hit then
						if not IsValid(self.Owner) then
							self.Entity:Remove()
							return
						end	
						local nuke = ents.Create("m9k_davy_crockett_explo")
						nuke:SetPos( self.Entity:GetPos() )
						nuke:SetOwner(self.Entity.Owner)
						nuke.Owner = self.Entity.Owner
						nuke:Spawn()
						nuke:Activate()
						self.Entity:Remove()
						self.Entity:SetNWBool("smoke", false)
					end
	
	self.Entity:SetPos(self.Entity:GetPos() + self.flightvector)
	self.flightvector = self.flightvector - self.flightvector/((147*39.37)/66) + self.Entity:GetUp()*2 + Vector(math.Rand(-0.3,0.3), math.Rand(-0.3,0.3),math.Rand(-0.1,0.1)) + Vector(0,0,-0.111)
	self.Entity:SetAngles(self.flightvector:Angle() + Angle(90,0,0))
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
			local particle = self.emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos + (self:GetUp() * -100 * i))
			if (particle) then
				particle:SetVelocity((self:GetUp() * -2000) )
				particle:SetDieTime( math.Rand( 2, 5 ) )
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