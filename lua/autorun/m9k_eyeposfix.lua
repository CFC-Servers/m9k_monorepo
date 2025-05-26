local PLAYER = FindMetaTable( "Player" )

function PLAYER:M9K_GetShootPos()
    local realShootPos = self.M9K_RealShootpos
    if realShootPos then
        return realShootPos
    end

    return self:GetShootPos()
end


hook.Add( "SetupMove", "M9K_ShootPosPredFix", function( ply, _mv, _cmd )
    ply.M9K_RealShootpos = ply:GetShootPos()
end )
