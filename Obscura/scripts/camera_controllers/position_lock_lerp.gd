class_name PositionLockLerp
extends CameraControllerBase


@export var box_width:float = 10.0
@export var box_height:float = 10.0
@export var follow_speed:float = 3#target.velocity.x#0.5 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2)) #slower
@export var catchup_speed:float = 3#target.velocity.z#0.8 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2))#faster
@export var leash_distance:float = 10.0

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void: #implement lerp own lerp all in this function
	# get the vector difference of the camera and target positions, normalize for direction, multiply to get the smooth follow speed
	# how far you are ahead of leash
	# (tpos - cpos ).normalize to get direction, direction * delta * followspeed
	# beyond leash distance, get distance and go in direction of player instead to correct the overcorrection
	# follow speed: if player is moving
	# catchup speed,: player is stationary (check with target.velocity which is vector3, compare to vec3 of 0,0,0), camera moves to vessel position, move global position of camera
	# timer interruption for catchup delay, if the timer isnt null and check velocity as well
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	# while the vessel is moving, implement that speed to be that of the follow_speed * direction * delta
	# once the vessel stops moving, implement that speed to be catchup_speed * delta * direction
	var distance = cpos.distance_to(tpos)
	print(distance)
	print(target.velocity)
	var direction = (tpos - cpos).normalized()
	
	var speed: float
	if not(target.velocity.x == 0 and target.velocity.z == 0):
		speed = follow_speed
	else:
		speed = catchup_speed

	#boundary checks
	#left
	if distance > leash_distance: # break the leash, must catch up
		#if target.velocity.x == 0 and target.velocity.z == 0:
			#global_position += direction * catchup_speed * delta
		global_position = direction * lerp(global_position, target.global_position, catchup_speed * delta)
	else:
		if target.velocity.x == 0 and target.velocity.z == 0:
			global_position = direction * lerp(global_position, target.global_position, catchup_speed * delta)
		else:
			global_position = direction * lerp(global_position, target.global_position, follow_speed * delta)
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var cross_size: float = 5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-cross_size/2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(cross_size/2, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -cross_size/2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, cross_size/2))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()


func lerp(start: Vector3, end: Vector3, alpha: float) -> Vector3:
	return Vector3(
		start.x + (end.x - start.x) * alpha,
		start.y + (end.y - start.y) * alpha,
		start.z + (end.z - start.z) * alpha,
	)
