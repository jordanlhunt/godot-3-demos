extends Node

const DEFAULT_MASS := 2.0
const DEFAULT_MAX_SPEED := 200.0


static func Follow(
	velocity: Vector2,
	currentGlobalPosition: Vector2,
	targetPosition: Vector2,
	maxSpeed := DEFAULT_MASS,
	mass := DEFAULT_MASS
) -> Vector2:
	var desiredVelocity := (targetPosition - currentGlobalPosition).normalized() * maxSpeed
	var streeing := (desiredVelocity - velocity) / mass
	var newVelocity := velocity + streeing
	return newVelocity
