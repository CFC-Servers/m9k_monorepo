include( "shared.lua" )

SWEP.PrevThinkBlowback = 0 --internal

local entMeta = FindMetaTable( "Entity" )
local entity_ManipulateBoneScale = entMeta.ManipulateBoneScale
local entity_ManipulateBoneAngles = entMeta.ManipulateBoneAngles
local entity_ManipulateBonePosition = entMeta.ManipulateBonePosition
local entity_GetTable = entMeta.GetTable
local entity_GetOwner = entMeta.GetOwner

function SWEP:IsFirstPerson()
    local owner = entity_GetOwner( self )
    return owner == LocalPlayer() and not owner:ShouldDrawLocalPlayer()
end
local thirdPersonShellType = {
    pistol = "EjectBrass_9mm",
    smg = "EjectBrass_556",
    ar2 = "EjectBrass_762Nato",
    shotgun = "EjectBrass_12Gauge",
    AirboatGun = "EjectBrass_338Mag"
}

net.Receive( "m9k_muzzleflash", function()
    local ent = net.ReadEntity()
    if not IsValid( ent ) then return end

    if ent.FireEffects and IsValid( entity_GetOwner(ent) ) then
        ent:FireEffects()
    end
end )

function SWEP:FireEffects()
    local isFirstPerson = self:IsFirstPerson()
    local isSilenced = self.SilencerAttached or self.HasBuiltInSilencer

    if not isFirstPerson then
        local shellAtt = self:GetAttachment( 2 )
        if shellAtt then
            local shellEffectType = thirdPersonShellType[self.Primary.Ammo] or "ShellEject"
            local shellEffect = EffectData()
            shellEffect:SetOrigin( shellAtt.Pos )
            shellEffect:SetAngles( shellAtt.Ang )
            shellEffect:SetEntity( self )
            shellEffect:SetFlags( 100 )
            util.Effect( shellEffectType, shellEffect )
        end
    end

    local muzzleAtt
    if isFirstPerson then
        muzzleAtt = entity_GetOwner( self ):GetViewModel():GetAttachment( 1 )
    else
        muzzleAtt = self:GetAttachment( 1 )
    end

    if muzzleAtt then
        local light = DynamicLight( self:EntIndex() )
        if light then
            local lightTime = 1000 / 0.4
            light.Pos = muzzleAtt.Pos
            light.r = 252
            light.g = 194
            light.b = 66
            light.Brightness = 2
            light.Decay = lightTime
            light.Size = isSilenced and 128 or 256
            light.DieTime = CurTime() + lightTime
            light.NoModel = not isFirstPerson
        end

        -- Should be enabled once all the muzzle attachment positions are properly aligned in the world models
        if not game.IsDedicated() and not isFirstPerson and not isSilenced then
            local flash = EffectData()
            flash:SetOrigin( muzzleAtt.Pos )
            flash:SetAngles( muzzleAtt.Ang )
            flash:SetScale( math.random( 0.8, 1.2 ) )
            flash:SetEntity( self )
            flash:SetAttachment( 1 )
            util.Effect( "CS_MuzzleFlash", flash )
        end
    end
end

function SWEP:HandleRecoil()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local selfTbl = entity_GetTable( self )
    local recoilPitch = selfTbl.ActiveRecoilPitch or 0
    local recoilYaw = selfTbl.ActiveRecoilYaw or 0

    if math.abs( recoilPitch ) < 0.001 and math.abs( recoilYaw ) < 0.001 then
        selfTbl.ActiveRecoilPitch = 0
        selfTbl.ActiveRecoilYaw = 0
        return
    end

    local decay = math.exp( -selfTbl.RecoilKickSpeed * FrameTime() )
    local newPitch = recoilPitch * decay
    local newYaw = recoilYaw * decay

    selfTbl.ActiveRecoilPitch = newPitch
    selfTbl.ActiveRecoilYaw = newYaw

    local eyeangles = owner:EyeAngles()
    eyeangles:Add( Angle( recoilPitch - newPitch, recoilYaw - newYaw, 0 ) )
    owner:SetEyeAngles( eyeangles )
end

function SWEP:DrawHUDBackground()
    self:HandleRecoil()
end

local host_timescale = GetConVar( "host_timescale" )

