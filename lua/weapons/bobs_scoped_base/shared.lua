-- Variables that are used on both client and server
SWEP.Category                 = ""
SWEP.Author                   = "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact                  = ""
SWEP.Purpose                  = ""
SWEP.Instructions             = ""
SWEP.MuzzleAttachment         = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment     = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair            = true
SWEP.ViewModelFOV             = 65
SWEP.ViewModelFlip            = true

SWEP.Base                     = "bobs_gun_base"

SWEP.Spawnable                = false
SWEP.AdminSpawnable           = false

SWEP.Primary.Sound            = "" -- Sound of the gun
SWEP.Primary.Round            = "" -- What kind of bullet?
SWEP.Primary.RPM              = 0 -- This is in Rounds Per Minute
SWEP.Primary.Cone             = 0.15 -- Accuracy of NPCs
SWEP.Primary.Damage           = 10
SWEP.Primary.SpreadHip           = .01 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.NumShots         = 1
SWEP.Primary.ClipSize         = 0
SWEP.Primary.DefaultClip      = 0 -- Default number of bullets in a clip
SWEP.Primary.KickUp           = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "none" -- What kind of ammo

-- SWEP.Secondary.ClipSize            = 0
-- SWEP.Secondary.DefaultClip            = 0                    -- Default number of bullets in a clip
-- SWEP.Secondary.Automatic            = false                    -- Automatic/Semi Auto if
SWEP.Secondary.Ammo           = ""

SWEP.Secondary.ScopeZoom      = 0
SWEP.Secondary.UseACOG        = false
SWEP.Secondary.UseMilDot      = false
SWEP.Secondary.UseSVD         = false
SWEP.Secondary.UseParabolic   = false
SWEP.Secondary.UseElcan       = false
SWEP.Secondary.UseGreenDuplex = false

SWEP.Scoped                   = true

SWEP.BoltAction               = false

SWEP.Penetration              = true
SWEP.Ricochet                 = true

SWEP.data                     = {} -- The starting firemode
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.5
SWEP.ReticleScale             = 0.5

local entMeta = FindMetaTable( "Entity" )
local entity_GetTable = entMeta.GetTable
local entity_GetOwner = entMeta.GetOwner

function SWEP:Initialize()
    self:SetReloading( false )
    self:SetBoltback( false )
    if CLIENT then
        -- We need to get these so we can scale everything to the player's current resolution.
        local iScreenWidth = surface.ScreenWidth()
        local iScreenHeight = surface.ScreenHeight()

        -- The following code is only slightly riped off from Night Eagle
        -- These tables are used to draw things like scopes and crosshairs to the HUD.
        -- so DONT GET RID OF IT!

        self.ScopeTable = {}
        self.ScopeTable.l = iScreenHeight * self.ScopeScale
        self.ScopeTable.x1 = 0.5 * (iScreenWidth + self.ScopeTable.l)
        self.ScopeTable.y1 = 0.5 * (iScreenHeight - self.ScopeTable.l)
        self.ScopeTable.x2 = self.ScopeTable.x1
        self.ScopeTable.y2 = 0.5 * (iScreenHeight + self.ScopeTable.l)
        self.ScopeTable.x3 = 0.5 * (iScreenWidth - self.ScopeTable.l)
        self.ScopeTable.y3 = self.ScopeTable.y2
        self.ScopeTable.x4 = self.ScopeTable.x3
        self.ScopeTable.y4 = self.ScopeTable.y1
        self.ScopeTable.l = (iScreenHeight + 1) * self.ScopeScale -- I don't know why this works, but it does.

        self.QuadTable = {}
        self.QuadTable.x1 = 0
        self.QuadTable.y1 = 0
        self.QuadTable.w1 = iScreenWidth
        self.QuadTable.h1 = 0.5 * iScreenHeight - self.ScopeTable.l
        self.QuadTable.x2 = 0
        self.QuadTable.y2 = 0.5 * iScreenHeight + self.ScopeTable.l
        self.QuadTable.w2 = self.QuadTable.w1
        self.QuadTable.h2 = self.QuadTable.h1
        self.QuadTable.x3 = 0
        self.QuadTable.y3 = 0
        self.QuadTable.w3 = 0.5 * iScreenWidth - self.ScopeTable.l
        self.QuadTable.h3 = iScreenHeight
        self.QuadTable.x4 = 0.5 * iScreenWidth + self.ScopeTable.l
        self.QuadTable.y4 = 0
        self.QuadTable.w4 = self.QuadTable.w3
        self.QuadTable.h4 = self.QuadTable.h3

        self.LensTable = {}
        self.LensTable.x = self.QuadTable.w3
        self.LensTable.y = self.QuadTable.h1
        self.LensTable.w = 2 * self.ScopeTable.l
        self.LensTable.h = 2 * self.ScopeTable.l

        self.ReticleTable = {}
        self.ReticleTable.wdivider = 3.125
        self.ReticleTable.hdivider = 1.7579 / self.ReticleScale -- Draws the texture at 512 when the resolution is 1600x900
        self.ReticleTable.x = (iScreenWidth / 2) - ((iScreenHeight / self.ReticleTable.hdivider) / 2)
        self.ReticleTable.y = (iScreenHeight / 2) - ((iScreenHeight / self.ReticleTable.hdivider) / 2)
        self.ReticleTable.w = iScreenHeight / self.ReticleTable.hdivider
        self.ReticleTable.h = iScreenHeight / self.ReticleTable.hdivider

        self.FilterTable = {}
        self.FilterTable.wdivider = 3.125
        self.FilterTable.hdivider = 1.7579 / 1.35
        self.FilterTable.x = (iScreenWidth / 2) - ((iScreenHeight / self.FilterTable.hdivider) / 2)
        self.FilterTable.y = (iScreenHeight / 2) - ((iScreenHeight / self.FilterTable.hdivider) / 2)
        self.FilterTable.w = iScreenHeight / self.FilterTable.hdivider
        self.FilterTable.h = iScreenHeight / self.FilterTable.hdivider
    end
    if SERVER then
        self:SetNPCMinBurst( 3 )
        self:SetNPCMaxBurst( 10 )
        self:SetNPCFireRate( 1 )
        --self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
    end
    self:SetHoldType( self.HoldType )

    local owner = entity_GetOwner(self)

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

