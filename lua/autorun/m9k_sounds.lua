local function AddSound( name, channel, volume, sound_path, level )
    sound.Add( { name = name, channel = channel, volume = volume, soundlevel = level, sound = sound_path } )
end

-- AN-94
AddSound( "an94.single", CHAN_WEAPON, 1, "weapons/an94/galil-1.ogg" )
AddSound( "an94.double", CHAN_WEAPON, 1, "weapons/an94/doubletap.ogg" )
AddSound( "Weapon_an-94.Clipout", CHAN_AUTO, 1, "weapons/an94/clipout.ogg" )
AddSound( "Weapon_an-94.Clipin", CHAN_AUTO, 1, "weapons/an94/clipin.ogg" )
AddSound( "Weapon_an-94.Boltpull", CHAN_AUTO, 1, "weapons/an94/boltpull.ogg" )
AddSound( "Weapon_an-94.Draw", CHAN_AUTO, 1, "weapons/an94/draw.ogg" )

-- AMD-65
AddSound( "amd65.single", CHAN_WEAPON, 1, "weapons/amd65/amd-1.ogg" )
AddSound( "amd65.Clipout", CHAN_AUTO, 1, "weapons/amd65/clipout.ogg" )
AddSound( "amd65.Clipin", CHAN_AUTO, 1, "weapons/amd65/magin2.ogg" )
AddSound( "amd65.BoltPull", CHAN_AUTO, 1, "weapons/amd65/boltpull.ogg" )
AddSound( "amd65.BoltBack", CHAN_AUTO, 1, "weapons/amd65/boltrelease.ogg" )

-- Tavor
AddSound( "Wep_imitavor.single", CHAN_WEAPON, 1, "weapons/tavor/famas-1.ogg" )
AddSound( "Wep_imitavor.Clipout", CHAN_AUTO, 1, "weapons/tavor/famas_clipout.ogg" )
AddSound( "Wep_imitavor.Clipout1", CHAN_AUTO, 1, "weapons/tavor/famas_clipout1.ogg" )
AddSound( "Wep_imitavor.Tap", CHAN_AUTO, 1, "weapons/tavor/famas_tap.ogg" )
AddSound( "Wep_imitavor.Clipin", CHAN_AUTO, 1, "weapons/tavor/famas_clipin.ogg" )
AddSound( "Wep_imitavor.Boltpull", CHAN_AUTO, 1, "weapons/tavor/famas_boltpull.ogg" )
AddSound( "Wep_imitavor.Boltrelease", CHAN_AUTO, 1, "weapons/tavor/famas_boltrelease.ogg" )
AddSound( "Wep_imitavor.Cloth", CHAN_AUTO, 1, "weapons/tavor/famas_cloth.ogg" )

-- F2000
AddSound( "Weapon_F2000.Single", CHAN_WEAPON, 1, { "weapons/fokku_tc_f2000/shot-1.ogg", "weapons/fokku_tc_f2000/shot-2.ogg", "weapons/fokku_tc_f2000/shot-3.ogg", "weapons/fokku_tc_f2000/shot-4.ogg" } )
AddSound( "f2000.playerbreathing", CHAN_AUTO, 1, "weapons/fokku_tc_f2000/playerbreathing.ogg" )
AddSound( "f2000.lightcloth", CHAN_AUTO, 1, "weapons/fokku_tc_f2000/cloth2.ogg" )
AddSound( "f2000.heavycloth", CHAN_AUTO, 1, "weapons/fokku_tc_f2000/cloth.ogg" )
AddSound( "f2000.magout", CHAN_AUTO, 1, "weapons/fokku_tc_f2000/clipout.ogg" )
AddSound( "f2000.magin", CHAN_AUTO, 1, "weapons/fokku_tc_f2000/clipin.ogg" )
AddSound( "f2000.boltback", CHAN_AUTO, 1, { "weapons/fokku_tc_f2000/chargeback.ogg", "weapons/fokku_tc_f2000/chargeback1.ogg" } )
AddSound( "f2000.boltforward", CHAN_AUTO, 1, { "weapons/fokku_tc_f2000/chargefor.ogg", "weapons/fokku_tc_f2000/chargefor1.ogg" } )

-- AK-47
AddSound( "47ak.Single", CHAN_WEAPON, 1, "weapons/AYKAYFORTY/ak47-1.ogg" )
AddSound( "47ak.Bolt", CHAN_AUTO, 1, "weapons/AYKAYFORTY/bolt.ogg" )
AddSound( "47ak.magin", CHAN_AUTO, 1, "weapons/AYKAYFORTY/magin.ogg" )
AddSound( "47ak.magout", CHAN_AUTO, 1, "weapons/AYKAYFORTY/magout.ogg" )

-- M14
AddSound( "Weapon_M14SP.Single", CHAN_WEAPON, 1, "weapons/fokku_tc_m14/sg550-1.ogg" )
AddSound( "Weapon_M14SP.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_m14/sg550_clipout.ogg" )
AddSound( "Weapon_M14SP.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_m14/sg550_clipin.ogg" )
AddSound( "Weapon_M14SP.Boltpull", CHAN_AUTO, 1, "weapons/fokku_tc_m14/sg550_boltpull.ogg" )
AddSound( "Weapon_M14.Deploy", CHAN_AUTO, 1, "weapons/fokku_tc_m14/sg550_deploy.ogg" )

-- G36
AddSound( "G36.single", CHAN_WEAPON, 1, "weapons/G36/m4a1_unsil-1.ogg" )
AddSound( "G36.Boltback", CHAN_AUTO, 1, "weapons/G36/Boltback.ogg" )
AddSound( "G36.BoltPull", CHAN_AUTO, 1, "weapons/G36/BoltPull.ogg" )
AddSound( "G36.Cloth", CHAN_AUTO, 1, "weapons/G36/Cloth.ogg" )
AddSound( "G36.PocketRussle", CHAN_AUTO, 1, "weapons/G36/PocketRussle.ogg" )
AddSound( "G36.MagOut", CHAN_AUTO, 1, "weapons/G36/MagOut.ogg" )
AddSound( "G36.MagFiddle", CHAN_AUTO, 1, "weapons/G36/MagFiddle.ogg" )
AddSound( "G36.MagSlap", CHAN_AUTO, 1, "weapons/G36/MagSlap.ogg" )
AddSound( "G36.PlaceSilencer", CHAN_AUTO, 1, "weapons/G36/PlaceSilencer.ogg" )
AddSound( "G36.TightenSilencer", CHAN_AUTO, 1, "weapons/G36/TightenSilencer.ogg" )
AddSound( "G36.SpinSilencer", CHAN_AUTO, 1, "weapons/G36/SpinSilencer.ogg" )
AddSound( "G36.Safety", CHAN_AUTO, 1, "weapons/G36/Safety.ogg" )

-- Winchester 1873
AddSound( "Weapon_73.Single", CHAN_WEAPON, 1, "weapons/winchester73/w73-1.ogg" )
AddSound( "Weapon_73.Pump", CHAN_ITEM, 1, "weapons/winchester73/w73pump.ogg" )
AddSound( "Weapon_73.Insertshell", CHAN_ITEM, 1, "weapons/winchester73/w73insertshell.ogg" )

-- L85
AddSound( "Weapon_l85.Single", CHAN_WEAPON, 1, "weapons/L85A2/aug-1.ogg" )
AddSound( "Weapon_l85.magin", CHAN_AUTO, 1, "weapons/L85A2/magin.ogg" )
AddSound( "Weapon_l85.magout", CHAN_AUTO, 1, "weapons/L85A2/magout.ogg" )
AddSound( "Weapon_l85.boltslap", CHAN_AUTO, 1, "weapons/L85A2/boltslap.ogg" )
AddSound( "Weapon_l85.boltpull", CHAN_AUTO, 1, "weapons/L85A2/boltpull.ogg" )
AddSound( "Weapon_l85.cloth", CHAN_AUTO, 1, "weapons/L85A2/cloth.ogg" )
AddSound( "Weapon_l85.Tap", CHAN_AUTO, 1, "weapons/L85A2/tap.ogg" )

-- AUG A3
AddSound( "aug_a3.Single", CHAN_WEAPON, 1, { "weapons/auga3/aug-1.ogg", "weapons/auga3/aug-2.ogg" } )
AddSound( "Weap_auga3.Clipout", CHAN_AUTO, 1, "weapons/auga3/clipout.ogg" )
AddSound( "Weap_auga3.Clipin", CHAN_AUTO, 1, "weapons/auga3/clipin.ogg" )
AddSound( "Weap_auga3.Boltpull", CHAN_AUTO, 1, "weapons/auga3/boltpull.ogg" )
AddSound( "Weap_auga3.boltslap", CHAN_AUTO, 1, "weapons/auga3/boltslap.ogg" )

