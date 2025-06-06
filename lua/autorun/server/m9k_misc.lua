M9K = M9K or {}

resource.AddWorkshop( "3114933414" ) -- Monorepo Content

local expectedTickSpeed = 1 / 67
local tickSpeed = engine.TickInterval()
M9K.TickspeedMult = tickSpeed / expectedTickSpeed

-- Temporary, see what's somehow causing this
local entMeta = FindMetaTable( "Entity" )
entMeta._SetOwner = entMeta._SetOwner or entMeta.SetOwner
local setOwner = entMeta._SetOwner

function entMeta:SetOwner( ply )
    if self:IsWeapon() and ply and not IsValid( ply ) then
        ErrorNoHaltWithStack( "M9K: SetOwner called with invalid player entity. " .. tostring( self ) .. "\n" )
    end

    setOwner( self, ply )
end
