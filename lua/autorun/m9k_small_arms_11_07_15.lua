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
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add( "m9k_bizonp19", "vgui/hud/m9k_bizonp19", icol  )
	killicon.Add( "m9k_colt1911", "vgui/hud/m9k_colt1911", icol  )
	killicon.Add( "m9k_coltpython", "vgui/hud/m9k_coltpython", icol  )
	killicon.Add( "m9k_deagle", "vgui/hud/m9k_deagle", icol  )
	killicon.Add( "m9k_glock", "vgui/hud/m9k_glock", icol  )
	killicon.Add( "m9k_hk45", "vgui/hud/m9k_hk45", icol  )
	killicon.Add( "m9k_luger", "vgui/hud/m9k_luger", icol  )
	killicon.Add( "m9k_m29satan", "vgui/hud/m9k_m29satan", icol  )
	killicon.Add( "m9k_m92beretta", "vgui/hud/m9k_m92beretta", icol  )
	killicon.Add( "m9k_model3russian", "vgui/hud/m9k_model3russian", icol  )
	killicon.Add( "m9k_mp7", "vgui/hud/m9k_mp7", icol  )
	killicon.Add( "m9k_ragingbull", "vgui/hud/m9k_ragingbull", icol  )
	killicon.Add( "m9k_remington1858", "vgui/hud/m9k_remington1858", icol  )
	killicon.Add( "m9k_sig_p229r", "vgui/hud/m9k_sig_p229r", icol  )
	killicon.Add( "m9k_smgp90", "vgui/hud/m9k_smgp90", icol  )
	killicon.Add( "m9k_sten", "vgui/hud/m9k_sten", icol  )
	killicon.Add( "m9k_thompson", "vgui/hud/m9k_thompson", icol  )
	killicon.Add( "m9k_usp", "vgui/hud/m9k_usp", icol  )
	killicon.Add( "m9k_uzi", "vgui/hud/m9k_uzi", icol  )
	killicon.Add( "m9k_model500", "vgui/hud/m9k_model500", icol  )
	killicon.Add( "m9k_model627", "vgui/hud/m9k_model627", icol  )
	killicon.Add( "m9k_ump45", "vgui/hud/m9k_ump45", icol  )
	killicon.Add( "m9k_mp9", "vgui/hud/m9k_mp9", icol  )
	killicon.Add( "m9k_vector", "vgui/hud/m9k_vector", icol  )
	killicon.Add( "m9k_tec9", "vgui/hud/m9k_tec9", icol  )
	killicon.Add( "m9k_mp5", "vgui/hud/m9k_mp5", icol  )
	killicon.Add( "m9k_kac_pdw", "vgui/hud/m9k_kac_pdw", icol  )
	killicon.Add( "m9k_honeybadger", "vgui/hud/m9k_honeybadger", icol  )
	killicon.Add( "m9k_mp5sd", "vgui/hud/m9k_mp5sd", icol  )
	killicon.Add( "m9k_magpulpdr", "vgui/hud/m9k_magpulpdr", icol  )
	killicon.Add( "m9k_scoped_taurus", "vgui/hud/m9k_scoped_taurus", icol  )
	killicon.Add( "m9k_mp40", "vgui/hud/m9k_mp40", icol  )
	

end

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
	
if !game.SinglePlayer() then

	if GetConVar("M9KClientGasDisable") == nil then
		CreateConVar("M9KClientGasDisable", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Turn off gas effect for all clients? 1 for yes, 0 for no. ")
	end
	
	if SERVER then
	
		function ClientSideGasDisabler()
			timer.Create("ClientGasBroadcastTimer", 15, 0, 
				function() BroadcastLua("RunConsoleCommand(\"M9KGasEffect\", \"0\")") end )
		end
	
		if GetConVar("M9KClientGasDisable"):GetBool() then
			ClientSideGasDisabler()
		end

		function M9K_Svr_Gas_Change_Callback(cvar, previous, new)
			if tobool(new) == true then
				ClientSideGasDisabler()
				BroadcastLua("print(\"Gas effects disabled on this server!\")")
			elseif tobool(new) == false then
				BroadcastLua("print(\"Gas effects re-enabled on this server.\")")
				BroadcastLua("print(\"You may turn on M9KGasEffect if you wish.\")")
				if timer.Exists("ClientGasBroadcastTimer") then
					timer.Destroy("ClientGasBroadcastTimer")
				end
			end				
		end
		cvars.AddChangeCallback("M9KClientGasDisable", M9K_Svr_Gas_Change_Callback)
	
	end
	
	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end		
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end

//MP40
sound.Add({
	name = 			"mp40.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/mp40/mp5-1.wav"
})

sound.Add({
	name = 			"Weapon_mp40m9k.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp40/magout.mp3"
})

sound.Add({
	name = 			"Weapon_mp40m9k.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp40/magin.mp3"
})

sound.Add({
	name = 			"Weapon_mp40m9k.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp40/boltback.mp3"
})

//Magpul PDR
sound.Add({
	name = 			"MAG_PDR.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/pdr/pdr-1.wav",
						"weapons/pdr/pdr-2.wav",
						"weapons/pdr/pdr-3.wav"}
})

