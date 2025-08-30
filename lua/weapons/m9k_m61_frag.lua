-- Variables that are used on both client and server
SWEP.Gun = "m9k_m61_frag" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Frag Grenade" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4
SWEP.SlotPos                = 21
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 2
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "grenade"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = true
SWEP.ViewModel              = "models/weapons/v_invisible_nade.mdl"
SWEP.WorldModel             = "models/weapons/w_grenade.mdl"
SWEP.ShowWorldModel         = false
SWEP.Base                   = "bobs_nade_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = ""
SWEP.Primary.RPM            = 30 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Grenade"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_thrown_m61" --NAME OF ENTITY GOES HERE

--  none of this matters for IEDs and other ent-tossing sweps, but here it is anyway
SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns

-- enter bone mod and other custom stuff below. Irons aren't used for grenades

SWEP.WElements              = {
    ["nade"] = { type = "Model", model = "models/weapons/w_m61_fraggynade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector( 3.611, 1.751, -2.003 ), angle = Angle( -143.148, 5.699, 0 ), size =
        Vector( 1.348, 1.348, 1.348 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.VElements              = {
    ["m61"] = { type = "Model", model = "models/weapons/w_m61_fraggynade.mdl", bone = "v_weapon.Flashbang_Parent", rel = "", pos = Vector( 0.194, -1.316, 0.54 ), angle = Angle( 95.096, -12.285, 97.221 ), size =
        Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods      = {
    ["v_weapon.Root16"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0.293, 0, 0 ) },
    ["v_weapon.Left_Thumb03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -9.509, 4.019, -0.26 ) },
    ["v_weapon.Left_Thumb01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -0.362, 0, 0 ), angle = Angle( 0.465, 15.345, 9.413 ) },
    ["v_weapon.Root17"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0.423, 12.668, 1.228 ) }
}
