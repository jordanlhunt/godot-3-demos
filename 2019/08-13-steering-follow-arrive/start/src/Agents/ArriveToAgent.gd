extends KinematicBody2D

onready var spriteTriangle: Sprite = get_node("TriangleGreen")
const MOUSE_JIGGLE_THRESHOLD := 3.0
var MAX_SPEED := 500.0
var movementVelocity := Vector2.ZERO
var targetToGlobalPosition := Vector2.ZERO


func _ready() -> void:
	set_physics_process(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		targetToGlobalPosition = get_global_mouse_position()
		set_physics_process(true)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		targetToGlobalPosition = get_global_mouse_position()
	# Prevent Jiggle and stop moving once arived
	if self.global_position.distance_to(targetToGlobalPosition) < MOUSE_JIGGLE_THRESHOLD:
		set_physics_process(false)
	movementVelocity = Steering.ArriveTo(
		movementVelocity, self.global_position, targetToGlobalPosition, MAX_SPEED
	)
	movementVelocity = move_and_slide(movementVelocity)
	spriteTriangle.rotation = movementVelocity.angle()