sound.Add({
	name = 			"Weapon_PDR.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pdr/pdr_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_PDR.Clipin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pdr/pdr_clipin2.mp3"
})

sound.Add({
	name = 			"Weapon_PDR.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pdr/pdr_boltpull.mp3"
})

sound.Add({
	name = 			"Weapon_PDR.Boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pdr/pdr_boltrelease.mp3"
})

sound.Add({
	name = 			"Weapon_PDR.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pdr/pdr_clipout.mp3"
})

//KAC PDW
sound.Add({
	name = 			"KAC_PDW.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_unsil-1.wav"
})

sound.Add({
	name = 			"KAC_PDW.SilentSingle",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1-1.wav"
})

sound.Add({
	name = 			"kac_pdw_001.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_clipout.mp3"
})

sound.Add({
	name = 			"kac_pdw_001.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_clipin.mp3"
})

sound.Add({
	name = 			"kac_pdw_001.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_boltpull.mp3"
})

sound.Add({
	name = 			"kac_pdw_001.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_deploy.mp3"
})

sound.Add({
	name = 			"kac_pdw_001.Silencer_On",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_silencer_on.mp3"
})

sound.Add({
	name = 			"kac_pdw_001.Silencer_Off",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/kac_pdw/m4a1_silencer_off.mp3"
})

//MP5
sound.Add({
	name = 			"mp5_navy_Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/mp5-1.wav"
})

sound.Add({
	name = 			"mp5_foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/foley.mp3"
})

sound.Add({
	name = 			"mp5_magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magout.mp3"
})

sound.Add({
	name = 			"mp5_magin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magin1.mp3"
})

sound.Add({
	name = 			"mp5_magin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/magin2.mp3"
})

sound.Add({
	name = 			"mp5_boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/boltback.mp3"
})

sound.Add({
	name = 			"mp5_boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/boltslap.mp3"
})

sound.Add({
	name = 			"mp5_cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/cloth.mp3"
})

sound.Add({
	name = 			"mp5_safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/brightmp5/safety.mp3"
})

//tec9
sound.Add({
	name = 			"Weapon_Tec9.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/tec9/ump45-1.wav"
})

sound.Add({
	name = 			"Weapon_Tec9.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tec9/tec9_magin.mp3"
})

sound.Add({
	name = 			"Weapon_Tec9.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tec9/tec9_magout.mp3"
})

sound.Add({
	name = 			"Weapon_Tec9.NewMag",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tec9/tec9_newmag.mp3"
})

sound.Add({
	name = 			"Weapon_Tec9.Charge",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tec9/tec9_charge.mp3"
})

//Kriss
sound.Add({
	name = 			"kriss_vector.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/Kriss/ump45-1.wav"
})

sound.Add({
	name = 			"kriss_vector.Magrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/magrel.mp3"
})

sound.Add({
	name = 			"kriss_vector.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/clipout.mp3"
})

sound.Add({
	name = 			"kriss_vector.Dropclip",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/dropclip.mp3"
})

sound.Add({
	name = 			"kriss_vector.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/clipin.mp3"
})


sound.Add({
	name = 			"kriss_vector.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/boltpull.mp3"
})

sound.Add({
	name = 			"kriss_vector.unfold",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/Kriss/unfold.mp3"
})

//MP9
sound.Add({
	name = 			"Weapon_mp9.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/mp9/tmp-1.wav"
})

sound.Add({
	name = 			"Weapon_mp9.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp9/tmp_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_mp9.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp9/tmp_clipout.mp3"
})

//ump45 
sound.Add({
	name = 			"m9k_hk_ump45.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45-1.wav"
})

sound.Add({
	name = 			"m9k_hk_ump45.Clipout1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_clipout1.mp3"
})

sound.Add({
	name = 			"m9k_hk_ump45.Clipout2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_clipout2.mp3"
})

sound.Add({
	name = 			"m9k_hk_ump45.Clipin1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_clipin1.mp3"
})

sound.Add({
	name = 			"m9k_hk_ump45.Clipin2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_clipin2.mp3"
})

