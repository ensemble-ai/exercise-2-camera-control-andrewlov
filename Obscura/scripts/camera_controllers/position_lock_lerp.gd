class_name PositionLockLerp
extends CameraControllerBase

@export var follow_speed:float #0.5 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2)) #slower
@export var catchup_speed:float #0.8 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2))#faster
@export var leash_distance:float = 12


func _ready() -> void:
	draw_camera_logic = true
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
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var direction
	
	var tpos = target.global_position
	var cpos = global_position
	var distance = sqrt(pow(cpos.x - tpos.x, 2) + pow(cpos.z - tpos.z, 2)) #pos.distance_to(tpos)
	
	
	follow_speed = 0.6 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2))
	catchup_speed = 90
	# while the vessel is moving, implement that speed to be that of the follow_speed * direction * delta
	if distance > leash_distance:
		if target.velocity != Vector3.ZERO:
			global_position += target.velocity * delta
		else:
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
	# once the vessel stops moving, implement that speed to be catchup_speed * delta * direction
	else: 
		if target.velocity == Vector3.ZERO:
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
		else:
			direction = (tpos - cpos).normalized()
			global_position += direction * follow_speed * delta
	
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
