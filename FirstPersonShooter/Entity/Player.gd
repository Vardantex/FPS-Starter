extends KinematicBody


var canShoot = true

#stats
var curHp = 10 
var maxHp = 10 
var ammo = 15 
var score = 0 

#physics 
var moveSpeed = 5.0
var jumpForce = 5.0
var gravity = 12.0

#cam look limit
var minLookAngle = -90
var maxLookAngle = 90
var lookSensitivity = 10 

#vectors
var vel = Vector3()
var mouseData = Vector2()

#components
onready var camera = get_node("Camera")
onready var muzzle = get_node("Camera/Muzzle")
onready var bulletScene = load("res://Particles/Bullet.tscn")


func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("RESTART"):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("EXIT"):
		get_tree().quit()
	
	#reset x and z velocity 
	vel.x = 0
	vel.z = 0 
	
	var input = Vector2()
	
	#movement inputs 
	if Input.is_action_pressed("WASD_FORWARD"):
		input.y -= 1
	if Input.is_action_pressed("WASD_BACK"):
		input.y += 1
	if Input.is_action_pressed("WASD_LEFT"):
		input.x -= 1
	if Input.is_action_pressed("WASD_RIGHT"):
		input.x += 1
	
	input = input.normalized()
	
	#Get the forward and right directions 
	var forward = global_transform.basis.z
	var right =  global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
	#set the velocity 
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	#apply gravity 
	vel.y -= gravity * delta
	
	#moce the player (velocity, ground normal)
	vel = move_and_slide(vel, Vector3.UP)
	
	#jump action 
	if Input.is_action_pressed("JUMP") and is_on_floor():
		vel.y = jumpForce
	
	pass

func _process(delta: float) -> void:
	
	#rorate the cam along x axis [up and down]
	camera.rotation_degrees.x -= mouseData.y * lookSensitivity * delta
	
	#set a limit for camera rotation x
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	
	#rotate the cam along y axis (left right)
	rotation_degrees.y -= mouseData.x * lookSensitivity * delta
	
	#Check if shot was taken 
	if Input.is_action_pressed("SHOOT") and ammo > 0:
		if canShoot == true:
			shoot()
	
	
	
	
	pass
	

#Detects keyboard input
func _input(event: InputEvent) -> void:
	#Tracks the mouse motion
	if event is InputEventMouseMotion:
		mouseData = event.relative
	

func bulletInterval():
	canShoot = true
	pass 
	

func shoot():
	$Interval.start()
	
	var bullet = bulletScene.instance() 
	get_node("/root/MainScene").add_child(bullet)
	
	#set the location of the bullet to the muzzle
	bullet.global_transform = muzzle.global_transform
	
	ammo -=1
	canShoot = false
	

func _ready() -> void:
	
	#hide the mouse cursur and lock in center
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	pass