sound.Add({
	name = 			"m9k_hk_ump45.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_boltslap.mp3"
})

sound.Add({
	name = 			"m9k_hk_ump45.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hk_ump45/ump45_cloth.mp3"
})


//p19 Bizon
sound.Add({
	name = 			"Weapon_P19.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/p19/p90-1.wav"
})

sound.Add({
	name = 			"Weapon_P19.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_P19.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_P19.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p19/p90_boltpull.mp3"
})

//p90
sound.Add({
	name = 			"P90_weapon.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/p90_smg/p90-1.wav"
})

sound.Add({
	name = 			"P90_weapon.unlock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p90_smg/p90_unlock.mp3"
})

sound.Add({
	name = 			"P90_weapon.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p90_smg/p90_magout.mp3"
})

sound.Add({
	name = 			"P90_weapon.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p90_smg/p90_magin.mp3"
})

sound.Add({
	name = 			"P90_weapon.cock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/p90_smg/p90_cock.mp3"
})

//sten
sound.Add({
	name = 			"Weaponsten.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5-1.wav"
	
})

sound.Add({
	name = 			"Weaponsten.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipout.mp3"
	
})

sound.Add({
	name = 			"Weaponsten.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_clipin.mp3"
	
})

sound.Add({
	name = 			"Weaponsten.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltpull.mp3"	
})

sound.Add({
	name = 			"Weaponsten.boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_boltslap.mp3"
	
})

sound.Add({
	name = 			"Weapon_stengun.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/sten/mp5_slideback.mp3"
	
})

//tommy gun
sound.Add({
	name = 			"Weapon_tmg.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/tmg/tmg_1.wav"
})

sound.Add({
	name = 			"Weapon_tmg.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tmg/tmg_magout.mp3"
})

sound.Add({
	name = 			"Weapon_tmg.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tmg/tmg_magin.mp3"
})

sound.Add({
	name = 			"Weapon_tmg.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tmg/tmg_cock.mp3"
})

//MP7
sound.Add({
	name =			"Weapon_MP7.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound =				"weapons/mp7/usp1.wav"
})

sound.Add({
	name =			"Weapon_MP7.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp7/mp7_magout.mp3"
})

sound.Add({
	name =			"Weapon_MP7.magin" ,
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp7/mp7_magin.mp3"
})

sound.Add({
	name =			"Weapon_MP7.charger" ,
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/mp7/mp7_charger.mp3"
})

//uzi
sound.Add({
	name = 			"Weapon_uzi.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/uzi/mac10-1.wav"
})

sound.Add({
	name = 			"imi_uzi_09mm.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/uzi/mac10_boltpull.mp3"
})

sound.Add({
	name = 			"imi_uzi_09mm.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/uzi/mac10_clipin.mp3"
})

sound.Add({
	name = 			"imi_uzi_09mm.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/uzi/mac10_clipout.mp3"
})

//MP5SD
sound.Add({
	name = 			"Weapon_hkmp5sd.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/mp5-1.wav"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/magout.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.magfiddle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/magfiddle.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/magin.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/boltpull.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/boltrelease.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/cloth.mp3"
})

sound.Add({
	name = 			"Weapon_hkmp5sd.safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hkmp5sd/safety.mp3"
})

//Honey Badger
sound.Add({
	name = 			"Weapon_HoneyB.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/hb/hb_fire.wav"
})

sound.Add({
	name = 			"Weapon_HoneyB.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hb/magout.mp3"
})

sound.Add({
	name = 			"Weapon_HoneyB.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hb/magin.mp3"
})

sound.Add({
	name = 			"Weapon_HoneyB.Boltcatch",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hb/boltcatch.mp3"
})

sound.Add({
	name = 			"Weapon_HoneyB.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hb/boltforward.mp3"
})

sound.Add({
	name = 			"Weapon_HoneyB.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hb/boltback.mp3"
})

//colt python
sound.Add({
	name = 			"Weapon_ColtPython.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/coltpython/python-1.wav"
})

sound.Add({
	name = 			"WepColtPython.clipdraw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/coltpython/clipdraw.mp3"
})

sound.Add({
	name = 			"WepColtPython.blick",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/coltpython/blick.mp3"
})

sound.Add({
	name = 			"WepColtPython.bulletsout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/coltpython/bulletsout.mp3"
})

sound.Add({
	name = 			"WepColtPython.bulletsin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/coltpython/bulletsin.mp3"
})

//Raging Bull
sound.Add({
	name = 			"weapon_r_bull.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/r_bull/r-bull-1.wav"
})

