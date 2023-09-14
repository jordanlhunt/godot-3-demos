extends KinematicBody2D

onready var spriteTriangle: Sprite = get_node("TriangleRed")
var MAX_SPEED := 500.0
var movementVelocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	var targetGlobalPosition: Vector2 = get_global_mouse_position()
	movementVelocity = Steering.Follow(
		movementVelocity, self.global_position, targetGlobalPosition, MAX_SPEED
	)
	move_and_slide(movementVelocity)
