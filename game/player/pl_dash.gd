extends CharacterBody2D

class_name Player

var SPEED = 170
var norm_SPEED = 170
var dash_SPEED = 1500

var fast_fell = false
var JUMP_VELOCITY = -280.0
var jump_add = 1
var jump_count = 0
var push_force = 30.0
var right_left = true

@onready var camera = $Camera2D
@onready var anim_sprite = $AnimatedSprite2D
@onready var dash = $dash

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
#	print(get_tree().get_nodes_in_group("Player")[0])

func _physics_process(delta):
	if Global.hp_input() < 1:
		get_tree().reload_current_scene()
		Global.regen(100)
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
	
	if Input.is_action_just_pressed("space") and jump_count < jump_add:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	if is_on_floor():
		jump_count = 0
		
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
	
	if Input.is_action_just_pressed("shift"):
		SPEED = dash_SPEED
		dash.start()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D: 
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

	
func _on_dash_timeout():
	SPEED = norm_SPEED
