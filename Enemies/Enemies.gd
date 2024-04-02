extends Entity
class_name Enemy


var ghost_scene = preload("res://Character/Ghost.tscn")
var jump_sound = preload("res://Sounds/Sound/Jump.wav")
@onready var edge_check_right = $Edge_Check_Right
@onready var edge_check_left = $Edge_Check_Left
@export var enemy_speed:int = 200

	
func _ready():
	health = max_health
	if randf_range(-1, 1) > 0:
		direction = 1
	else:
		direction = -1
	speed = enemy_speed
		
func _physics_process(delta):
	flip_sprite()
	update_animation()
	var found_wall = is_on_wall()
	var found_edge = not edge_check_right.is_colliding() or not  edge_check_left.is_colliding()
	if found_wall or found_edge:
		direction *= -1

	if is_dead:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity  * delta
		
	elif jump_count != 0:
		jump_count = 0
	if !is_stunned && Engine.time_scale != 0:
		if direction:
			velocity.x = direction * speed

	move_and_slide()
	check_collisions()
				
func add_ghost():
	var ghost = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	ghost.global_position = global_position
	ghost.play(sprite_2d.animation)
	ghost.flip_h = sprite_2d.flip_h
	ghost.sprite_2d.frame = sprite_2d.frame

func flip_sprite():
	if is_stunned || is_dead:
		return
	if velocity.x != 0:
		if velocity.x > 1:
			sprite_2d.flip_h = 1
		if velocity.x < -1:
			sprite_2d.flip_h = 0