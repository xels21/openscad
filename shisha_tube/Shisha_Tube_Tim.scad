radiusTopShisha = 8;
radiusBottomShisha = 6;
heightInShisha = 20;
radiusTubeInner = 5;
radiusTubeOuter = 8.5;
heightPartInTube = 10;
numberOfPartsInTube = 3;

diffTopBottom = radiusTopShisha - radiusBottomShisha;
diffTubeBottom = radiusTubeOuter - radiusBottomShisha;
relation = diffTubeBottom / diffTopBottom;
height = heightInShisha * relation;

module cylinderInTube (startHeightFirst, countPart) {
    diffTubeInnerTopBottom = radiusTubeOuter / radiusTubeInner;
    translate ([0, 0, startHeightFirst + (countPart * heightPartInTube)])
    cylinder (h=heightPartInTube, r1=radiusTubeInner, r2=radiusTubeInner + diffTubeInnerTopBottom, $fn=100);
}

module solidComposition () {
    cylinder (h=height, r1=radiusBottomShisha, r2=radiusTubeOuter, $fn=100);
    for (countPart = [0:numberOfPartsInTube - 1]) {
        cylinderInTube(height, countPart);
        cylinderInTube(height, countPart);  
    }
}

module finishedPart () {
    difference () {
        solidComposition();
        translate ([0, 0, -0.25])
        cylinder (height + numberOfPartsInTube * heightPartInTube + 0.5, radiusTubeInner - 0.35, radiusTubeInner - 0.35, $fn=100);
    }
}
cylinder(r=13,h=.3);
finishedPart();