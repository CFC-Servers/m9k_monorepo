-- Variables that are used on both client and server
-- Major thanks to rm-rf / for thinking up a solution to the reload glitch. Good man!

SWEP.Category               = ""
SWEP.Author                 = "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.Base                   = "bobs_gun_base"
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.DrawCrosshair          = true -- Hell no, crosshairs r 4 nubz!
SWEP.ViewModelFOV           = 65 -- How big the gun will look
SWEP.ViewModelFlip          = true -- True for CSS models, False for HL2 models

SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false

SWEP.Primary.Sound          = "" -- Sound of the gun
SWEP.Primary.RPM            = 0 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 0 -- Size of a clip
SWEP.Primary.DefaultClip    = 0 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum side recoil (koolaid)
SWEP.Primary.Automatic      = true -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "none" -- What kind of ammo
SWEP.Primary.Reloading      = false -- Reloading func

-- SWEP.Secondary.ClipSize            = 0                    -- Size of a clip
-- SWEP.Secondary.DefaultClip            = 0                    -- Default number of bullets in a clip
-- SWEP.Secondary.Automatic            = false                    -- Automatic/Semi Auto
SWEP.Secondary.Ammo         = ""
SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} -- The starting firemode
SWEP.data.ironsights        = 1


SWEP.ShotgunReloading       = false
SWEP.ShotgunFinish          = 0.5
SWEP.ShellTime              = 0.35
SWEP.InsertingShell         = false

SWEP.NextReload             = 0

--[[---------------------------------------------------------
   Name: SWEP:Think()
   Desc: Called every frame.
-----------------------------------------------------------]]
function SWEP:Think()
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end
    if self:GetOwner().NextReload == nil then self:GetOwner().NextReload = CurTime() + 1 end
    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    --if the owner presses shoot while the timer is in effect, then...
    if (self:GetOwner():KeyPressed( IN_ATTACK )) and (self:GetNextPrimaryFire() <= CurTime()) and (timer.Exists( timerName )) and not (self:GetOwner():KeyDown( IN_SPEED )) then
        if self:CanPrimaryAttack() then --well first, if we actually can attack, then...
            timer.Remove( timerName ) -- kill the timer, and
            self:PrimaryAttack() -- ATTAAAAACK!
        end
    end

    if self.InsertingShell == true and self:GetOwner():Alive() then
        vm = self:GetOwner():GetViewModel() -- its a messy way to do it, but holy shit, it works!
        vm:ResetSequence( vm:LookupSequence( "after_reload" ) ) -- Fuck you, garry, why the hell can't I reset a sequence in multiplayer?
        vm:SetPlaybackRate( .01 ) -- or if I can, why does facepunch have to be such a shitty community, and your wiki have to be an unreadable goddamn mess?
        self.InsertingShell = false -- You get paid for this, what's your excuse?
    end

    self:IronSight()
end

--[[---------------------------------------------------------
   Name: SWEP:Deploy()
   Desc: Whip it out.
-----------------------------------------------------------]]
function SWEP:Deploy()
    if not self:GetOwner():IsPlayer() then return end

    self.DrawCrosshair = self.OrigCrossHair
    self:SetHoldType( self.HoldType )

    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end

    self:SendWeaponAnim( ACT_VM_DRAW )
    self:SetReloading( false )

    self:SetNextPrimaryFire( CurTime() + 0.5 )
    self:SetNextSecondaryFire( CurTime() + 0.5 )
    self.ActionDelay = CurTime() + 0.5

    if SERVER then
        self:SetIronsights( false )
    end

    self:GetOwner().NextReload = CurTime() + 1

    return true
end

--[[---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
-----------------------------------------------------------]]
function SWEP:Reload()
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    if self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ) <= 0 then return end

    local maxcap = self.Primary.ClipSize
    local spaceavail = self:Clip1()
    local shellz = (maxcap) - (spaceavail) + 1

    if (timer.Exists( "ShotgunReload_" .. self:GetOwner():UniqueID() )) or self:GetOwner().NextReload > CurTime() or maxcap == spaceavail then return end

    self:SetReloading( true )
    if self:GetOwner():IsPlayer() then
        if self:GetNextPrimaryFire() <= (CurTime() + 2) then
            self:SetNextPrimaryFire( CurTime() + 2 ) -- wait TWO seconds before you can shoot again
        end
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START ) -- sending start reload anim
        self:GetOwner():SetAnimation( PLAYER_RELOAD )

        self:GetOwner().NextReload = CurTime() + 1

        if (SERVER) then
            self:GetOwner():SetFOV( 0, 0.15 )
            self:SetIronsights( false )
        end

        if SERVER and self:GetOwner():Alive() then
            local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
            timer.Create( timerName, self.ShellTime + .05, shellz, function()
                if not IsValid( self ) then return end
                if IsValid( self:GetOwner() ) and IsValid( self ) then
                    if self:GetOwner():Alive() then
                        self:InsertShell()
                    end
                end
            end )
        end
    elseif self:GetOwner():IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
    end
end

function SWEP:InsertShell()
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end

    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    if self:GetOwner():Alive() then
        local curwep = self:GetOwner():GetActiveWeapon()
        if not IsValid( curwep ) or curwep:GetClass() ~= self.Gun then
            timer.Remove( timerName )
            return
        end

        if (self:Clip1() >= self.Primary.ClipSize or self:GetOwner():GetAmmoCount( self.Primary.Ammo ) <= 0) then
            -- if clip is full or ammo is out, then...
            self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH ) -- send the pump anim
            timer.Remove( timerName ) -- kill the timer
            self:SetReloading( false )
        elseif (self:Clip1() <= self.Primary.ClipSize and self:GetOwner():GetAmmoCount( self.Primary.Ammo ) >= 0) then
            self.InsertingShell = true --well, I tried!
            self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false ) -- out of the frying pan
            self:SetClip1( self:Clip1() + 1 ) --  into the fire

            timer.Simple( .05, function()
                if not IsValid( self ) then return end
                self:ShellAnimCaller()
            end )
        end
    else
        timer.Remove( timerName ) -- kill the timer
    end
end

function SWEP:ShellAnimCaller()
    self:SendWeaponAnim( ACT_VM_RELOAD )
end
