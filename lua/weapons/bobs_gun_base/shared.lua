-- --Variables that are used on both client and server
SWEP.Category               = ""
SWEP.Gun                    = ""
SWEP.Author                 = "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.DrawCrosshair          = true -- Hell no, crosshairs r 4 nubz!
SWEP.ViewModelFOV           = 65 -- How big the gun will look
SWEP.ViewModelFlip          = true -- True for CSS models, False for HL2 models

SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false

SWEP.Primary.Sound          = "" -- Sound of the gun
SWEP.Primary.Round = "" -- What kind of bullet?
SWEP.Primary.Cone           = 0.2 -- Accuracy of NPCs
SWEP.Primary.Damage         = 10
SWEP.Primary.SpreadHip         = .01 --define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.NumShots       = 1
SWEP.Primary.RPM            = 0 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 0
SWEP.Primary.DefaultClip    = 0 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.KickUpMultiplier       = 2

SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum side recoil (koolaid)
SWEP.Primary.Automatic      = true -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "none" -- What kind of ammo

-- SWEP.Secondary.ClipSize                 = 0
-- SWEP.Secondary.DefaultClip                      = 0                                     -- Default number of bullets in a clip
-- SWEP.Secondary.Automatic                        = false                                 -- Automatic/Semi Auto
SWEP.Secondary.Ammo         = ""
----HAHA! GOTCHA, YA BASTARD!

-- SWEP.Secondary.IronFOV                  = 0                                     -- How much you 'zoom' in. Less is more!

SWEP.IronsightsBlowback = true -- Disabled the default activity and use the blowback system instead?
SWEP.RecoilBack = 3 -- How much the gun kicks back in iron sights
SWEP.RecoilRecoverySpeed = 2 -- How fast does the gun return to the center
SWEP.RecoilKickSpeed = 40 -- How fast accumulated recoil is applied to the view (higher = snappier kick)
SWEP.RecoilAmount = 0 -- Internal, do not touch
SWEP.IronSightTime = 0.15

SWEP.Penetration            = true
SWEP.Ricochet               = true
SWEP.BoltAction             = false
SWEP.Scoped                 = false
SWEP.ShellTime              = .35
SWEP.CanBeSilenced          = false
SWEP.SilencerAttached               = false
SWEP.NextSilence            = 0
SWEP.SelectiveFire          = false
SWEP.NextFireSelect         = 0
SWEP.OrigCrossHair          = true
SWEP.CanShootWhileRunning   = false

local CLIENT                = CLIENT
local SERVER                = SERVER
local MASK_SHOT             = MASK_SHOT
local IN_USE                = IN_USE
local IN_SPEED              = IN_SPEED
local IN_FORWARD            = IN_FORWARD
local IN_BACK               = IN_BACK
local IN_MOVELEFT           = IN_MOVELEFT
local IN_MOVERIGHT          = IN_MOVERIGHT

local defaultClipMult = GetConVar( "M9KDefaultClip" )
local dmgMultCvar = GetConVar( "M9KDamageMultiplier" )
local damageMultiplier = dmgMultCvar:GetFloat()
local IS_SINGLEPLAYER = game.SinglePlayer()

local function dmgMultCallback( _, _, new )
    damageMultiplier = tonumber( new )
end
cvars.AddChangeCallback( "M9KDamageMultiplier", dmgMultCallback, "gunbase" )

local m9k_enginespread = CreateConVar( "m9k_enginespread", "0", { FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_NOTIFY }, "Use engine spread for M9K weapons, not recommended" )

