extends KinematicBody


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





func _ready() -> void:
	pass
