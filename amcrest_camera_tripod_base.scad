baseDia=95;
baseThickness=10;
mountHolePositionRadius=68.5/2;
mountHoleDia=6;
mountHoleInsetDia=mountHoleDia*2;
tripodSurfaceWidth=25;
tripodSurfaceDepth=20;
tripodSurfaceThickness=12;

tripodNutInsetDia=12;
tripodNutInsetThickness=8;
tripodNutBackClearanceDia=tripodNutInsetDia*2/3;

overlap=0.01;
$fn=50;

difference() {
    hull() {
        cylinder(d=baseDia, h=baseThickness);
        translate([0,-baseDia/2+tripodSurfaceThickness/2,baseThickness-overlap])
            tripodAttachment();
    }
    rotate([0,0,45]) {
        translate([mountHolePositionRadius,0,0]) mountHole();
        translate([-mountHolePositionRadius,0,0]) mountHole();
        translate([0,mountHolePositionRadius,0]) mountHole();
        translate([0,-mountHolePositionRadius,0]) mountHole();
    }
    // tripod 1/4-20 nut inset
    translate([0,-baseDia/2-overlap,baseThickness+tripodSurfaceDepth/2])
            rotate([-90,0,0]) {
                cylinder(d=tripodNutInsetDia, h=tripodNutInsetThickness, $fn=6);
                translate([0,0,tripodNutInsetThickness-overlap])
                    cylinder(d=tripodNutBackClearanceDia, h=tripodNutInsetThickness);
            }
}


module mountHole() {
    union() {
        translate([0,0,-overlap]) cylinder(d=mountHoleDia, h=baseThickness+overlap*2);
        // inset hole
        translate([0,0,baseThickness]) cylinder(d=mountHoleInsetDia, h=tripodSurfaceDepth+overlap);
    }
}

module tripodAttachment() {
    hull() {
        translate([tripodSurfaceWidth-tripodSurfaceThickness/2,0,0])
            cylinder(d=tripodSurfaceThickness, h=tripodSurfaceDepth);
        translate([-tripodSurfaceWidth+tripodSurfaceThickness/2,0,0])
            cylinder(d=tripodSurfaceThickness, h=tripodSurfaceDepth);
    }
}