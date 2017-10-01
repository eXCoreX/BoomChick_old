extends KinematicBody2D

const maxSpeed = 300;
const verticalAcceleration = 50;
const maxGravity = 200;
const horizontalAcceleration = 100;
const jumpstartvelocity = 100;
const rotateOffset = 0.02
var isLeft = true;
var isLeftFp = true;
var acceleration = Vector2(0,0);

func _ready():
	set_process(true);
	pass

func _process(delta):
	var mpos = get_viewport().get_mouse_pos();
	var BS = get_node("BoomStick")
	var BSpos = BS.get_pos()
	var BSgpos = BS.get_global_pos()
	var Ch = get_node("Chick")
	var Chgpos = Ch.get_global_pos()
	BS.look_at(mpos)
	BS.rotate(0.5 * PI)
	var angle = BS.get_global_rot()
	
	if( (angle > -0.5*PI) and (angle < 0.5*PI) ):
		isLeft = true
	elif( abs(angle) > 0.4*PI ):
		isLeft = false
	
	# //TODO: проверять не находится ли курсор между BSgpos.x и симметричным иксом относительно Chgpos.x
	if(isLeft):
		if !(isLeftFp):
			BS.set_flip_v(false)
			Ch.set_flip_h(false)
			BS.set_pos(Vector2(-abs(BS.get_pos().x), BS.get_pos().y))
			isLeftFp = true
		BS.rotate(rotateOffset)
	
	elif(!isLeft):
		if (isLeftFp):
			BS.set_flip_v(true)
			Ch.set_flip_h(true)
			BS.set_pos(Vector2(abs(BS.get_pos().x), BS.get_pos().y))
			isLeftFp = false
		BS.rotate(-rotateOffset)
	
	print(angle)
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