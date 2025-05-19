include<polyhedra.scad>;

// RGB colors for examples
polyhedraEdgeColor = "blue";
polyhedraVertexColor = "blue";
polyhedraFixColor = "darkblue";
polyhedraFaceColor1 = "yellow";
polyhedraFaceColor2 = "yellow";
polyhedraFaceColor3 = "yellow";
polyhedraSolidColor = [253, 191, 111] / 255;

// This font is used in the enumerated examples for edges, vertices and faces. If you don't have this font installed, choose a font from the Font List in the OpenSCAD Help menu.
polyhedraEnumeratedFont = "Consolas";
fontSize = 0.4; // [0.4:0.2:3]
// Uncomment a display mode to change how the shapes are rendered
polyhedraDisplayMode = "wireframe"; // [enumerated, wireframe, solid]

//radius=0.1; // [0.01:0.01:0.2]
//radiusFix=0.04; // [0.01:0.01:0.2]

diagonals = true;

module icosahedron() {
    show_polyhedron(
    icosahedron_vertices,
    icosahedron_edges,
    icosahedron_adjacent_vertices,
        [icosahedron_faces]
    );
}

/*
uses show_vertices, show_edges and show_faces to display all components of the polyhedra. also renders a solid polyhedraon.
vertices is a vertices array
edges is an edges array
adjacent vertices is an adjacent_vertices array
faces_array is an array of face arrays. Each set of faces is shown in a different color. For Example: [snub_dodecahedron_triangle_faces, snub_dodecahedron_pentagon_faces]
*/
module show_polyhedron(vertices, edges, adjacentVertices, facesArray) {

    faceColorArray = [polyhedraFaceColor1, polyhedraFaceColor2, polyhedraFaceColor3];

    show_vertices(vertices, adjacentVertices);

    color(polyhedraEdgeColor)
        show_edges(vertices, edges);

    for (i = [0:min(len(faceColorArray), len(facesArray)) - 1])
        color(faceColorArray[i])
            show_faces(vertices, facesArray[i]);

    if (polyhedraDisplayMode == "enumerated") {
        r = norm(vertices[0]);
        s = (r - 0.1) / r;
        color(polyhedraSolidColor)
            scale(s)
                polyhedron(points = vertices, faces = concat_all(facesArray));
    } else if (polyhedraDisplayMode == "solid") {
        color(polyhedraSolidColor)
            polyhedron(points = vertices, faces = concat_all(facesArray));
    }
}

/*
creates a sample_vertex for each vertex in verts
the adjacents array is used to orient the vertices correctly
*/
module show_vertices(verts, adjacents) {
    for (i = [0:len(verts) - 1]) {
        color(polyhedraVertexColor)
            orient_vertex(verts[i], verts[adjacents[i][0]])
                sample_vertex(i);
        color(polyhedraFixColor)
            orient_vertex(verts[i], verts[adjacents[i][0]])
                rotate([180, 0, 0])
                    linear_extrude(height = 1)
                        circle(r = radiusFix);
    }
}

/*
this module is used for the example vertices
i is the number displayed in "enumerated" mode
in "wireframe" mode a sphere is created instead
*/
module sample_vertex(i) {
    if (polyhedraDisplayMode == "enumerated")
        rotate(-90)
            linear_extrude(0.1)
                underlined_text(text = str(i));
    else if (polyhedraDisplayMode == "wireframe")
        sphere(r = radius);
}

/*
creates a sample_face for each face in faces and orients it
*/
module show_faces(verts, faces) {
    for (i = [0:len(faces) - 1]) {
        center = sum_verts(map_verts(verts, faces[i])) / len(faces[i]) ;
        r = norm(verts[faces[i][0]] - center) - 0.1;
        orient_face(map_verts(verts, faces[i]))
            sample_face(i = i, n = len(faces[i]), r = r);
    }
}

/*
creates a sample_edge for edge in edges and orients it
*/
module show_edges(verts, edges) {
    for (i = [0:len(edges) - 1]) {
        a = verts[edges[i][0]];
        b = verts[edges[i][1]];

        orient_edge(a, b) {
            sample_edge(i = i, h = norm(a - b));
        }
    }
}

/*
2d text with a line under it, so 6 and 9 can be more easily differentiated.
*/
module underlined_text(text = "abc", text_size = 0.2) {
    scale(text_size)
        text(text, font = polyhedraEnumeratedFont, size = text_size, valign = "center", halign = "center");
    // translate([0, -text_size * 0.3])
    //     square(size = [text_size * 0.3 * len(text), text_size / 20], center = true);
}

/*
this module is used for example edges
i is the number displayed in "enumerated" mode
in "wireframe" mode a cylinder is created instead
*/
module sample_edge(i, h = 2, r = radius) {
    if (polyhedraDisplayMode == "enumerated")
        linear_extrude(height = h * 0.7, center = true)
            translate([0.1, 0, 0])
                rotate(-90)
                    underlined_text(str(i), text_size = 0.1);
    else if (polyhedraDisplayMode == "wireframe")
        linear_extrude(height = h, center = true)
            circle(r = r);
}

/*
this module is used to create an example face in "enumerated" mode
i is the number displayed on the face
n is the number of sides the face has
*/
module sample_face(i, n, r = 3, h = 0.1, t = 0.1) {
    if (polyhedraDisplayMode == "enumerated") {
        linear_extrude(height = h) {
            underlined_text(str(i), text_size = r / 2);
            rotate(180 / n - 90)
                difference() {
                    circle($fn = n, r = r);
                    circle($fn = n, r = r - t);
                }
        }
    } else if (polyhedraDisplayMode == "wireframe") {
        translate([0, -0.24, 0])
            linear_extrude(height = h) {
                underlined_text(str(i), text_size = fontSize);
            }
    }
}