sound.Add({
	name = 			"weapons_r_bull_bullreload_wav",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/r_bull/bullreload.mp3"
})

sound.Add({
	name = 			"weapons_r_bull_draw_gun_wav",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/r_bull/draw_gun.mp3"
})

//smith and wesson model 3
sound.Add({
	name = 			"Model3.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/model3/model3-1.wav" 
})

sound.Add({
	name = 			"Model3.Hammer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/Hammer.mp3" 
})

sound.Add({
	name = 			"Model3.Break_Eject",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/Break_eject.mp3" 
})

sound.Add({
	name = 			"Model3.bulletout_1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/bulletout_1.mp3"
})

sound.Add({
	name = 			"Model3.bulletout_2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/bulletout_2.mp3"
})

sound.Add({
	name = 			"Model3.bulletout_3",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/bulletout_3.mp3"
})

sound.Add({
	name = 			"Model3.bullets_in",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/bullets_in.mp3"
})

sound.Add({
	name = 			"Model3.Break_close",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model3/Break_CLose.mp3"	
})

//m29 satan
sound.Add({
	name = 			"Weapon_satan1.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/satan1/satan-1.wav"
})

sound.Add({
	name = 			"Weapon_satan1.blick",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/blick.mp3"
})

sound.Add({
	name = 			"Weapon_satan1.unfold",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/unfold.mp3"
})

sound.Add({
	name = 			"Weapon_satan1.bulletsin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/bulletsin.mp3"
})

sound.Add({
	name = 			"Weapon_satan1.bulletsout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/satan1/bulletsout.mp3"
})

//Remington 1858
sound.Add({
	name = 			"Remington.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/remington/remington-1.wav" 
})

sound.Add({
	name = 			"Remington.cylinderhit",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/cylinderhit.mp3" 
})

sound.Add({
	name = 			"Remington.cylinderswap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/cylinderswap.mp3" 
})

sound.Add({
	name = 			"Remington.bounce1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/bounce1.mp3" 
})

sound.Add({
	name = 			"Remington.bounce1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/bounce2.mp3" 
})

sound.Add({
	name = 			"Remington.bounce1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/bounce3.mp3" 
})

sound.Add({
	name = 			"Remington.Hammer",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/remington/hammer.mp3" 
})

//BERETTAM92
sound.Add({
	name = 			"Weapon_m92b.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			")weapons/beretta92/berettam92-1.wav"
})

sound.Add({
	name = 			"Weapon_beretta92.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_sliderelease.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Slidepull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_slidepull.mp3"
})

sound.Add({
	name = 			"Weapon_beretta92.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/beretta92/berettam92_slideback.mp3"
})

//hk45c
sound.Add({
	name = 			"Weapon_hk45.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/hk45/hk45-1.wav"
})

sound.Add({
	name = 			"HK45C.Deploy",
	channel =		CHAN_ITEM,
	volume =		1,	
	sound =			"weapons/hk45/draw.mp3"
})

sound.Add({
	name = 			"HK45C.Magout",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/hk45/magout.mp3"
})

sound.Add({
	name = 			"HK45C.Magin",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/hk45/magin.mp3"
})

sound.Add({
	name = 			"HK45C.Release",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/hk45/sliderelease.mp3"
})

sound.Add({
	name = 			"HK45C.Slidepull",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/hk45/slidepull.mp3"
})

//usp
sound.Add({
	name = 			"Weapon_fokkususp.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_usp/fiveseven-1.wav" 
})

sound.Add({
	name = 			"Weapon_fokkususp.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_usp/fiveseven_clipout.mp3" 
})

sound.Add({
	name = 			"Weapon_fokkususp.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_usp/fiveseven_clipin.mp3" 
})

sound.Add({
	name = 			"Weapon_fokkususp.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_usp/fiveseven_slideback.mp3" 
})

sound.Add({
	name = 			"Weapon_fokkususp.Slidepull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_usp/fiveseven_slidepull.mp3" 
})

// Sig P228
sound.Add({
	name = 			"Sauer1_P228.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1,
	sound =			"weapons/sig_p228/p228-1.wav"
})

sound.Add({
	name = 			"Sauer1_P228.Magout",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magout.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.Magin",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magin.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.MagShove",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magshove.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.Sliderelease",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/sliderelease.mp3"
})

sound.Add({
	name = 			"Sauer1_P228.Cloth",
	channel =		CHAN_ITEM,
	volume =		.5,
	sound =			"weapons/sig_p228/cloth.mp3"
})

sound.Add({
	name = 			"Sauer1_P228.Shift",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/shift.mp3"
})

//glock 18
sound.Add({
	name = 			"Dmgfok_glock.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/mac10-1.wav" 
})