function SWEP:BoltBack()
    local owner = entity_GetOwner(self)

    if self:Clip1() > 0 or owner:GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 then
        self:SetBoltback( true )
        timer.Simple( .25, function()
            if not IsValid( self ) or not IsValid( owner ) then return end

            if self:GetClass() ~= self.Gun then return end
            if self:GetIronsights() then
                owner:SetFOV( 0, 0.3 )
                self:SetIronsights( false )
                self:SetDrawViewmodel( true )
            end

            local boltactiontime = ( 1 / ( self.Primary.RPM / 60 ) )
            timer.Simple( boltactiontime - 0.2, function()
                if not IsValid( self ) or not IsValid( owner ) then return end
                self:SetBoltback( false )
                if owner:KeyDown( IN_ATTACK2 ) and not owner:KeyDown( IN_SPEED ) and not self:GetReloading() then
                    owner:SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
                    self.IronSightsPos = self.SightsPos -- Bring it up
                    self.IronSightsAng = self.SightsAng -- Bring it up
                    self.DrawCrosshair = false
                    self:SetIronsights( true )
                    self:SetDrawViewmodel( false )
                end
            end )
        end )
    end
end

function SWEP:Reload()
    if self:Clip1() >= self.Primary.ClipSize then return end

    local owner = entity_GetOwner(self)
    if not IsValid( owner ) then return end

    if owner:GetAmmoCount( self:GetPrimaryAmmoType() ) <= 0 then return end
    if owner:KeyDown( IN_USE ) then return end
    if self:GetBoltback() then return end

    self:DefaultReload( ACT_VM_RELOAD )
    if not owner:IsNPC() then
        self.Idle = CurTime() + owner:GetViewModel():SequenceDuration()
    end

    if ( self:Clip1() < self.Primary.ClipSize ) and not owner:IsNPC() then
        -- When the current clip < full clip and the rest of your ammo > 0, then

        owner:SetFOV( 0, 0.3 )
        -- Zoom = 0

        self:SetIronsights( false )
        self:SetReloading( true )
        self:SetDrawViewmodel( true )
    end

    local waitdammit
    if owner:GetViewModel() == nil then
        waitdammit = 3
    else
        waitdammit = owner:GetViewModel():SequenceDuration()
    end
    timer.Simple( waitdammit + .1, function()
        if not IsValid( self ) or not IsValid( owner ) then return end

        self:SetReloading( false )
        if owner:KeyDown( IN_ATTACK2 ) then
            owner:SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self.DrawCrosshair = false
            self:SetIronsights( true )
            self:SetDrawViewmodel( false )
        elseif owner:KeyDown( IN_SPEED ) then
            if self:GetNextPrimaryFire() <= ( CurTime() + 0.3 ) then
                self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
            end
            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true )
            owner:SetFOV( 0, 0.2 )
        end
    end )
end

--[[---------------------------------------------------------
IronSight
-----------------------------------------------------------]]

