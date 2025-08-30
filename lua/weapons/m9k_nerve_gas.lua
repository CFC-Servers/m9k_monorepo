-- Variables that are used on both client and server
SWEP.Gun = "m9k_nerve_gas" -- must be the name of your swep but NO CAPITALS!

SWEP.Category                = "M9K Specialties"
SWEP.Author                = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions                = ""
SWEP.MuzzleAttachment            = "1"     -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment            = "2"     -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName                = "Nerve Gas"        -- Weapon name (Shown on HUD)
SWEP.Slot                = 4
SWEP.SlotPos                = 22
SWEP.DrawAmmo                = true        -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair            = false        -- set false if you want no crosshair
SWEP.Weight                = 2
SWEP.AutoSwitchTo            = true
SWEP.AutoSwitchFrom            = true
SWEP.HoldType                 = "grenade"



SWEP.ViewModelFOV            = 70
SWEP.ViewModelFlip            = true
SWEP.ViewModel                 = "models/weapons/v_invisible_nade.mdl"
SWEP.WorldModel             = "models/weapons/w_grenade.mdl"
SWEP.Base                = "bobs_nade_base"
SWEP.Spawnable                = true
SWEP.AdminSpawnable            = true
SWEP.FiresUnderwater         = true
SWEP.ShowWorldModel = false

SWEP.Primary.Sound            = Sound("")
SWEP.Primary.RPM                = 30        -- This is in Rounds Per Minute
SWEP.Primary.ClipSize            = 1
SWEP.Primary.DefaultClip        = 1
SWEP.Primary.KickUp                = 0        -- Maximum up recoil (rise)
SWEP.Primary.KickDown            = 0        -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal        = 0        -- Maximum up recoil (stock)
SWEP.Primary.Automatic            = false        -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo            = "NerveGas"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round             = "m9k_nervegasnade"    --NAME OF ENTITY GOES HERE

--  none of this matters for IEDs and other ent-tossing sweps, but here it is anyway
SWEP.Secondary.IronFOV            = 0        -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots    = 0        -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage        = 0    -- Base damage per bullet
SWEP.Primary.SpreadHip        = 0    -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = 0 -- Ironsight accuracy, should be the same for shotguns

-- enter bone mod and other custom stuff below. Irons aren't used for grenades



SWEP.ViewModelBoneMods = {
    ["v_weapon.Left_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.3, 2.382, 5.651) },
    ["v_weapon.Root16"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-2.968, 0, 0) },
    ["v_weapon.Left_Thumb01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.123, 10.102, 0) },
    ["v_weapon.Left_Thumb03"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(2.601, 7.284, 40.835) },
    ["v_weapon.Right_Thumb01"] = { scale = Vector(1, 1, 1), pos = Vector(-0.362, 0, 0), angle = Angle(0.465, 15.345, 9.413) },
    ["v_weapon.Root17"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-8.174, 19.604, 3.446) }
}

SWEP.VElements = {
    ["nerve"] = { type = "Model", model = "models/healthvial.mdl", bone = "v_weapon.Flashbang_Parent", rel = "", pos = Vector(-0.076, 0.24, 0.063), angle = Angle(-17.351, -8.782, -99.302), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/gv/nerve_vial.vmt", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
    ["nerveagent"] = { type = "Model", model = "models/healthvial.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.22, 2.107, -4.025), angle = Angle(0, 0, 0), size = Vector(0.865, 0.865, 0.865), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/weapons/gv/nerve_vial.vmt", skin = 0, bodygroup = {} }
}

function SWEP:Think()
end
