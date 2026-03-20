extends Node
class_name Saveload
static var saveloadscene: Saveload = null
var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)


func _ready() -> void:
	saveloadscene = self
	load_game()
func save_game():
	#var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var id = 0

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		if !save_nodes[id].has_method("loaddata"):
			
			continue
		
		save_nodes[id].loaddata(node_data)
	
		id += 1
	
#func reset_checkpoint():
	#var dir = DirAccess.open("user://")
	#if dir.file_exists("savegame.save"):
		#dir.remove("savegame.save")
		#return true
	#return false

#func reset_and_reload():
	
