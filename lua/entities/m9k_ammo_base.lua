ENT.Base = "base_anim"
ENT.PhysicsSounds = true

if SERVER then
    AddCSLuaFile()

    local ammo_detonation = GetConVar( "M9KAmmoDetonation" )

    function ENT:Initialize()
        self:SetModel( self.Model )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetUseType( SIMPLE_USE )
        self:PhysWake()
    end

    function ENT:OnTakeDamage( dmg )
        self:TakePhysicsDamage( dmg )

        if not ammo_detonation:GetBool() then
            return
        end

        if dmginfo:GetDamage() > 75 or math.random( 1, 5 ) == 1 then
            local attacker = dmg:GetAttacker()
            local pos = self:GetPos() + Vector( 0, 0, 10 )

            local effectdata = EffectData()
            effectdata:SetOrigin( pos )
            util.Effect( "ThumperDust", effectdata )
            util.Effect( "Explosion", effectdata )

            for i = 1, 100 do
                local trace = util.TraceLine( {
                    start = pos,
                    endpos = pos + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( 0, 1 ) ) * 64000,
                    filter = self
                } )

                if IsValid( trace.Entity ) then
                    trace.Entity:TakeDamage( 30 * math.Rand( 0.85, 1.15 ), attacker, self )
                end
            end

            self:Remove()
        end
    end

    function ENT:Use( activator )
        if activator:IsPlayer() and not self.Planted then
            if self.AmmoGiveWeapon and not IsValid( activator:GetWeapon( self.AmmoGiveWeapon ) ) then
                activator:Give( self.AmmoGiveWeapon )
                activator:GiveAmmo( self.AmmoCount - 1, self.AmmoType )
            else
                activator:GiveAmmo( self.AmmoCount, self.AmmoType )
            end

            self:Remove()
        end
    end
else
    function ENT:Draw()
        self:DrawModel()

        if self.Text then
            local pos = self:GetPos()
            local pos_offset = self.PosOffset
            pos:Add(self:GetUp() * pos_offset.x)
            pos:Add(self:GetRight() * pos_offset.y)
            pos:Add(self:GetForward() * pos_offset.z)

            local angles = self:GetAngles()
            local ang_offset = self.AngOffset
            angles:RotateAroundAxis( angles:Right(), ang_offset.x )
            angles:RotateAroundAxis( angles:Up(), ang_offset.y )
            angles:RotateAroundAxis( angles:Forward(), ang_offset.z )

            cam.Start3D2D( pos, angles, 0.07 )
                draw.SimpleText( self.Text, self.TextFont, 31, -22, Color( 230, 45, 45 ), 1, 1 )
            cam.End3D2D()
        end
    end
end
