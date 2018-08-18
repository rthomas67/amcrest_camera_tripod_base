baseDia=95;
baseThickness=10;
mountHolePositionRadius=68.5/2;
mountHoleDia=6;
mountHoleInsetDia=mountHoleDia*2;
tripodSurfaceWidth=25;
tripodSurfaceDepth=30;
tripodSurfaceThickness=12;

tripodNutInsetDia=12;
tripodNutInsetDepth=14;

textDepth=0.5;
fontHeight=4;
textBottomInset=tripodSurfaceThickness/2-fontHeight/2;

logoScaleFactor=0.14;
logoXAdjust=-7;
logoYAdjust=-1;

overlap=0.01;
$fn=50;

difference() {
    hull() {
        cylinder(d=baseDia, h=baseThickness);
        translate([0,-baseDia/2-tripodSurfaceThickness/2,0])
            tripodAttachment();
    }
    rotate([0,0,0]) {
        translate([mountHolePositionRadius,0,0]) mountHole();
        translate([-mountHolePositionRadius,0,0]) mountHole();
        translate([0,mountHolePositionRadius,0]) mountHole();
        translate([0,-mountHolePositionRadius,0]) mountHole();
    }
    // tripod 1/4-20 nut inset
    translate([0,-baseDia/2-tripodSurfaceThickness-overlap,tripodSurfaceDepth/2])
            rotate([-90,0,0]) {
                cylinder(d=tripodNutInsetDia, h=tripodNutInsetDepth, $fn=6);
            }
    translate([0,-baseDia/2-tripodSurfaceThickness+textBottomInset,tripodSurfaceDepth-textDepth]) {
        //text("AMCREST",font="Cambria Math",size=fontHeight,halign="center");
    }
    translate([-tripodSurfaceWidth/2+logoXAdjust,
            -baseDia/2-tripodSurfaceThickness+textBottomInset+logoYAdjust,
            tripodSurfaceDepth-textDepth]) {
        scale([logoScaleFactor,logoScaleFactor,1])
        linear_extrude(height = 2)
            import("amcrest_logo.dxf");
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