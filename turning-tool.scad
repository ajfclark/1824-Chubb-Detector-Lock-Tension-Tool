keyLength=74;
keyD=9.5;

handleLength=75;

postD=5.75;
postLength=25;

boltActuatorX=4.7;
boltActuatorZ=3.4;
boltActuatorY=20;

channelD=4;

fitTollerance=.75;

postHoleD=postD + fitTollerance;
keyR=keyD/2;

ringPositions=[52.5,56,63.5,67];
ringWidth = 2;

$fn=64;
offset=1/100;

module torus(pos, torusR, circleD) {
	translate(pos)
		rotate_extrude(convexity = 10)
			translate([torusR, 0, 0])
				circle(d = circleD);
}

module boltActuator(size) {
		translate([-size.x/2, 0, 0])
			cube(size);
}

module handle() {
	translate([-keyR/2,0,0])
	cube([keyR,keyD,keyR]);
	translate([-handleLength/2,0,0])
	cube([handleLength,keyR,keyR]);
}

difference(){
	union() {
		difference() {
			cylinder(h=keyLength,d=keyD);
			// pick channel
			translate([0,keyR,0]) cylinder(h=keyLength,d=channelD);
			// decoration
			for (z = ringPositions) {
				torus([0,0,z], keyR, ringWidth);
			}
		}
		boltActuator([boltActuatorX,boltActuatorY+keyR,boltActuatorZ]);
		translate([0,0,keyLength])
			sphere(d=keyD);
	}
	
	// post hole
    translate([0,0,-offset]) cylinder(h=postLength+offset,d=postHoleD);

	// handle notch
	translate([0,0,keyLength+3.5]) cube([keyD,keyR,keyD],center=true);
	// handle key
	translate([0,0,keyLength-1]) cube([keyR,keyR,keyD],center=true);
}

translate([handleLength,0,0]) handle();

