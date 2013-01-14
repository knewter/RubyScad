require 'matrix'

module RubyScad
  VERSION = 1.0

  CUBE_STR = "cube(size=[%<x>.3f, %<y>.3f, %<z>.3f], center=%<center>s);"
  SPHERE_STR = "sphere(r=%<r>.3f, $fa=%<fa>.2f, $fs=%<fs>.2f, $fn=%<fn>.2f, center=%<center>s);"
  CYLINDER_STR = "cylinder(h=%<h>.3f, r1=%<r1>.3f, r2=%<r2>.3f, $fa=%<fa>.2f, $fs=%<fs>.2f, $fn=%<fn>.2f, center=%<center>s);"
  POLYHEDRON_STR = "polyhedron(points=%<points>s, triangles=%<triangles>s, convexity=%<convexity>d, center=%<center>s);"
  SQUARE_STR = "square(size=[%<x>.3f, %<y>.3f], center=%<center>s);"
  CIRCLE_STR = "circle(r=%<r>.3f, $fa=%<fa>.2f, $fs=%<fs>.2f, $fn=%<fn>.2f, center=%<center>s);"
  POLYGON_STR = "polygon(points=%<points>s, pathes=%<paths>s, convexity=%<convexity>d, center=%<center>s);"
  TRANSLATE_STR = "translate([%<x>.3f, %<y>.3f, %<z>.3f])"
  ROTATE_STR = "rotate([%<x>.3f, %<y>.3f, %<z>.3f])"
  ROTATE_STR_2D = "rotate(a=%<angle>.3f)"
  SCALE_STR = "scale([%<x>.3f, %<y>.3f, %<z>.3f])"
  MIRROR_STR = "mirror([%<x>.3f, %<y>.3f, %<z>.3f])"
  MULTMATRIX_STR = "multmatrix(m=%<matrix>s)"
  COLOR_STR = "color([%<r>.1f, %<g>.1f, %<b>.1f, %<a>.1f])"
  COLOR_NAME_STR = "color(\"%<color>\")"
  UNION_STR = "union()"
  DIFFERENCE_STR = "difference()"
  INTERSECTION_STR = "intersection()"
  RENDER_STR = "render(convexity=%<convexity>d)"
  MINKOWSKI_STR = "minkowski()"
  HULL_STR = "hull()"
  BACKGROUND_STR = '%'
  DEBUG_STR = '#'
  ROOT_STR = '!'
  DISABLE_STR = '*'
  IMPORT_STR = "import(file=\"%<file>s\", layer=\"%<layer>s\", convexity=%<convexity>d, scale=%<scale>d);"
  INCLUDE_STR = "include <%<file>s>"
  USE_STR = "use <%<file>s>"
  ECHO_STR = "echo(\"%<string>s\");"
  SURFACE_STR = "surface(file=\"%<file>s\", center=%<center>s, convexity=%<convexity>d);"
  LINEAR_EXTRUDE_STR = "linear_extrude(height=%<height>.3f, center=%<center>s, convexity=%<convexity>d, twist=%<twist>d, slices=%<slices>d, file=\"%<file>s\", layer=\"%<layer>s\")"
  ROTATE_EXTRUDE_STR = "rotate_extrude(center=%<center>s, convexity=%<convexity>d, slices=%<slices>d, file=\"%<file>s\", layer=\"%<layer>s\")"
  PROJECTION_STR = "projection(cut=%<cut>s)"

  START_BLOCK = "{"
  END_BLOCK = "}"
  TAB_SIZE = 3
  PAD = 0.01

  @@fa = 12
  @@fs = 2
  @@fn = 0
  @@slices = 40
  @@convexity = 10
  @@center = false
  @@floating_precision = ".3f"

  def fa(value)
    @@fa = value
  end

  def fs(value)
    @@fs = value
  end

  def fn(value)
    @@fn = value
  end

  def slices(value)
    @@slices = value
  end

  def convexity(value)
    @@convexity = value
  end

  def center(value)
    @@center = value
  end

  def dxf_cross(args={})
    return 0.0
  end

  def dxf_dim(args={})
    return 0.0
  end

  def projection(args={}, &block)
    cut = args.fetch(:cut, false)
    format_block PROJECTION_STR % {cut: cut}, &block
  end
  
  def linear_extrude(args={}, &block)
    height = args.fetch(:height, 1)
    center = args.fetch(:center, @@center)
    convexity = args.fetch(:convexity, @@convexity)
    slices = args.fetch(:slices, @@slices)
    twist = args.fetch(:twist, 0)
    file = args.fetch(:file, "")
    layer = args.fetch(:layer, "")
    str_end = file == "" ? "" : ";"
    format_block LINEAR_EXTRUDE_STR.concat(str_end) % {height: height, center: center, convexity: convexity, slices: slices, twist: twist, file: file, layer: layer}, &block
    
  end

  def rotate_extrude(args={}, &block)
    center = args.fetch(:center, @@center)
    convexity = args.fetch(:convexity, @@convexity)
    slices = args.fetch(:slices, @@slices)
    file = args.fetch(:file, "")
    layer = args.fetch(:layer, "")
    str_end = file == "" ? "" : ";"
    format_block ROTATE_EXTRUDE_STR.concat(str_end) % {center: center, convexity: convexity, slices: slices, file: file, layer: layer}, &block
  end

  def echo(*args)
    s = args.join(", ")
    format_output ECHO_STR % {string: s}
  end

  def import(args={})
    file = args.fetch(:file, "")
    layer = args.fetch(:layer, "")
    convexity = args.fetch(:convexity, 10)
    scale = args.fetch(:scale, 1)
    format_output IMPORT_STR % {file: file, layer: layer, convexity: convexity, scale: scale}
  end

  def include(args={})
    file = args.fetch(:file, "")
    format_output INCLUDE_STR % {file: file}
  end

  def use(args={})
    file = args.fetch(:file, "")
    format_output USE_STR % {file: file}
  end

  def difference(&block)
    format_block DIFFERENCE_STR, &block
  end

  def union(&block)
    format_block UNION_STR, &block
  end

  def intersection(&block)
    format_block INTERSECTION_STR, &block
  end

  def render(args={}, &block)
    convexity = args.fetch(:convexity, 1)
    format_block RENDER_STR % {convexity: convexity}, &block 
  end

  def minkowski(&block)
    format_block MINKOWSKI_STR, &block
  end

  def hull(&block)
    format_block HULL_STR, &block
  end

  def background()
    format_output BACKGROUND_STR
    yield if block_given?
  end

  def debug()
    format_output DEBUG_STR
    yield if block_given?
  end

  def root()
    format_output ROOT_STR
    yield if block_given?
  end

  def disable()
    format_output DISABLE_STR
    yield if block_given?
  end

  def cube(args={})
    x, y, z = vector_input(args.fetch(:size, [1,1,1]))
    center = args.fetch(:center, @@center)
    format_output CUBE_STR % {x: x, y: y, z: z, center: center}
  end

  def sphere(args={})
    if args.include?(:d)
      r = args[:d]/2.0
    else
      r = args.fetch(:r, 0.0)
    end
    fa = args.fetch(:fa, @@fa)
    fs = args.fetch(:fs, @@fs)
    fn = args.fetch(:fn, @@fn)
    center = args.fetch(:center, @@center)
    format_output SPHERE_STR % {r: r, fa: fa, fs: fs, fn: fn, center: center}
  end

  def polyhedron(args={})
    triangles = args.fetch(:triangles, [])
    points = args.fetch(:points, [])
    convexity = args.fetch(:convexity, @@convexity)
    center = args.fetch(:center, @@center)
    format_output POLYHEDRON_STR % {points: points, triangles: triangles, convexity: convexity, center: center}
  end

  def square(args={})
    x, y = vector_input(args.fetch(:size, [1, 1]))
    center = args.fetch(:center, @@center)
    format_output SQUARE_STR % {x: x, y: y, center: center}
  end

  def circle(args={})
    if args.include?(:d)
      r = args[:d]/2.0
    else
      r = args.fetch(:r, 0.0)
    end
    fa = args.fetch(:fa, @@fa)
    fs = args.fetch(:fs, @@fs)
    fn = args.fetch(:fn, @@fn)
    center = args.fetch(:center, @@center)
    format_output CIRCLE_STR % {r: r, fa: fa, fs: fs, fn: fn, center: center}
  end

  def polygon(args={})
    paths = args.fetch(:paths, [])
    points = args.fetch(:points, [])
    convexity = args.fetch(:convexity, @@convexity)
    center = args.fetch(:center, @@center)
    format_output POLYGON_STR % {points: points, paths: paths, convexity: convexity, center: center}
  end

  def surface(args={})
    file = args.fetch(:file, [])
    convexity = args.fetch(:convexity, @@convexity)
    center = args.fetch(:center, @@center)
    format_output SURFACE_STR % {file: file, convexity: convexity, center: center}
  end

  def cylinder(args={})
    if args.include?(:r)
      r1 = args[:r]
      r2 = args[:r]
    else
      r1 = args.fetch(:r1, 1.0)
      r2 = args.fetch(:r2, 1.0)
    end
    h = args.fetch(:h, 1.0)
    fa = args.fetch(:fa, @@fa)
    fs = args.fetch(:fs, @@fs)
    fn = args.fetch(:fn, @@fn)
    center = args.fetch(:center, @@center)
    format_output CYLINDER_STR % {r1: r1, r2: r2, h: h, fa: fa, fs: fs, fn: fn, center: center }
  end

  def translate(args={}, &block)
    vector_output TRANSLATE_STR, args, &block
  end

  def rotate(args={}, &block)    
    if (!args[:v]) && (args[:a].is_a?(Numeric))
      format_block ROTATE_STR_2D % {angle: args[:a]}
    else
      if args.include?(:v)
        x, y, z = args[:v].collect{ |v| v*args[:a]}
      else
        args[:v] = args[:a] if args[:a].is_a? Array
        x, y, z = vector_input(args)
      end
      format_block ROTATE_STR % {x: x, y: y, z: z}, &block
    end
  end

  def scale(args={}, &block)
    vector_output SCALE_STR, args, &block
  end

  def mirror(args={}, &block)
    vector_output MIRROR_STR, args, &block
  end

  def multmatrix(args={}, &block)
    m = args.fetch(:m, [])
    format_block MULTMATRIX_STR % {matrix: m}, &block
  end

  def color(args={}, &block)
    color = args.fetch(:color, nil)
    if color.is_a? String
      format_block COLOR_NAME_STR % {color:args}
    elsif color.is_a? Array
      r, g, b, a = pad_fill(color, 4, 1.0)
      format_block COLOR_STR % {r: r, g: g, b: b, a: a}, &block
    end
  end

  def pad_fill(array, size, value)
    (0..size).each { |v| array[v] = value unless array[v] }
    array
  end
  
  def vector_output(string, args={}, &block)
    x, y, z = vector_input(args)
    format_block string % {x: x, y: y, z: z}, &block
  end

  def vector_input(args={})
    if args.is_a?(Array) or args.is_a?(Vector)
      x, y, z = pad_fill(args.to_a, 3, 0)
    elsif args.is_a? Numeric
      x, y, z = [].fill(args, 0..2)
    elsif args.is_a? Hash
      if args.include?(:v)
        args[:v].fill(0.0, args[:v].length, 3-args[:v].length)
        x, y, z = pad_fill(args[:v].to_a, 3, 0)
      else
        x = args.fetch(:x, 0)
        y = args.fetch(:y, 0)
        z = args.fetch(:z, 0)
      end
    end
    return x, y, z
  end

  def format_block(output_str)
    format_output output_str.concat(' ')
    if block_given?
      start_block
      yield
      end_block
    else
      new_line unless output_str.include?(';')
    end
  end

  def new_line
    format_output "\n"
  end

  def start_block()
    format_output START_BLOCK
  end

  def end_block()
    format_output END_BLOCK
  end

  def end_all_blocks()
    end_block while @@tab_level > 0
  end

  def space_string(str, tab_level)
    ((' '*TAB_SIZE)*tab_level) + str
  end

  def raw_output(str)
    if @@output_file
      File.open(@@output_file, 'a') { |f| f.print(str) } 
    else
      print str
    end
  end

  def format_output(str)
    @@prev_output ||= ""
    @@tab_level ||= 0
    str.lines do |l|
      l.concat("\n") if l.match('[;\}\{]')
      @@tab_level-=1 if(l.include?('}')) && @@tab_level > 0
      l = space_string(l, @@tab_level) if @@prev_output.include?("\n") 
      raw_output(l)
      @@tab_level+=1 if(l.include?('{'))
      @@prev_output = l
    end
  end

  def lookup(x, points)
    xmin, xmax = [0.0, 0.0]
    points.keys.sort.reverse_each do |k|
      if k <= x
        xmin = k
        break
      end
    end
    points.keys.sort.each do |k|
      if k >= x
        xmax = k
        break
      end
    end
    return points[xmax] if x == xmax
    return points[xmin] if x == xmin
    return points[xmin] + (((x - xmin) * (points[xmax] - points[xmin])) / (xmax - xmin))
end

  def self.start_output
    @@output_file = nil
    if ARGV[0] && ARGV[0].include?(".scad")
      @@output_file = ARGV[0]
      ARGV.shift
    end
    if @@output_file
      File.open(@@output_file, 'w') do |f|
        f.puts "//script created with rubyscad #{VERSION}\n\n"
      end
    end
  end

  def self.extended(mod)
    start_output
  end

  def self.included(mod)
    start_output
  end

  start_output if __FILE__== $0  
end

class Numeric
  def radians
    self * Math::PI / 180
  end
end
