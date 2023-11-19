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

game.AddAmmoType({name="SatCannon",dmgtype=DMG_BULLET})
game.AddAmmoType({name="40mmGrenade",dmgtype=DMG_BULLET})
game.AddAmmoType({name="C4Explosive",dmgtype=DMG_BULLET})
game.AddAmmoType({name="ProxMine",dmgtype=DMG_BULLET})
game.AddAmmoType({name="Improvised_Explosive",dmgtype=DMG_BULLET})
game.AddAmmoType({name="Nuclear_Warhead",dmgtype=DMG_BULLET})
game.AddAmmoType({name="NerveGas",dmgtype=DMG_BULLET})
game.AddAmmoType({name="StickyGrenade",dmgtype=DMG_BULLET})
game.AddAmmoType({name="Harpoon",dmgtype=DMG_BULLET})
game.AddAmmoType({name="nitroG",dmgtype=DMG_BULLET})

game.AddParticles("particles/nitro_main.pcf")

if GetConVarString("nuke_yield") == nil then --if one of them doesn't exists, then they all probably don't exist
    CreateConVar("nuke_yield", 200, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_.mp3eresolution", 0.2, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_ignoreragdoll", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_breakconstraints", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_disintegration", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_damage", 100, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_epic_blast.mp3e", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_radiation_duration", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
    CreateConVar("nuke_radiation_damage", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "nuke variables" )
end

local function GuardUp(victim, info)

    if not IsValid(victim) then return end
    if not victim:IsPlayer() then return end
    if not IsValid(victim:GetActiveWeapon()) then return end
    if not IsValid(info:GetAttacker()) then return end
    if not IsValid(info:GetInflictor()) then return end

    if info:GetInflictor():GetClass() == "m9k_damascus" then
        if victim:IsPlayer() and victim:Alive() then
            if victim:GetNWBool("GuardIsUp", false) and victim:GetActiveWeapon():GetClass() == "m9k_damascus" then
                info:SetDamage(0)
                victim:EmitSound(Sound("weapons/blades/clash.mp3"))
            else
                victim:EmitSound(Sound("weapons/blades/swordchop.mp3"))
            end
        else
            victim:EmitSound(Sound("weapons/blades/swordchop.mp3"))
        end
    end

end
hook.Add("EntityTakeDamage", "GuardUp", GuardUp )

local function DukesUp(victim, info)
    if not IsValid(victim) then return end
    if not victim:IsPlayer() then return end
    if not IsValid(victim:GetActiveWeapon()) then return end
    if not IsValid(info:GetAttacker()) then return end
    if not IsValid(info:GetInflictor()) then return end

    if victim:IsPlayer() and victim:Alive() then
        if victim:GetActiveWeapon():GetClass() == "m9k_fists" then
            if victim:GetNWBool("DukesAreUp", false) and info:GetDamageType() == DMG_CLUB then
                info:SetDamage(1)
            end
        end
    end

end
hook.Add("EntityTakeDamage", "DukesUp", DukesUp )
--thanks for sharing the information i needed to fix this, intox!

function PoisonChildChecker(victim, info)

    if !IsValid(victim) then return end
    if not IsValid(info:GetAttacker()) then return end
    if not IsValid(info:GetInflictor()) then return end

    if info:GetInflictor() ~= nil then
        if info:GetInflictor():GetClass() == "POINT_HURT" then
            dealer = info:GetInflictor()
            if IsValid(dealer:GetParent()) then
                local dealerParent = dealer:GetParent()
                if dealerParent:GetClass() == "m9k_poison_parent" then
                    if IsValid(dealerParent:GetOwner()) then
                        info:SetAttacker(dealerParent:GetOwner())
                        info:SetInflictor(dealerParent)
                    end
                end
            end
        end
    end

end
hook.Add("EntityTakeDamage", "PoisonChildChecker", PoisonChildChecker )
