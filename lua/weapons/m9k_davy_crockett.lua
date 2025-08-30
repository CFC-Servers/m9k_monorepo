-- Variables that are used on both client and server
SWEP.Gun = "m9k_davy_crockett" -- must be the name of your swep but NO CAPITALS!
SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Davy Crockett" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4
SWEP.SlotPos                = 31
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "rpg"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_RL7.mdl"
SWEP.WorldModel             = "models/weapons/w_RL7.mdl"
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = ""
SWEP.Primary.RPM            = 20 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Nuclear_Warhead"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_launched_davycrockett" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 40 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( -3.7384, -5.7481, -0.2713 )
SWEP.SightsAng              = Vector( 1.1426, 0.0675, 0 )
SWEP.RunSightsPos           = Vector( 2.4946, -1.5644, 1.699 )
SWEP.RunSightsAng           = Vector( -20.1104, 35.1164, -12.959 )


if GetConVar( "M9K_Davy_Crockett_Timer" ) == nil then
    SWEP.NextFireTime = 3
    SWEP.Countdown = 3
    print( "M9K_Davy_Crockett_Timer con var is missing! You may have a corrupt addon, or hit the lua limit." )
else
    SWEP.NextFireTime = GetConVarNumber( "M9K_Davy_Crockett_Timer" )
    SWEP.Countdown = GetConVarNumber( "M9K_Davy_Crockett_Timer" )
end

SWEP.FireDelay = SWEP.NextFireTime

--and now to the nasty parts of this swep...
function SWEP:Deploy()
    local owner = self:GetOwner()

    if timer.Exists( "davy_crocket_" .. owner:UniqueID() ) then
        timer.Remove( "davy_crocket_" .. owner:UniqueID() )
    end
    self:SetIronsights( false )
    self:SendWeaponAnim( ACT_VM_DRAW )

    if GetConVar( "DavyCrockettAllowed" ):GetBool() then
        self.FireDelay = CurTime() + self.NextFireTime
        self:SetNextPrimaryFire( self.FireDelay )
        owner:PrintMessage( HUD_PRINTCENTER, "Warhead will be armed in " .. self.Countdown .. " seconds." )
        owner.DCCount = self.Countdown - 1
        timer.Create( "davy_crocket_" .. owner:UniqueID(), 1, self.Countdown, function()
            if not IsValid( self ) then return end
            if not IsValid( owner ) then return end
            if not IsValid( owner:GetActiveWeapon() ) then return end
            if owner:GetActiveWeapon():GetClass() ~= self.Gun then
                timer.Remove( "davy_crocket_" .. owner:UniqueID() )
                return
            end

            self:DeployCountDownFunc( owner.DCCount )
            owner.DCCount = owner.DCCount - 1
        end )
    else
        owner:PrintMessage( HUD_PRINTCENTER, "Nukes are not allowed on this server." )
    end

    if not owner:IsNPC() then
        self.ResetSights = CurTime() + owner:GetViewModel():SequenceDuration()
    end

    self:SetHoldType( self.HoldType )
    self:SetReloading( false )
    return true
end

function SWEP:DeployCountDownFunc( count )
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if owner:GetActiveWeapon():GetClass() ~= self.Gun then
        timer.Remove( "davy_crocket_" .. owner:UniqueID() )
        return
    end
    if count == 0 then
        owner:PrintMessage( HUD_PRINTTALK, "WARHEAD IS ARMED AND READY TO FIRE" )
    elseif count == 1 then
        owner:PrintMessage( HUD_PRINTTALK, count .. " second remaining!" )
    else
        owner:PrintMessage( HUD_PRINTTALK, count .. " seconds remaining" )
    end
    if count <= 5 then
        self:EmitSound( "C4.PlantSound" )
    end
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()

    if self:CanPrimaryAttack() and self.FireDelay <= CurTime() and not owner:KeyDown( IN_SPEED ) then
        if owner:IsPlayer() then
            if GetConVar( "DavyCrockettAllowed" ) == nil or (GetConVar( "DavyCrockettAllowed" ):GetBool()) then
                self:FireRocket()
                self:EmitSound( "RPGF.single" )
                self:TakePrimaryAmmo( 1 )
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                owner:SetAnimation( PLAYER_ATTACK1 )
                owner:MuzzleFlash()
                self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            else
                owner:PrintMessage( HUD_PRINTCENTER, "Nukes are not allowed on this server." )
            end
        end
        self:CheckWeaponsAndAmmo()
    end
