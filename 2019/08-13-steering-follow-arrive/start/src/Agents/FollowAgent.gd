extends KinematicBody2D
onready var spriteTriangle: Sprite = get_node("TriangleRed")
onready var followTarget := get_node(targetPath)
const ARRIVAL_THRESHOLD := 3.0
export var targetPath := NodePath()
var followDistanceOffset := 115.0
var followGlobalPositionOffset := Vector2.ZERO
var MAX_SPEED := 500.0
var movementVelocity := Vector2.ZERO


func _physics_process(delta: float) -> void:
	# Safeguard against uninitalized target
	if followTarget == self:
		set_physics_process(false)
	var targetGlobalPosition: Vector2 = followTarget.global_position
	var distanceToTarget := self.global_position.distance_to(targetGlobalPosition)
	# Prevent Jiggle
	if distanceToTarget < ARRIVAL_THRESHOLD:
		return
	# If close enough to target just stay there
	if distanceToTarget > followDistanceOffset:
		followGlobalPositionOffset = (
			targetGlobalPosition
			- (targetGlobalPosition - self.global_position).normalized() * followDistanceOffset
		)
	else:
		followGlobalPositionOffset = self.global_position
	movementVelocity = Steering.ArriveTo(
		movementVelocity, self.global_position, followGlobalPositionOffset, MAX_SPEED, 5, 200.0
	)
	move_and_slide(movementVelocity)
	spriteTriangle.rotation = movementVelocity.angle()
