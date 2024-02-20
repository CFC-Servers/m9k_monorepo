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
SWEP.Primary.Round            = ("") -- What kind of bullet?
SWEP.Primary.RPM              = 0 -- This is in Rounds Per Minute
SWEP.Primary.Cone             = 0.15 -- Accuracy of NPCs
SWEP.Primary.Recoil           = 10
SWEP.Primary.Damage           = 10
SWEP.Primary.Spread           = .01 --define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.NumShots         = 1
SWEP.Primary.ClipSize         = 0 -- Size of a clip
SWEP.Primary.DefaultClip      = 0 -- Default number of bullets in a clip
SWEP.Primary.KickUp           = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown         = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal   = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic        = true -- Automatic/Semi Auto
SWEP.Primary.Ammo             = "none" -- What kind of ammo

-- SWEP.Secondary.ClipSize            = 0                    -- Size of a clip
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

SWEP.Tracer                   = 0

SWEP.data                     = {} -- The starting firemode
SWEP.data.ironsights          = 1
SWEP.ScopeScale               = 0.5
SWEP.ReticleScale             = 0.5
SWEP.IronSightsPos            = Vector( 2.4537, 1.0923, 0.2696 )
SWEP.IronSightsAng            = Vector( 0.0186, -0.0547, 0 )

function SWEP:Initialize()
    self:SetNWBool( "Reloading", false )

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

    if CLIENT then
        -- -- Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

        self:CreateModels( self.VElements ) -- create viewmodels
        self:CreateModels( self.WElements ) -- create worldmodels

        -- -- init view model bone build function
        if IsValid( self:GetOwner() ) and self:GetOwner():IsPlayer() then
            if self:GetOwner():Alive() then
                local vm = self:GetOwner():GetViewModel()
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
        local oldpath = "vgui/hud/name" -- the path goes here
        local newpath = string.gsub( oldpath, "name", self.Gun )
        self.WepSelectIcon = surface.GetTextureID( newpath )
    end
end

function SWEP:BoltBack()
    if not SERVER then return end
    if self:Clip1() > 0 or self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ) > 0 then
        timer.Simple( .25, function()
            if not IsValid( self ) or not IsValid( self:GetOwner() ) then return end

            self:SetNWBool( "Reloading", true )
            if self:GetClass() ~= self.Gun then return end
            if (self:GetIronsights() == true) then
                self:GetOwner():SetFOV( 0, 0.3 )
                self:SetIronsights( false )
                self:GetOwner():DrawViewModel( true )
            end

            local boltactiontime = (self:GetOwner():GetViewModel():SequenceDuration())
            timer.Simple( boltactiontime + .1, function()
                if not IsValid( self ) or not IsValid( self:GetOwner() ) then return end
                self:SetNWBool( "Reloading", false )
                if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
                    self:GetOwner():SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
                    self.IronSightsPos = self.SightsPos -- Bring it up
                    self.IronSightsAng = self.SightsAng -- Bring it up
                    self.DrawCrosshair = false
                    self:SetIronsights( true, self:GetOwner() )
                    self:GetOwner():DrawViewModel( false )
                end
            end )
        end )
    end
end

function SWEP:Reload()
    if self:GetOwner():KeyDown( IN_USE ) then return end

    self:DefaultReload( ACT_VM_RELOAD )
    if not self:GetOwner():IsNPC() then
        self.Idle = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    end

    if (self:Clip1() < self.Primary.ClipSize) and not self:GetOwner():IsNPC() then
        -- When the current clip < full clip and the rest of your ammo > 0, then

        self:GetOwner():SetFOV( 0, 0.3 )
        -- Zoom = 0

        self:SetIronsights( false )
        -- Set the ironsight to false
        self:SetNWBool( "Reloading", true )
        if CLIENT then return end
        self:GetOwner():DrawViewModel( true )
    end

    local waitdammit
    if self:GetOwner():GetViewModel() == nil then
        waitdammit = 3
    else
        waitdammit = (self:GetOwner():GetViewModel():SequenceDuration())
    end
    timer.Simple( waitdammit + .1, function()
        if not IsValid( self ) or not IsValid( self:GetOwner() ) then return end

        self:SetNWBool( "Reloading", false )
        if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
            if CLIENT then return end
            self:GetOwner():SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self.DrawCrosshair = false
            self:SetIronsights( true, self:GetOwner() )
            self:GetOwner():DrawViewModel( false )
        elseif self:GetOwner():KeyDown( IN_SPEED ) and self:GetClass() == self.Gun then
            if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
                self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
            end
            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
            self:GetOwner():SetFOV( 0, 0.2 )
        end
    end )
end

