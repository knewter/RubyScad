//created with rubyscad 1.0

translate(v = [-30, 0]) 
linear_extrude(height = 100, twist = 411, convexity = 8) 
difference() {
   circle(r = 20); 
   rotate(a = 0) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 51) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 102) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 154) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 205) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 257) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
   rotate(a = 308) 
   polygon(points = [[40, 0], [20, 0], [14.672, 3.119], [13.595, 6.339], [15.760, 12.313], [31.520, 24.626]]); 
}
translate(v = [30, 0]) 
difference() {
   cylinder($fn = 6, r = 30, h = 20); 
   translate(v = [0, 0, -10]) 
   linear_extrude(height = 40, twist = 102, convexity = 2) 
   difference() {
      circle(r = 21); 
      rotate(a = 0) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 51) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 102) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 154) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 205) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 257) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
      rotate(a = 308) 
      polygon(points = [[42, 0], [21, 0], [15.650, 3.327], [14.501, 6.762], [16.548, 12.929], [33.096, 25.858]]); 
   }
}
linear_extrude(height = 100, twist = 1500.000, $fn = 19.200, convexity = 5) {
   polygon(points = [[109.998, 0.000], [90.002, 0.000], [85.225, 28.930], [104.161, 35.358]]); 
   polygon(points = [[104.161, 35.358], [85.225, 28.930], [71.402, 54.789], [87.268, 66.963]]); 
   polygon(points = [[87.268, 66.963], [71.402, 54.789], [50.002, 74.833], [61.112, 91.461]]); 
   polygon(points = [[61.112, 91.461], [50.002, 74.833], [23.294, 86.934], [28.470, 106.251]]); 
   polygon(points = [[28.470, 106.251], [23.294, 86.934], [-5.886, 89.808], [-7.194, 109.764]]); 
   polygon(points = [[-7.194, 109.764], [-5.886, 89.808], [-34.442, 83.149], [-42.095, 101.627]]); 
   polygon(points = [[-42.095, 101.627], [-34.442, 83.149], [-59.341, 67.666], [-72.528, 82.702]]); 
   polygon(points = [[-72.528, 82.702], [-59.341, 67.666], [-77.942, 45.000], [-95.263, 55.000]]); 
   polygon(points = [[-95.263, 55.000], [-77.942, 45.000], [-88.271, 17.558], [-107.886, 21.460]]); 
   polygon(points = [[-107.886, 21.460], [-88.271, 17.558], [-89.230, -11.747], [-109.059, -14.358]]); 
   polygon(points = [[-109.059, -14.358], [-89.230, -11.747], [-80.719, -39.806], [-98.656, -48.652]]); 
   polygon(points = [[-98.656, -48.652], [-80.719, -39.806], [-63.640, -63.640], [-77.781, -77.781]]); 
   polygon(points = [[-77.781, -77.781], [-63.640, -63.640], [-39.806, -80.719], [-48.651, -98.655]]); 
   polygon(points = [[-48.651, -98.655], [-39.806, -80.719], [-11.747, -89.231], [-14.358, -109.058]]); 
   polygon(points = [[-14.358, -109.058], [-11.747, -89.231], [17.558, -88.272], [21.460, -107.885]]); 
   polygon(points = [[21.460, -107.885], [17.558, -88.272], [45.001, -77.944], [54.999, -95.261]]); 
}
