/mob/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"
	set hidden = 1
	if(!usr.client.holder)
		return

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'>Speech is currently admin-disabled.</span>")
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return
	log_prayer("[src.key]/([src.name]): [msg]")
//	if(usr.client)
//		if(usr.client.prefs.muted & MUTE_PRAY)
//			to_chat(usr, "<span class='danger'>I cannot pray (muted).</span>")
//			return
//		if(src.client.handle_spam_prevention(msg,MUTE_PRAY))
//			return

	var/mutable_appearance/cross = mutable_appearance('icons/obj/storage.dmi', "bible")
	var/font_color = "purple"
	var/prayer_type = "PRAYER"
	var/deity
	if(ishuman(src))
		var/mob/living/carbon/human/human_user = src
		deity = human_user.patron.name
	if(usr.job == "Chaplain")
		cross.icon_state = "kingyellow"
		font_color = "blue"
		prayer_type = "CHAPLAIN PRAYER"
		if(GLOB.deity)
			deity = GLOB.deity
	else if(isliving(usr))
		var/mob/living/L = usr
		if(HAS_TRAIT(L, TRAIT_SPIRITUAL))
			cross.icon_state = "holylight"
			font_color = "blue"
			prayer_type = "SPIRITUAL PRAYER"

	var/msg_tmp = msg
	msg = "<span class='adminnotice'>[icon2html(cross, GLOB.admins)]<b><font color=[font_color]>[prayer_type][deity ? " (to [deity])" : ""]: </font>[ADMIN_FULLMONTY(src)] [ADMIN_SC(src)]:</b> <span class='linkify'>[msg]</span></span>"

	for(var/client/C in GLOB.admins)
		if(C.prefs.chat_toggles & CHAT_PRAYER)
			to_chat(C, msg)
			if(C.prefs.toggles & SOUND_PRAYERS)
				if(usr.job == "Priest")
					SEND_SOUND(C, sound('sound/blank.ogg'))

	for(var/mob/M in GLOB.dead_mob_list)
		if(!M.client)
			continue
//		var/T = get_turf(src)
		if(M.stat == DEAD)
			var/client/J = M.client
			to_chat(J, msg)

	to_chat(usr, "<span class='info'>I pray to the gods: \"[msg_tmp]\"</span>")

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Prayer") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	//log_admin("HELP: [key_name(src)]: [msg]")

/proc/CentCom_announce(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=orange>CENTCOM:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_CENTCOM_REPLY(Sender)]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)


/proc/Syndicate_announce(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=crimson>SYNDICATE:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_SYNDICATE_REPLY(Sender)]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)


/proc/Nuke_request(text , mob/Sender)
	var/msg = copytext(sanitize(text), 1, MAX_MESSAGE_LEN)
	msg = "<span class='adminnotice'><b><font color=orange>NUKE CODE REQUEST:</font>[ADMIN_FULLMONTY(Sender)] [ADMIN_CENTCOM_REPLY(Sender)] [ADMIN_SET_SD_CODE]:</b> [msg]</span>"
	to_chat(GLOB.admins, msg)


/mob/proc/roguepray(msg as text)
//	set category = "IC"
//	set name = "Pray"
//	set hidden = 1
//	if(!usr.client.holder)
//		return
//
//	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	// Make it show only for admins, linked so that it's easier for them to jump to the person praying
	message_admins("[src.key]/([src.real_name]) [ADMIN_JMP(src)] prays: <span class='info'>[msg]</span>")

	// Log the prayer to file
	log_prayer("<span class='info'>[src.key]/([src.real_name]) prays: [msg]</span>")

/*	for(var/client/C in GLOB.admins)
//		if(C.prefs.chat_toggles & CHAT_PRAYER)
///			to_chat(C, msg)

	for(var/client/J in GLOB.clients)
		if(!J.mob)
			continue
//		var/T = get_turf(src)
		var/go = FALSE
		if(isliving(J.mob))
			var/mob/living/M = J.mob
			if(M.stat == DEAD)
				go = TRUE
		if(isobserver(J.mob))
			go = TRUE
		if(istype(J.mob, /mob/dead/new_player))
			go = TRUE
		if(!go)
			continue
		to_chat(J, msg)
*/