function SWEP:IronSight()
    local owner = entity_GetOwner(self)
    if not IsValid( owner ) then return end
    local selfTbl = entity_GetTable( self )
    if not owner:IsNPC() and selfTbl.ResetSights and CurTime() >= selfTbl.ResetSights then
        selfTbl.ResetSights = nil

        if selfTbl.SilencerAttached then
            self:SendWeaponAnim( ACT_VM_IDLE_SILENCED )
        else
            self:SendWeaponAnim( ACT_VM_IDLE )
        end
    end

    local pressingE = owner:KeyDown( IN_USE )
    local pressingM2 = owner:KeyDown( IN_ATTACK2 )

    if selfTbl.CanBeSilenced and selfTbl.NextSilence < CurTime() and pressingE and pressingM2 then
        self:Silencer()
        return
    end

    if selfTbl.SelectiveFire and selfTbl.NextFireSelect < CurTime() and not self:GetReloading() and not self:GetBoltback() and pressingE and owner:KeyPressed( IN_RELOAD ) then
        self:SelectFireMode()
        return
    end

    -- Set run effect
    if owner:KeyPressed( IN_SPEED ) and not self:GetReloading() then
        if self:GetNextPrimaryFire() <= ( CurTime() + self.IronSightTime ) then
            self:SetNextPrimaryFire( CurTime() + self.IronSightTime )
        end
        selfTbl.IronSightsPos = selfTbl.RunSightsPos
        selfTbl.IronSightsAng = selfTbl.RunSightsAng
        self:SetIronsights( true )
        owner:SetFOV( 0, self.IronSightTime )
        selfTbl.DrawCrosshair = false
        self:SetDrawViewmodel( true )
    end

    -- Unset run effect
    if owner:KeyReleased( IN_SPEED ) then
        self:SetIronsights( false )
        owner:SetFOV( 0, self.IronSightTime )
        self.DrawCrosshair = self.XHair
    end

    -- Set iron sights
    if not owner:KeyDown( IN_SPEED ) and owner:KeyPressed( IN_ATTACK2 ) and not self:GetReloading() and not self:GetBoltback() then
        owner:SetFOV( 75 / selfTbl.Secondary.ScopeZoom, self.IronSightTime )
        selfTbl.IronSightsPos = selfTbl.SightsPos
        selfTbl.IronSightsAng = selfTbl.SightsAng
        selfTbl.DrawCrosshair = false
        self:SetIronsights( true )
        self:SetDrawViewmodel( false )
    end

    -- Unset iron sights
    if owner:KeyReleased( IN_ATTACK2 ) and not owner:KeyDown( IN_SPEED ) and not self:GetBoltback() then
        owner:SetFOV( 0, self.IronSightTime )
        self.DrawCrosshair = self.XHair
        self:SetIronsights( false )
        self:SetDrawViewmodel( true )
    end

    if pressingM2 and not pressingE and not owner:KeyDown( IN_SPEED ) then
        selfTbl.SwayScale = 0.05
        selfTbl.BobScale  = 0.05
    else
        selfTbl.SwayScale = 1.0
        selfTbl.BobScale  = 1.0
    end

    if ( not CLIENT ) or ( not IsFirstTimePredicted() and not game.SinglePlayer() ) then return end
    self.bIron = self:GetIronsightsActive()
    self.fIronTime = self:GetIronsightsTime()
    self.CurrentTime = CurTime()
    self.CurrentSysTime = SysTime()
end

function SWEP:SetDrawViewmodel( bool )
    if SERVER then return end
    local owner = entity_GetOwner(self)
    owner:DrawViewModel( bool )
end

function SWEP:DrawHUD()
    local owner = entity_GetOwner(self)
    if not IsValid( owner ) then return end

    local selfTable = self:GetTable()
    if not owner:KeyDown( IN_ATTACK2 ) then return end
    if self:GetIronsights() == true and ( not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_USE ) ) then
        if selfTable.Secondary.UseACOG then
            -- Draw the FAKE SCOPE THANG
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )

            -- Draw the CHEVRON
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_acogchevron" ) )
            surface.DrawTexturedRect( selfTable.ReticleTable.x, selfTable.ReticleTable.y, selfTable.ReticleTable.w, selfTable.ReticleTable.h )

            -- Draw the ACOG REFERENCE LINES
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_acogcross" ) )
            surface.DrawTexturedRect( selfTable.ReticleTable.x, selfTable.ReticleTable.y, selfTable.ReticleTable.w, selfTable.ReticleTable.h )
        end

        if selfTable.Secondary.UseMilDot then
            -- Draw the MIL DOT SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_scopesight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseSVD then
            -- Draw the SVD SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_svdsight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseParabolic then
            -- Draw the PARABOLIC SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_parabolicsight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseElcan then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_elcanreticle" ) )
            surface.DrawTexturedRect( selfTable.ReticleTable.x, selfTable.ReticleTable.y, selfTable.ReticleTable.w, selfTable.ReticleTable.h )

            -- Draw the ELCAN SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_elcansight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseGreenDuplex then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_nvgilluminatedduplex" ) )
            surface.DrawTexturedRect( selfTable.ReticleTable.x, selfTable.ReticleTable.y, selfTable.ReticleTable.w, selfTable.ReticleTable.h )

            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseAimpoint then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/aimpoint" ) )
            surface.DrawTexturedRect( selfTable.ReticleTable.x, selfTable.ReticleTable.y, selfTable.ReticleTable.w, selfTable.ReticleTable.h )

            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end

        if selfTable.Secondary.UseMatador then
            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/rocketscope" ) )
            surface.DrawTexturedRect( selfTable.LensTable.x - 1, selfTable.LensTable.y, selfTable.LensTable.w, selfTable.LensTable.h )
        end
    end
end

function SWEP:AdjustMouseSensitivity()
    local owner = entity_GetOwner(self)
    if not IsValid( owner ) then return end

    if owner:KeyDown( IN_SPEED ) then return end
    if not self:GetIronsights() then return end

    if owner:KeyDown( IN_ATTACK2 ) then
        return 1 / ( self.Secondary.ScopeZoom / 2 )
    end
end
