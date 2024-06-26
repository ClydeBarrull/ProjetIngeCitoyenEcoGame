extends Node2D

class_name LeafCurtain

signal Hiding

@onready var upper : AnimationPlayer = $UpperCurtain/AnimationPlayer
@onready var lower : AnimationPlayer = $LowerCurtain/AnimationPlayer

func play():
	upper.play("LowerTheCurtain")
	lower.play("LowerTheCurtain")
	await get_tree().create_timer(upper.current_animation_length / 2).timeout
	Hiding.emit()
