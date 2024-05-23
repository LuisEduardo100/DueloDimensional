extends Area2D


@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("orange")
	
func _on_area_entered(area):
	if Player:
		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector2(0, -20), 0.5)
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		tween.tween_callback(self.queue_free)
