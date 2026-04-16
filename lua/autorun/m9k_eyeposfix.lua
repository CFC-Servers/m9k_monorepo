local PLAYER = FindMetaTable( "Player" )
local PLAYER_GetShootPos = PLAYER.GetShootPos

function PLAYER:M9K_GetShootPos()
    local realShootPos = self.M9K_RealShootpos
    if realShootPos then
        return realShootPos
    end

    return PLAYER_GetShootPos( self )
end


hook.Add( "SetupMove", "M9K_ShootPosPredFix", function( ply, _mv, _cmd )
    ply.M9K_RealShootpos = PLAYER_GetShootPos( ply )
end )
