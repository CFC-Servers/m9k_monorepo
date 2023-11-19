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
