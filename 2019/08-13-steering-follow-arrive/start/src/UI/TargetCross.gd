extends Area2D

onready var animationPlayerNode: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	connect("body_entered", self, "OnBodyEntered")
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		animationPlayerNode.play("FadeIn")


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		self.global_position = get_global_mouse_position()


func OnBodyEntered(body: PhysicsBody2D) -> void:
	animationPlayerNode.play("FadeOut")
