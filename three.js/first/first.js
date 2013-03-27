var width = window.innerWidth;
var height = window.innerHeight;

var scene = new THREE.Scene();
var camera = new THREE.OrthographicCamera(width/-2, width/2, height/-2, height, 0, 1000);

var renderer = new THREE.WebGLRenderer({antialias:true});
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

var cubes = new Array();

for (var i=0; i<1000; i++)
{
	cubes[i] = new SineArm(scene);
}

camera.position.z = 1;

function render() {
	requestAnimationFrame(render);

	for (var i=0; i<1000; i++)
	{
		cubes[i].rotate();
	}
	
	renderer.render(scene, camera);
}

render();