
function SineArm (scene) {
	this.scene = scene;
	
	this.material = new THREE.ShaderMaterial({
		uniforms: 
		{
			time: 
			{
				type: "f",
				value: 0.0
			}
		},
		vertexShader: $('#vertexshader').text(),
		fragmentShader: $('#fragmentshader').text() });
	
	this.mesh = new THREE.Mesh(new THREE.CylinderGeometry(5, 0.1, 100, 10, 10, false), this.material);
	this.mesh.position.x = Math.random() * width - width/2;
	this.mesh.position.y = Math.random() * height - height/2;
	this.scene.add(this.mesh);

	
	this.printMessage = function() {
		console.log("hey there");
	}
	
	this.rotate = function() {
		this.material.uniforms['time'].value -= 0.1;
		//this.mesh.rotation.x += 0.01;
		//this.mesh.rotation.y += 0.01;
	}
}