SWEP.IronSightsPos = Vector( 0, 0, 0 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

SWEP.VElements = {}
SWEP.WElements = {}

SWEP.ActiveRecoilPitch = 0
SWEP.ActiveRecoilYaw = 0

local entMeta = FindMetaTable( "Entity" )
local entity_GetTable = entMeta.GetTable
local entity_GetOwner = entMeta.GetOwner

local playerMeta = FindMetaTable( "Player" )
local player_KeyDown = playerMeta.KeyDown

function SWEP:Initialize()
    self.Reloadaftershoot = 0 -- Can't reload when firing
    self:SetHoldType( self.HoldType )
    self:SetReloading( false )
    self.OrigCrossHair = self.DrawCrosshair

    local owner = entity_GetOwner( self )

    if SERVER and owner:IsNPC() then
        self:SetNPCMinBurst( 3 )
        self:SetNPCMaxBurst( 10 ) -- None of this really matters but you need it here anyway
        self:SetNPCFireRate( 1 / ( self.Primary.RPM / 60 ) )
        -- --self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
    end

    local clipMult = defaultClipMult:GetInt()
    if clipMult ~= -1 then
        self.Primary.DefaultClip = self.Primary.ClipSize * clipMult
    end

    if CLIENT then
        -- -- Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

        self:CreateModels( self.VElements ) -- create viewmodels
        self:CreateModels( self.WElements ) -- create worldmodels

        -- -- init view model bone build function
        if IsValid( owner ) and owner:IsPlayer() then
            if owner:Alive() then
                local vm = owner:GetViewModel()
                if IsValid( vm ) then
                    self:ResetBonePositions( vm )
                    -- -- Init viewmodel visibility
                    if (self.ShowViewModel == nil or self.ShowViewModel) then
                        vm:SetColor( Color( 255, 255, 255, 255 ) )
                    else
                        -- -- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
                        vm:SetMaterial( "Debug/hsv" )
                    end
                end
            end
        end
    end

    if CLIENT then
        self:SetupWepSelectIcon()
    end
end

-- We have to do this to prevent weapon_base setting it back to pistol https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/sh_anim.lua#L64
function SWEP:OnReloaded()
    self:SetWeaponHoldType( self:GetHoldType() )
end

function SWEP:SetupDataTables()
    self:NetworkVar( "Bool", "IronsightsActive" )
    self:NetworkVar( "Bool", "Reloading" )
    self:NetworkVar( "Float", "IronsightsTime" )
    self:NetworkVar( "Bool", "Boltback" )
    self:NetworkVar( "Bool", "Running" )
    self.GetIronsights = self.GetIronsightsActive
end

function SWEP:SetIronsights( b )
    self:SetIronsightsActive( b )
    self:SetIronsightsTime( CurTime() )
end

function SWEP:Equip()
    self:SetHoldType( self.HoldType )
end

function SWEP:Deploy()
    self:SetIronsights( false )
    self.DrawCrosshair = self.OrigCrossHair
    self:SetHoldType( self.HoldType )

    if self.SilencerAttached then
        self:SendWeaponAnim( ACT_VM_DRAW_SILENCED )
    else
        self:SendWeaponAnim( ACT_VM_DRAW )
    end

    if self.DeployDelay then
        self:SetNextPrimaryFire( CurTime() + self.DeployDelay )
    end

    local owner = entity_GetOwner( self )
    if not owner:IsNPC() and owner ~= nil and self.ResetSights and owner:GetViewModel() ~= nil then
        self.ResetSights = CurTime() + owner:GetViewModel():SequenceDuration()
    end
    return true
end

function SWEP:Holster()
    local owner = entity_GetOwner( self )
    self:SetReloading( false )
    self:SetIronsights( false )
    self:SetIronsightsTime( 0 )
    self.IronSightsPos = Vector( 0, 0, 0 )
    self.IronSightsAng = Vector( 0, 0, 0 )

    if CLIENT and IsValid( owner ) and not owner:IsNPC() then
        local vm = owner:GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end

    return true
end

function SWEP:OnRemove()
    local owner = entity_GetOwner( self )

    if CLIENT and IsValid( owner ) and not owner:IsNPC() then
        local vm = owner:GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
            self:ClearModels( self.VElements )
            self:ClearModels( self.WElements )
        end
    end
end

function SWEP:IsRunning()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return false end
    if not owner:IsPlayer() then return false end

    local crouching = owner:Crouching()
    if crouching then return false end

    local sprintDown = player_KeyDown( owner, IN_SPEED )
    if not sprintDown then return false end

    local forwardDown = player_KeyDown( owner, IN_FORWARD )
    local backDown = player_KeyDown( owner, IN_BACK )
    if forwardDown ~= backDown then return true end

    local leftDown = player_KeyDown( owner, IN_MOVELEFT )
    local rightDown = player_KeyDown( owner, IN_MOVERIGHT )
    if leftDown ~= rightDown then return true end

    return false
end

function SWEP:StartedRunning()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local selfTbl = entity_GetTable( self )
    return selfTbl.IsRunning( self ) and not selfTbl.GetRunning( self )
end

function SWEP:StoppedRunning()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local selfTbl = entity_GetTable( self )
    return not selfTbl.IsRunning( self ) and selfTbl.GetRunning( self )
end

function SWEP:FireAnimationEvent( _pos, _ang, event, _options )
    local isCssMuzzleFlash = ( event == 5001 or event == 5011 or event == 5021 or event == 5031 )
    if isCssMuzzleFlash and ( self.SilencerAttached or self.HasBuiltInSilencer ) then return true end
    if isCssMuzzleFlash and not self:IsFirstPerson() then return true end

    if isCssMuzzleFlash and self.CSMuzzleFlashes then
        local data = EffectData()
        data:SetFlags( 0 )
        data:SetEntity( entity_GetOwner(self):GetViewModel() )
        data:SetAttachment( math.floor( ( event - 4991 ) / 10 ) )
        data:SetScale( 1 )
        util.Effect( "CS_MuzzleFlash", data )

        return true
    end
end

local shellEffects = {
    pistol = "ShellEject",
    smg = "RifleShellEject",
    ar2 = "RifleShellEject",
    shotgun = "ShotgunShellEject"
}

function SWEP:FireAnimation()
    local owner = entity_GetOwner(self)

    -- Muzzle flash light
    if SERVER then
        local rf = RecipientFilter()
        rf:AddPVS( self:GetPos() )
        rf:RemovePlayer( owner )

        net.Start( "m9k_muzzleflash" )
        net.WriteEntity( self )
        net.Send( rf )
    end
    if CLIENT and IsFirstTimePredicted() then
        self:FireEffects()
    end

    -- Sounds
    local silenced = self.SilencerAttached
    if silenced then
        self:EmitSound( self.Primary.SilencedSound )
    else
        self:EmitSound( self.Primary.Sound )
    end

    -- If we're not iron-sighting, just fire normally and return
    if self.Scoped or ( not self:GetIronsightsActive() or not self.IronsightsBlowback ) then
        if silenced then
            self:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
        else
            self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        end

        return
    end

    -- Ironsights logic
    self.RecoilAmount = self.RecoilBack
    if CLIENT then
        self.PrevThinkBlowback = CurTime()
    end
    if silenced then
        self:SendWeaponAnim( ACT_VM_IDLE_SILENCED )
    else
        self:SendWeaponAnim( ACT_VM_IDLE )
    end

    -- Effects only clientside, for the owner and if we're in first person aiming down sights, we do this because we aren't using the "real" fire animation
    if not CLIENT then return end
    if not IsFirstTimePredicted() then return end
    if owner ~= LocalPlayer() then return end
    if EyePos() ~= owner:EyePos() then return end

    local vm = owner:GetViewModel()
    if not self.NoMuzzleFlash then
        local muzzleAtt = vm:GetAttachment( 1 )
        if muzzleAtt then
            local flash = EffectData()
            flash:SetOrigin( muzzleAtt.Pos )
            flash:SetAngles( muzzleAtt.Ang )
            flash:SetScale( 1 )
            flash:SetEntity( vm )
            flash:SetMagnitude( 1 )
            flash:SetAttachment( 1 )
            util.Effect( "CS_MuzzleFlash", flash )
        end
    end

    local shell = shellEffects[self.Primary.Ammo]
    if shell then
        local att = vm:GetAttachment( 2 )
        if att then
            local shellEffect = EffectData()
            shellEffect:SetOrigin( att.Pos )
            shellEffect:SetAngles( att.Ang )
            shellEffect:SetEntity( vm )
            util.Effect( shell, shellEffect )
        end
    end
end

function SWEP:CanPrimaryAttack()
    if self:Clip1() <= 0 then
        self:EmitSound( "Weapon_Pistol.Empty" )
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        self:Reload()
        return false
    end

    if self:GetReloading() then return false end

    return true
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    local owner = entity_GetOwner( self )

    if not self.CanShootWhileRunning and self:IsRunning() then
        self:SetNextPrimaryFire( CurTime() + 0.2 )
        return false
    end

    self:ShootBulletInformation()
    self:TakePrimaryAmmo( 1 )

    self:FireAnimation()

    owner:SetAnimation( PLAYER_ATTACK1 )
    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
    self:CheckWeaponsAndAmmo()

    if self.BoltAction then
        self:BoltBack()
    end
end

local weaponStrip = GetConVar( "M9KWeaponStrip" )
function SWEP:CheckWeaponsAndAmmo()
    if self:Clip1() ~= 0 then return end

    local owner = entity_GetOwner( self )
    local hasAmmo = owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0
    if hasAmmo then
        self:Reload()
        return
    end

    if SERVER and weaponStrip:GetBool() then
        timer.Simple( 0.1, function()
            if not IsValid( self ) or not IsValid( owner ) then return end
            if owner == nil then return end
            owner:StripWeapon( self.Gun )
        end )
    end
end

--[[---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This func add the damage, the recoil, the number of shots and the cone on the bullet.
-------------------------------------------------------]]
function SWEP:ShootBulletInformation()
    local currentCone
    if self:GetIronsightsActive() == true and player_KeyDown( entity_GetOwner( self ), IN_ATTACK2 ) then
        currentCone = self.Primary.SpreadIronSights
    else
        currentCone = self.Primary.SpreadHip
    end

    local damagedice = math.Rand( 0.95, 1.05 )

    local basedamage = damageMultiplier * self.Primary.Damage
    local currentDamage = basedamage * damagedice

    self:ShootBullet( currentDamage, self.Primary.NumShots, currentCone )
end

--[[---------------------------------------------------------
   Name: SWEP:BulletCallback()
   Desc: A convenience func to handle bullet callbacks.
-------------------------------------------------------]]
local iterationCount = {
    ["SniperPenetratedRound"] = 10,
    ["pistol"] = 2,
    ["357"] = 5,
    ["smg1"] = 4,
    ["ar2"] = 5,
    ["buckshot"] = 1,
    ["slam"] = 1,
    ["AirboatGun"] = 8
}

local penetrationDepthTbl = {
    ["SniperPenetratedRound"] = 20,
    ["pistol"] = 9,
    ["357"] = 12,
    ["smg1"] = 14,
    ["ar2"] = 16,
    ["buckshot"] = 5,
    ["slam"] = 5,
    ["AirboatGun"] = 17
}

local penetrationDamageMult = {
    [MAT_CONCRETE] = 0.3,
    [MAT_METAL] = 0.3,
    [MAT_WOOD] = 0.8,
    [MAT_PLASTIC] = 0.8,
    [MAT_GLASS] = 0.8,
    [MAT_FLESH] = 0.9,
    [MAT_ALIENFLESH] = 0.9
}

local easyPenMaterials = {
    [MAT_GLASS] = true,
    [MAT_PLASTIC] = true,
    [MAT_WOOD] = true,
    [MAT_FLESH] = true,
    [MAT_ALIENFLESH] = true
}

local spreadVec = Vector( 0, 0, 0 )

local disablepen = GetConVar( "M9KDisablePenetration" ):GetBool()
cvars.AddChangeCallback( "M9KDisablePenetration", function( _, _, new )
    disablepen = tobool( new )
end )

local disablericochet = GetConVar( "M9KDisableRicochet" ):GetBool()
cvars.AddChangeCallback( "M9KDisableRicochet", function( _, _, new )
    disablericochet = tobool( new )
end )

function SWEP:BulletCallback( iteration, attacker, bulletTrace, dmginfo, direction )
    if CLIENT then return end
    if bulletTrace.HitSky then return end

    iteration = iteration and iteration + 1 or 0
    local maxIterations = iterationCount[self.Primary.Ammo] or 14
    if iteration > maxIterations then return end

    direction = direction or bulletTrace.Normal

    if not disablepen then
        local penetrated = self:BulletPenetrate( iteration, attacker, bulletTrace, dmginfo, direction )
        if penetrated then return end
    end

    if not disablericochet then
        local ricochet = self:BulletRicochet( iteration, attacker, bulletTrace, dmginfo, direction )
        if ricochet then return end
    end
end

function SWEP:BulletPenetrate( iteration, attacker, bulletTrace, dmginfo, direction )
    local penDepth = penetrationDepthTbl[self.Primary.Ammo] or 5
    local penDirection = direction * penDepth
    if easyPenMaterials[bulletTrace.MatType] then
        penDirection = direction * penDepth * 2
    end

    if not util.IsInWorld( bulletTrace.HitPos + penDirection ) then return false end

    local hitEnt = bulletTrace.Entity
    local penTrace = util.TraceLine( {
        endpos = bulletTrace.HitPos,
        start = bulletTrace.HitPos + penDirection,
        mask = MASK_SHOT,
        filter = function( ent )
            return ent == hitEnt
        end
    } )

    if penTrace.AllSolid and penTrace.HitWorld then return false end
    if not penTrace.Hit then return false end
    if penTrace.Fraction >= 0.99 or penTrace.Fraction <= 0.01 then return false end

    local damageMult = penetrationDamageMult[penTrace.MatType] or 0.5
    local bullet = {
        Inflictor = self,
        Num = 1,
        Src = penTrace.HitPos,
        Dir = direction,
        Spread = spreadVec,
        Tracer = 1,
        TracerName = "m9k_effect_mad_penetration_trace",
        Force = 5,
        IgnoreEntity = hitEnt:IsPlayer() and hitEnt or nil,
        Damage = dmginfo:GetDamage() * damageMult,
        Callback = function( a, b, c )
            if not IsValid( self ) then return end
            self:BulletCallback( iteration, a, b, c, direction )
        end
    }

    timer.Simple( 0, function()
        if not IsValid( attacker ) then return end
        attacker:FireBullets( bullet )
    end )

    return true
end

local bulletMissSounds = {
    "weapons/fx/nearmiss/bulletLtoR03.wav",
    "weapons/fx/nearmiss/bulletLtoR04.wav",
    "weapons/fx/nearmiss/bulletLtoR06.wav",
    "weapons/fx/nearmiss/bulletLtoR07.wav",
    "weapons/fx/nearmiss/bulletLtoR09.wav",
    "weapons/fx/nearmiss/bulletLtoR10.wav",
    "weapons/fx/nearmiss/bulletLtoR13.wav",
    "weapons/fx/nearmiss/bulletLtoR14.wav"
}

local ricochetAmmoTable = {
    ["pistol"] = true,
    ["buckshot"] = true,
    ["slam"] = true,
    ["SniperPenetratedRound"] = true
}

function SWEP:BulletRicochet( iteration, attacker, bulletTrace, dmginfo, direction )
    local shouldRicochet = ricochetAmmoTable[self.Primary.Ammo] or false
    if not shouldRicochet and math.random( 1, 4 ) ~= 1 then return false end

    if bulletTrace.MatType ~= MAT_METAL then
        local missSound = bulletMissSounds[math.random( #bulletMissSounds )]
        sound.Play( missSound, bulletTrace.HitPos, 75, math.random( 75, 150 ), 1 )

        if self.Tracer == 0 or self.Tracer == 1 or self.Tracer == 2 then
            local effectdata = EffectData()
            effectdata:SetOrigin( bulletTrace.HitPos )
            effectdata:SetNormal( bulletTrace.HitNormal )
            effectdata:SetScale( 20 )
            util.Effect( "AR2Impact", effectdata )
        elseif self.Tracer == 3 then
            local effectdata = EffectData()
            effectdata:SetOrigin( bulletTrace.HitPos )
            effectdata:SetNormal( bulletTrace.HitNormal )
            effectdata:SetScale( 20 )
            util.Effect( "StunstickImpact", effectdata )
        end

        return false
    end

    local dotProduct = bulletTrace.HitNormal:Dot( direction * -1 )
    local bullet = {
        Inflictor = self,
        Num = 1,
        Src = bulletTrace.HitPos + bulletTrace.HitNormal,
        Dir = ( ( 2 * bulletTrace.HitNormal * dotProduct ) + direction ) + ( VectorRand() * 0.05 ),
        Spread = spreadVec,
        Tracer = SERVER and 1 or 0,
        TracerName = "m9k_effect_mad_ricochet_trace",
        Force = dmginfo:GetDamage() * 0.15,
        Damage = dmginfo:GetDamage() * 0.5,
        Callback = function( a, b, c )
            if not IsValid( self ) then return end
            self:BulletCallback( iteration, a, b, c )
        end
    }

    --debugoverlay.Line( bulletTrace.HitPos, bulletTrace.HitPos + bullet.Dir * 100, 10, SERVER and Color( 255, 0, 0 ) or Color( 0, 255, 0 ), true )

    timer.Simple( 0, function()
        attacker:FireBullets( bullet )
    end )

    return true
end

--[[---------------------------------------------------------
   Name: SWEP:ShootBullet()
   Desc: A convenience func to shoot bullets.
-------------------------------------------------------]]
local shotBiasMin = GetConVar( "ai_shot_bias_min" ):GetFloat()
local shotBiasMax = GetConVar( "ai_shot_bias_max" ):GetFloat()

local function getSpread( gun, dir, aimcone )
    local owner = entity_GetOwner( gun )

    local dirAng = dir:Angle()
    local right = dirAng:Right()
    local up = dirAng:Up()

    local x, y, z
    local bias = 1

    local shotBias = ( ( shotBiasMax - shotBiasMin ) * bias ) + shotBiasMin
    local flatness = math.abs( bias ) * 0.5

    local cmd = owner:GetCurrentCommand()
    local seed = "m9k_spread_" .. util.CRC(  gun:GetCreationID() .. gun:EntIndex() .. CurTime() .. owner:GetUserGroup() .. cmd:CommandNumber() .. cmd:TickCount() )
    local seedNum = 0

    local function getRnd()
        seedNum = seedNum + 1
        return util.SharedRandom( seed, -1, 1, seedNum )
    end

    for _ = 1, 1000 do -- Not infinite, just in case
        x = getRnd() * flatness + getRnd() * ( 1 - flatness )
        y = getRnd() * flatness + getRnd() * ( 1 - flatness )

        if shotBias < 0 then
            x = x >= 0 and 1 - x or -1 - x
            y = y >= 0 and 1 - y or -1 - y
        end

        z = x * x + y * y

        if z <= 1 then
            break
        end
    end

    up:Mul( y * aimcone )
    right:Mul( x * aimcone )
    right:Add( up )
    right:Add( dir )
    right:Normalize()

    return right
end

function SWEP:ShootBullet( damage, bulletCount, aimcone )
    bulletCount = bulletCount or 1
    aimcone = aimcone or 0

    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end

    if IsFirstTimePredicted() then
        local bulletDir = ( owner:GetAimVector():Angle() + owner:GetViewPunchAngles() ):Forward()
        local tracer = self.Tracer or "Tracer"

        local bullet
        if bulletCount > 1 then -- Shotguns, otherwise we'd have to fire each bullet individually
            bullet = {
                Inflictor = self,
                Num = bulletCount,
                Src = owner:M9K_GetShootPos(),
                Dir = bulletDir,
                Spread = Vector( aimcone, aimcone, 0 ),
                Tracer = 3,
                TracerName = tracer,
                Force = damage * 0.25,
                Damage = damage,
                Callback = function( attacker, tracedata, dmginfo )
                    if not IsValid( self ) then return end
                    self:BulletCallback( 0, attacker, tracedata, dmginfo )
                end
            }
        else
            local engineSpread = m9k_enginespread:GetBool()
            local spreadDir = engineSpread and Vector( aimcone, aimcone, 0 ) or Vector( 0, 0, 0 )
            local dir = engineSpread and bulletDir or getSpread( self, bulletDir, aimcone )
            bullet = {
                Inflictor = self,
                Num = bulletCount,
                Src = owner:M9K_GetShootPos(),
                Dir = dir,
                Spread = spreadDir,
                Tracer = 3,
                TracerName = tracer,
                Force = damage * 0.25,
                Damage = damage,
                Callback = function( attacker, tracedata, dmginfo )
                    if not IsValid( self ) then return end
                    self:BulletCallback( 0, attacker, tracedata, dmginfo )
                end
            }
        end

        owner:FireBullets( bullet )

        hook.Run( "M9K_BulletFired", self, owner )
    end

    self:AddRecoil()
end

function SWEP:SecondaryAttack()
    return false
end

function SWEP:AddRecoil()
    if not CLIENT then return end
    if not IsFirstTimePredicted() then return end

    local recoilPitch = math.Rand( -self.Primary.KickDown, -self.Primary.KickUp * self.KickUpMultiplier )
    local recoilYaw = math.Rand( -self.Primary.KickHorizontal, self.Primary.KickHorizontal )

    if self:GetIronsightsActive() and not self.Scoped then
        recoilPitch = recoilPitch * 0.5
        recoilYaw = recoilYaw * 0.5
    end

    self.ActiveRecoilPitch = self.ActiveRecoilPitch + recoilPitch
    self.ActiveRecoilYaw = self.ActiveRecoilYaw + recoilYaw
end

function SWEP:ReloadAnim()
    local owner = entity_GetOwner( self )
    if IsValid( owner ) and owner:IsPlayer() then
        owner:SetAnimation( PLAYER_RELOAD )
    end

    if self.SilencerAttached then
        self:SendWeaponAnim( ACT_VM_RELOAD_SILENCED )
    else
        self:SendWeaponAnim( ACT_VM_RELOAD )
    end
end

function SWEP:ReloadClip()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end

    local ammoToLoad = math.min( self.Primary.ClipSize - self:Clip1(), owner:GetAmmoCount( self:GetPrimaryAmmoType() ) )
    self:SetClip1( self:Clip1() + ammoToLoad )
    owner:RemoveAmmo( ammoToLoad, self:GetPrimaryAmmoType() )
end

function SWEP:Reload()
    if self:GetReloading() then return end
    if self:Clip1() >= self.Primary.ClipSize then return end

    local owner = entity_GetOwner( self )
    if player_KeyDown( owner, IN_USE ) then return end -- Mode switch
    if owner:GetAmmoCount( self:GetPrimaryAmmoType() ) <= 0 then return end
    if self:GetIronsights() and player_KeyDown( owner, IN_ATTACK2 ) then return end

    self:ReloadAnim()

    if CLIENT then
        self.DrawCrosshair = false
    end

    owner:SetFOV( 0, self.IronSightTime )
    self:SetIronsights( false )
    self:SetReloading( true )

    self.IronSightsAng = Vector( 0, 0, 0 )
    self.IronSightsPos = Vector( 0, 0, 0 )

    local waitdammit = owner:GetViewModel():SequenceDuration()
    timer.Create( "m9k_reload_" .. self:GetClass() .. self:EntIndex(), waitdammit, 1, function()
        if not IsValid( self ) then return end
        if not IsValid( owner ) then return end
        if not self:GetReloading() then return end
        if owner:GetActiveWeapon() ~= self then return self:SetReloading( false ) end

        self:ReloadClip()
        self:SetReloading( false )

        if not self:IsRunning() and player_KeyDown( owner, IN_ATTACK2 ) and self.Scoped == false then
            owner:SetFOV( self.Secondary.IronFOV, self.IronSightTime )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true )
            if CLIENT then
                self.DrawCrosshair = false
            end

            return
        end

        if not self.CanShootWhileRunning and self:IsRunning() then
            if self:GetNextPrimaryFire() <= CurTime() + .03 then
                self:SetNextPrimaryFire( CurTime() + self.IronSightTime ) -- Make it so you can't shoot for another quarter second
            end
            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true )
            owner:SetFOV( 0, self.IronSightTime )
            return
        end

        if CLIENT then
            self.DrawCrosshair = self.OrigCrossHair
        end
    end )
end

function SWEP:Silencer()
    if self.NextSilence > CurTime() then return end

    local owner = entity_GetOwner( self )

    owner:SetFOV( 0, self.IronSightTime )
    self:SetIronsights( false )
    self:SetReloading( true ) -- i know we're not reloading but it works

    if self.SilencerAttached then
        self:SendWeaponAnim( ACT_VM_DETACH_SILENCER )
        self.SilencerAttached = false
    elseif not self.SilencerAttached then
        self:SendWeaponAnim( ACT_VM_ATTACH_SILENCER )
        self.SilencerAttached = true
    end

    local siltimer = CurTime() + owner:GetViewModel():SequenceDuration() + 0.1
    if self:GetNextPrimaryFire() <= siltimer then
        self:SetNextPrimaryFire( siltimer )
    end
    self.NextSilence = siltimer

    timer.Simple( owner:GetViewModel():SequenceDuration() + 0.1, function()
        if not IsValid( self ) then return end
        if not IsValid( owner ) then return end

        self:SetReloading( false )
        if player_KeyDown( owner, IN_ATTACK2 ) then
            if CLIENT then return end
            if self.Scoped == false then
                owner:SetFOV( self.Secondary.IronFOV, self.IronSightTime )
                self.IronSightsPos = self.SightsPos -- Bring it up
                self.IronSightsAng = self.SightsAng -- Bring it up
                self:SetIronsights( true )
                self.DrawCrosshair = false
            else
                return
            end
        elseif not self.CanShootWhileRunning and self:IsRunning() then
            if self:GetNextPrimaryFire() <= CurTime() + self.IronSightTime then
                self:SetNextPrimaryFire( CurTime() + self.IronSightTime ) -- Make it so you can't shoot for another quarter second
            end

            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true )
            owner:SetFOV( 0, self.IronSightTime )
        else
            return
        end
    end )
