function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	if data:GetScale() == 1 then
		for i=1, 50 do
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
			if (particle) then
				particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(100, 300) )
				if i == 1 or i == 2 or i == 3 or i == 5 then 
				particle:SetDieTime( 20 )
				else
				particle:SetDieTime( math.Rand( 10, 20 ) )
				end
				particle:SetStartAlpha( math.Rand( 40, 60 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 40, 50 ) )
				particle:SetEndSize( math.Rand( 200, 250 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 186 , 17 , 17 ) 
 				particle:SetAirResistance( 100 ) 
 				//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
				particle:SetCollide( true )
				particle:SetBounce( 1 )
			end
		end
	elseif data:GetScale() == 2 then
		for i=1, 150 do
			local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
			if (particle) then
				particle:SetVelocity( VectorRand():GetNormalized()*math.Rand(500, 1000) )
				if i <= 20 then 
				particle:SetDieTime( 30 )
				else
				particle:SetDieTime( math.Rand( 20, 30 ) )
				end
				particle:SetStartAlpha( math.Rand( 40, 60 ) )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand( 100,200 ) )
				particle:SetEndSize( math.Rand( 400,500 ) )
				particle:SetRoll( math.Rand(0, 360) )
				particle:SetRollDelta( math.Rand(-1, 1) )
				particle:SetColor( 186 , 17 , 17 ) 
 				particle:SetAirResistance( 100 ) 
 				//particle:SetGravity( Vector(math.Rand(-30, 30),math.Rand(-30, 30), -200 )) 	
				particle:SetCollide( true )
				particle:SetBounce( 1 )
			end
		end
	end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()

end