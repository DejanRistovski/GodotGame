extends Area3D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node3D) -> void:
	game_manager.add_points(1)
	queue_free()
