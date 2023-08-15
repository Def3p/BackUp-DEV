extends CharacterBody2D

class_name Player

var SPEED = 170.0
var JUMP_VELOCITY = -250.0
var fast_fell = false

@onready var anim_sprite = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor() and Input.is_action_pressed("space"):
		velocity.y = JUMP_VELOCITY
		
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
			anim_sprite.flip_h = true
			anim_sprite.play("walk")
		else:
			anim_sprite.flip_h = false
			anim_sprite.play("walk")

	move_and_slide()
	
	

