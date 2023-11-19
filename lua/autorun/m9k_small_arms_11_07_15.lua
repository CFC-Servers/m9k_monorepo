/*------------------------------------------------------

If you're reading this, then that mean's you've extracted this addon, probably with intentions
of editing it for your own needs, or that you're using a legacy addon.

I have no problem with that, but you must understand that I cannot offer support for legacy addons.
If you've extracted this addon, I cannot offer any help fixing problems that come up. It's impossible
to know what you've changed, and thus impossible to know what to fix.

"But Bob!" you might say. "I only changed one thing!"

Well, that's a shame. Everybody is going to say this, and I know that some of those people will be
lying to me. The only thing I can do is to refuse support to everyone using legacy addons.

So, by using a legacy addon, you accept the fact that I cannot help fix anything that might be broken.

I know it's tough love, but that's the way it's got to be.

------------------------------------------------------*/

--I'm pretty sure we don't need these anymore...
--Almost 99 percent sure that's I'm 100 percent sure...

-- if GetConVar("M9KDisableHolster") == nil then
    -- CreateConVar("M9KDisableHolster", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable my totally worthless and broken holster system? Won't hurt my feelings any. 1 for true, 2 for false. A map change may be required.")
    -- print("Holster Disable con var created")
-- end

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
