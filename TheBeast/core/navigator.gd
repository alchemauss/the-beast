extends LinkButton


func _on_new_game_pressed():
	game.lives = 3
	game.coins = 0
	game.collected = 0
	game.last_stage = 1
	return get_tree().change_scene("res://zones/stage_1.tscn")


func _on_main_menu_pressed():
	return get_tree().change_scene("res://screens/main_menu/main_menu.tscn")


func _on_continue_pressed():
	return get_tree().change_scene("res://zones/stage_" + str(game.last_stage) + ".tscn")


func _on_quit_game_pressed():
	get_tree().quit()