end

function SWEP:SelectFireMode()
    local owner = entity_GetOwner(self)

    if self.Primary.Automatic then
        self.Primary.Automatic = false
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            owner:PrintMessage( HUD_PRINTTALK, "Semi-automatic selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
    else
        self.Primary.Automatic = true
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            owner:PrintMessage( HUD_PRINTTALK, "Automatic selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
    end
end

function SWEP:IronSight()
    local owner = entity_GetOwner( self )
    if not IsValid( owner ) then return end

    local selfTbl = entity_GetTable( self )

    -- Reset animation
    if selfTbl.ResetSights and CurTime() >= selfTbl.ResetSights then
        selfTbl.ResetSights = nil
        self:SendWeaponAnim( selfTbl.SilencerAttached and ACT_VM_IDLE_SILENCED or ACT_VM_IDLE )
    end

    local pressingE = player_KeyDown( owner, IN_USE )
    local pressingM2 = player_KeyDown( owner, IN_ATTACK2 )

    if pressingE then
        -- Silencer logic
        if selfTbl.CanBeSilenced and selfTbl.NextSilence < CurTime() and pressingM2 then
            selfTbl.Silencer( self )
            return
        end

        -- Firemode logic
        if selfTbl.SelectiveFire and selfTbl.NextFireSelect < CurTime() and not selfTbl.GetReloading( self ) and owner:KeyPressed( IN_RELOAD ) then
            selfTbl.SelectFireMode( self )
            return
        end
    end

    if not selfTbl.CanShootWhileRunning then
        -- Set run effect
        if selfTbl.StartedRunning( self ) and not selfTbl.GetReloading( self ) then
            if self:GetNextPrimaryFire() <= ( CurTime() + selfTbl.IronSightTime ) then
                self:SetNextPrimaryFire( CurTime() + selfTbl.IronSightTime )
            end

            selfTbl.IronSightsPos = selfTbl.RunSightsPos
            selfTbl.IronSightsAng = selfTbl.RunSightsAng
            selfTbl.SetIronsights( self, true )

            owner:SetFOV( 0, selfTbl.IronSightTime )
            selfTbl.DrawCrosshair = false
        end

        -- Unset run effect
        if selfTbl.StoppedRunning( self ) then
            selfTbl.SetIronsights( self, false )

            owner:SetFOV( 0, selfTbl.IronSightTime )
            selfTbl.DrawCrosshair = selfTbl.OrigCrossHair
        end
    end

    if selfTbl.GetIronsights( self ) then
        -- Unset iron sights
        if owner:KeyReleased( IN_ATTACK2 ) then
            selfTbl.SetIronsights( self, false )

            owner:SetFOV( 0, self.IronSightTime )
            selfTbl.DrawCrosshair = selfTbl.OrigCrossHair
        end
    else
        -- Set iron sights
        if pressingM2 and ( selfTbl.CanShootWhileRunning or not selfTbl.IsRunning( self ) ) and not selfTbl.GetReloading( self ) then
            selfTbl.IronSightsPos = selfTbl.SightsPos
            selfTbl.IronSightsAng = selfTbl.SightsAng
            selfTbl.SetIronsights( self, true )

            owner:SetFOV( selfTbl.Secondary.IronFOV, selfTbl.IronSightTime )
            selfTbl.DrawCrosshair = false
        end
    end

    if pressingM2 and not pressingE and not selfTbl.IsRunning( self ) then
        selfTbl.SwayScale = 0.05
        selfTbl.BobScale = 0.05
    else
        selfTbl.SwayScale = 1.0
        selfTbl.BobScale = 1.0

        if selfTbl.CanShootWhileRunning and pressingM2 then
            selfTbl.SwayScale = 0.25
            selfTbl.BobScale = 0.25
        end
    end

    if SERVER or ( not IsFirstTimePredicted() and not IS_SINGLEPLAYER ) then return end
    selfTbl.bIron = selfTbl.GetIronsightsActive( self )
    selfTbl.fIronTime = selfTbl.GetIronsightsTime( self )
    selfTbl.CurrentTime = CurTime()
    selfTbl.CurrentSysTime = SysTime()
end

--[[---------------------------------------------------------
Think
-------------------------------------------------------]]
function SWEP:ThinkCustom()
    self:IronSight()
end

function SWEP:Think()
    self:ThinkCustom()
    self:SetRunning( self:IsRunning() )
end