-- FAMAS
AddSound( "Weapon_FAMTC.Single", CHAN_WEAPON, 1, { "weapons/fokku_tc_famas/shot-1.ogg", "weapons/fokku_tc_famas/shot-2.ogg" } )
AddSound( "Weapon_FAMTC.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_famas/famas_clipout.ogg" )
AddSound( "Weapon_FAMTC.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_famas/famas_clipin.ogg" )
AddSound( "Weapon_FAMTC.forearm", CHAN_AUTO, 1, "weapons/fokku_tc_famas/famas_forearm.ogg" )

-- AS Val
AddSound( "Dmgfok_vally.Single", CHAN_WEAPON, 1, "weapons/dmg_val/galil-1.ogg" )
AddSound( "Dmgfok_vally.Clipout", CHAN_AUTO, 1, "weapons/dmg_val/galil_clipout.ogg" )
AddSound( "Dmgfok_vally.Clipin", CHAN_AUTO, 1, "weapons/dmg_val/galil_clipin.ogg" )
AddSound( "Dmgfok_vally.Boltpull", CHAN_AUTO, 1, "weapons/dmg_val/galil_Boltpull.ogg" )
AddSound( "Dmgfok_vally.Draw", CHAN_AUTO, 1, "weapons/dmg_val/draw.ogg" )

-- Vikhr
AddSound( "Dmgfok_vikhr.Single", CHAN_WEAPON, 1, "weapons/dmg_vikhr/galil-1.ogg" )
AddSound( "Dmgfok_vikhr.Silenced", CHAN_WEAPON, 1, "weapons/dmg_vikhr/galil-sil.ogg" )
AddSound( "Dmgfok_vikhr.Clipout", CHAN_AUTO, 1, "weapons/dmg_vikhr/galil_clipout.ogg" )
AddSound( "Dmgfok_vikhr.Clipin", CHAN_AUTO, 1, "weapons/dmg_vikhr/galil_clipin.ogg" )
AddSound( "Dmgfok_vikhr.Boltpull", CHAN_AUTO, 1, "weapons/dmg_vikhr/galil_Boltpull.ogg" )
AddSound( "Dmgfok_vikhr.Draw", CHAN_AUTO, 1, "weapons/dmg_vikhr/draw.ogg" )

-- Magpul Masada ACR
AddSound( "Masada.Single", CHAN_WEAPON, 1, ")weapons/masadamagpul/masada_unsil.ogg" )
AddSound( "Masada.Cloth1", CHAN_AUTO, 1, "weapons/masadamagpul/cloth1.ogg" )
AddSound( "Masada.Cloth2", CHAN_AUTO, 1, "weapons/masadamagpul/cloth2.ogg" )
AddSound( "Masada.Magin1", CHAN_AUTO, 1, "weapons/masadamagpul/magin1.ogg" )
AddSound( "Masada.Magin2", CHAN_AUTO, 1, "weapons/masadamagpul/magin2.ogg" )
AddSound( "Masada.Foley", CHAN_AUTO, 1, "weapons/masadamagpul/foley.ogg" )
AddSound( "Masada.Magout", CHAN_AUTO, 1, "weapons/masadamagpul/magout.ogg" )
AddSound( "Masada.Magslap", CHAN_AUTO, 1, "weapons/masadamagpul/magslap.ogg" )
AddSound( "Masada.Safety", CHAN_AUTO, 1, "weapons/masadamagpul/safety.ogg" )
AddSound( "Masada.Chargerback", CHAN_AUTO, 1, "weapons/masadamagpul/chargerback.ogg" )
AddSound( "Masada.Boltrelease", CHAN_AUTO, 1, "weapons/masadamagpul/boltrelease.ogg" )
AddSound( "Masada.Placesilencer", CHAN_AUTO, 1, "weapons/masadamagpul/placesilencer.ogg" )
AddSound( "Masada.Removesilencer", CHAN_AUTO, 1, "weapons/masadamagpul/removesilencer.ogg" )

