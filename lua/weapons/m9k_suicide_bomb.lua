-- Variables that are used on both client and server
SWEP.Gun = "m9k_suicide_bomb" -- must be the name of your swep but NO CAPITALS!
SWEP.Category                = "M9K Specialties"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = "Right click to select delay" .. "\n" .. "Left click to plant."
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Timed C4"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 4                -- Slot in the weapon selection menu
SWEP.SlotPos                = 27            -- Position in the slot
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false        -- set false if you want no crosshair
SWEP.Weight                = 30            -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo            = true        -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom            = true        -- Auto switch from if you pick up a better weapon
SWEP.HoldType                 = "slam"        -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = false
SWEP.ViewModel                = "models/weapons/v_sb.mdl"    -- Weapon view model
SWEP.WorldModel                = "models/weapons/w_sb.mdl"    -- Weapon world model
SWEP.ShowWorldModel            = true
SWEP.Base                = "bobs_gun_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater         = true

SWEP.Primary.Sound            = ""        -- Script that calls the primary fire sound
SWEP.Primary.RPM                = 10        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 1        -- Size of a clip
SWEP.Primary.DefaultClip        = 1        -- Bullets you start with
SWEP.Primary.KickUp                = 0        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "C4Explosive"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round = "m9k_mad_c4" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV = 0 -- How much you 'zoom' in. Less is more!
SWEP.Timer = 0

SWEP.Primary.NumShots = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos = Vector(0, 0, 0)    -- These are the same as IronSightPos and IronSightAng
SWEP.SightsAng = Vector(0, 0, 0)    -- No, I don't know why
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

local ammoBoxes = {
    ["m9k_ammo_40mm"] = true,
    ["m9k_ammo_c4"] = true,
    ["m9k_ammo_frags"] = true,
    ["m9k_ammo_ieds"] = true,
    ["m9k_ammo_nervegas"] = true,
    ["m9k_ammo_nuke"] = true,
    ["m9k_ammo_proxmines"] = true,
    ["m9k_ammo_rockets"] = true,
    ["m9k_ammo_stickynades"] = true,
    ["m9k_ammo_357"] = true,
    ["m9k_ammo_ar2"] = true,
    ["m9k_ammo_buckshot"] = true,
    ["m9k_ammo_pistol"] = true,
    ["m9k_ammo_smg"] = true,
    ["m9k_ammo_sniper_rounds"] = true,
    ["m9k_ammo_winchester"] = true
}

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
        return
    end

    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
    local wait = self:GetOwner():GetViewModel():SequenceDuration() + .75
    self:SetNextPrimaryFire( CurTime() + wait )

    timer.Simple( wait, function()
        if not IsValid( self ) then return end
        local owner = self:GetOwner()
        if not IsValid( owner ) then return end

        local activeWeapon = owner:GetActiveWeapon()
        if not IsValid( activeWeapon ) then return end
        if activeWeapon ~= self then return end

        if self:Clip1() == 0 and owner:GetAmmoCount( self:GetPrimaryAmmoType() ) == 0  then
            if SERVER then
                owner:StripWeapon( self.Gun )
            end
        else
            self:SendWeaponAnim( ACT_VM_DRAW )
            self:Reload()
        end
    end )

    if CLIENT then return end

    timer.Simple( self:GetOwner():GetViewModel():SequenceDuration(), function()
        if not IsValid( self ) then return end
        local owner = self:GetOwner()
        if not IsValid( owner ) then return end

        local activeWeapon = owner:GetActiveWeapon()
        if not IsValid( activeWeapon ) then return end
        if activeWeapon ~= self then return end

        if self.Timer == 0 and self:CanPrimaryAttack() then
            owner:SetAnimation( PLAYER_ATTACK1 )
            self:TakePrimaryAmmo( 1 )
            self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
            self:Suicide()

            return
        end

        if self.Timer >= 5 and self:CanPrimaryAttack() then
            self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )
            self:SetNextSecondaryFire( CurTime() + 0.3 )
            owner:SetAnimation( PLAYER_ATTACK1 )
            self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
            self:TakePrimaryAmmo( 1 )

            local tr = {
                start = owner:M9K_GetShootPos(),
                endpos = owner:M9K_GetShootPos() + 100 * owner:GetAimVector(),
                filter = { owner }
            }
            local trace = util.TraceLine( tr )

            local C4 = ents.Create( self.Primary.Round )
            C4:SetPos( trace.HitPos + trace.HitNormal )
            trace.HitNormal.z = -trace.HitNormal.z
            C4:SetAngles( trace.HitNormal:Angle() - Angle( 90, 180, 0 ) )
            C4.BombOwner = owner
            C4.Timer = self.Timer
            C4:Spawn()

            local traceEnt = trace.Entity

            if trace.Hit and IsValid( traceEnt ) then
                if ammoBoxes[traceEnt:GetClass()] then
                    C4:SetParent( traceEnt )
                    traceEnt.Planted = true
                    return
                end

                if not traceEnt:IsNPC() and not traceEnt:IsPlayer() then
                    C4:SetParent( traceEnt )
                    return
                end
            else
                C4:SetMoveType( MOVETYPE_VPHYSICS )
            end
        end
    end )
end

function SWEP:Suicide()
    if self.SuicideExploded then return end
    self.SuicideExploded = true

    local owner = self:GetOwner()
    local effectdata = EffectData()
    effectdata:SetOrigin( owner:GetPos() )
    util.Effect( "ThumperDust", effectdata )
    util.Effect( "Explosion", effectdata )

    local boomEffect = EffectData()
    boomEffect:SetOrigin( owner:GetPos() )
    boomEffect:SetNormal( Vector( 0, 0, 1 ) )
    boomEffect:SetEntity( owner )
    boomEffect:SetScale( 1.3 )
    boomEffect:SetRadius( 67 )
    boomEffect:SetMagnitude( 18 )
    util.Effect( "m9k_gdcw_cinematicboom", boomEffect )

    util.ScreenShake( owner:GetPos(), 2000, 255, 2.5, 1250 )
    util.BlastDamage( self, self:GetOwner(), owner:GetPos(), 500, 500 )

    owner:EmitSound( "C4.Explode", 70 )
end

function SWEP:SecondaryAttack()
    self:SetNextPrimaryFire( CurTime() + 0.1 )
    self:SetNextSecondaryFire( CurTime() + 0.1 )

    if not IsFirstTimePredicted() then return end

    if self.Timer == 5 then
        self.Timer = 10
    elseif self.Timer == 10 then
        self.Timer = 15
    elseif self.Timer == 15 then
        self.Timer = 20
    elseif self.Timer == 20 then
        self.Timer = 0
    elseif self.Timer == 0 then
        self.Timer = 5
    end
    self:GetOwner():EmitSound( "C4.PlantSound" )

    if CLIENT then
        if self.Timer == 0 then
            self:GetOwner():PrintMessage( HUD_PRINTCENTER, "WARNING! TIMER REDUCED TO ZERO!" )
        else
            self:GetOwner():PrintMessage( HUD_PRINTCENTER, string.format( "Timer set to %s Seconds.", self.Timer ) )
        end
    end
end

function SWEP:Think()
    if self.BetterBeDead then
        self:GetOwner():Kill()
    end
end
