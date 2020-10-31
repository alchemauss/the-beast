extends Node

const SaveGame = preload("res://core/save/save_game.gd")

var SAVE_FOLDER := "res://debug/save"
var SAVE_NAME := "beast_game_%03d.save"

var error: int = 0


func save(id: int):
	var save_game = SaveGame.new()
	save_game.game_version = ProjectSettings.get_setting("application/config/version")
	for node in get_tree().get_nodes_in_group("save"):
		node.save(save_game)

	var directory := Directory.new()
	if not directory.dir_exists(SAVE_FOLDER):
		error = directory.make_dir_recursive(SAVE_FOLDER)

	var save_path = SAVE_FOLDER.plus_file(SAVE_NAME % id)
	error = ResourceSaver.save(save_path, save_game)
	if error != OK:
		print("There was an issue writing the save %s to %s" % [id, save_path])


func load(id: int):
	var save_file_path := SAVE_FOLDER.plus_file(SAVE_NAME % id)
	var file := File.new()
	if not file.file_exists(save_file_path):
		return print("Save file %s doesn't exist" % save_file_path)

	var save_game := load(save_file_path)
	for node in get_tree().get_nodes_in_group("save"):
		node.load(save_game)
