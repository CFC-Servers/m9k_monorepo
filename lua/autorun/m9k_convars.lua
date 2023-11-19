if GetConVar("DebugM9K") == nil then
    CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
    CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
    print("Weapon Strip con var created")
end

if GetConVar("M9KDisablePenetration") == nil then
    CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
    print("Penetration/ricochet con var created")
end

if GetConVar("M9KDynamicRecoil") == nil then
    CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
    print("Recoil con var created")
end

if GetConVar("M9KAmmoDetonation") == nil then
    CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
    print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
    CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
    print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
    CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
    print("Default Clip con var created")
end

if GetConVar("M9KUniqueSlots") == nil then
    CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
    print("Unique Slots con var created")
end

if GetConVar("M9KExplosiveNerveGas") == nil then
    CreateConVar("M9KExplosiveNerveGas", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use silent explosions for nerve gas? Doesn't clip through walls, but does make other things explode.")
    print("Explosive Nerve Gas con var created")
end

if GetConVar("M9K_Davy_Crockett_Timer") == nil then
    CreateConVar("M9K_Davy_Crockett_Timer", "3", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Time to make Davy Crockett holder wait before firing the weapon.")
    print("Davy Crockett timer created")
end

if GetConVar("DavyCrockettAllowed") == nil then
    CreateConVar("DavyCrockettAllowed", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow people to shoot the Davy Crockett?")
    if (GetConVar("DebugM9K"):GetBool()) then print("m9k_davy_crockett blacklist convar created!") end
end

if GetConVar("DavyCrocketAdminOnly") == nil then
    CreateConVar("DavyCrocketAdminOnly", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Make the Davy Crockett an Admin Only weapon?")
    if (GetConVar("DebugM9K"):GetBool()) then print("DavyCrocketAdminOnly convar created!") end
end

if GetConVar("OrbitalStrikeAdminOnly") == nil then
    CreateConVar("OrbitalStrikeAdminOnly", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Make the Orbital Cannon an Admin Only weapon?")
    if (GetConVar("DebugM9K"):GetBool()) then print("OrbitalStrikeAdminOnly convar created!") end
end