local mat = Material( "effects/spark" )
function EFFECT:Init( data )
    self.StartPos = data:GetStart()
    self.EndPos = data:GetOrigin()
    self.Dir = self.EndPos - self.StartPos
    self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos )

    self.TracerTime = 0.25
    self.DieTime = CurTime() + self.TracerTime
end

function EFFECT:Think()
    if ( CurTime() > self.DieTime ) then return false end

    return true
end

function EFFECT:Render()
    local fDelta = ( self.DieTime - CurTime() ) / self.TracerTime
    fDelta = math.Clamp( fDelta, 0, 1 )

    render.SetMaterial( mat )

    local color = Color( 170, 170, 170 )
    render.DrawBeam( self.StartPos, self.EndPos, 5 * fDelta, 0.8, 0, color )
end