function SWEP:GetViewModelPosition( pos, ang )
    local selfTbl = entity_GetTable( self )

    local bIron = selfTbl.bIron
    if not selfTbl.IronSightsPos or bIron == nil then return pos, ang end

    local time = selfTbl.CurrentTime + ( SysTime() - selfTbl.CurrentSysTime ) * game.GetTimeScale() * host_timescale:GetFloat()
    local fIronTime = selfTbl.fIronTime
    local ironSightsTime = selfTbl.IronSightTime

    if ( not bIron ) and fIronTime < time - ironSightsTime then
        return pos, ang
    end

    local mul = 1.0

    if fIronTime > time - ironSightsTime then
        mul = math.Clamp( ( time - fIronTime ) / ironSightsTime, 0, 1 )

        if not bIron then
            mul = 1 - mul
        end
    end

    if selfTbl.IronSightsAng then
        local x, y, z = selfTbl.IronSightsAng:Unpack()
        ang:RotateAroundAxis( ang:Right(), x * mul )
        ang:RotateAroundAxis( ang:Up(), y * mul )
        ang:RotateAroundAxis( ang:Forward(), z * mul )
    end

    local x, y, z = selfTbl.IronSightsPos:Unpack()

    local rigth = ang:Right()
    rigth:Mul( mul )
    rigth:Mul( x )

    local forward = ang:Forward()
    forward:Mul( mul )
    forward:Mul( y )

    local up = ang:Up()
    up:Mul( mul )
    up:Mul( z )

    pos:Add( rigth )
    pos:Add( forward )
    pos:Add( up )

    if selfTbl.RecoilAmount > 0 and selfTbl.GetIronsightsActive( self ) then
        local recoilOffset = ang:Forward()
        recoilOffset:Mul( -selfTbl.RecoilAmount )
        pos:Add( recoilOffset )

        local easer = math.ease.OutCubic( selfTbl.RecoilRecoverySpeed * ( CurTime() - selfTbl.PrevThinkBlowback ) )

        if easer ~= selfTbl.RecoilAmount then
            selfTbl.RecoilAmount = math.Truncate( Lerp( easer, selfTbl.RecoilAmount, 0 ), 3 ) --truncated so the value actually returns to zero
        end
    end

    return pos, ang
end

local zeroVector = Vector( 0, 0, 0 )
local zeroAngle = Angle( 0, 0, 0 )
local oneVector = Vector( 1, 1, 1 )

function SWEP:SetupWepSelectIcon()
    if entity_GetOwner(self) ~= LocalPlayer() then return end

    local stored = weapons.GetStored( self:GetClass() )
    if not stored.WepSelectIconMaterial then
        local path = self.WeaponIconPath and self.WeaponIconPath or "vgui/hud/" .. self:GetClass()
        stored.WepSelectIconMaterial = Material( path )
    end

    self.WepSelectIconMaterial = stored.WepSelectIconMaterial
end

function SWEP:DrawWeaponSelection( x, y, wide, _tall, alpha )
    -- Set us up the texture
    surface.SetDrawColor( 255, 255, 255, alpha )
    if self.WepSelectIconMaterial then
        surface.SetMaterial( self.WepSelectIconMaterial )
    else
        self:SetupWepSelectIcon()
        surface.SetTexture( surface.GetTextureID( "weapons/swep" ) )
    end

    -- Borders
    y = y + 10
    x = x + 10
    wide = wide - 20

    -- Draw that mother
    surface.DrawTexturedRect( x, y,  wide, wide / 2 )
end

SWEP.vRenderOrder = nil
function SWEP:ViewModelDrawn()
    local owner = entity_GetOwner(self)
    if not IsValid( owner ) then return end
    local vm = owner:GetViewModel()
    if not IsValid( vm ) then return end

    local selfTbl = entity_GetTable( self )
    if not selfTbl.VElements then return end

    self:UpdateBonePositions( vm )

    if not selfTbl.vRenderOrder then
        -- -- we build a render order because sprites need to be drawn after models
        selfTbl.vRenderOrder = {}

        for k, v in pairs( selfTbl.VElements ) do
            if v.type == "Model" then
                table.insert( selfTbl.vRenderOrder, 1, k )
            elseif v.type == "Sprite" or v.type == "Quad" then
                table.insert( selfTbl.vRenderOrder, k )
            end
        end
    end

    for _, name in ipairs( selfTbl.vRenderOrder ) do
        local v = selfTbl.VElements[name]
        if not v then
            selfTbl.vRenderOrder = nil
            break
        end
        if v.hide then continue end

        local model = v.modelEnt
        local sprite = v.spriteMaterial

        if not v.bone then continue end

        local pos, ang = self:GetBoneOrientation( selfTbl.VElements, v, vm )

        if not pos then continue end

        if v.type == "Model" and IsValid( model ) then
            model:SetPos( pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )

            model:SetAngles( ang )
            -- --model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale( v.size )
            model:EnableMatrix( "RenderMultiply", matrix )

            if v.material == "" then
                model:SetMaterial( "" )
            elseif model:GetMaterial() ~= v.material then
                model:SetMaterial( v.material )
            end

            if v.skin and v.skin ~= model:GetSkin() then
                model:SetSkin( v.skin )
            end

            if v.bodygroup then
                for k, v in pairs( v.bodygroup ) do
                    if model:GetBodygroup( k ) ~= v then
                        model:SetBodygroup( k, v )
                    end
                end
            end

            if v.surpresslightning then
                render.SuppressEngineLighting( true )
            end

            render.SetColorModulation( v.color.r / 255, v.color.g / 255, v.color.b / 255 )
            render.SetBlend( v.color.a / 255 )
            model:DrawModel()
            render.SetBlend( 1 )
            render.SetColorModulation( 1, 1, 1 )

            if v.surpresslightning then
                render.SuppressEngineLighting( false )
            end
        elseif v.type == "Sprite" and sprite then
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial( sprite )
            render.DrawSprite( drawpos, v.size.x, v.size.y, v.color )
        elseif v.type == "Quad" and v.draw_func then
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )

            cam.Start3D2D( drawpos, ang, v.size )
            v.draw_func( self )
            cam.End3D2D()
        end
    end
