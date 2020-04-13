extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
#func _ready():
#

func change_velocity(accel):
	velocity.x += accel / 60.0
	
var started_time = false
var time = 0

var previous_calculated_position = 0
var calculated_position = 0

func  my_lerp(start,end,amt):
	return (1-amt)*start+amt*end

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right"):
		print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
		print("press calculated_position %s" % calculated_position)
		
		$Tween.interpolate_property(self, "calculated_position", 0, 64, 1, Tween.TRANS_EXPO)
		$Tween.start()
		started_time = true
	elif Input.is_action_just_pressed("ui_left"):
#		change_velocity(16)
		
		$Tween.interpolate_property(self, "calculated_position", position.x, position.x - 64, 1, Tween.TRANS_EXPO)
		$Tween.start()

		started_time = true
#	else:
#		velocity = Vector2.ZERO
		


	if started_time:
		time += delta
		print("time: %s" % time)
		print("calculated_position %s" % calculated_position)
		print("calc_vel %s" % calc_vel(previous_calculated_position, calculated_position, delta))
		velocity.x = calc_vel(previous_calculated_position, calculated_position, delta)
		print("real position %s" % position)
		previous_calculated_position = calculated_position
		
		if time > 1:
			velocity = Vector2.ZERO
			started_time = false
			previous_calculated_position = 0
			calculated_position = 0
			time = 0
			print("finish calculated_position %s" % calculated_position)

	velocity = move_and_slide(velocity)
	

func calc_vel(s0, sf, delta):
	return (sf - s0) / delta