end

function SWEP:FireRocket()
    local owner = self:GetOwner()

    local aim = owner:GetAimVector()
    local pos = owner:M9K_GetShootPos()

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( owner )
        rocket.Owner = owner
        rocket:Spawn()
        rocket:Activate()
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
    local owner = self:GetOwner()

    if CLIENT and IsValid( owner ) and not owner:IsNPC() then
        local vm = owner:GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    if timer.Exists( "davy_crocket_" .. owner:UniqueID() ) then timer.Remove( "davy_crocket_" .. owner:UniqueID() ) end
    return true
end

SWEP.VElements = {
    ["bomb"] = { type = "Model", model = "models/Failure/MK6/m62.mdl", bone = "Rocket", rel = "", pos = Vector( -0.093, 7.412, -0.005 ), angle = Angle( -45, 0, 90 ), size = Vector( 0.449, 0.449, 0.449 ), color =
        Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
    ["nuke"] = { type = "Model", model = "models/failure/mk6/m62.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector( 28.054, 0.268, -5.1 ), angle = Angle( -90, 0, 0 ), size = Vector( 0.504,
        0.504, 0.504 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

if GetConVar( "DavyCrocketAdminOnly" ) == nil then
    print( "DavyCrocketAdminOnly is missing! You may have hit the lua limit!" )
else
    if GetConVar( "DavyCrocketAdminOnly" ):GetInt() == 1 then
        SWEP.Spawnable = false
    end
end

--[[---------------------------------------------------------
IronSight
-------------------------------------------------------]]
function SWEP:IronSight()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end

    if not owner:IsNPC() then
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil
        end
    end

    if self.CanBeSilenced and self.NextSilence < CurTime() then
        if owner:KeyDown( IN_USE ) and owner:KeyPressed( IN_ATTACK2 ) then
            self:Silencer()
        end
    end

    if self.SelectiveFire and self.NextFireSelect < CurTime() and not (self:GetReloading()) then
        if owner:KeyDown( IN_USE ) and owner:KeyPressed( IN_RELOAD ) then
            self:SelectFireMode()
        end
    end

    -- --copy this...
    if owner:KeyPressed( IN_SPEED ) and not (self:GetReloading()) then -- If you are running
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true )
        owner:SetFOV( 0, 0.3 )
        self.DrawCrosshair = false
    end

    if owner:KeyReleased( IN_SPEED ) then -- If you release run then
        self:SetIronsights( false )
        owner:SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
    end -- Shoulder the gun

    -- --down to this
    if not owner:KeyDown( IN_USE ) and not owner:KeyDown( IN_SPEED ) then
        -- --If the key E (Use Key) is not pressed, then

        if owner:KeyPressed( IN_ATTACK2 ) and not (self:GetReloading()) then
            owner:SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true, owner )
            self.DrawCrosshair = false

            if CLIENT then return end
        end
    end

    if owner:KeyReleased( IN_ATTACK2 ) and not owner:KeyDown( IN_USE ) and not owner:KeyDown( IN_SPEED ) then
        -- --If the right click is released, then
        owner:SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
        self:SetIronsights( false )

        if CLIENT then return end
    end

    if owner:KeyDown( IN_ATTACK2 ) and not owner:KeyDown( IN_USE ) and not owner:KeyDown( IN_SPEED ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end