end

SWEP.wRenderOrder = nil
function SWEP:DrawWorldModel()
    local selfTbl = entity_GetTable( self )
    if selfTbl.ShowWorldModel == nil or selfTbl.ShowWorldModel then
        self:DrawModel()
    end

    if not selfTbl.WElements then return end

    if not selfTbl.wRenderOrder then
        selfTbl.wRenderOrder = {}

        for k, v in pairs( selfTbl.WElements ) do
            if v.type == "Model" then
                table.insert( selfTbl.wRenderOrder, 1, k )
            elseif v.type == "Sprite" or v.type == "Quad" then
                table.insert( selfTbl.wRenderOrder, k )
            end
        end
    end

    local owner = entity_GetOwner(self)

    local bone_ent
    if IsValid( owner ) then
        bone_ent = owner
    else
        -- -- when the weapon is dropped
        bone_ent = self
    end

    for _, name in ipairs( selfTbl.wRenderOrder ) do
        local v = selfTbl.WElements[name]
        if not v then
            selfTbl.wRenderOrder = nil
            break
        end
        if v.hide then continue end

        local pos, ang

        if v.bone then
            pos, ang = self:GetBoneOrientation( selfTbl.WElements, v, bone_ent )
        else
            pos, ang = self:GetBoneOrientation( selfTbl.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
        end

        if not pos then continue end

        local model = v.modelEnt
        local sprite = v.spriteMaterial

        if v.type == "Model" and IsValid( model ) then
            model:SetPos( pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )

            model:SetAngles( ang )
            -- --model:SetModelScale(v.size)
            local matrix = Matrix()
            matrix:Scale( v.size )
            model:EnableMatrix( "RenderMultiply", matrix )

            if v.material == "" then
                model:SetMaterial( "" )
            elseif model:GetMaterial() ~= v.material then
                model:SetMaterial( v.material )
            end

            if v.skin and v.skin ~= model:GetSkin() then
                model:SetSkin( v.skin )
            end

            if v.bodygroup then
                for k, v in pairs( v.bodygroup ) do
                    if model:GetBodygroup( k ) ~= v then
                        model:SetBodygroup( k, v )
                    end
                end
            end

            if v.surpresslightning then
                render.SuppressEngineLighting( true )
            end

            render.SetColorModulation( v.color.r / 255, v.color.g / 255, v.color.b / 255 )
            render.SetBlend( v.color.a / 255 )
            model:DrawModel()
            render.SetBlend( 1 )
            render.SetColorModulation( 1, 1, 1 )

            if v.surpresslightning then
                render.SuppressEngineLighting( false )
            end
        elseif v.type == "Sprite" and sprite then
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            render.SetMaterial( sprite )
            render.DrawSprite( drawpos, v.size.x, v.size.y, v.color )
        elseif v.type == "Quad" and v.draw_func then
            local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )

            cam.Start3D2D( drawpos, ang, v.size )
            v.draw_func( self )
            cam.End3D2D()
        end
    end
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
    local bone, pos, ang
    if tab.rel and tab.rel ~= "" then
        local v = basetab[tab.rel]

        if not v then return end

        -- -- Technically, if there exists an element with the same name as a bone
        -- -- you can get in an infinite loop. Let's just hope nobody's that stupid.
        pos, ang = self:GetBoneOrientation( basetab, v, ent )
        if not pos then return end

        pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
        ang:RotateAroundAxis( ang:Up(), v.angle.y )
        ang:RotateAroundAxis( ang:Right(), v.angle.p )
        ang:RotateAroundAxis( ang:Forward(), v.angle.r )
    else
        bone = ent:LookupBone( bone_override or tab.bone )

        if not bone then return end

        pos, ang = Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
        local m = ent:GetBoneMatrix( bone )
        if m then
            pos, ang = m:GetTranslation(), m:GetAngles()
        end

        local owner = entity_GetOwner(self)

        if IsValid( owner ) and owner:IsPlayer() and ent == owner:GetViewModel() and self.ViewModelFlip then
            ang.r = -ang.r ---- Fixes mirrored models
        end
    end

    return pos, ang
