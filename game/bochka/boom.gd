extends Node2D

# Предположим, что у вас есть объект CPUParticles2D и Timer в вашем узле.
@onready var cpu_particles = $CPUParticles2D
@onready var timer = $Timer
@onready var timer2 = $Timer2
func _ready():
	# Установите таймер на желаемое время и начните его.
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.start()
	cpu_particles.emitting = false
	cpu_particles.one_shot = true

func _process(delta):
	# Проверьте, истекло ли время таймера.
	if timer.time_left <= 0:
		# Удалите объекты.
		for child in get_children():
			if child.name != "CPUParticles2D" and child.name != "Timer":
				child.queue_free()
		
	if timer.time_left <= 0:
		cpu_particles.emitting = true
