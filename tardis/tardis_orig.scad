H = 40;  //Height of main section cube
Ratio =0.6;  //Height to Width Ratio
//S = 50;  //Width of each side, use this to ignore the proper H/W ratio
S = H * Ratio;  //Width of each side
Lr = S/15; // Light Radius
Lh = H/9;  // Light Height
Dh = H - S/3.5;  // Door Height
Dw = 2 * S/5;  // Door Width
Po = (-Dh + 8 * S / 5) / 3;  // Panel Offset
Pr = Dw - (2 * Po);  // Panel Size
HD = S/3; // Hollowing out diameter

$fn = 100;

color([0,0,0.7])
difference()
{
	union()
	{
		//Main Box
		cube([S,S,H]);
		//Middle Box
		translate([S/20,S/20,0]) cube([S-(S/10),S-(S/10),H+(S/15)]);
		//Top Box
		translate([S/10,S/10,0]) cube([S-(S/5),S-(S/5),H+(S/7.5)]);
		//Roof
		polyhedron(
			points=[ [S/2,S/2,H+(S/5)],[S/10,S/10,H+(S/7.5)],[S/10,S-S/10,H+(S/7.5)],
			[S-S/10,S-S/10,H+(S/7.5)],[S-S/10,S/10,H+(S/7.5)]],
			triangles=[ [0,1,2], [0,2,3],[0,3,4],[0,4,1],[1,3,2],[1,4,3] ]
		);
		//Bottom Fringe
		translate([-S/10,-S/10,0]) cube([S + S/5, S + S/5,S/10]);
		translate([-S/10,-S/10,0]) polyhedron(points= [ [0,0,S/10], [S + S/5,0,S/10], [S + S/5,S + S/5,S/10],
										 [0,S + S/5,S/10], [(S + S/5)/2,(S + S/5)/2, S/2.5] ],
								triangles = [ [0,4,1], [1,4,2], [2,4,3], [3,4,0], [0,1,2], [0,2,3] ] );
		//Led Top
		translate([S/2,S/2,H+S/5.5]) 
		union()
		{
			cylinder(Lh - Lr, r = Lr);
			translate([0,0,Lh-Lr]) cylinder(Lr, Lr + 0.25,0);
		}
		//Name Plates
		translate([S/25,-1,H-S/3.5+3*S/20]) cube([S-2*S/25, S + 2, S/3.5-3*S/20]);
		translate([-1,S/25,H-S/3.5+3*S/20]) cube([S + 2, S-2*S/25, S/3.5-3*S/20]);
		
	}

	//Faces
	for(i=[0,90,180,270])
	{
		translate([S/2,S/2,0]) rotate([0,0,i]) translate([-S/2,-S/2,0]) face();
	}

	//Hollowing Out
	translate([S/2,S/2,-1]) union()
	{
		cylinder(H - S/5 - 1, r = HD);
		//translate([0,0,H - S/5 - 1]) sphere(r=S/2.5);
		translate([0,0,H - S/5 -1-.01]) cylinder(S/2.5,HD,Lr);
	}
	
	//Print just the top for testing
	//translate([-S/2,-S/2,-1]) cube([2*S,2*S,H-S/10]);
	
}

module face()
{
	render() color([0,0,0.5]) translate([0,-1,3 * S/20])
	union()
	{
		translate([2*S/25,0,0]) cube([Dw,2,Dh]);
		translate([13*S/25,0,0]) cube([Dw,2,Dh]);
		color([0,0,0.4])
		for(i=[2*S/25 + Po,Po + 13*S/25])
		{
			for(j=[0,1,2])
			{
				translate([i,0,(j+1) * Po + j * Pr]) cube([Pr, 3, Pr]);
			}
			difference(){
			translate([i,0,4 * Po + 3 * Pr]) cube([Pr, 3, Pr]);
			translate([i,0,4 * Po + 3.5 * Pr -0.5]) cube([Pr,4,1]);
			translate([i+Pr/3-0.5,0,4 * Po + 3* Pr]) cube([1,4,Pr]);
			translate([i+2*Pr/3-0.5,0,4 * Po + 3* Pr]) cube([1,4,Pr]);
			}
			
		}		

	}
	
}