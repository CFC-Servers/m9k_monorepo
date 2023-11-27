local function melee( victim, info )
    if not IsValid( victim ) then return end
    if not victim:IsPlayer() then return end
    if not IsValid( victim:GetActiveWeapon() ) then return end
    if not IsValid( info:GetAttacker() ) then return end
    if not IsValid( info:GetInflictor() ) then return end

    if not victim:IsPlayer() or not victim:Alive() then return end
    if victim:GetActiveWeapon():GetClass() == "m9k_fists" and victim:GetNWBool( "DukesAreUp", false ) and info:GetDamageType() == DMG_CLUB then
        info:SetDamage( 1 )
    end

    if info:GetInflictor():GetClass() == "m9k_damascus" then
        if victim:IsPlayer() and victim:Alive() then
            if victim:GetNWBool( "GuardIsUp", false ) and victim:GetActiveWeapon():GetClass() == "m9k_damascus" then
                info:SetDamage( 0 )
                victim:EmitSound( "weapons/blades/clash.mp3" )
            else
                victim:EmitSound( "weapons/blades/swordchop.mp3" )
            end
        else
            victim:EmitSound( "weapons/blades/swordchop.mp3" )
        end
    end
end
hook.Add( "EntityTakeDamage", "M9k_Melee", melee )

function PoisonChildChecker( victim, info )
    if not IsValid( victim ) then return end
    if not IsValid( info:GetAttacker() ) then return end

    local dealer = info:GetInflictor()
    if not IsValid( dealer ) then return end

    if dealer:GetClass() ~= "POINT_HURT" then return end
    if not IsValid( dealer:GetParent() ) then return end

    local dealerParent = dealer:GetParent()
    if dealerParent:GetClass() ~= "m9k_poison_parent" then return end
    if not IsValid( dealerParent:GetOwner() ) then return end

    info:SetAttacker( dealerParent:GetOwner() )
    info:SetInflictor( dealerParent )
end

hook.Add( "EntityTakeDamage", "m9k_Poison_PoisonChildChecker", PoisonChildChecker )