end

function SWEP:CreateModels( tab )
    if not tab then return end

    -- -- Create the clientside models here because Garry says we can't do it in the render hook
    for _, v in pairs( tab ) do
        if (v.type == "Model" and v.model and v.model ~= "" and (! IsValid( v.modelEnt ) or v.createdModel ~= v.model) and
                string.find( v.model, ".mdl" ) and file.Exists( v.model, "GAME" )) then
            v.modelEnt = ClientsideModel( v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE )
            if (IsValid( v.modelEnt )) then
                v.modelEnt:SetPos( self:GetPos() )
                v.modelEnt:SetAngles( self:GetAngles() )
                v.modelEnt:SetParent( self )
                v.modelEnt:SetNoDraw( true )
                v.createdModel = v.model
            else
                v.modelEnt = nil
            end
        elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (! v.spriteMaterial or v.createdSprite ~= v.sprite)
                and file.Exists( "materials/" .. v.sprite .. ".vmt", "GAME" )) then
            local name = v.sprite .. "-"
            local params = { ["$basetexture"] = v.sprite }
            -- -- make sure we create a unique name based on the selected options
            local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
            for i, j in ipairs( tocheck ) do
                if (v[j]) then
                    params["$" .. j] = 1
                    name = name .. "1"
                else
                    name = name .. "0"
                end
            end
            v.createdSprite = v.sprite
            v.spriteMaterial = CreateMaterial( name, "UnlitGeneric", params )
        end
    end
end

function SWEP:ClearModels( tab )
    if not tab then return end

    for _, v in pairs( tab ) do
        if v.type == "Model" and IsValid( v.modelEnt ) then
            v.modelEnt:Remove()
            v.modelEnt = nil
        end
    end
end

function SWEP:UpdateBonePositions( vm )
    local viewModelBoneMods = self.ViewModelBoneMods
    if viewModelBoneMods then
        if not vm:GetBoneCount() then return end

        local loopthrough = viewModelBoneMods
        for k, v in pairs( loopthrough ) do
            local bone = vm:LookupBone( k )
            if not bone then continue end

            local s = Vector( v.scale.x, v.scale.y, v.scale.z )
            local p = Vector( v.pos.x, v.pos.y, v.pos.z )

            if vm:GetManipulateBoneScale( bone ) ~= s then
                vm:ManipulateBoneScale( bone, s )
            end
            if vm:GetManipulateBoneAngles( bone ) ~= v.angle then
                vm:ManipulateBoneAngles( bone, v.angle )
            end
            if vm:GetManipulateBonePosition( bone ) ~= p then
                vm:ManipulateBonePosition( bone, p )
            end
        end
    else
        self:ResetBonePositions( vm )
    end
end

function SWEP:ResetBonePositions( vm )
    local vmBones = vm:GetBoneCount()
    if not vmBones then return end
    for i = 0, vmBones do
        entity_ManipulateBoneScale( vm, i, oneVector )
        entity_ManipulateBoneAngles( vm, i, zeroAngle )
        entity_ManipulateBonePosition( vm, i, zeroVector )
    end
end

--[[*************************
        Global utility code
*************************--]]

-- -- Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
-- -- Does not copy entities of course, only copies their reference.
-- -- WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
function table.FullCopy( tab )
    if (not tab) then return nil end

    local res = {}
    for k, v in pairs( tab ) do
        if (type( v ) == "table") then
            res[k] = table.FullCopy( v ) ---- recursion ho!
        elseif (type( v ) == "Vector") then
            res[k] = Vector( v.x, v.y, v.z )
        elseif (type( v ) == "Angle") then
            res[k] = Angle( v.p, v.y, v.r )
        else
            res[k] = v
        end
    end

    return res
end