function SWEP:PostReloadScopeCheck()
    self:SetNWBool( "Reloading", false )
    if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
        if CLIENT then return end
        self:GetOwner():SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
        self.IronSightsPos = self.SightsPos -- Bring it up
        self.IronSightsAng = self.SightsAng -- Bring it up
        self.DrawCrosshair = false
        self:SetIronsights( true, self:GetOwner() )
        self:GetOwner():DrawViewModel( false )
    elseif self:GetOwner():KeyDown( IN_SPEED ) and self:GetClass() == self.Gun then
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.2 )
    end
end

--[[---------------------------------------------------------
IronSight
-----------------------------------------------------------]]
function SWEP:IronSight()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end

    if self.SelectiveFire and self.NextFireSelect < CurTime() and not (self:GetNWBool( "Reloading" )) then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_RELOAD ) then
            self:SelectFireMode()
        end
    end

    if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_ATTACK2 ) then return end

    if self:GetOwner():KeyPressed( IN_SPEED ) and not (self:GetNWBool( "Reloading" )) then -- If you hold E and you can shoot then
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.2 )
    end

    if self:GetOwner():KeyDown( IN_SPEED ) and not (self:GetNWBool( "Reloading" )) then -- If you hold E or run then
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end -- Lower the gun
    end

    if self:GetOwner():KeyReleased( IN_USE ) or self:GetOwner():KeyReleased( IN_SPEED ) then -- If you release E then
        self:SetIronsights( false, self:GetOwner() ) -- Set the ironsight true
        self.DrawCrosshair = self.XHair
    end


    if self:GetOwner():KeyPressed( IN_SPEED ) or self:GetOwner():KeyPressed( IN_USE ) then -- If you run then
        self:GetOwner():SetFOV( 0, 0.2 )
        self.DrawCrosshair = false
        if CLIENT then return end
        self:GetOwner():DrawViewModel( true )
    end

    if self:GetOwner():KeyPressed( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_SPEED ) and not (self:GetNWBool( "Reloading" )) then
        self:GetOwner():SetFOV( 75 / self.Secondary.ScopeZoom, 0.15 )
        self.IronSightsPos = self.SightsPos -- Bring it up
        self.IronSightsAng = self.SightsAng -- Bring it up
        self.DrawCrosshair = false
        self:SetIronsights( true, self:GetOwner() )
        if CLIENT then return end
        self:GetOwner():DrawViewModel( false )
    elseif self:GetOwner():KeyPressed( IN_ATTACK2 ) and not (self:GetNWBool( "Reloading" )) and self:GetOwner():KeyDown( IN_SPEED ) then
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.2 )
    end

    if (self:GetOwner():KeyReleased( IN_ATTACK2 ) or self:GetOwner():KeyDown( IN_SPEED )) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        self:GetOwner():SetFOV( 0, 0.2 )
        self:SetIronsights( false, self:GetOwner() )
        self.DrawCrosshair = self.XHair
        -- Set the ironsight false
        if CLIENT then return end
        self:GetOwner():DrawViewModel( true )
    end

    if self:GetOwner():KeyDown( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end

function SWEP:DrawHUD()
    if self:GetOwner():KeyDown( IN_ATTACK2 ) and (self:GetIronsights() == true) and (not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_USE )) then
        if self.Secondary.UseACOG then
            -- Draw the FAKE SCOPE THANG
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )

            -- Draw the CHEVRON
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_acogchevron" ) )
            surface.DrawTexturedRect( self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h )

            -- Draw the ACOG REFERENCE LINES
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_acogcross" ) )
            surface.DrawTexturedRect( self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h )
        end

        if self.Secondary.UseMilDot then
            -- Draw the MIL DOT SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_scopesight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseSVD then
            -- Draw the SVD SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_svdsight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseParabolic then
            -- Draw the PARABOLIC SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_parabolicsight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseElcan then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_elcanreticle" ) )
            surface.DrawTexturedRect( self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h )

            -- Draw the ELCAN SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_elcansight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseGreenDuplex then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_nvgilluminatedduplex" ) )
            surface.DrawTexturedRect( self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h )

            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseAimpoint then
            -- Draw the RETICLE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/aimpoint" ) )
            surface.DrawTexturedRect( self.ReticleTable.x, self.ReticleTable.y, self.ReticleTable.w, self.ReticleTable.h )

            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/gdcw_closedsight" ) )
            surface.DrawTexturedRect( self.LensTable.x, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end

        if self.Secondary.UseMatador then
            -- Draw the SCOPE
            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.SetTexture( surface.GetTextureID( "scope/rocketscope" ) )
            surface.DrawTexturedRect( self.LensTable.x - 1, self.LensTable.y, self.LensTable.w, self.LensTable.h )
        end
    end
end

function SWEP:AdjustMouseSensitivity()
    local owner = self:GetOwner()
    if owner:KeyDown( IN_SPEED ) then return end
    if not self:GetIronsights() then return end

    if owner:KeyDown( IN_ATTACK2 ) then
        return 1 / ( self.Secondary.ScopeZoom / 2 )
    end
end
