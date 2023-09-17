extends Node

const DEFAULT_MASS := 2.0
const DEFAULT_MAX_SPEED := 500.0
const DEFAULT_SLOW_RADIUS := 200.0
const SLOW_DOWN_OFFSET := .8


static func Follow(
	velocity: Vector2,
	currentGlobalPosition: Vector2,
	targetPosition: Vector2,
	maxSpeed := DEFAULT_MASS,
	mass := DEFAULT_MASS
) -> Vector2:
	var desiredVelocity := (targetPosition - currentGlobalPosition).normalized() * maxSpeed
	var steering := (desiredVelocity - velocity) / mass
	var newVelocity := velocity + steering
	return newVelocity


static func ArriveTo(
	velocity: Vector2,
	currentGlobalPosition: Vector2,
	targetPosition: Vector2,
	maxSpeed := DEFAULT_MAX_SPEED,
	mass := DEFAULT_MASS,
	slowRadius := DEFAULT_SLOW_RADIUS
):
	var distanceToTarget := currentGlobalPosition.distance_to(targetPosition)
	var desiredVelocity := (targetPosition - currentGlobalPosition).normalized() * maxSpeed
	# Slow down around target
	if distanceToTarget < slowRadius:
		desiredVelocity *= (distanceToTarget / slowRadius) * SLOW_DOWN_OFFSET + .2

	var steering := (desiredVelocity - velocity) / mass
	var newVelocity := velocity + steering
	return newVelocity
