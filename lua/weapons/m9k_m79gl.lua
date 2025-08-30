-- Variables that are used on both client and server
SWEP.Gun = "m9k_m79gl" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "M79 GL" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4
SWEP.SlotPos                = 29
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "shotgun"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_m79_grenadelauncher.mdl"
SWEP.WorldModel             = "models/weapons/w_m79_grenadelauncher.mdl"
SWEP.ShowWorldModel         = true

SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "40mmGrenade.Single"
SWEP.Primary.RPM            = 15 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.KickUp         = 0.3 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0.3 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.3 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "40mmGrenade"

SWEP.Secondary.IronFOV      = 60 -- How much you 'zoom' in. Less is more!
SWEP.Primary.Round          = "m9k_launched_m79" --NAME OF ENTITY GOES HERE
SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.ShellTime              = .5

SWEP.Primary.NumShots       = 1 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 30 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .025 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .015 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( -4.633, -7.651, 2.108 )
SWEP.SightsAng              = Vector( 1.294, 0.15, 0 )
SWEP.RunSightsPos           = Vector( 3.279, -5.574, 0 )
SWEP.RunSightsAng           = Vector( -1.721, 49.917, 0 )

function SWEP:Deploy()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    self:SetHoldType( self.HoldType )
    self:SetNextPrimaryFire( CurTime() + 1 )

    local timerName = "ShotgunReload_" .. owner:UniqueID()
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end

    self:SendWeaponAnim( ACT_VM_DRAW )

    self:SetNextSecondaryFire( CurTime() + 1 )
    self.ActionDelay = CurTime() + .25

    if SERVER then
        self:SetIronsights( false )
    end

    self.NextReload = CurTime() + 1

    return true
end

function SWEP:PrimaryAttack()
    if self:GetNextPrimaryFire() > CurTime() then return end
    if self:CanPrimaryAttack() then
        local owner = self:GetOwner()
        if not IsValid( owner ) then return end

        if not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_RELOAD ) then
            self:FireRocket()
            self:EmitSound( self.Primary.Sound )
            self:TakePrimaryAmmo( 1 )
            self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
            owner:SetAnimation( PLAYER_ATTACK1 )
            owner:MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1.75 )
        else
            self:Reload()
        end
    end
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    local owner = self:GetOwner()

    local aim = owner:GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = owner:M9K_GetShootPos() + side * 6 + up * -5

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( owner )
        rocket:Spawn()
        rocket:Activate()
    end
end

function SWEP:Reload()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local maxcap = self.Primary.ClipSize
    local spaceavail = self:Clip1()
    local shellz = (maxcap) - (spaceavail) + 1

    if (timer.Exists( "ShotgunReload" )) or self.NextReload > CurTime() or maxcap == spaceavail then return end

    if owner:IsPlayer() then
        self:SetNextPrimaryFire( CurTime() + 1.75 ) -- wait one second before you can shoot again
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START ) -- sending start reload anim
        owner:SetAnimation( PLAYER_RELOAD )

        self.NextReload = CurTime() + 1

        if (SERVER) then
            owner:SetFOV( 0, 0.15 )
            self:SetIronsights( false )
        end

        if SERVER and owner:Alive() then
            local timerName = "ShotgunReload_" .. owner:UniqueID()
            timer.Create( timerName, self.ShellTime + .05, shellz, function()
                if not IsValid( self ) then return end
                if IsValid( owner ) and IsValid( self ) then
                    if owner:Alive() then
                        self:InsertShell()
                    end
                end
            end )
        end
    elseif owner:IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
    end
end

function SWEP:Think()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    if self.InsertingShell == true and owner:Alive() then
        vm = owner:GetViewModel() -- its a messy way to do it, but holy shit, it works!
        vm:ResetSequence( vm:LookupSequence( "after_reload" ) ) -- Fuck you, garry, why the hell can't I reset a sequence in multiplayer?
        vm:SetPlaybackRate( .01 ) -- or if I can, why does facepunch have to be such a shitty community, and your wiki have to be an unreadable goddamn mess?
        self.InsertingShell = false -- You get paid for this, what's your excuse?
    end

    self:IronSight()
end
