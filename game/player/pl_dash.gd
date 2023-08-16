extends CharacterBody2D

class_name Player




var SPEED = 170.0
var JUMP_VELOCITY = -250.0
var DOUBLE_JUMP_VELOCITY = -200.0
var fast_fell = false
var can_double_jump = false

var right_left = true

@onready var camera = $Camera2D
@onready var anim_sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
#	print(get_tree().get_nodes_in_group("Player")[0])

func _physics_process(delta):
	Global.add_pos(global_transform.origin)
	if Input.is_action_just_pressed("+"):
		if camera.zoom[0] < 10 or camera.zoom[1] < 10:
			camera.zoom[0] += 1
			camera.zoom[1] += 1
	if Input.is_action_just_pressed("-"):
		if camera.zoom[0] != 0.5 or camera.zoom[1] != 0.5:
			camera.zoom[0] -= 1
			camera.zoom[1] -= 1
	
	if right_left:
		anim_sprite.flip_h = true
	else:
		anim_sprite.flip_h = false
	
	if not is_on_floor():
		velocity.y += gravity * delta

		# check for double jump
		if can_double_jump and Input.is_action_pressed("space"):
			velocity.y = DOUBLE_JUMP_VELOCITY
			can_double_jump = false
	else:
		can_double_jump = true
	
		if Input.is_action_pressed("space"):
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
		
	if not is_on_floor():
		if velocity.y > 0 and not fast_fell:
			velocity.y += 100
			fast_fell = true
	else:
		fast_fell = false
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x == 0:
		anim_sprite.play("idle")
	else:
		if(velocity.x > 0):
			right_left = false
			anim_sprite.play("walk")
		else:
			right_left = true
			anim_sprite.play("walk")

	move_and_slide()
