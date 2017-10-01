extends KinematicBody2D

const maxSpeed = 300;
const verticalAcceleration = 50;
const maxGravity = 200;
const horizontalAcceleration = 100;
const jumpstartvelocity = 100;

var acceleration = Vector2(0,0);

func _ready():
	set_process(true);
	pass

func _process(delta):
	var vel = Vector2(0,0);
	if(Input.is_action_pressed("Left")):
		#vel.x = -speed*delta;
		acceleration.x += -horizontalAcceleration*delta;
		pass
	
	if(Input.is_action_pressed("Right")):
		acceleration.x += horizontalAcceleration*delta;
		pass
		
	
	#if(Input.is_action_pressed("Up") && is_colliding()):
	#	vel.y = -jumpstartvelocity;
	if(is_colliding()):
		#print(get_collision_normal().dot(Vector2(0, -1)));
		if(get_collision_normal().dot(Vector2(0, -1)) < 5):
			acceleration.y = 0;
		else:
			acceleration.y += verticalAcceleration*delta;
		acceleration = get_collision_normal().slide(acceleration);
	else:
		acceleration.y += verticalAcceleration*delta;
		
	vel = acceleration*delta;
	vel.x = clamp(vel.x, -maxSpeed, maxSpeed);
	vel.y = clamp(vel.y, -maxGravity, maxGravity);
	
	move(vel);
	pass