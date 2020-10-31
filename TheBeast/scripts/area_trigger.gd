extends Area2D

export (String) var scene_name = "stage_1"


func _on_coin_body_entered(_body):
	game.collected += 1
	get_parent().remove_child(self)


func _on_checkpoint_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	if body.get_name() == "player":
		if current_scene == scene_name:
			game.lives -= 1
			game.collected = 0
			current_scene = get_tree().reload_current_scene()
		elif scene_name == "win_screen":
			current_scene = get_tree().change_scene("res://screens/win_screen.tscn")
		else:
			game.coins += game.collected
			game.collected = 0
			game.last_stage += 1
			print(game.last_stage)
			current_scene = get_tree().change_scene("res://zones/" + scene_name + ".tscn")

		if game.lives == 0:
			current_scene = get_tree().change_scene("res://screens/game_over/game_over.tscn")
			game.lives = 3
			game.collected = 0
