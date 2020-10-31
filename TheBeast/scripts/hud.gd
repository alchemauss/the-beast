extends Control


func _process(_delta):
	var huds = self.get_children()[0].get_children()
	huds[0].text = "Lives: " + str(game.lives)
	huds[1].text = "Coins: " + str(game.coins + game.collected)
