extends KinematicBody2D

export (int) var SPEED = 400
export (int) var GRAVITY = 1200
export (int) var JUMP_SPEED = -400

const UP = Vector2(0, -1)

onready var sprite = self.get_node("texture")

var velocity = Vector2()
var jump_counter = 0
var teleported = false


func check_collision():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		return collision.collider is TileMap


func teleport_player():
	if Input.get_action_strength("right"):
		self.position.x += 240
		if check_collision():
			self.position.y -= 50

	elif Input.get_action_strength("left"):
		self.position.x -= 240
		if check_collision():
			self.position.y -= 50


func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_Z:
			if event.pressed and not teleported:
				Engine.time_scale = 0.25
			else:
				Engine.time_scale = 1
		if event.scancode == KEY_X:
			if event.pressed and not teleported:
				teleported = true
				teleport_player()
				Engine.time_scale = 1
		if event.scancode == KEY_ESCAPE:
			get_tree().paused = event.pressed


func get_input():
	velocity.x = 0
	if Input.is_action_just_pressed("jump") and jump_counter < 1:
		jump_counter += 1
		velocity.y = JUMP_SPEED
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED


func _physics_process(delta):
	get_input()
	if is_on_floor():
		jump_counter = 0
		teleported = false
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, UP)


func _process(_delta):
	if velocity.y != 0:
		if velocity.x != 0:
			sprite.flip_h = velocity.x <= 0
		if velocity.y < 0:
			if jump_counter != 0:
				sprite.play("jump_roll")
			else:
				sprite.play("jumping")
		else:
			sprite.play("falling")
	elif velocity.x != 0:
		sprite.play("walk")
		sprite.flip_h = velocity.x <= 0
	else:
		sprite.play("idle")


func _ready():
	set_process_input(true)