sound.Add({
	name = 			"Dmgfok_glock.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/magout.mp3" 
})

sound.Add({
	name = 			"Dmgfok_glock.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/magin.mp3" 
})

sound.Add({
	name = 			"Dmgfok_glock.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/boltpull.mp3" 
})

sound.Add({
	name = 			"Dmgfok_glock.Boltrelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/boltrelease.mp3" 
})

sound.Add({
	name = 			"Dmgfok_glock.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_glock/mac10_deploy.mp3" 
})

//colt 1911
sound.Add({
	name = 			"Dmgfok_co1911.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/dmg_colt1911/deagle-1.wav"
})

sound.Add({
	name = 			"Dmgfok_co1911.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_colt1911/draw.mp3"
})

sound.Add({
	name = 			"Dmgfok_co1911.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_colt1911/de_clipin.mp3"
})

sound.Add({
	name = 			"Dmgfok_co1911.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_colt1911/de_slideback.mp3"
})

sound.Add({
	name = 			"Dmgfok_co1911.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_colt1911/draw.mp3"
})

//luger
sound.Add({
	name = 			"Weapon_luger.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/luger/luger-1.wav"
})

sound.Add({
	name = 			"Weapon_luger.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/luger/luger_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_luger.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/luger/luger_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_luger.Sliderelease",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/luger/luger_sliderelease.mp3"
})

//desert eagle
sound.Add({
	name = 			"Weapon_TDegle.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_deagle/deagle-1.wav" 
})

sound.Add({
	name = 			"Weapon_TDegle.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_deagle/de_clipout.mp3" 
})

sound.Add({
	name = 			"Weapon_TDegle.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_deagle/de_clipin.mp3" 
})

sound.Add({
	name = 			"Weapon_TDegle.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_deagle/de_slideback.mp3" 
})

sound.Add({
	name = 			"Weapon_TDegle.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_deagle/de_deploy.mp3" 
})

// Sig P229R
sound.Add({
	name = 			"Sauer1_P228.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1,
	sound =			"weapons/sig_p228/p228-1.wav"
})

sound.Add({
	name = 			"Sauer1_P228.Magout",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magout.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.Magin",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magin.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.MagShove",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/magshove.mp3" 
})

sound.Add({
	name = 			"Sauer1_P228.Sliderelease",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/sliderelease.mp3"
})

sound.Add({
	name = 			"Sauer1_P228.Cloth",
	channel =		CHAN_ITEM,
	volume =		.5,
	sound =			"weapons/sig_p228/cloth.mp3"
})

sound.Add({
	name = 			"Sauer1_P228.Shift",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/sig_p228/shift.mp3"
})

//Model 500
sound.Add({
	name = 			"Model_500.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound =			"weapons/model500/deagle-1.wav"		
})

sound.Add({
	name = 			"saw_model_500.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model500/de_clipin.mp3"	
})

sound.Add({
	name = 			"saw_model_500.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model500/de_clipout.mp3"	
})

sound.Add({
	name = 			"saw_model_500.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model500/de_deploy.mp3"	
})

sound.Add({
	name = 			"saw_model_500.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/model500/de_slideback.mp3"	
})

//S&W 627
sound.Add({
	name = 			"model_627perf.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/627/deagle-1.wav"
})

sound.Add({
	name = 			"model_627perf.wheel_in",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/627/wheel_in.mp3"
})

sound.Add({
	name = 			"model_627perf.bullets_in",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/627/bullets_in.mp3"
})

sound.Add({
	name = 			"model_627perf.bulletout_3",
	channel = 		CHAN_USER_BASE+11,
	volume = 		1.0,
	sound = 			"weapons/627/bulletout_3.mp3"
})

sound.Add({
	name = 			"model_627perf.bulletout_2",
	channel = 		CHAN_USER_BASE+12,
	volume = 		1.0,
	sound = 			"weapons/627/bulletout_2.mp3"
})

sound.Add({
	name = 			"model_627perf.bulletout_1",
	channel = 		CHAN_USER_BASE+13,
	volume = 		1.0,
	sound = 			"weapons/627/bulletout_1.mp3"
})

sound.Add({
	name = 			"model_627perf.wheel_out",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/627/wheel_out.mp3"
})

//usc
sound.Add({
	name = 			"Weapon_hkusc.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			{"weapons/usc/ump45-1.wav",
						"weapons/usc/ump45-2.wav"}
})

sound.Add({
	name = 			"Weapon_hkusc.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_hkusc.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_hkusc.Boltslap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usc/ump45_boltslap.mp3"
})

m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )

small_autorun_mounted = true