-- M4A1
AddSound( "Dmgfok_M4A1.Single", CHAN_WEAPON, 1, "weapons/dmg_m4a1/m4a1_unsil-1.ogg" )
AddSound( "Dmgfok_M4A1.Silencer_Off", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_silencer_off.ogg" )
AddSound( "Dmgfok_M4A1.Silencer_On", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_silencer_on.ogg" )
AddSound( "Dmgfok_M4A1.Clipout", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_clipout.ogg" )
AddSound( "Dmgfok_M4A1.Clipin", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_clipin.ogg" )
AddSound( "Dmgfok_M4A1.Boltrelease", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_boltrelease.ogg" )
AddSound( "Dmgfok_M4A1.Boltrelease2", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_boltrelease_silenced.ogg" )
AddSound( "Dmgfok_M4A1.Boltpull", CHAN_AUTO, 1, "weapons/dmg_m4a1/m4a1_boltpull.ogg" )

-- M16A4
AddSound( "Dmgfok_M16A4.Single", CHAN_WEAPON, 1, ")weapons/dmg_m16a4/shoot.ogg" )
AddSound( "Dmgfok_M16A4.Clipout", CHAN_AUTO, 1, "weapons/dmg_m16a4/magout.ogg" )
AddSound( "Dmgfok_M16A4.Clipin", CHAN_AUTO, 1, "weapons/dmg_m16a4/magin.ogg" )
AddSound( "Dmgfok_M16A4.Boltrelease", CHAN_AUTO, 1, "weapons/dmg_m16a4/boltrelease.ogg" )
AddSound( "Dmgfok_M16A4.Boltpull", CHAN_AUTO, 1, "weapons/dmg_m16a4/boltpull.ogg" )

-- AK-47
AddSound( "Tactic_AK47.Single", CHAN_WEAPON, 1, "weapons/fokku_tc_ak47/ak47-1.ogg" )
AddSound( "Tactic_AK47.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_ak47/ak47_clipout.ogg" )
AddSound( "Tactic_AK47.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_ak47/ak47_clipin.ogg" )
AddSound( "Tactic_AK47.Boltpull", CHAN_AUTO, 1, "weapons/fokku_tc_ak47/ak47_boltpull.ogg" )

-- SCAR
AddSound( "Wep_fnscarh.Single", CHAN_WEAPON, 1, { "weapons/fnscarh/aug-1.ogg", "weapons/fnscarh/aug-2.ogg", "weapons/fnscarh/aug-3.ogg" } )
AddSound( "Wep_fnscar.Boltpull", CHAN_AUTO, 1, "weapons/fnscarh/aug_boltpull.ogg" )
AddSound( "Wep_fnscar.Boltslap", CHAN_AUTO, 1, "weapons/fnscarh/aug_boltslap.ogg" )
AddSound( "Wep_fnscar.Clipout", CHAN_AUTO, 1, "weapons/fnscarh/aug_clipout.ogg" )
AddSound( "Wep_fnscar.Clipin", CHAN_AUTO, 1, "weapons/fnscarh/aug_clipin.ogg" )

-- FN FAL
AddSound( "fnfal.Single", CHAN_WEAPON, 1, "weapons/fn_fal/galil-1.ogg" )
AddSound( "Weapon_fnfal.Clipout", CHAN_AUTO, 1, "weapons/fn_fal/galil_clipout.ogg" )
AddSound( "Weapon_fnfal.Clipin", CHAN_AUTO, 1, "weapons/fn_fal/galil_clipin.ogg" )
AddSound( "Weapon_fnfal.Boltpull", CHAN_AUTO, 1, "weapons/fn_fal/galil_boltpull.ogg" )

-- HK416
AddSound( "hk416weapon.SilencedSingle", CHAN_WEAPON, 1, "weapons/twinkie_hk416/m4a1-1.ogg" )
AddSound( "hk416weapon.UnsilSingle", CHAN_WEAPON, 1, "weapons/twinkie_hk416/m4a1_unsil-1.ogg" )
AddSound( "hk416weapon.Clipout", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_clipout.ogg" )
AddSound( "hk416weapon.Magtap", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_tap.ogg" )
AddSound( "hk416weapon.Clipin", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_clipin.ogg" )
AddSound( "hk416weapon.Boltpull", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_boltpull.ogg" )
AddSound( "hk416weapon.Boltrelease", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_boltrelease.ogg" )
AddSound( "hk416weapon.Deploy", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_deploy.ogg" )
AddSound( "hk416weapon.Silencer_On", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_silencer_on.ogg" )
AddSound( "hk416weapon.Silencer_Off", CHAN_AUTO, 1, "weapons/twinkie_hk416/m4a1_silencer_off.ogg" )

-- G3
AddSound( "hk_g3_weapon.Single", CHAN_WEAPON, 1, "weapons/hk_g3/galil-1.ogg" )
AddSound( "hk_g3_weapon.Clipout", CHAN_AUTO, 1, "weapons/hk_g3/galil_clipout.ogg" )
AddSound( "hk_g3_weapon.Clipin", CHAN_AUTO, 1, "weapons/hk_g3/galil_clipin.ogg" )
AddSound( "hk_g3_weapon.Boltpull", CHAN_AUTO, 1, "weapons/hk_g3/boltpull.ogg" )
AddSound( "hk_g3_weapon.Boltforward", CHAN_AUTO, 1, "weapons/hk_g3/boltforward.ogg" )
AddSound( "hk_g3_weapon.cloth", CHAN_AUTO, 1, "weapons/hk_g3/Cloth.ogg" )
AddSound( "hk_g3_weapon.draw", CHAN_AUTO, 1, "weapons/hk_g3/draw.ogg" )

-- PKM
AddSound( "pkm.single", CHAN_WEAPON, 1, { "weapons/pkm/pkm-1.ogg", "weapons/pkm/pkm-2.ogg", "weapons/pkm/pkm-3.ogg", "weapons/pkm/pkm-4.ogg", "weapons/pkm/pkm-5.ogg" } )
AddSound( "Weapon_PKM.Cloth", CHAN_AUTO, 1, "weapons/pkm/pkm_cloth.ogg" )
AddSound( "Weapon_PKM.Coverup", CHAN_AUTO, 1, "weapons/pkm/pkm_coverup.ogg" )
AddSound( "Weapon_PKM.Bullet", CHAN_AUTO, 1, "weapons/pkm/pkm_bullet.ogg" )
AddSound( "Weapon_PKM.Boxout", CHAN_AUTO, 1, "weapons/pkm/pkm_boxout.ogg" )
AddSound( "Weapon_PKM.Boxin", CHAN_AUTO, 1, "weapons/pkm/pkm_boxin.ogg" )
AddSound( "Weapon_PKM.Chain", CHAN_AUTO, 1, "weapons/pkm/pkm_chain.ogg" )
AddSound( "Weapon_PKM.Coverdown", CHAN_AUTO, 1, "weapons/pkm/pkm_coverdown.ogg" )
AddSound( "Weapon_PKM.Coversmack", CHAN_AUTO, 1, "weapons/pkm/pkm_coversmack.ogg" )
AddSound( "Weapon_PKM.Bolt", CHAN_AUTO, 1, "weapons/pkm/pkm_bolt.ogg" )
AddSound( "Weapon_PKM.Draw", CHAN_AUTO, 1, "weapons/pkm/pkm_draw.ogg" )

-- SVT-40
AddSound( "Weapon_SVT40.single", CHAN_WEAPON, 1, "weapons/svt40/g3sg1-1.ogg" )
AddSound( "Weapon_SVT40.Cloth1", CHAN_AUTO, 1, "weapons/svt40/g3sg1_cloth1.ogg" )
AddSound( "Weapon_SVT40.Cloth2", CHAN_AUTO, 1, "weapons/svt40/g3sg1_cloth2.ogg" )
AddSound( "Weapon_SVT40.Clipout", CHAN_AUTO, 1, "weapons/svt40/g3sg1_clipout.ogg" )
AddSound( "Weapon_SVT40.Clipin", CHAN_AUTO, 1, "weapons/svt40/g3sg1_clipin.ogg" )
AddSound( "Weapon_SVT40.ClipTap", CHAN_AUTO, 1, "weapons/svt40/g3sg1_cliptap.ogg" )
AddSound( "Weapon_SVT40.SlideBack", CHAN_AUTO, 1, "weapons/svt40/g3sg1_slide_b.ogg" )
AddSound( "Weapon_SVT40.SlideForward", CHAN_AUTO, 1, "weapons/svt40/g3sg1_slide_f.ogg" )

-- SPAS-12
AddSound( "spas_12_shoty.Single", CHAN_WEAPON, 1, "weapons/spas_12/xm1014-1.ogg" )
AddSound( "spas_12_shoty.insert", CHAN_AUTO, 1, "weapons/spas_12/xm_insert.ogg" )
AddSound( "spas_12_shoty.cock", CHAN_AUTO, 1, "weapons/spas_12/xm_cock.ogg" )

-- USAS-12
AddSound( "Weapon_usas.Single", CHAN_WEAPON, 1, "weapons/usas12/xm1014-1.ogg" )
AddSound( "Weapon_usas.clipin", CHAN_AUTO, 1, "weapons/usas12/magin.ogg" )
AddSound( "Weapon_usas.clipout", CHAN_AUTO, 1, "weapons/usas12/magout.ogg" )
AddSound( "Weapon_usas.draw", CHAN_AUTO, 1, "weapons/usas12/draw.ogg" )

-- Remington 7615P
AddSound( "7615p_remington.Single", CHAN_WEAPON, 1, "weapons/7615p/scout_fire-1.ogg" )
AddSound( "7615p_bob.pump", CHAN_AUTO, 1, "weapons/7615p/m3_pump.ogg" )
AddSound( "Weapon_7615P.Clipout", CHAN_AUTO, 1, "weapons/7615p/sg550_clipout.ogg" )
AddSound( "Weapon_7615P.Clipin", CHAN_AUTO, 1, "weapons/7615p/sg550_clipin.ogg" )

-- Dragunov SVU
AddSound( "Weapon_SVU.Single", CHAN_WEAPON, 1, "weapons/svu/g3sg1-1.ogg" )
AddSound( "Weapon_svuxx.Clipin", CHAN_AUTO, 1, "weapons/svu/g3sg1_clipin.ogg" )
AddSound( "Weapon_svuxx.Clipout", CHAN_AUTO, 1, "weapons/svu/g3sg1_clipout.ogg" )
AddSound( "Weapon_svuxx.Slide", CHAN_AUTO, 1, "weapons/svu/g3sg1_slide.ogg" )

-- Winchester Model 94
AddSound( "Weapon_Win94.Single", CHAN_WEAPON, 1, "weapons/win94/scout_fire-1.ogg" )
AddSound( "Weapon_Win94.Bolt", CHAN_AUTO, 1, "weapons/win94/scout_bolt.ogg" )
AddSound( "weapons/hamburgpling.ogg", CHAN_AUTO, 1, "weapons/win94/hamburgpling.ogg" )
AddSound( "Weapon_Win94.Clipout", CHAN_AUTO, 1, "weapons/win94/scout_clipout.ogg" )

-- Striker 12
AddSound( "ShotStriker12.Single", CHAN_WEAPON, 1, "weapons/striker12/xm1014-1.ogg" )
AddSound( "ShotStriker12.Deploy", CHAN_AUTO, 1, "weapons/striker12/deploy.ogg" )
AddSound( "ShotStriker12.InsertShell", CHAN_AUTO, 1, "weapons/striker12/m3_insertshell.ogg" )

-- AW50
AddSound( "Weaponaw50.Single", CHAN_WEAPON, 1, "weapons/aw50/awp_fire.ogg" )
AddSound( "Weaponaw50.clipin", CHAN_AUTO, 1, "weapons/aw50/awp_magin.ogg" )
AddSound( "Weaponaw50.clipout", CHAN_AUTO, 1, "weapons/aw50/awp_magout.ogg" )
AddSound( "Weaponaw50.boltback", CHAN_AUTO, 1, "weapons/aw50/m24_boltback.ogg" )
AddSound( "Weaponaw50.boltforward", CHAN_AUTO, 1, "weapons/aw50/m24_boltforward.ogg" )

-- PSG-1
AddSound( "Weapon_psg_1.Single", CHAN_WEAPON, 1, "weapons/psg1/g3sg1-1.ogg" )
AddSound( "Weapon_psg_1.Back", CHAN_AUTO, 1, "weapons/psg1/psg_boltpull.ogg" )
AddSound( "Weapon_psg_1.Clipout", CHAN_AUTO, 1, "weapons/psg1/psg_clipout.ogg" )
AddSound( "Weapon_psg_1.Clipin", CHAN_AUTO, 1, "weapons/psg1/psg_clipin.ogg" )
AddSound( "Weapon_psg_1.Forward", CHAN_AUTO, 1, "weapons/psg1/psg_boltrelease.ogg" )
AddSound( "Weapon_psg_1.Deploy", CHAN_AUTO, 1, "weapons/psg1/deploy1.ogg" )

-- Contender G2
AddSound( "contender_g2.Single", CHAN_WEAPON, 1, { "weapons/g2contender/scout-1.ogg", "weapons/g2contender/scout-2.ogg", "weapons/g2contender/scout-3.ogg" } )
AddSound( "contender_g2.Draw", CHAN_AUTO, 1, "weapons/g2contender/Draw.ogg" )
AddSound( "contender_g2.Hammer", CHAN_AUTO, 1, { "weapons/g2contender/Cock-1.ogg", "weapons/g2contender/Cock-2.ogg" } )
AddSound( "contender_g2.Open", CHAN_AUTO, 1, "weapons/g2contender/open_chamber.ogg" )
AddSound( "contender_g2.Shellout", CHAN_AUTO, 1, "weapons/g2contender/Bullet_out.ogg" )
AddSound( "contender_g2.Shellin", CHAN_AUTO, 1, "weapons/g2contender/Bullet_in.ogg" )
AddSound( "contender_g2.Close", CHAN_AUTO, 1, "weapons/g2contender/close_chamber.ogg" )
AddSound( "contender_g2.Shell", CHAN_AUTO, 1, { "weapons/g2contender/pl_shell1.ogg", "weapons/g2contender/pl_shell2.ogg", "weapons/g2contender/pl_shell3.ogg", "weapons/g2contender/pl_shell4.ogg" } )

-- Barrett M98B
AddSound( "M98.Single", CHAN_WEAPON, 1, "weapons/M98/shot-1.ogg" )
AddSound( "M98_Bolt", CHAN_AUTO, 1, "weapons/M98/bolt.ogg" )
AddSound( "M98_Handle", CHAN_AUTO, 1, "weapons/M98/handle.ogg" )
AddSound( "M98_Deploy", CHAN_AUTO, 1, "weapons/M98/draw.ogg" )
AddSound( "M98_Draw", CHAN_AUTO, 1, "weapons/M98/draw_2.ogg" )
AddSound( "M98_Foley", CHAN_AUTO, 1, "weapons/M98/foley.ogg" )
AddSound( "M98_Clipout", CHAN_AUTO, 1, "weapons/M98/clipout.ogg" )
AddSound( "M98_Clipin", CHAN_AUTO, 1, "weapons/M98/clipin.ogg" )
AddSound( "M98_Boltback", CHAN_AUTO, 1, "weapons/M98/boltback.ogg" )
AddSound( "M98_Boltforward", CHAN_AUTO, 1, "weapons/M98/boltforward.ogg" )

-- Barrett M82 .50 cal
AddSound( "BarretM82.Single", CHAN_WEAPON, 1, "weapons/M82/barret50-1.ogg" )
AddSound( "Weapon_M82.Boltup", CHAN_AUTO, 1, "weapons/M82/boltup.ogg" )
AddSound( "Weapon_M82.Clipin", CHAN_AUTO, 1, "weapons/M82/clipin.ogg" )
AddSound( "Weapon_M82.Clipout", CHAN_AUTO, 1, "weapons/M82/clipout.ogg" )
AddSound( "Weapon_M82.Boltdown", CHAN_AUTO, 1, "weapons/M82/boltdown.ogg" )

-- M24
AddSound( "Dmgfok_M24SN.Single", CHAN_WEAPON, 1, "weapons/dmg_m24/awp1.ogg" )
AddSound( "Dmgfok_M24SN.Clipin", CHAN_AUTO, 1, "weapons/dmg_m24/m24_magin.ogg" )
AddSound( "Dmgfok_M24SN.Clipout", CHAN_AUTO, 1, "weapons/dmg_m24/m24_magout.ogg" )
AddSound( "Dmgfok_M24SN.Boltback", CHAN_AUTO, 1, "weapons/dmg_m24/m24_boltback.ogg" )
AddSound( "Dmgfok_M24SN.Boltforward", CHAN_AUTO, 1, "weapons/dmg_m24/m24_boltforward.ogg" )

-- SVD Dragunov
AddSound( "Weapon_svd01.Single", CHAN_WEAPON, 1, "weapons/SVD/g3sg1-1.ogg" )
AddSound( "Weapon_SVD.Foley", CHAN_AUTO, 1, "weapons/SVD/foley.ogg" )
AddSound( "Weapon_SVD.Handle", CHAN_AUTO, 1, "weapons/SVD/handle.ogg" )
AddSound( "Weapon_SVD.Clipout", CHAN_AUTO, 1, "weapons/SVD/Clipout.ogg" )
AddSound( "Weapon_SVD.Cliptap", CHAN_AUTO, 1, "weapons/SVD/Cliptap.ogg" )
AddSound( "Weapon_SVD.Clipin", CHAN_AUTO, 1, "weapons/SVD/ClipIn.ogg" )
AddSound( "Weapon_SVD.Slideback", CHAN_AUTO, 1, "weapons/SVD/SlideBack.ogg" )
AddSound( "Weapon_SVD.SlideForward", CHAN_AUTO, 1, "weapons/SVD/SlideForward.ogg" )
AddSound( "Weapon_SVD.Draw", CHAN_AUTO, 1, "weapons/SVD/Draw.ogg" )

-- HK SL8
AddSound( "Weapon_hksl8.Single", CHAN_WEAPON, 1, { "weapons/hksl8/SG552-1.ogg", "weapons/hksl8/SG552-2.ogg", "weapons/hksl8/SG552-3.ogg", "weapons/hksl8/SG552-4.ogg" } )
AddSound( "sl8.Draw", CHAN_AUTO, 1, "weapons/hksl8/draw.ogg" )
AddSound( "sl8.Safety", CHAN_AUTO, 1, "weapons/hksl8/safety.ogg" )
AddSound( "sl8.Magout", CHAN_AUTO, 1, "weapons/hksl8/magout.ogg" )
AddSound( "sl8.MagFiddle", CHAN_AUTO, 1, "weapons/hksl8/magfiddle.ogg" )
AddSound( "sl8.MagIn", CHAN_AUTO, 1, "weapons/hksl8/magin.ogg" )
AddSound( "sl8.BoltBack", CHAN_AUTO, 1, "weapons/hksl8/boltback.ogg" )
AddSound( "sl8.Boltforward", CHAN_AUTO, 1, "weapons/hksl8/boltforward.ogg" )

-- Intervention
AddSound( "Weapon_INT.Single", CHAN_WEAPON, 1, "weapons/fokku_tc_intrv/int1.ogg" )
AddSound( "Weapon_INT.Deploy", CHAN_AUTO, 1, "weapons/fokku_tc_intrv/int_deploy.ogg" )
AddSound( "Weapon_INT.Bolt", CHAN_AUTO, 1, "weapons/fokku_tc_intrv/int_bolt.ogg" )
AddSound( "Weapon_INT.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_intrv/int_clipout.ogg" )
AddSound( "Weapon_INT.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_intrv/int_clipin.ogg" )

-- Winchester 1887
AddSound( "1887winch.Single", CHAN_WEAPON, 1, "weapons/1887winchester/1887-1.ogg" )
AddSound( "1887winch.Insertshell", CHAN_AUTO, 1, "weapons/1887winchester/1887_insertshell.ogg" )
AddSound( "1887winch.Pump", CHAN_AUTO, 1, "weapons/1887winchester/1887pump1.ogg" )
AddSound( "1887pump2.Pump", CHAN_AUTO, 1, "weapons/1887winchester/1887pump2.ogg" )

-- Winchester 1897
AddSound( "Trench_97.Single", CHAN_WEAPON, 1, "weapons/1897trench/m3-1.ogg" )
AddSound( "Trench_97.Insertshell", CHAN_AUTO, 1, "weapons/1897trench/m3_insertshell.ogg" )
AddSound( "Trench_97.Pump", CHAN_AUTO, 1, "weapons/1897trench/m3_pump.ogg" )
AddSound( "Trench_07.Pump", CHAN_AUTO, 1, "weapons/1897trench/1897_deploy.ogg" )

-- Browning Auto-5
AddSound( "Weapon_a5.Single", CHAN_WEAPON, 1, "weapons/browninga5/xm1014-1.ogg" )
AddSound( "Weapon_bauto5.InsertShell", CHAN_AUTO, 1, "weapons/browninga5/xm1014_insertshell.ogg" )
AddSound( "Weapon_a5.back", CHAN_AUTO, 1, "weapons/browninga5/xm1014_check.ogg" )
AddSound( "Weapon_a5.draw", CHAN_AUTO, 1, "weapons/browninga5/xm1014_deploy.ogg" )

-- Double-barrel shotgun
AddSound( "Double_Barrel.Single", CHAN_WEAPON, 1, "weapons/dbarrel/xm1014-1.ogg" )
AddSound( "dbarrel_dblast", CHAN_WEAPON, 1, "weapons/dbarrel/dblast.ogg" )
AddSound( "Double_Barrel.InsertShell", CHAN_ITEM, 1, "weapons/dbarrel/xm1014_insertshell.ogg" )
AddSound( "Double_Barrel.barreldown", CHAN_ITEM, 1, "weapons/dbarrel/barreldown.ogg" )
AddSound( "Double_Barrel.barrelup", CHAN_ITEM, 1, "weapons/dbarrel/barrelup.ogg" )

-- Pancor Jackhammer
AddSound( "Weapon_Jackhammer.Single", CHAN_WEAPON, 0.65, "weapons/jackhammer/xm1014-1.ogg" )
AddSound( "Weapon_Jackhammer.Clipout", CHAN_AUTO, 0.65, "weapons/jackhammer/clipout.ogg" )
AddSound( "Weapon_Jackhammer.Clipin", CHAN_AUTO, 0.65, "weapons/jackhammer/magtap.ogg" )
AddSound( "Weapon_Jackhammer.Forearm", CHAN_AUTO, 0.45, "weapons/jackhammer/boltcatch.ogg" )
AddSound( "Weapon_Jackhammer.Cloth", CHAN_AUTO, 1, "weapons/jackhammer/cloth.ogg" )

-- Ithaca M37
AddSound( "IthacaM37.Single", CHAN_WEAPON, 1, "weapons/m37/m3-1.ogg" )
AddSound( "IthacaM37.Insertshell", CHAN_AUTO, 1, "weapons/m37/m3_insertshell.ogg" )
AddSound( "IthacaM37.Pump", CHAN_AUTO, 1, "weapons/m37/m3_pump.ogg" )

-- Mossberg 590
AddSound( "Mberg_590.Single", CHAN_WEAPON, 1, "weapons/590/m3-1.ogg" )
AddSound( "Mberg_590.Insertshell", CHAN_AUTO, 1, "weapons/590/m3_insertshell.ogg" )
AddSound( "Mberg_590.Pump", CHAN_AUTO, 1, "weapons/590/m3_pump.ogg" )
AddSound( "Mberg_590.Bullet", CHAN_AUTO, 1, "weapons/590/m3_bullet.ogg" )
AddSound( "Mberg_590.Draw", CHAN_AUTO, 1, "weapons/590/m3_draw.ogg" )

-- Ares Shrike
AddSound( "Weapon_shrk.Single", CHAN_WEAPON, 1, "weapons/shrike/shrike-1.ogg" )
AddSound( "Weapon_shrk.bOut", CHAN_AUTO, 1, "weapons/shrike/boxout.ogg" )
AddSound( "Weapon_shrk.Button", CHAN_AUTO, 1, "weapons/shrike/button.ogg" )
AddSound( "Weapon_shrk.cUp", CHAN_AUTO, 1, "weapons/shrike/coverup.ogg" )
AddSound( "Weapon_shrk.Bullet1", CHAN_AUTO, 1, "weapons/shrike/bullet.ogg" )
AddSound( "Weapon_shrk.bIn", CHAN_AUTO, 1, "weapons/shrike/boxin.ogg" )
AddSound( "Weapon_shrk.Bullet2", CHAN_AUTO, 1, "weapons/shrike/bullet.ogg" )
AddSound( "Weapon_shrk.cDown", CHAN_AUTO, 1, "weapons/shrike/coverdown.ogg" )
AddSound( "Weapon_shrk.Ready", CHAN_AUTO, 1, "weapons/shrike/ready.ogg" )

-- M60
AddSound( "Weapon_M_60.Single", CHAN_WEAPON, 1, ")weapons/m60/m60-1.ogg" )
AddSound( "Weapon_M_60.Coverup", CHAN_AUTO, 1, "weapons/m60/m60_coverup.ogg" )
AddSound( "Weapon_M_60.Boxout", CHAN_AUTO, 1, "weapons/m60/m60_boxout.ogg" )
AddSound( "Weapon_M_60.Boxin", CHAN_AUTO, 1, "weapons/m60/m60_boxin.ogg" )
AddSound( "Weapon_M_60.Chain", CHAN_AUTO, 1, "weapons/m60/m60_chain.ogg" )
AddSound( "Weapon_M_60.Coverdown", CHAN_AUTO, 1, "weapons/m60/m60_coverdown.ogg" )

-- M249
AddSound( "Weapon_249M.Single", CHAN_WEAPON, 1, ")weapons/m249/m249-1.wav" )
AddSound( "Weapon_249M.Coverdown", CHAN_AUTO, 1, "weapons/schmung.M249/m249_coverdown.ogg" )
AddSound( "Weapon_249M.Chain", CHAN_AUTO, 1, "weapons/schmung.M249/m249_chain.ogg" )
AddSound( "Weapon_249M.Coverup", CHAN_AUTO, 1, "weapons/schmung.M249/m249_coverup.ogg" )
AddSound( "Weapon_249M.Boxout", CHAN_AUTO, 1, "weapons/schmung.M249/m249_boxout.ogg" )
AddSound( "Weapon_Flakk249.Magin", CHAN_AUTO, 1, "weapons/schmung.M249/magin.ogg" )
AddSound( "Weapon_Flakk249.Boltpull", CHAN_AUTO, 1, "weapons/schmung.M249/boltpull.ogg" )
AddSound( "Weapon_Flakk249.Boltrel", CHAN_AUTO, 1, "weapons/schmung.M249/boltrel.ogg" )

-- M134 Minigun
AddSound( "BlackVulcan.Single", CHAN_WEAPON, 1, ")weapons/minigun/mini-1.ogg" )
AddSound( "BlackVulcan.Boxout", CHAN_AUTO, 1, ")weapons/minigun/mini_boxout.ogg" )
AddSound( "BlackVulcan.Coverup", CHAN_AUTO, 1, ")weapons/minigun/mini_coverup.ogg" )
AddSound( "BlackVulcan.Boxin", CHAN_AUTO, 1, ")weapons/minigun/mini_boxin.ogg" )
AddSound( "BlackVulcan.Chain", CHAN_AUTO, 1, ")weapons/minigun/mini_chain.ogg" )
AddSound( "BlackVulcan.Coverdown", CHAN_AUTO, 1, ")weapons/minigun/mini_coverdown.ogg" )

-- FG 42
AddSound( "FG42_weapon.Single", CHAN_WEAPON, 1, "weapons/fg42/ak47-1.ogg" )
AddSound( "FG42_weapon.Clipout", CHAN_AUTO, 1, "weapons/fg42/ak47_clipout.ogg" )
AddSound( "FG42_weapon.Clipin", CHAN_AUTO, 1, "weapons/fg42/ak47_clipin.ogg" )
AddSound( "FG42_weapon.BoltPull", CHAN_AUTO, 1, "weapons/fg42/ak47_boltpull.ogg" )

-- M1918 BAR
AddSound( "Weapon_bar1.clipin", CHAN_AUTO, 1, "weapons/jen.ak/mag.in.ogg" )
AddSound( "Weapon_bar1.clipout", CHAN_AUTO, 1, "weapons/jen.ak/mag.out.ogg" )
AddSound( "Weapon_bar1.mag.tap", CHAN_AUTO, 1, "weapons/jen.ak/mag.tap.ogg" )
AddSound( "Weapon_bar1.boltpull", CHAN_AUTO, 0.7, "weapons/jen.ak/bolt.pull.ogg" )
AddSound( "Weapon_bar1.bolt.rel", CHAN_AUTO, 0.5, "weapons/jen.ak/bolt.rel.ogg" )
AddSound( "Weapon_bar1.Single", CHAN_WEAPON, 1, "weapons/jen.ak/fire.ogg" )
AddSound( "3rd_Weapon_bar1.Single", CHAN_WEAPON, 1, "weapons/jen.ak/fire.ogg" )

-- Tactical 870
AddSound( "WepRem870.single", CHAN_WEAPON, 1, "weapons/tact870/m3-1.ogg" )
AddSound( "WepRem870.pump", CHAN_AUTO, 1, "weapons/tact870/m3_pump.ogg" )
AddSound( "WepRem870.Insertshell", CHAN_AUTO, 1, "weapons/tact870/m3_insertshell.ogg" )

-- Benelli M3
AddSound( "BenelliM3.single", CHAN_WEAPON, 1, "weapons/BenelliM3/m3-1.ogg" )
AddSound( "BenelliM3.insertshell", CHAN_AUTO, 1, "weapons/BenelliM3/m3_insertshell.ogg" )
AddSound( "BenelliM3.Pump", CHAN_AUTO, 1, "weapons/BenelliM3/m3_pump.ogg" )

-- MP40
AddSound( "mp40.single", CHAN_WEAPON, 1, "weapons/mp40/mp5-1.ogg" )
AddSound( "Weapon_mp40m9k.Clipout", CHAN_AUTO, 1, "weapons/mp40/magout.ogg" )
AddSound( "Weapon_mp40m9k.Clipin", CHAN_AUTO, 1, "weapons/mp40/magin.ogg" )
AddSound( "Weapon_mp40m9k.Slideback", CHAN_AUTO, 1, "weapons/mp40/boltback.ogg" )

-- Magpul PDR
AddSound( "MAG_PDR.Single", CHAN_WEAPON, 1, { "weapons/pdr/pdr-1.ogg", "weapons/pdr/pdr-2.ogg", "weapons/pdr/pdr-3.ogg" } )
AddSound( "Weapon_PDR.Clipin", CHAN_AUTO, 1, "weapons/pdr/pdr_clipin.ogg" )
AddSound( "Weapon_PDR.Clipin2", CHAN_AUTO, 1, "weapons/pdr/pdr_clipin2.ogg" )
AddSound( "Weapon_PDR.Boltpull", CHAN_AUTO, 1, "weapons/pdr/pdr_boltpull.ogg" )
AddSound( "Weapon_PDR.Boltrelease", CHAN_AUTO, 1, "weapons/pdr/pdr_boltrelease.ogg" )
AddSound( "Weapon_PDR.Clipout", CHAN_AUTO, 1, "weapons/pdr/pdr_clipout.ogg" )

-- KAC PDW
AddSound( "KAC_PDW.Single", CHAN_WEAPON, 1, "weapons/kac_pdw/m4a1_unsil-1.ogg" )
AddSound( "KAC_PDW.SilentSingle", CHAN_WEAPON, 1, "weapons/kac_pdw/m4a1-1.ogg" )
AddSound( "kac_pdw_001.Clipout", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_clipout.ogg" )
AddSound( "kac_pdw_001.Clipin", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_clipin.ogg" )
AddSound( "kac_pdw_001.Boltpull", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_boltpull.ogg" )
AddSound( "kac_pdw_001.Deploy", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_deploy.ogg" )
AddSound( "kac_pdw_001.Silencer_On", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_silencer_on.ogg" )
AddSound( "kac_pdw_001.Silencer_Off", CHAN_AUTO, 1, "weapons/kac_pdw/m4a1_silencer_off.ogg" )

-- MP5
AddSound( "mp5_navy_Single", CHAN_WEAPON, 1, "weapons/brightmp5/mp5-1.ogg" )
AddSound( "mp5_foley", CHAN_AUTO, 1, "weapons/brightmp5/foley.ogg" )
AddSound( "mp5_magout", CHAN_AUTO, 1, "weapons/brightmp5/magout.ogg" )
AddSound( "mp5_magin1", CHAN_AUTO, 1, "weapons/brightmp5/magin1.ogg" )
AddSound( "mp5_magin2", CHAN_AUTO, 1, "weapons/brightmp5/magin2.ogg" )
AddSound( "mp5_boltback", CHAN_AUTO, 1, "weapons/brightmp5/boltback.ogg" )
AddSound( "mp5_boltslap", CHAN_AUTO, 1, "weapons/brightmp5/boltslap.ogg" )
AddSound( "mp5_cloth", CHAN_AUTO, 1, "weapons/brightmp5/cloth.ogg" )
AddSound( "mp5_safety", CHAN_AUTO, 1, "weapons/brightmp5/safety.ogg" )

-- TEC-9
AddSound( "Weapon_Tec9.Single", CHAN_WEAPON, 1, "weapons/tec9/ump45-1.ogg" )
AddSound( "Weapon_Tec9.Magin", CHAN_AUTO, 1, "weapons/tec9/tec9_magin.ogg" )
AddSound( "Weapon_Tec9.Magout", CHAN_AUTO, 1, "weapons/tec9/tec9_magout.ogg" )
AddSound( "Weapon_Tec9.NewMag", CHAN_AUTO, 1, "weapons/tec9/tec9_newmag.ogg" )
AddSound( "Weapon_Tec9.Charge", CHAN_AUTO, 1, "weapons/tec9/tec9_charge.ogg" )

-- Kriss Vector
AddSound( "kriss_vector.Single", CHAN_WEAPON, 1, "weapons/Kriss/ump45-1.ogg" )
AddSound( "kriss_vector.Magrelease", CHAN_AUTO, 1, "weapons/Kriss/magrel.ogg" )
AddSound( "kriss_vector.Clipout", CHAN_AUTO, 1, "weapons/Kriss/clipout.ogg" )
AddSound( "kriss_vector.Dropclip", CHAN_AUTO, 1, "weapons/Kriss/dropclip.ogg" )
AddSound( "kriss_vector.Clipin", CHAN_AUTO, 1, "weapons/Kriss/clipin.ogg" )
AddSound( "kriss_vector.Boltpull", CHAN_AUTO, 1, "weapons/Kriss/boltpull.ogg" )
AddSound( "kriss_vector.unfold", CHAN_AUTO, 1, "weapons/Kriss/unfold.ogg" )

-- MP9
AddSound( "Weapon_mp9.Single", CHAN_WEAPON, 1, "weapons/mp9/tmp-1.ogg" )
AddSound( "Weapon_mp9.Clipin", CHAN_AUTO, 1, "weapons/mp9/tmp_clipin.ogg" )
AddSound( "Weapon_mp9.Clipout", CHAN_AUTO, 1, "weapons/mp9/tmp_clipout.ogg" )

-- UMP45
AddSound( "m9k_hk_ump45.Single", CHAN_WEAPON, 1, "weapons/hk_ump45/ump45-1.ogg" )
AddSound( "m9k_hk_ump45.Clipout1", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_clipout1.ogg" )
AddSound( "m9k_hk_ump45.Clipout2", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_clipout2.ogg" )
AddSound( "m9k_hk_ump45.Clipin1", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_clipin1.ogg" )
AddSound( "m9k_hk_ump45.Clipin2", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_clipin2.ogg" )
AddSound( "m9k_hk_ump45.Boltslap", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_boltslap.ogg" )
AddSound( "m9k_hk_ump45.Cloth", CHAN_AUTO, 1, "weapons/hk_ump45/ump45_cloth.ogg" )

-- P19 Bizon
AddSound( "Weapon_P19.Single", CHAN_WEAPON, 1, "weapons/p19/p90-1.ogg" )
AddSound( "Weapon_P19.Clipout", CHAN_AUTO, 1, "weapons/p19/p90_clipout.ogg" )
AddSound( "Weapon_P19.Clipin", CHAN_AUTO, 1, "weapons/p19/p90_clipin.ogg" )
AddSound( "Weapon_P19.Boltpull", CHAN_AUTO, 1, "weapons/p19/p90_boltpull.ogg" )

-- P90
AddSound( "P90_weapon.single", CHAN_WEAPON, 1, "weapons/p90_smg/p90-1.ogg" )
AddSound( "P90_weapon.unlock", CHAN_AUTO, 1, "weapons/p90_smg/p90_unlock.ogg" )
AddSound( "P90_weapon.magout", CHAN_AUTO, 1, "weapons/p90_smg/p90_magout.ogg" )
AddSound( "P90_weapon.magin", CHAN_AUTO, 1, "weapons/p90_smg/p90_magin.ogg" )
AddSound( "P90_weapon.cock", CHAN_AUTO, 1, "weapons/p90_smg/p90_cock.ogg" )

-- Sten
AddSound( "Weaponsten.Single", CHAN_WEAPON, 1, "weapons/sten/mp5-1.ogg" )
AddSound( "Weaponsten.clipout", CHAN_AUTO, 1, "weapons/sten/mp5_clipout.ogg" )
AddSound( "Weaponsten.clipin", CHAN_AUTO, 1, "weapons/sten/mp5_clipin.ogg" )
AddSound( "Weaponsten.boltpull", CHAN_AUTO, 1, "weapons/sten/mp5_boltpull.ogg" )
AddSound( "Weaponsten.boltslap", CHAN_AUTO, 1, "weapons/sten/mp5_boltslap.ogg" )
AddSound( "Weapon_stengun.Slideback", CHAN_AUTO, 1, "weapons/sten/mp5_slideback.ogg" )

-- Tommy Gun
AddSound( "Weapon_tmg.single", CHAN_WEAPON, 1, "weapons/tmg/tmg_1.ogg" )
AddSound( "Weapon_tmg.Clipout", CHAN_AUTO, 1, "weapons/tmg/tmg_magout.ogg" )
AddSound( "Weapon_tmg.Clipin", CHAN_AUTO, 1, "weapons/tmg/tmg_magin.ogg" )
AddSound( "Weapon_tmg.Boltpull", CHAN_AUTO, 1, "weapons/tmg/tmg_cock.ogg" )

-- MP7
AddSound( "Weapon_MP7.single", CHAN_WEAPON, 1, "weapons/mp7/usp1.ogg" )
AddSound( "Weapon_MP7.magout", CHAN_AUTO, 1, "weapons/mp7/mp7_magout.ogg" )
AddSound( "Weapon_MP7.magin", CHAN_AUTO, 1, "weapons/mp7/mp7_magin.ogg" )
AddSound( "Weapon_MP7.charger", CHAN_AUTO, 1, "weapons/mp7/mp7_charger.ogg" )

-- Uzi
AddSound( "Weapon_uzi.single", CHAN_WEAPON, 1, "weapons/uzi/mac10-1.ogg" )
AddSound( "imi_uzi_09mm.boltpull", CHAN_AUTO, 1, "weapons/uzi/mac10_boltpull.ogg" )
AddSound( "imi_uzi_09mm.clipin", CHAN_AUTO, 1, "weapons/uzi/mac10_clipin.ogg" )
AddSound( "imi_uzi_09mm.clipout", CHAN_AUTO, 1, "weapons/uzi/mac10_clipout.ogg" )

-- MP5SD
AddSound( "Weapon_hkmp5sd.single", CHAN_WEAPON, 1, "weapons/hkmp5sd/mp5-1.ogg" )
AddSound( "Weapon_hkmp5sd.magout", CHAN_AUTO, 1, "weapons/hkmp5sd/magout.ogg" )
AddSound( "Weapon_hkmp5sd.magfiddle", CHAN_AUTO, 1, "weapons/hkmp5sd/magfiddle.ogg" )
AddSound( "Weapon_hkmp5sd.magin", CHAN_AUTO, 1, "weapons/hkmp5sd/magin.ogg" )
AddSound( "Weapon_hkmp5sd.boltpull", CHAN_AUTO, 1, "weapons/hkmp5sd/boltpull.ogg" )
AddSound( "Weapon_hkmp5sd.boltrelease", CHAN_AUTO, 1, "weapons/hkmp5sd/boltrelease.ogg" )
AddSound( "Weapon_hkmp5sd.cloth", CHAN_AUTO, 1, "weapons/hkmp5sd/cloth.ogg" )
AddSound( "Weapon_hkmp5sd.safety", CHAN_AUTO, 1, "weapons/hkmp5sd/safety.ogg" )

-- Honey Badger
AddSound( "Weapon_HoneyB.single", CHAN_WEAPON, 1, "weapons/hb/hb_fire.ogg" )
AddSound( "Weapon_HoneyB.Magout", CHAN_AUTO, 1, "weapons/hb/magout.ogg" )
AddSound( "Weapon_HoneyB.Magin", CHAN_AUTO, 1, "weapons/hb/magin.ogg" )
AddSound( "Weapon_HoneyB.Boltcatch", CHAN_AUTO, 1, "weapons/hb/boltcatch.ogg" )
AddSound( "Weapon_HoneyB.Boltforward", CHAN_AUTO, 1, "weapons/hb/boltforward.ogg" )
AddSound( "Weapon_HoneyB.Boltback", CHAN_AUTO, 1, "weapons/hb/boltback.ogg" )

-- Colt Python
AddSound( "Weapon_ColtPython.Single", CHAN_WEAPON, 1, "weapons/coltpython/python-1.ogg" )
AddSound( "WepColtPython.clipdraw", CHAN_AUTO, 1, "weapons/coltpython/clipdraw.ogg" )
AddSound( "WepColtPython.blick", CHAN_AUTO, 1, "weapons/coltpython/blick.ogg" )
AddSound( "WepColtPython.bulletsout", CHAN_AUTO, 1, "weapons/coltpython/bulletsout.ogg" )
AddSound( "WepColtPython.bulletsin", CHAN_AUTO, 1, "weapons/coltpython/bulletsin.ogg" )

-- Raging Bull
AddSound( "weapon_r_bull.Single", CHAN_WEAPON, 1, "weapons/r_bull/r-bull-1.ogg" )
AddSound( "weapons_r_bull_bullreload_wav", CHAN_ITEM, 1, "weapons/r_bull/bullreload.ogg" )
AddSound( "weapons_r_bull_draw_gun_wav", CHAN_ITEM, 1, "weapons/r_bull/draw_gun.ogg" )

-- Smith & Wesson Model 3
AddSound( "Model3.Single", CHAN_WEAPON, 1, "weapons/model3/model3-1.ogg" )
AddSound( "Model3.Hammer", CHAN_AUTO, 1, "weapons/model3/Hammer.ogg" )
AddSound( "Model3.Break_Eject", CHAN_AUTO, 1, "weapons/model3/Break_eject.ogg" )
AddSound( "Model3.bulletout_1", CHAN_AUTO, 1, "weapons/model3/bulletout_1.ogg" )
AddSound( "Model3.bulletout_2", CHAN_AUTO, 1, "weapons/model3/bulletout_2.ogg" )
AddSound( "Model3.bulletout_3", CHAN_AUTO, 1, "weapons/model3/bulletout_3.ogg" )
AddSound( "Model3.bullets_in", CHAN_AUTO, 1, "weapons/model3/bullets_in.ogg" )
AddSound( "Model3.Break_close", CHAN_AUTO, 1, "weapons/model3/Break_CLose.ogg" )

-- M29 Satan
AddSound( "Weapon_satan1.single", CHAN_WEAPON, 1, "weapons/satan1/satan-1.ogg" )
AddSound( "Weapon_satan1.blick", CHAN_AUTO, 1, "weapons/satan1/blick.ogg" )
AddSound( "Weapon_satan1.unfold", CHAN_AUTO, 1, "weapons/satan1/unfold.ogg" )
AddSound( "Weapon_satan1.bulletsin", CHAN_AUTO, 1, "weapons/satan1/bulletsin.ogg" )
AddSound( "Weapon_satan1.bulletsout", CHAN_AUTO, 1, "weapons/satan1/bulletsout.ogg" )

-- Remington 1858
AddSound( "Remington.single", CHAN_WEAPON, 1, "weapons/remington/remington-1.ogg" )
AddSound( "Remington.cylinderhit", CHAN_AUTO, 1, "weapons/remington/cylinderhit.ogg" )
AddSound( "Remington.cylinderswap", CHAN_AUTO, 1, "weapons/remington/cylinderswap.ogg" )
AddSound( "Remington.bounce1", CHAN_AUTO, 1, "weapons/remington/bounce1.ogg" )
AddSound( "Remington.bounce1", CHAN_AUTO, 1, "weapons/remington/bounce2.ogg" )
AddSound( "Remington.bounce1", CHAN_AUTO, 1, "weapons/remington/bounce3.ogg" )
AddSound( "Remington.Hammer", CHAN_AUTO, 1, "weapons/remington/hammer.ogg" )

-- Beretta M92
AddSound( "Weapon_m92b.Single", CHAN_WEAPON, 1, ")weapons/beretta92/berettam92-1.ogg" )
AddSound( "Weapon_beretta92.Clipout", CHAN_AUTO, 1, "weapons/beretta92/berettam92_clipout.ogg" )
AddSound( "Weapon_beretta92.Clipin", CHAN_AUTO, 1, "weapons/beretta92/berettam92_clipin.ogg" )
AddSound( "Weapon_beretta92.Sliderelease", CHAN_AUTO, 1, "weapons/beretta92/berettam92_sliderelease.ogg" )
AddSound( "Weapon_beretta92.Slidepull", CHAN_AUTO, 1, "weapons/beretta92/berettam92_slidepull.ogg" )
AddSound( "Weapon_beretta92.Slideback", CHAN_AUTO, 1, "weapons/beretta92/berettam92_slideback.ogg" )

-- HK45C
AddSound( "Weapon_hk45.Single", CHAN_WEAPON, 1, "weapons/hk45/hk45-1.ogg" )
AddSound( "HK45C.Deploy", CHAN_AUTO, 1, "weapons/hk45/draw.ogg" )
AddSound( "HK45C.Magout", CHAN_AUTO, 1, "weapons/hk45/magout.ogg" )
AddSound( "HK45C.Magin", CHAN_AUTO, 1, "weapons/hk45/magin.ogg" )
AddSound( "HK45C.Release", CHAN_AUTO, 1, "weapons/hk45/sliderelease.ogg" )
AddSound( "HK45C.Slidepull", CHAN_AUTO, 1, "weapons/hk45/slidepull.ogg" )

-- USP
AddSound( "Weapon_fokkususp.Single", CHAN_WEAPON, 1, "weapons/fokku_tc_usp/fiveseven-1.ogg" )
AddSound( "Weapon_fokkususp.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_usp/fiveseven_clipout.ogg" )
AddSound( "Weapon_fokkususp.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_usp/fiveseven_clipin.ogg" )
AddSound( "Weapon_fokkususp.Slideback", CHAN_AUTO, 1, "weapons/fokku_tc_usp/fiveseven_slideback.ogg" )
AddSound( "Weapon_fokkususp.Slidepull", CHAN_AUTO, 1, "weapons/fokku_tc_usp/fiveseven_slidepull.ogg" )

-- Sig P228
AddSound( "Sauer1_P228.Single", CHAN_WEAPON, 1, "weapons/sig_p228/p228-1.ogg" )
AddSound( "Sauer1_P228.Magout", CHAN_AUTO, 1, "weapons/sig_p228/magout.ogg" )
AddSound( "Sauer1_P228.Magin", CHAN_AUTO, 1, "weapons/sig_p228/magin.ogg" )
AddSound( "Sauer1_P228.MagShove", CHAN_AUTO, 1, "weapons/sig_p228/magshove.ogg" )
AddSound( "Sauer1_P228.Sliderelease", CHAN_AUTO, 1, "weapons/sig_p228/sliderelease.ogg" )
AddSound( "Sauer1_P228.Cloth", CHAN_AUTO, 0.5, "weapons/sig_p228/cloth.ogg" )
AddSound( "Sauer1_P228.Shift", CHAN_AUTO, 1, "weapons/sig_p228/shift.ogg" )

-- Glock 18
AddSound( "Dmgfok_glock.Single", CHAN_WEAPON, 1, "weapons/dmg_glock/mac10-1.ogg" )
AddSound( "Dmgfok_glock.Clipout", CHAN_AUTO, 1, "weapons/dmg_glock/magout.ogg" )
AddSound( "Dmgfok_glock.clipin", CHAN_AUTO, 1, "weapons/dmg_glock/magin.ogg" )
AddSound( "Dmgfok_glock.Boltpull", CHAN_AUTO, 1, "weapons/dmg_glock/boltpull.ogg" )
AddSound( "Dmgfok_glock.Boltrelease", CHAN_AUTO, 1, "weapons/dmg_glock/boltrelease.ogg" )
AddSound( "Dmgfok_glock.Deploy", CHAN_AUTO, 1, "weapons/dmg_glock/mac10_deploy.ogg" )

-- Colt 1911
AddSound( "Dmgfok_co1911.Single", CHAN_WEAPON, 1, "weapons/dmg_colt1911/deagle-1.ogg" )
AddSound( "Dmgfok_co1911.Clipout", CHAN_AUTO, 1, "weapons/dmg_colt1911/draw.ogg" )
AddSound( "Dmgfok_co1911.Clipin", CHAN_AUTO, 1, "weapons/dmg_colt1911/de_clipin.ogg" )
AddSound( "Dmgfok_co1911.Slideback", CHAN_AUTO, 1, "weapons/dmg_colt1911/de_slideback.ogg" )
AddSound( "Dmgfok_co1911.Draw", CHAN_AUTO, 1, "weapons/dmg_colt1911/draw.ogg" )

-- Luger
AddSound( "Weapon_luger.Single", CHAN_WEAPON, 1, "weapons/luger/luger-1.ogg" )
AddSound( "Weapon_luger.Clipout", CHAN_AUTO, 1, "weapons/luger/luger_clipout.ogg" )
AddSound( "Weapon_luger.Clipin", CHAN_AUTO, 1, "weapons/luger/luger_clipin.ogg" )
AddSound( "Weapon_luger.Sliderelease", CHAN_AUTO, 1, "weapons/luger/luger_sliderelease.ogg" )

-- Desert Eagle
AddSound( "Weapon_TDegle.Single", CHAN_WEAPON, 1, "weapons/fokku_tc_deagle/deagle-1.ogg" )
AddSound( "Weapon_TDegle.Clipout", CHAN_AUTO, 1, "weapons/fokku_tc_deagle/de_clipout.ogg" )
AddSound( "Weapon_TDegle.Clipin", CHAN_AUTO, 1, "weapons/fokku_tc_deagle/de_clipin.ogg" )
AddSound( "Weapon_TDegle.Slideback", CHAN_AUTO, 1, "weapons/fokku_tc_deagle/de_slideback.ogg" )
AddSound( "Weapon_TDegle.Deploy", CHAN_AUTO, 1, "weapons/fokku_tc_deagle/de_deploy.ogg" )

-- Sig P229R
AddSound( "Sauer1_P228.Single", CHAN_AUTO, 1, "weapons/sig_p228/p228-1.ogg" )
AddSound( "Sauer1_P228.Magout", CHAN_AUTO, 1, "weapons/sig_p228/magout.ogg" )
AddSound( "Sauer1_P228.Magin", CHAN_AUTO, 1, "weapons/sig_p228/magin.ogg" )
AddSound( "Sauer1_P228.MagShove", CHAN_AUTO, 1, "weapons/sig_p228/magshove.ogg" )
AddSound( "Sauer1_P228.Sliderelease", CHAN_AUTO, 1, "weapons/sig_p228/sliderelease.ogg" )
AddSound( "Sauer1_P228.Cloth", CHAN_AUTO, 0.5, "weapons/sig_p228/cloth.ogg" )
AddSound( "Sauer1_P228.Shift", CHAN_AUTO, 1, "weapons/sig_p228/shift.ogg" )

-- Model 500
AddSound( "Model_500.Single", CHAN_WEAPON, 1, "weapons/model500/deagle-1.ogg" )
AddSound( "saw_model_500.Clipin", CHAN_AUTO, 1, "weapons/model500/de_clipin.ogg" )
AddSound( "saw_model_500.Clipout", CHAN_AUTO, 1, "weapons/model500/de_clipout.ogg" )
AddSound( "saw_model_500.Deploy", CHAN_AUTO, 1, "weapons/model500/de_deploy.ogg" )
AddSound( "saw_model_500.Slideback", CHAN_AUTO, 1, "weapons/model500/de_slideback.ogg" )

-- S&W 627
AddSound( "model_627perf.Single", CHAN_WEAPON, 1, "weapons/627/deagle-1.ogg" )
AddSound( "model_627perf.wheel_in", CHAN_AUTO, 1, "weapons/627/wheel_in.ogg" )
AddSound( "model_627perf.bullets_in", CHAN_AUTO, 1, "weapons/627/bullets_in.ogg" )
AddSound( "model_627perf.bulletout_3", CHAN_AUTO, 1, "weapons/627/bulletout_3.ogg" )
AddSound( "model_627perf.bulletout_2", CHAN_AUTO, 1, "weapons/627/bulletout_2.ogg" )
AddSound( "model_627perf.bulletout_1", CHAN_AUTO, 1, "weapons/627/bulletout_1.ogg" )
AddSound( "model_627perf.wheel_out", CHAN_AUTO, 1, "weapons/627/wheel_out.ogg" )

-- HK USC
AddSound( "Weapon_hkusc.Single", CHAN_WEAPON, 1, { "weapons/usc/ump45-1.ogg", "weapons/usc/ump45-2.ogg" } )
AddSound( "Weapon_hkusc.Clipout", CHAN_AUTO, 1, "weapons/usc/ump45_clipout.ogg" )
AddSound( "Weapon_hkusc.Clipin", CHAN_AUTO, 1, "weapons/usc/ump45_clipin.ogg" )
AddSound( "Weapon_hkusc.Boltslap", CHAN_AUTO, 1, "weapons/usc/ump45_boltslap.ogg" )

-- EX41
AddSound( "EX41.Pump", CHAN_AUTO, 1, "weapons/ex41/m3_pump.ogg" )
AddSound( "EX41.Insertshell", CHAN_AUTO, 1, "weapons/ex41/m3_insertshell.ogg" )
AddSound( "EX41.Draw", CHAN_AUTO, 1, "weapons/ex41/draw.ogg" )

-- RPG
AddSound( "RPGF.single", CHAN_WEAPON, 1, "GDC/Rockets/RPGF.ogg", 155 )
AddSound( "M202F.single", CHAN_WEAPON, 1, { "GDC/Rockets/M202F.ogg", "gdc/rockets/m202f2.ogg" }, 155 )
AddSound( "MATADORF.single", CHAN_WEAPON, 1, "GDC/Rockets/MATADORF.ogg", 155 )

-- Suicide bomb
AddSound( "sb.click", CHAN_AUTO, 1, "weapons/suicidebomb/c4_click.ogg" )

-- M79 grenade launcher
AddSound( "M79_launcher.close", CHAN_AUTO, 1, "weapons/M79/m79_close.ogg" )
AddSound( "M79_glauncher.barrelup", CHAN_AUTO, 1, "weapons/M79/barrelup.ogg" )
AddSound( "M79_glauncher.InsertShell", CHAN_AUTO, 1, "weapons/M79/xm_insert.ogg" )
AddSound( "M79_launcher.draw", CHAN_AUTO, 1, "weapons/M79/m79_close.ogg" )
AddSound( "40mmGrenade.Single", CHAN_WEAPON, 1, "weapons/M79/40mmthump.ogg" )
