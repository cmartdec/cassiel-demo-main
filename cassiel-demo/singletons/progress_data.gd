extends Node

const SAVE_PATH = "user://demo_save.json"


var settings:Dictionary = {
	"volume":{
		"master": 0.5,
		"sound": 0.75,
		"music": 0.25
	}
}


func _ready():
	apply_settings()
	load_game_file()

func save():
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(settings))
	
	save_file.close()

func apply_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(settings.volume.master))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear2db(settings.volume.sound))
	

func load_game_file():
	var save_file = File.new()
	
	save_file.open(SAVE_PATH, File.READ)
	
	var saved_settings:Dictionary = parse_json(save_file.get_line())
	
	settings = Utils.merge_dictionaries(settings, saved_settings)
	
	save_file.close()





