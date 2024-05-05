extends Area2D




@export_enum("Apple", "Banana", "Cherry", "Kiwi", "Melon", "Orange", "Pineapple", "Strawberry") var fruit_name:String
@export var collected_ani:StringName = "Collected"
@export var value:int = 1
@export var delay:int = 1

func _ready():
	$AnimatedSprite2D.play(fruit_name)

func _on_body_entered(body):
	$AnimatedSprite2D.play(collected_ani)
	GameManger.add_points(value)
	


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Collected":
		queue_free()
