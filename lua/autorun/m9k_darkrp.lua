local gameMode = engine.ActiveGamemode()
if gameMode == "sandbox" or gameMode == "terrortown" then return end

local pocketBlacklist = {
    ["m9k_davy_crockett_explo"] = true,
    ["m9k_gdcwa_matador_90mm"] = true,
    ["m9k_gdcwa_rpg_heat"] = true,
    ["m9k_improvised_explosive"] = true,
    ["m9k_launched_davycrockett"] = true,
    ["m9k_launched_ex41"] = true,
    ["m9k_launched_m79"] = true,
    ["m9k_m202_rocket"] = true,
    ["m9k_mad_c4"] = true,
    ["m9k_milkor_nade"] = true,
    ["m9k_nervegasnade"] = true,
    ["m9k_nitro_vapor"] = true,
    ["m9k_oribital_cannon"] = true,
    ["m9k_poison_parent"] = true,
    ["m9k_proxy"] = true,
    ["m9k_released_poison"] = true,
    ["m9k_thrown_harpoon"] = true,
    ["m9k_thrown_knife"] = true,
    ["m9k_thrown_m61"] = true,
    ["m9k_thrown_nitrox"] = true,
    ["m9k_thrown_spec_knife"] = true,
    ["m9k_thrown_sticky_grenade"] = true,
    ["bb_dod_bazooka_rocket"] = true,
    ["bb_dod_panzershreck_rocket"] = true,
    ["bb_garand_riflenade"] = true,
    ["bb_k98_riflenade"] = true,
    ["bb_planted_dod_tnt"] = true,
    ["bb_thrownalliedfrag"] = true,
    ["bb_thrownaxisfrag"] = true,
    ["bb_thrownsmoke_axis"] = true,
    ["bb_thrownaxisfrag"] = true,
    ["bb_planted_alt_c4"] = true,
    ["bb_planted_css_c4"] = true,
    ["bb_throwncssfrag"] = true,
    ["bb_throwncsssmoke"] = true,
    ["m9k_ammo_40mm"] = true,
    ["m9k_ammo_40mm_single"] = true,
    ["m9k_ammo_357"] = true,
    ["m9k_ammo_ar2"] = true,
    ["m9k_ammo_buckshot"] = true,
    ["m9k_ammo_c4"] = true,
    ["m9k_ammo_frags"] = true,
    ["m9k_ammo_ieds"] = true,
    ["m9k_ammo_nervegas"] = true,
    ["m9k_ammo_nuke"] = true,
    ["m9k_ammo_pistol"] = true,
    ["m9k_ammo_proxmines"] = true,
    ["m9k_ammo_rockets"] = true,
    ["m9k_ammo_smg"] = true,
    ["m9k_ammo_sniper_rounds"] = true,
    ["m9k_ammo_stickynades"] = true,
    ["m9k_ammo_winchester"] = true
}

local function blacklist( _, wep )
    if not IsValid( wep ) then return end
    local class = wep:GetClass()

    if pocketBlacklist[class] then
        return false
    end
end

hook.Add( "canPocket", "PocketM9KWeapons", blacklist )
