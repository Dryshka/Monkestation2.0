/// Location where we save the information about how many rounds it has been since the engine blew up
#define DELAMINATION_COUNT_FILEPATH "data/rounds_since_delamination.txt"
#define DELAMINATION_HIGHSCORE_FILEPATH "data/delamination_highscore.txt"
#define TRAM_COUNT_FILEPATH "data/tram_hits_last_round.txt"

/datum/controller/subsystem/persistence/proc/load_delamination_counter()
	if (!fexists(DELAMINATION_COUNT_FILEPATH))
		return
	rounds_since_engine_exploded = text2num(file2text(DELAMINATION_COUNT_FILEPATH))
	if (fexists(DELAMINATION_HIGHSCORE_FILEPATH))
		delam_highscore = text2num(file2text(DELAMINATION_HIGHSCORE_FILEPATH))
	for (var/obj/machinery/incident_display/sign as anything in GLOB.map_delamination_counters)
		sign.update_delam_count(rounds_since_engine_exploded, delam_highscore)


/datum/controller/subsystem/persistence/proc/save_delamination_counter()
	rustg_file_write("[rounds_since_engine_exploded + 1]", DELAMINATION_COUNT_FILEPATH)
	if((rounds_since_engine_exploded + 1) > delam_highscore)
		rustg_file_write("[rounds_since_engine_exploded + 1]", DELAMINATION_HIGHSCORE_FILEPATH)


/datum/controller/subsystem/persistence/proc/load_tram_counter()
	if(!fexists(TRAM_COUNT_FILEPATH))
		return
	tram_hits_last_round = text2num(file2text(TRAM_COUNT_FILEPATH))

/datum/controller/subsystem/persistence/proc/save_tram_counter()
		rustg_file_write("[tram_hits_this_round]", TRAM_COUNT_FILEPATH)

#undef DELAMINATION_COUNT_FILEPATH
#undef DELAMINATION_HIGHSCORE_FILEPATH
#undef TRAM_COUNT_FILEPATH
