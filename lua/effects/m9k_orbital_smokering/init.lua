function EFFECT:Init(data)
	self.Entity = data:GetEntity()
	pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(pos)
	if data:GetScale() == 1 then
		self:RingBlast()
	else
		local particle = self.Emitter:Add( "pincher.vmt", pos)
		if (particle) then
			particle:SetDieTime( 2 )
			particle:SetStartAlpha( 255)
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( 1 )
			particle:SetEndSize( 2000 )
			particle:SetRoll(0)
			particle:SetRollDelta( 0)
 			particle:SetAirResistance( 0 ) 
			particle:SetCollide( false )
			particle:SetBounce( 0 )
		end
		timer.Simple(2, function()
			Emitter = ParticleEmitter(pos)
			local particle = Emitter:Add( "effects/strider_bulge_dudv.vmt", pos)
			if (particle) then
				particle:SetDieTime( .25 )
				particle:SetStartAlpha( 255)
				particle:SetEndAlpha( 255 )
				particle:SetStartSize( 5000 )
				particle:SetEndSize( 1 )
				particle:SetRoll(0)
				particle:SetRollDelta( 0)
				particle:SetAirResistance( 0 ) 
				particle:SetCollide( false )
				particle:SetBounce( 0 )
			end
		end)
			
	end
end

function EFFECT:Think()
return false
end

function EFFECT:Render()

end

function EFFECT:RingBlast()
	for i=1, 300 do
		local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), pos)
		if (particle) then
			particle:SetVelocity(Vector(math.random(-10,10),math.random(-10,10),0):GetNormal() * 10000)
			particle:SetDieTime( 2.5 )
			particle:SetStartAlpha( math.Rand( 40, 60 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand(100,150) )
			particle:SetEndSize( math.Rand( 300,350) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor(  90,83,68 ) 
 			particle:SetAirResistance( 50 ) 
			particle:SetCollide( false )
			particle:SetBounce( 0 )
		end
	end
end