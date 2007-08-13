" THIS FILE WAS GENERATED AUTOMATICALLY -- DO NOT EDIT! "

{ import: Object }

libcairo : Object ()

{ include <cairo.h> }
{ include <cairo-features.h> }
{ include <cairo-xlib.h> }

libcairo CAIRO_VERSION_MAJOR [ ^SmallInteger value_: self _CAIRO_VERSION_MAJOR ]
libcairo _CAIRO_VERSION_MAJOR { return (oop)(1); }
libcairo CAIRO_VERSION_MINOR [ ^SmallInteger value_: self _CAIRO_VERSION_MINOR ]
libcairo _CAIRO_VERSION_MINOR { return (oop)(2); }
libcairo CAIRO_VERSION_MICRO [ ^SmallInteger value_: self _CAIRO_VERSION_MICRO ]
libcairo _CAIRO_VERSION_MICRO { return (oop)(4); }
libcairo _CAIRO_VERSION_STRING { return (oop)("1.2.4"); }
libcairo CAIRO_HAS_SVG_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_SVG_SURFACE ]
libcairo _CAIRO_HAS_SVG_SURFACE { return (oop)(1); }
libcairo CAIRO_HAS_PDF_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_PDF_SURFACE ]
libcairo _CAIRO_HAS_PDF_SURFACE { return (oop)(1); }
libcairo CAIRO_HAS_PS_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_PS_SURFACE ]
libcairo _CAIRO_HAS_PS_SURFACE { return (oop)(1); }
libcairo CAIRO_HAS_FT_FONT [ ^SmallInteger value_: self _CAIRO_HAS_FT_FONT ]
libcairo _CAIRO_HAS_FT_FONT { return (oop)(1); }
libcairo CAIRO_HAS_PNG_FUNCTIONS [ ^SmallInteger value_: self _CAIRO_HAS_PNG_FUNCTIONS ]
libcairo _CAIRO_HAS_PNG_FUNCTIONS { return (oop)(1); }
libcairo CAIRO_HAS_QUARTZ_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_QUARTZ_SURFACE ]
libcairo _CAIRO_HAS_QUARTZ_SURFACE { return (oop)(1); }
libcairo CAIRO_HAS_XLIB_XRENDER_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_XLIB_XRENDER_SURFACE ]
libcairo _CAIRO_HAS_XLIB_XRENDER_SURFACE { return (oop)(1); }
libcairo CAIRO_HAS_XLIB_SURFACE [ ^SmallInteger value_: self _CAIRO_HAS_XLIB_SURFACE ]
libcairo _CAIRO_HAS_XLIB_SURFACE { return (oop)(1); }
libcairo CAIRO_VERSION [ ^SmallInteger value_: self _CAIRO_VERSION ]
libcairo _CAIRO_VERSION { return (oop)((((1) *10000) +((2) *100) +((4) *1))); }
libcairo cairo_version [
    | _ |
    _ := self _cairo_version.
    ^SmallInteger value_: _
]
libcairo _cairo_version {
  int _;
  _=(int)cairo_version();
  return (oop)(long)_;
}
libcairo cairo_version_string [
    | _ |
    _ := self _cairo_version_string.
    ^String value_: _
]
libcairo _cairo_version_string {
  char * _;
  _=(char *)cairo_version_string();
  return (oop)(long)_;
}
" struct cairo_matrix_t "
" struct cairo_user_data_key_t "
" enum cairo_status_t "
libcairo CAIRO_STATUS_SUCCESS [ ^SmallInteger value_: self _CAIRO_STATUS_SUCCESS ]
libcairo _CAIRO_STATUS_SUCCESS { return (oop)(0); }
libcairo CAIRO_STATUS_NO_MEMORY [ ^SmallInteger value_: self _CAIRO_STATUS_NO_MEMORY ]
libcairo _CAIRO_STATUS_NO_MEMORY { return (oop)(1); }
libcairo CAIRO_STATUS_INVALID_RESTORE [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_RESTORE ]
libcairo _CAIRO_STATUS_INVALID_RESTORE { return (oop)(2); }
libcairo CAIRO_STATUS_INVALID_POP_GROUP [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_POP_GROUP ]
libcairo _CAIRO_STATUS_INVALID_POP_GROUP { return (oop)(3); }
libcairo CAIRO_STATUS_NO_CURRENT_POINT [ ^SmallInteger value_: self _CAIRO_STATUS_NO_CURRENT_POINT ]
libcairo _CAIRO_STATUS_NO_CURRENT_POINT { return (oop)(4); }
libcairo CAIRO_STATUS_INVALID_MATRIX [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_MATRIX ]
libcairo _CAIRO_STATUS_INVALID_MATRIX { return (oop)(5); }
libcairo CAIRO_STATUS_INVALID_STATUS [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_STATUS ]
libcairo _CAIRO_STATUS_INVALID_STATUS { return (oop)(6); }
libcairo CAIRO_STATUS_NULL_POINTER [ ^SmallInteger value_: self _CAIRO_STATUS_NULL_POINTER ]
libcairo _CAIRO_STATUS_NULL_POINTER { return (oop)(7); }
libcairo CAIRO_STATUS_INVALID_STRING [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_STRING ]
libcairo _CAIRO_STATUS_INVALID_STRING { return (oop)(8); }
libcairo CAIRO_STATUS_INVALID_PATH_DATA [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_PATH_DATA ]
libcairo _CAIRO_STATUS_INVALID_PATH_DATA { return (oop)(9); }
libcairo CAIRO_STATUS_READ_ERROR [ ^SmallInteger value_: self _CAIRO_STATUS_READ_ERROR ]
libcairo _CAIRO_STATUS_READ_ERROR { return (oop)(10); }
libcairo CAIRO_STATUS_WRITE_ERROR [ ^SmallInteger value_: self _CAIRO_STATUS_WRITE_ERROR ]
libcairo _CAIRO_STATUS_WRITE_ERROR { return (oop)(11); }
libcairo CAIRO_STATUS_SURFACE_FINISHED [ ^SmallInteger value_: self _CAIRO_STATUS_SURFACE_FINISHED ]
libcairo _CAIRO_STATUS_SURFACE_FINISHED { return (oop)(12); }
libcairo CAIRO_STATUS_SURFACE_TYPE_MISMATCH [ ^SmallInteger value_: self _CAIRO_STATUS_SURFACE_TYPE_MISMATCH ]
libcairo _CAIRO_STATUS_SURFACE_TYPE_MISMATCH { return (oop)(13); }
libcairo CAIRO_STATUS_PATTERN_TYPE_MISMATCH [ ^SmallInteger value_: self _CAIRO_STATUS_PATTERN_TYPE_MISMATCH ]
libcairo _CAIRO_STATUS_PATTERN_TYPE_MISMATCH { return (oop)(14); }
libcairo CAIRO_STATUS_INVALID_CONTENT [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_CONTENT ]
libcairo _CAIRO_STATUS_INVALID_CONTENT { return (oop)(15); }
libcairo CAIRO_STATUS_INVALID_FORMAT [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_FORMAT ]
libcairo _CAIRO_STATUS_INVALID_FORMAT { return (oop)(16); }
libcairo CAIRO_STATUS_INVALID_VISUAL [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_VISUAL ]
libcairo _CAIRO_STATUS_INVALID_VISUAL { return (oop)(17); }
libcairo CAIRO_STATUS_FILE_NOT_FOUND [ ^SmallInteger value_: self _CAIRO_STATUS_FILE_NOT_FOUND ]
libcairo _CAIRO_STATUS_FILE_NOT_FOUND { return (oop)(18); }
libcairo CAIRO_STATUS_INVALID_DASH [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_DASH ]
libcairo _CAIRO_STATUS_INVALID_DASH { return (oop)(19); }
libcairo CAIRO_STATUS_INVALID_DSC_COMMENT [ ^SmallInteger value_: self _CAIRO_STATUS_INVALID_DSC_COMMENT ]
libcairo _CAIRO_STATUS_INVALID_DSC_COMMENT { return (oop)(20); }
" enum cairo_content_t "
libcairo CAIRO_CONTENT_COLOR [ ^SmallInteger value_: self _CAIRO_CONTENT_COLOR ]
libcairo _CAIRO_CONTENT_COLOR { return (oop)(4096); }
libcairo CAIRO_CONTENT_ALPHA [ ^SmallInteger value_: self _CAIRO_CONTENT_ALPHA ]
libcairo _CAIRO_CONTENT_ALPHA { return (oop)(8192); }
libcairo CAIRO_CONTENT_COLOR_ALPHA [ ^SmallInteger value_: self _CAIRO_CONTENT_COLOR_ALPHA ]
libcairo _CAIRO_CONTENT_COLOR_ALPHA { return (oop)(12288); }
libcairo _cairo_create :_target {
  cairo_t * _;
  _=(cairo_t *)cairo_create((cairo_surface_t *)(long)v__target);
  return (oop)(long)_;
}
libcairo _cairo_reference :_cr {
  cairo_t * _;
  _=(cairo_t *)cairo_reference((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_destroy :cr [
    | _ |
    _ := self _cairo_destroy : cr.
    ^_
]
libcairo _cairo_destroy :_cr {
  cairo_destroy((cairo_t *)(long)v__cr);
}
libcairo cairo_save :cr [
    | _ |
    _ := self _cairo_save : cr.
    ^_
]
libcairo _cairo_save :_cr {
  cairo_save((cairo_t *)(long)v__cr);
}
libcairo cairo_restore :cr [
    | _ |
    _ := self _cairo_restore : cr.
    ^_
]
libcairo _cairo_restore :_cr {
  cairo_restore((cairo_t *)(long)v__cr);
}
libcairo cairo_push_group :cr [
    | _ |
    _ := self _cairo_push_group : cr.
    ^_
]
libcairo _cairo_push_group :_cr {
  cairo_push_group((cairo_t *)(long)v__cr);
}
libcairo cairo_push_group_with_content :cr :content [
    | _ |
    _ := self _cairo_push_group_with_content : cr : content _integerValue.
    ^_
]
libcairo _cairo_push_group_with_content :_cr :_content {
  cairo_push_group_with_content((cairo_t *)(long)v__cr, (cairo_content_t)(long)v__content);
}
libcairo _cairo_pop_group :_cr {
  cairo_pattern_t * _;
  _=(cairo_pattern_t *)cairo_pop_group((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_pop_group_to_source :cr [
    | _ |
    _ := self _cairo_pop_group_to_source : cr.
    ^_
]
libcairo _cairo_pop_group_to_source :_cr {
  cairo_pop_group_to_source((cairo_t *)(long)v__cr);
}
" enum cairo_operator_t "
libcairo CAIRO_OPERATOR_CLEAR [ ^SmallInteger value_: self _CAIRO_OPERATOR_CLEAR ]
libcairo _CAIRO_OPERATOR_CLEAR { return (oop)(0); }
libcairo CAIRO_OPERATOR_SOURCE [ ^SmallInteger value_: self _CAIRO_OPERATOR_SOURCE ]
libcairo _CAIRO_OPERATOR_SOURCE { return (oop)(1); }
libcairo CAIRO_OPERATOR_OVER [ ^SmallInteger value_: self _CAIRO_OPERATOR_OVER ]
libcairo _CAIRO_OPERATOR_OVER { return (oop)(2); }
libcairo CAIRO_OPERATOR_IN [ ^SmallInteger value_: self _CAIRO_OPERATOR_IN ]
libcairo _CAIRO_OPERATOR_IN { return (oop)(3); }
libcairo CAIRO_OPERATOR_OUT [ ^SmallInteger value_: self _CAIRO_OPERATOR_OUT ]
libcairo _CAIRO_OPERATOR_OUT { return (oop)(4); }
libcairo CAIRO_OPERATOR_ATOP [ ^SmallInteger value_: self _CAIRO_OPERATOR_ATOP ]
libcairo _CAIRO_OPERATOR_ATOP { return (oop)(5); }
libcairo CAIRO_OPERATOR_DEST [ ^SmallInteger value_: self _CAIRO_OPERATOR_DEST ]
libcairo _CAIRO_OPERATOR_DEST { return (oop)(6); }
libcairo CAIRO_OPERATOR_DEST_OVER [ ^SmallInteger value_: self _CAIRO_OPERATOR_DEST_OVER ]
libcairo _CAIRO_OPERATOR_DEST_OVER { return (oop)(7); }
libcairo CAIRO_OPERATOR_DEST_IN [ ^SmallInteger value_: self _CAIRO_OPERATOR_DEST_IN ]
libcairo _CAIRO_OPERATOR_DEST_IN { return (oop)(8); }
libcairo CAIRO_OPERATOR_DEST_OUT [ ^SmallInteger value_: self _CAIRO_OPERATOR_DEST_OUT ]
libcairo _CAIRO_OPERATOR_DEST_OUT { return (oop)(9); }
libcairo CAIRO_OPERATOR_DEST_ATOP [ ^SmallInteger value_: self _CAIRO_OPERATOR_DEST_ATOP ]
libcairo _CAIRO_OPERATOR_DEST_ATOP { return (oop)(10); }
libcairo CAIRO_OPERATOR_XOR [ ^SmallInteger value_: self _CAIRO_OPERATOR_XOR ]
libcairo _CAIRO_OPERATOR_XOR { return (oop)(11); }
libcairo CAIRO_OPERATOR_ADD [ ^SmallInteger value_: self _CAIRO_OPERATOR_ADD ]
libcairo _CAIRO_OPERATOR_ADD { return (oop)(12); }
libcairo CAIRO_OPERATOR_SATURATE [ ^SmallInteger value_: self _CAIRO_OPERATOR_SATURATE ]
libcairo _CAIRO_OPERATOR_SATURATE { return (oop)(13); }
libcairo cairo_set_operator :cr :op [
    | _ |
    _ := self _cairo_set_operator : cr : op _integerValue.
    ^_
]
libcairo _cairo_set_operator :_cr :_op {
  cairo_set_operator((cairo_t *)(long)v__cr, (cairo_operator_t)(long)v__op);
}
libcairo cairo_set_source :cr :source [
    | _ |
    _ := self _cairo_set_source : cr : source.
    ^_
]
libcairo _cairo_set_source :_cr :_source {
  cairo_set_source((cairo_t *)(long)v__cr, (cairo_pattern_t *)(long)v__source);
}
libcairo cairo_set_source_rgb :cr :red :green :blue [
    | _ |
    _ := self _cairo_set_source_rgb : cr : red asFloat : green asFloat : blue asFloat.
    ^_
]
libcairo _cairo_set_source_rgb :_cr :_red :_green :_blue {
  double red;
  double green;
  double blue;
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  cairo_set_source_rgb((cairo_t *)(long)v__cr, red, green, blue);
}
libcairo cairo_set_source_rgba :cr :red :green :blue :alpha [
    | _ |
    _ := self _cairo_set_source_rgba : cr : red asFloat : green asFloat : blue asFloat : alpha asFloat.
    ^_
]
libcairo _cairo_set_source_rgba :_cr :_red :_green :_blue :_alpha {
  double red;
  double green;
  double blue;
  double alpha;
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  memcpy(&alpha, v__alpha, sizeof(double));
  cairo_set_source_rgba((cairo_t *)(long)v__cr, red, green, blue, alpha);
}
libcairo cairo_set_source_surface :cr :surface :x :y [
    | _ |
    _ := self _cairo_set_source_surface : cr : surface : x asFloat : y asFloat.
    ^_
]
libcairo _cairo_set_source_surface :_cr :_surface :_x :_y {
  double x;
  double y;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  cairo_set_source_surface((cairo_t *)(long)v__cr, (cairo_surface_t *)(long)v__surface, x, y);
}
libcairo cairo_set_tolerance :cr :tolerance [
    | _ |
    _ := self _cairo_set_tolerance : cr : tolerance asFloat.
    ^_
]
libcairo _cairo_set_tolerance :_cr :_tolerance {
  double tolerance;
  memcpy(&tolerance, v__tolerance, sizeof(double));
  cairo_set_tolerance((cairo_t *)(long)v__cr, tolerance);
}
" enum cairo_antialias_t "
libcairo CAIRO_ANTIALIAS_DEFAULT [ ^SmallInteger value_: self _CAIRO_ANTIALIAS_DEFAULT ]
libcairo _CAIRO_ANTIALIAS_DEFAULT { return (oop)(0); }
libcairo CAIRO_ANTIALIAS_NONE [ ^SmallInteger value_: self _CAIRO_ANTIALIAS_NONE ]
libcairo _CAIRO_ANTIALIAS_NONE { return (oop)(1); }
libcairo CAIRO_ANTIALIAS_GRAY [ ^SmallInteger value_: self _CAIRO_ANTIALIAS_GRAY ]
libcairo _CAIRO_ANTIALIAS_GRAY { return (oop)(2); }
libcairo CAIRO_ANTIALIAS_SUBPIXEL [ ^SmallInteger value_: self _CAIRO_ANTIALIAS_SUBPIXEL ]
libcairo _CAIRO_ANTIALIAS_SUBPIXEL { return (oop)(3); }
libcairo cairo_set_antialias :cr :antialias [
    | _ |
    _ := self _cairo_set_antialias : cr : antialias _integerValue.
    ^_
]
libcairo _cairo_set_antialias :_cr :_antialias {
  cairo_set_antialias((cairo_t *)(long)v__cr, (cairo_antialias_t)(long)v__antialias);
}
" enum cairo_fill_rule_t "
libcairo CAIRO_FILL_RULE_WINDING [ ^SmallInteger value_: self _CAIRO_FILL_RULE_WINDING ]
libcairo _CAIRO_FILL_RULE_WINDING { return (oop)(0); }
libcairo CAIRO_FILL_RULE_EVEN_ODD [ ^SmallInteger value_: self _CAIRO_FILL_RULE_EVEN_ODD ]
libcairo _CAIRO_FILL_RULE_EVEN_ODD { return (oop)(1); }
libcairo cairo_set_fill_rule :cr :fill_rule [
    | _ |
    _ := self _cairo_set_fill_rule : cr : fill_rule _integerValue.
    ^_
]
libcairo _cairo_set_fill_rule :_cr :_fill_rule {
  cairo_set_fill_rule((cairo_t *)(long)v__cr, (cairo_fill_rule_t)(long)v__fill_rule);
}
libcairo cairo_set_line_width :cr :width [
    | _ |
    _ := self _cairo_set_line_width : cr : width asFloat.
    ^_
]
libcairo _cairo_set_line_width :_cr :_width {
  double width;
  memcpy(&width, v__width, sizeof(double));
  cairo_set_line_width((cairo_t *)(long)v__cr, width);
}
" enum cairo_line_cap_t "
libcairo CAIRO_LINE_CAP_BUTT [ ^SmallInteger value_: self _CAIRO_LINE_CAP_BUTT ]
libcairo _CAIRO_LINE_CAP_BUTT { return (oop)(0); }
libcairo CAIRO_LINE_CAP_ROUND [ ^SmallInteger value_: self _CAIRO_LINE_CAP_ROUND ]
libcairo _CAIRO_LINE_CAP_ROUND { return (oop)(1); }
libcairo CAIRO_LINE_CAP_SQUARE [ ^SmallInteger value_: self _CAIRO_LINE_CAP_SQUARE ]
libcairo _CAIRO_LINE_CAP_SQUARE { return (oop)(2); }
libcairo cairo_set_line_cap :cr :line_cap [
    | _ |
    _ := self _cairo_set_line_cap : cr : line_cap _integerValue.
    ^_
]
libcairo _cairo_set_line_cap :_cr :_line_cap {
  cairo_set_line_cap((cairo_t *)(long)v__cr, (cairo_line_cap_t)(long)v__line_cap);
}
" enum cairo_line_join_t "
libcairo CAIRO_LINE_JOIN_MITER [ ^SmallInteger value_: self _CAIRO_LINE_JOIN_MITER ]
libcairo _CAIRO_LINE_JOIN_MITER { return (oop)(0); }
libcairo CAIRO_LINE_JOIN_ROUND [ ^SmallInteger value_: self _CAIRO_LINE_JOIN_ROUND ]
libcairo _CAIRO_LINE_JOIN_ROUND { return (oop)(1); }
libcairo CAIRO_LINE_JOIN_BEVEL [ ^SmallInteger value_: self _CAIRO_LINE_JOIN_BEVEL ]
libcairo _CAIRO_LINE_JOIN_BEVEL { return (oop)(2); }
libcairo cairo_set_line_join :cr :line_join [
    | _ |
    _ := self _cairo_set_line_join : cr : line_join _integerValue.
    ^_
]
libcairo _cairo_set_line_join :_cr :_line_join {
  cairo_set_line_join((cairo_t *)(long)v__cr, (cairo_line_join_t)(long)v__line_join);
}
libcairo cairo_set_dash :cr :dashes :num_dashes :offset [
    | _ |
    _ := self _cairo_set_dash : cr : dashes : num_dashes _integerValue : offset asFloat.
    ^_
]
libcairo _cairo_set_dash :_cr :_dashes :_num_dashes :_offset {
  double offset;
  memcpy(&offset, v__offset, sizeof(double));
  cairo_set_dash((cairo_t *)(long)v__cr, (double *)(long)v__dashes, (int)(long)v__num_dashes, offset);
}
libcairo cairo_set_miter_limit :cr :limit [
    | _ |
    _ := self _cairo_set_miter_limit : cr : limit asFloat.
    ^_
]
libcairo _cairo_set_miter_limit :_cr :_limit {
  double limit;
  memcpy(&limit, v__limit, sizeof(double));
  cairo_set_miter_limit((cairo_t *)(long)v__cr, limit);
}
libcairo cairo_translate :cr :tx :ty [
    | _ |
    _ := self _cairo_translate : cr : tx asFloat : ty asFloat.
    ^_
]
libcairo _cairo_translate :_cr :_tx :_ty {
  double tx;
  double ty;
  memcpy(&tx, v__tx, sizeof(double));
  memcpy(&ty, v__ty, sizeof(double));
  cairo_translate((cairo_t *)(long)v__cr, tx, ty);
}
libcairo cairo_scale :cr :sx :sy [
    | _ |
    _ := self _cairo_scale : cr : sx asFloat : sy asFloat.
    ^_
]
libcairo _cairo_scale :_cr :_sx :_sy {
  double sx;
  double sy;
  memcpy(&sx, v__sx, sizeof(double));
  memcpy(&sy, v__sy, sizeof(double));
  cairo_scale((cairo_t *)(long)v__cr, sx, sy);
}
libcairo cairo_rotate :cr :angle [
    | _ |
    _ := self _cairo_rotate : cr : angle asFloat.
    ^_
]
libcairo _cairo_rotate :_cr :_angle {
  double angle;
  memcpy(&angle, v__angle, sizeof(double));
  cairo_rotate((cairo_t *)(long)v__cr, angle);
}
libcairo cairo_transform :cr :matrix [
    | _ |
    _ := self _cairo_transform : cr : matrix.
    ^_
]
libcairo _cairo_transform :_cr :_matrix {
  cairo_transform((cairo_t *)(long)v__cr, (cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_set_matrix :cr :matrix [
    | _ |
    _ := self _cairo_set_matrix : cr : matrix.
    ^_
]
libcairo _cairo_set_matrix :_cr :_matrix {
  cairo_set_matrix((cairo_t *)(long)v__cr, (cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_identity_matrix :cr [
    | _ |
    _ := self _cairo_identity_matrix : cr.
    ^_
]
libcairo _cairo_identity_matrix :_cr {
  cairo_identity_matrix((cairo_t *)(long)v__cr);
}
libcairo cairo_user_to_device :cr :x :y [
    | _ |
    _ := self _cairo_user_to_device : cr : x : y.
    ^_
]
libcairo _cairo_user_to_device :_cr :_x :_y {
  cairo_user_to_device((cairo_t *)(long)v__cr, (double *)(long)v__x, (double *)(long)v__y);
}
libcairo cairo_user_to_device_distance :cr :dx :dy [
    | _ |
    _ := self _cairo_user_to_device_distance : cr : dx : dy.
    ^_
]
libcairo _cairo_user_to_device_distance :_cr :_dx :_dy {
  cairo_user_to_device_distance((cairo_t *)(long)v__cr, (double *)(long)v__dx, (double *)(long)v__dy);
}
libcairo cairo_device_to_user :cr :x :y [
    | _ |
    _ := self _cairo_device_to_user : cr : x : y.
    ^_
]
libcairo _cairo_device_to_user :_cr :_x :_y {
  cairo_device_to_user((cairo_t *)(long)v__cr, (double *)(long)v__x, (double *)(long)v__y);
}
libcairo cairo_device_to_user_distance :cr :dx :dy [
    | _ |
    _ := self _cairo_device_to_user_distance : cr : dx : dy.
    ^_
]
libcairo _cairo_device_to_user_distance :_cr :_dx :_dy {
  cairo_device_to_user_distance((cairo_t *)(long)v__cr, (double *)(long)v__dx, (double *)(long)v__dy);
}
libcairo cairo_new_path :cr [
    | _ |
    _ := self _cairo_new_path : cr.
    ^_
]
libcairo _cairo_new_path :_cr {
  cairo_new_path((cairo_t *)(long)v__cr);
}
libcairo cairo_move_to :cr :x :y [
    | _ |
    _ := self _cairo_move_to : cr : x asFloat : y asFloat.
    ^_
]
libcairo _cairo_move_to :_cr :_x :_y {
  double x;
  double y;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  cairo_move_to((cairo_t *)(long)v__cr, x, y);
}
libcairo cairo_new_sub_path :cr [
    | _ |
    _ := self _cairo_new_sub_path : cr.
    ^_
]
libcairo _cairo_new_sub_path :_cr {
  cairo_new_sub_path((cairo_t *)(long)v__cr);
}
libcairo cairo_line_to :cr :x :y [
    | _ |
    _ := self _cairo_line_to : cr : x asFloat : y asFloat.
    ^_
]
libcairo _cairo_line_to :_cr :_x :_y {
  double x;
  double y;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  cairo_line_to((cairo_t *)(long)v__cr, x, y);
}
libcairo cairo_curve_to :cr :x1 :y1 :x2 :y2 :x3 :y3 [
    | _ |
    _ := self _cairo_curve_to : cr : x1 asFloat : y1 asFloat : x2 asFloat : y2 asFloat : x3 asFloat : y3 asFloat.
    ^_
]
libcairo _cairo_curve_to :_cr :_x1 :_y1 :_x2 :_y2 :_x3 :_y3 {
  double x1;
  double y1;
  double x2;
  double y2;
  double x3;
  double y3;
  memcpy(&x1, v__x1, sizeof(double));
  memcpy(&y1, v__y1, sizeof(double));
  memcpy(&x2, v__x2, sizeof(double));
  memcpy(&y2, v__y2, sizeof(double));
  memcpy(&x3, v__x3, sizeof(double));
  memcpy(&y3, v__y3, sizeof(double));
  cairo_curve_to((cairo_t *)(long)v__cr, x1, y1, x2, y2, x3, y3);
}
libcairo cairo_arc :cr :xc :yc :radius :angle1 :angle2 [
    | _ |
    _ := self _cairo_arc : cr : xc asFloat : yc asFloat : radius asFloat : angle1 asFloat : angle2 asFloat.
    ^_
]
libcairo _cairo_arc :_cr :_xc :_yc :_radius :_angle1 :_angle2 {
  double xc;
  double yc;
  double radius;
  double angle1;
  double angle2;
  memcpy(&xc, v__xc, sizeof(double));
  memcpy(&yc, v__yc, sizeof(double));
  memcpy(&radius, v__radius, sizeof(double));
  memcpy(&angle1, v__angle1, sizeof(double));
  memcpy(&angle2, v__angle2, sizeof(double));
  cairo_arc((cairo_t *)(long)v__cr, xc, yc, radius, angle1, angle2);
}
libcairo cairo_arc_negative :cr :xc :yc :radius :angle1 :angle2 [
    | _ |
    _ := self _cairo_arc_negative : cr : xc asFloat : yc asFloat : radius asFloat : angle1 asFloat : angle2 asFloat.
    ^_
]
libcairo _cairo_arc_negative :_cr :_xc :_yc :_radius :_angle1 :_angle2 {
  double xc;
  double yc;
  double radius;
  double angle1;
  double angle2;
  memcpy(&xc, v__xc, sizeof(double));
  memcpy(&yc, v__yc, sizeof(double));
  memcpy(&radius, v__radius, sizeof(double));
  memcpy(&angle1, v__angle1, sizeof(double));
  memcpy(&angle2, v__angle2, sizeof(double));
  cairo_arc_negative((cairo_t *)(long)v__cr, xc, yc, radius, angle1, angle2);
}
libcairo cairo_rel_move_to :cr :dx :dy [
    | _ |
    _ := self _cairo_rel_move_to : cr : dx asFloat : dy asFloat.
    ^_
]
libcairo _cairo_rel_move_to :_cr :_dx :_dy {
  double dx;
  double dy;
  memcpy(&dx, v__dx, sizeof(double));
  memcpy(&dy, v__dy, sizeof(double));
  cairo_rel_move_to((cairo_t *)(long)v__cr, dx, dy);
}
libcairo cairo_rel_line_to :cr :dx :dy [
    | _ |
    _ := self _cairo_rel_line_to : cr : dx asFloat : dy asFloat.
    ^_
]
libcairo _cairo_rel_line_to :_cr :_dx :_dy {
  double dx;
  double dy;
  memcpy(&dx, v__dx, sizeof(double));
  memcpy(&dy, v__dy, sizeof(double));
  cairo_rel_line_to((cairo_t *)(long)v__cr, dx, dy);
}
libcairo cairo_rel_curve_to :cr :dx1 :dy1 :dx2 :dy2 :dx3 :dy3 [
    | _ |
    _ := self _cairo_rel_curve_to : cr : dx1 asFloat : dy1 asFloat : dx2 asFloat : dy2 asFloat : dx3 asFloat : dy3 asFloat.
    ^_
]
libcairo _cairo_rel_curve_to :_cr :_dx1 :_dy1 :_dx2 :_dy2 :_dx3 :_dy3 {
  double dx1;
  double dy1;
  double dx2;
  double dy2;
  double dx3;
  double dy3;
  memcpy(&dx1, v__dx1, sizeof(double));
  memcpy(&dy1, v__dy1, sizeof(double));
  memcpy(&dx2, v__dx2, sizeof(double));
  memcpy(&dy2, v__dy2, sizeof(double));
  memcpy(&dx3, v__dx3, sizeof(double));
  memcpy(&dy3, v__dy3, sizeof(double));
  cairo_rel_curve_to((cairo_t *)(long)v__cr, dx1, dy1, dx2, dy2, dx3, dy3);
}
libcairo cairo_rectangle :cr :x :y :width :height [
    | _ |
    _ := self _cairo_rectangle : cr : x asFloat : y asFloat : width asFloat : height asFloat.
    ^_
]
libcairo _cairo_rectangle :_cr :_x :_y :_width :_height {
  double x;
  double y;
  double width;
  double height;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  memcpy(&width, v__width, sizeof(double));
  memcpy(&height, v__height, sizeof(double));
  cairo_rectangle((cairo_t *)(long)v__cr, x, y, width, height);
}
libcairo cairo_close_path :cr [
    | _ |
    _ := self _cairo_close_path : cr.
    ^_
]
libcairo _cairo_close_path :_cr {
  cairo_close_path((cairo_t *)(long)v__cr);
}
libcairo cairo_paint :cr [
    | _ |
    _ := self _cairo_paint : cr.
    ^_
]
libcairo _cairo_paint :_cr {
  cairo_paint((cairo_t *)(long)v__cr);
}
libcairo cairo_paint_with_alpha :cr :alpha [
    | _ |
    _ := self _cairo_paint_with_alpha : cr : alpha asFloat.
    ^_
]
libcairo _cairo_paint_with_alpha :_cr :_alpha {
  double alpha;
  memcpy(&alpha, v__alpha, sizeof(double));
  cairo_paint_with_alpha((cairo_t *)(long)v__cr, alpha);
}
libcairo cairo_mask :cr :pattern [
    | _ |
    _ := self _cairo_mask : cr : pattern.
    ^_
]
libcairo _cairo_mask :_cr :_pattern {
  cairo_mask((cairo_t *)(long)v__cr, (cairo_pattern_t *)(long)v__pattern);
}
libcairo cairo_mask_surface :cr :surface :surface_x :surface_y [
    | _ |
    _ := self _cairo_mask_surface : cr : surface : surface_x asFloat : surface_y asFloat.
    ^_
]
libcairo _cairo_mask_surface :_cr :_surface :_surface_x :_surface_y {
  double surface_x;
  double surface_y;
  memcpy(&surface_x, v__surface_x, sizeof(double));
  memcpy(&surface_y, v__surface_y, sizeof(double));
  cairo_mask_surface((cairo_t *)(long)v__cr, (cairo_surface_t *)(long)v__surface, surface_x, surface_y);
}
libcairo cairo_stroke :cr [
    | _ |
    _ := self _cairo_stroke : cr.
    ^_
]
libcairo _cairo_stroke :_cr {
  cairo_stroke((cairo_t *)(long)v__cr);
}
libcairo cairo_stroke_preserve :cr [
    | _ |
    _ := self _cairo_stroke_preserve : cr.
    ^_
]
libcairo _cairo_stroke_preserve :_cr {
  cairo_stroke_preserve((cairo_t *)(long)v__cr);
}
libcairo cairo_fill :cr [
    | _ |
    _ := self _cairo_fill : cr.
    ^_
]
libcairo _cairo_fill :_cr {
  cairo_fill((cairo_t *)(long)v__cr);
}
libcairo cairo_fill_preserve :cr [
    | _ |
    _ := self _cairo_fill_preserve : cr.
    ^_
]
libcairo _cairo_fill_preserve :_cr {
  cairo_fill_preserve((cairo_t *)(long)v__cr);
}
libcairo cairo_copy_page :cr [
    | _ |
    _ := self _cairo_copy_page : cr.
    ^_
]
libcairo _cairo_copy_page :_cr {
  cairo_copy_page((cairo_t *)(long)v__cr);
}
libcairo cairo_show_page :cr [
    | _ |
    _ := self _cairo_show_page : cr.
    ^_
]
libcairo _cairo_show_page :_cr {
  cairo_show_page((cairo_t *)(long)v__cr);
}
libcairo _cairo_in_stroke :_cr :_x :_y {
  cairo_bool_t _;
  double x;
  double y;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  _=(cairo_bool_t)cairo_in_stroke((cairo_t *)(long)v__cr, x, y);
  return (oop)(long)_;
}
libcairo _cairo_in_fill :_cr :_x :_y {
  cairo_bool_t _;
  double x;
  double y;
  memcpy(&x, v__x, sizeof(double));
  memcpy(&y, v__y, sizeof(double));
  _=(cairo_bool_t)cairo_in_fill((cairo_t *)(long)v__cr, x, y);
  return (oop)(long)_;
}
libcairo cairo_stroke_extents :cr :x1 :y1 :x2 :y2 [
    | _ |
    _ := self _cairo_stroke_extents : cr : x1 : y1 : x2 : y2.
    ^_
]
libcairo _cairo_stroke_extents :_cr :_x1 :_y1 :_x2 :_y2 {
  cairo_stroke_extents((cairo_t *)(long)v__cr, (double *)(long)v__x1, (double *)(long)v__y1, (double *)(long)v__x2, (double *)(long)v__y2);
}
libcairo cairo_fill_extents :cr :x1 :y1 :x2 :y2 [
    | _ |
    _ := self _cairo_fill_extents : cr : x1 : y1 : x2 : y2.
    ^_
]
libcairo _cairo_fill_extents :_cr :_x1 :_y1 :_x2 :_y2 {
  cairo_fill_extents((cairo_t *)(long)v__cr, (double *)(long)v__x1, (double *)(long)v__y1, (double *)(long)v__x2, (double *)(long)v__y2);
}
libcairo cairo_reset_clip :cr [
    | _ |
    _ := self _cairo_reset_clip : cr.
    ^_
]
libcairo _cairo_reset_clip :_cr {
  cairo_reset_clip((cairo_t *)(long)v__cr);
}
libcairo cairo_clip :cr [
    | _ |
    _ := self _cairo_clip : cr.
    ^_
]
libcairo _cairo_clip :_cr {
  cairo_clip((cairo_t *)(long)v__cr);
}
libcairo cairo_clip_preserve :cr [
    | _ |
    _ := self _cairo_clip_preserve : cr.
    ^_
]
libcairo _cairo_clip_preserve :_cr {
  cairo_clip_preserve((cairo_t *)(long)v__cr);
}
" struct cairo_glyph_t "
" struct cairo_text_extents_t "
" struct cairo_font_extents_t "
" enum cairo_font_slant_t "
libcairo CAIRO_FONT_SLANT_NORMAL [ ^SmallInteger value_: self _CAIRO_FONT_SLANT_NORMAL ]
libcairo _CAIRO_FONT_SLANT_NORMAL { return (oop)(0); }
libcairo CAIRO_FONT_SLANT_ITALIC [ ^SmallInteger value_: self _CAIRO_FONT_SLANT_ITALIC ]
libcairo _CAIRO_FONT_SLANT_ITALIC { return (oop)(1); }
libcairo CAIRO_FONT_SLANT_OBLIQUE [ ^SmallInteger value_: self _CAIRO_FONT_SLANT_OBLIQUE ]
libcairo _CAIRO_FONT_SLANT_OBLIQUE { return (oop)(2); }
" enum cairo_font_weight_t "
libcairo CAIRO_FONT_WEIGHT_NORMAL [ ^SmallInteger value_: self _CAIRO_FONT_WEIGHT_NORMAL ]
libcairo _CAIRO_FONT_WEIGHT_NORMAL { return (oop)(0); }
libcairo CAIRO_FONT_WEIGHT_BOLD [ ^SmallInteger value_: self _CAIRO_FONT_WEIGHT_BOLD ]
libcairo _CAIRO_FONT_WEIGHT_BOLD { return (oop)(1); }
" enum cairo_subpixel_order_t "
libcairo CAIRO_SUBPIXEL_ORDER_DEFAULT [ ^SmallInteger value_: self _CAIRO_SUBPIXEL_ORDER_DEFAULT ]
libcairo _CAIRO_SUBPIXEL_ORDER_DEFAULT { return (oop)(0); }
libcairo CAIRO_SUBPIXEL_ORDER_RGB [ ^SmallInteger value_: self _CAIRO_SUBPIXEL_ORDER_RGB ]
libcairo _CAIRO_SUBPIXEL_ORDER_RGB { return (oop)(1); }
libcairo CAIRO_SUBPIXEL_ORDER_BGR [ ^SmallInteger value_: self _CAIRO_SUBPIXEL_ORDER_BGR ]
libcairo _CAIRO_SUBPIXEL_ORDER_BGR { return (oop)(2); }
libcairo CAIRO_SUBPIXEL_ORDER_VRGB [ ^SmallInteger value_: self _CAIRO_SUBPIXEL_ORDER_VRGB ]
libcairo _CAIRO_SUBPIXEL_ORDER_VRGB { return (oop)(3); }
libcairo CAIRO_SUBPIXEL_ORDER_VBGR [ ^SmallInteger value_: self _CAIRO_SUBPIXEL_ORDER_VBGR ]
libcairo _CAIRO_SUBPIXEL_ORDER_VBGR { return (oop)(4); }
" enum cairo_hint_style_t "
libcairo CAIRO_HINT_STYLE_DEFAULT [ ^SmallInteger value_: self _CAIRO_HINT_STYLE_DEFAULT ]
libcairo _CAIRO_HINT_STYLE_DEFAULT { return (oop)(0); }
libcairo CAIRO_HINT_STYLE_NONE [ ^SmallInteger value_: self _CAIRO_HINT_STYLE_NONE ]
libcairo _CAIRO_HINT_STYLE_NONE { return (oop)(1); }
libcairo CAIRO_HINT_STYLE_SLIGHT [ ^SmallInteger value_: self _CAIRO_HINT_STYLE_SLIGHT ]
libcairo _CAIRO_HINT_STYLE_SLIGHT { return (oop)(2); }
libcairo CAIRO_HINT_STYLE_MEDIUM [ ^SmallInteger value_: self _CAIRO_HINT_STYLE_MEDIUM ]
libcairo _CAIRO_HINT_STYLE_MEDIUM { return (oop)(3); }
libcairo CAIRO_HINT_STYLE_FULL [ ^SmallInteger value_: self _CAIRO_HINT_STYLE_FULL ]
libcairo _CAIRO_HINT_STYLE_FULL { return (oop)(4); }
" enum cairo_hint_metrics_t "
libcairo CAIRO_HINT_METRICS_DEFAULT [ ^SmallInteger value_: self _CAIRO_HINT_METRICS_DEFAULT ]
libcairo _CAIRO_HINT_METRICS_DEFAULT { return (oop)(0); }
libcairo CAIRO_HINT_METRICS_OFF [ ^SmallInteger value_: self _CAIRO_HINT_METRICS_OFF ]
libcairo _CAIRO_HINT_METRICS_OFF { return (oop)(1); }
libcairo CAIRO_HINT_METRICS_ON [ ^SmallInteger value_: self _CAIRO_HINT_METRICS_ON ]
libcairo _CAIRO_HINT_METRICS_ON { return (oop)(2); }
libcairo _cairo_font_options_create {
  cairo_font_options_t * _;
  _=(cairo_font_options_t *)cairo_font_options_create();
  return (oop)(long)_;
}
libcairo _cairo_font_options_copy :_original {
  cairo_font_options_t * _;
  _=(cairo_font_options_t *)cairo_font_options_copy((cairo_font_options_t *)(long)v__original);
  return (oop)(long)_;
}
libcairo cairo_font_options_destroy :options [
    | _ |
    _ := self _cairo_font_options_destroy : options.
    ^_
]
libcairo _cairo_font_options_destroy :_options {
  cairo_font_options_destroy((cairo_font_options_t *)(long)v__options);
}
libcairo cairo_font_options_status :options [
    | _ |
    _ := self _cairo_font_options_status : options.
    ^SmallInteger value_: _
]
libcairo _cairo_font_options_status :_options {
  cairo_status_t _;
  _=(cairo_status_t)cairo_font_options_status((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_font_options_merge :options :other [
    | _ |
    _ := self _cairo_font_options_merge : options : other.
    ^_
]
libcairo _cairo_font_options_merge :_options :_other {
  cairo_font_options_merge((cairo_font_options_t *)(long)v__options, (cairo_font_options_t *)(long)v__other);
}
libcairo _cairo_font_options_equal :_options :_other {
  cairo_bool_t _;
  _=(cairo_bool_t)cairo_font_options_equal((cairo_font_options_t *)(long)v__options, (cairo_font_options_t *)(long)v__other);
  return (oop)(long)_;
}
libcairo _cairo_font_options_hash :_options {
  unsigned long _;
  _=(unsigned long)cairo_font_options_hash((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_font_options_set_antialias :options :antialias [
    | _ |
    _ := self _cairo_font_options_set_antialias : options : antialias _integerValue.
    ^_
]
libcairo _cairo_font_options_set_antialias :_options :_antialias {
  cairo_font_options_set_antialias((cairo_font_options_t *)(long)v__options, (cairo_antialias_t)(long)v__antialias);
}
libcairo cairo_font_options_get_antialias :options [
    | _ |
    _ := self _cairo_font_options_get_antialias : options.
    ^SmallInteger value_: _
]
libcairo _cairo_font_options_get_antialias :_options {
  cairo_antialias_t _;
  _=(cairo_antialias_t)cairo_font_options_get_antialias((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_font_options_set_subpixel_order :options :subpixel_order [
    | _ |
    _ := self _cairo_font_options_set_subpixel_order : options : subpixel_order _integerValue.
    ^_
]
libcairo _cairo_font_options_set_subpixel_order :_options :_subpixel_order {
  cairo_font_options_set_subpixel_order((cairo_font_options_t *)(long)v__options, (cairo_subpixel_order_t)(long)v__subpixel_order);
}
libcairo cairo_font_options_get_subpixel_order :options [
    | _ |
    _ := self _cairo_font_options_get_subpixel_order : options.
    ^SmallInteger value_: _
]
libcairo _cairo_font_options_get_subpixel_order :_options {
  cairo_subpixel_order_t _;
  _=(cairo_subpixel_order_t)cairo_font_options_get_subpixel_order((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_font_options_set_hint_style :options :hint_style [
    | _ |
    _ := self _cairo_font_options_set_hint_style : options : hint_style _integerValue.
    ^_
]
libcairo _cairo_font_options_set_hint_style :_options :_hint_style {
  cairo_font_options_set_hint_style((cairo_font_options_t *)(long)v__options, (cairo_hint_style_t)(long)v__hint_style);
}
libcairo cairo_font_options_get_hint_style :options [
    | _ |
    _ := self _cairo_font_options_get_hint_style : options.
    ^SmallInteger value_: _
]
libcairo _cairo_font_options_get_hint_style :_options {
  cairo_hint_style_t _;
  _=(cairo_hint_style_t)cairo_font_options_get_hint_style((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_font_options_set_hint_metrics :options :hint_metrics [
    | _ |
    _ := self _cairo_font_options_set_hint_metrics : options : hint_metrics _integerValue.
    ^_
]
libcairo _cairo_font_options_set_hint_metrics :_options :_hint_metrics {
  cairo_font_options_set_hint_metrics((cairo_font_options_t *)(long)v__options, (cairo_hint_metrics_t)(long)v__hint_metrics);
}
libcairo cairo_font_options_get_hint_metrics :options [
    | _ |
    _ := self _cairo_font_options_get_hint_metrics : options.
    ^SmallInteger value_: _
]
libcairo _cairo_font_options_get_hint_metrics :_options {
  cairo_hint_metrics_t _;
  _=(cairo_hint_metrics_t)cairo_font_options_get_hint_metrics((cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo cairo_select_font_face :cr :family :slant :weight [
    | _ |
    _ := self _cairo_select_font_face : cr : family _stringValue : slant _integerValue : weight _integerValue.
    ^_
]
libcairo _cairo_select_font_face :_cr :_family :_slant :_weight {
  cairo_select_font_face((cairo_t *)(long)v__cr, (char *)(long)v__family, (cairo_font_slant_t)(long)v__slant, (cairo_font_weight_t)(long)v__weight);
}
libcairo cairo_set_font_size :cr :size [
    | _ |
    _ := self _cairo_set_font_size : cr : size asFloat.
    ^_
]
libcairo _cairo_set_font_size :_cr :_size {
  double size;
  memcpy(&size, v__size, sizeof(double));
  cairo_set_font_size((cairo_t *)(long)v__cr, size);
}
libcairo cairo_set_font_matrix :cr :matrix [
    | _ |
    _ := self _cairo_set_font_matrix : cr : matrix.
    ^_
]
libcairo _cairo_set_font_matrix :_cr :_matrix {
  cairo_set_font_matrix((cairo_t *)(long)v__cr, (cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_get_font_matrix :cr :matrix [
    | _ |
    _ := self _cairo_get_font_matrix : cr : matrix.
    ^_
]
libcairo _cairo_get_font_matrix :_cr :_matrix {
  cairo_get_font_matrix((cairo_t *)(long)v__cr, (cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_set_font_options :cr :options [
    | _ |
    _ := self _cairo_set_font_options : cr : options.
    ^_
]
libcairo _cairo_set_font_options :_cr :_options {
  cairo_set_font_options((cairo_t *)(long)v__cr, (cairo_font_options_t *)(long)v__options);
}
libcairo cairo_get_font_options :cr :options [
    | _ |
    _ := self _cairo_get_font_options : cr : options.
    ^_
]
libcairo _cairo_get_font_options :_cr :_options {
  cairo_get_font_options((cairo_t *)(long)v__cr, (cairo_font_options_t *)(long)v__options);
}
libcairo cairo_set_scaled_font :cr :scaled_font [
    | _ |
    _ := self _cairo_set_scaled_font : cr : scaled_font.
    ^_
]
libcairo _cairo_set_scaled_font :_cr :_scaled_font {
  cairo_set_scaled_font((cairo_t *)(long)v__cr, (cairo_scaled_font_t *)(long)v__scaled_font);
}
libcairo cairo_show_text :cr :utf8 [
    | _ |
    _ := self _cairo_show_text : cr : utf8 _stringValue.
    ^_
]
libcairo _cairo_show_text :_cr :_utf8 {
  cairo_show_text((cairo_t *)(long)v__cr, (char *)(long)v__utf8);
}
libcairo cairo_show_glyphs :cr :glyphs :num_glyphs [
    | _ |
    _ := self _cairo_show_glyphs : cr : glyphs : num_glyphs _integerValue.
    ^_
]
libcairo _cairo_show_glyphs :_cr :_glyphs :_num_glyphs {
  cairo_show_glyphs((cairo_t *)(long)v__cr, (cairo_glyph_t *)(long)v__glyphs, (int)(long)v__num_glyphs);
}
libcairo _cairo_get_font_face :_cr {
  cairo_font_face_t * _;
  _=(cairo_font_face_t *)cairo_get_font_face((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_font_extents :cr :extents [
    | _ |
    _ := self _cairo_font_extents : cr : extents.
    ^_
]
libcairo _cairo_font_extents :_cr :_extents {
  cairo_font_extents((cairo_t *)(long)v__cr, (cairo_font_extents_t *)(long)v__extents);
}
libcairo cairo_set_font_face :cr :font_face [
    | _ |
    _ := self _cairo_set_font_face : cr : font_face.
    ^_
]
libcairo _cairo_set_font_face :_cr :_font_face {
  cairo_set_font_face((cairo_t *)(long)v__cr, (cairo_font_face_t *)(long)v__font_face);
}
libcairo cairo_text_extents :cr :utf8 :extents [
    | _ |
    _ := self _cairo_text_extents : cr : utf8 _stringValue : extents.
    ^_
]
libcairo _cairo_text_extents :_cr :_utf8 :_extents {
  cairo_text_extents((cairo_t *)(long)v__cr, (char *)(long)v__utf8, (cairo_text_extents_t *)(long)v__extents);
}
libcairo cairo_glyph_extents :cr :glyphs :num_glyphs :extents [
    | _ |
    _ := self _cairo_glyph_extents : cr : glyphs : num_glyphs _integerValue : extents.
    ^_
]
libcairo _cairo_glyph_extents :_cr :_glyphs :_num_glyphs :_extents {
  cairo_glyph_extents((cairo_t *)(long)v__cr, (cairo_glyph_t *)(long)v__glyphs, (int)(long)v__num_glyphs, (cairo_text_extents_t *)(long)v__extents);
}
libcairo cairo_text_path :cr :utf8 [
    | _ |
    _ := self _cairo_text_path : cr : utf8 _stringValue.
    ^_
]
libcairo _cairo_text_path :_cr :_utf8 {
  cairo_text_path((cairo_t *)(long)v__cr, (char *)(long)v__utf8);
}
libcairo cairo_glyph_path :cr :glyphs :num_glyphs [
    | _ |
    _ := self _cairo_glyph_path : cr : glyphs : num_glyphs _integerValue.
    ^_
]
libcairo _cairo_glyph_path :_cr :_glyphs :_num_glyphs {
  cairo_glyph_path((cairo_t *)(long)v__cr, (cairo_glyph_t *)(long)v__glyphs, (int)(long)v__num_glyphs);
}
libcairo _cairo_font_face_reference :_font_face {
  cairo_font_face_t * _;
  _=(cairo_font_face_t *)cairo_font_face_reference((cairo_font_face_t *)(long)v__font_face);
  return (oop)(long)_;
}
libcairo cairo_font_face_destroy :font_face [
    | _ |
    _ := self _cairo_font_face_destroy : font_face.
    ^_
]
libcairo _cairo_font_face_destroy :_font_face {
  cairo_font_face_destroy((cairo_font_face_t *)(long)v__font_face);
}
libcairo cairo_font_face_status :font_face [
    | _ |
    _ := self _cairo_font_face_status : font_face.
    ^SmallInteger value_: _
]
libcairo _cairo_font_face_status :_font_face {
  cairo_status_t _;
  _=(cairo_status_t)cairo_font_face_status((cairo_font_face_t *)(long)v__font_face);
  return (oop)(long)_;
}
" enum cairo_font_type_t "
libcairo CAIRO_FONT_TYPE_TOY [ ^SmallInteger value_: self _CAIRO_FONT_TYPE_TOY ]
libcairo _CAIRO_FONT_TYPE_TOY { return (oop)(0); }
libcairo CAIRO_FONT_TYPE_FT [ ^SmallInteger value_: self _CAIRO_FONT_TYPE_FT ]
libcairo _CAIRO_FONT_TYPE_FT { return (oop)(1); }
libcairo CAIRO_FONT_TYPE_WIN32 [ ^SmallInteger value_: self _CAIRO_FONT_TYPE_WIN32 ]
libcairo _CAIRO_FONT_TYPE_WIN32 { return (oop)(2); }
libcairo CAIRO_FONT_TYPE_ATSUI [ ^SmallInteger value_: self _CAIRO_FONT_TYPE_ATSUI ]
libcairo _CAIRO_FONT_TYPE_ATSUI { return (oop)(3); }
libcairo cairo_font_face_get_type :font_face [
    | _ |
    _ := self _cairo_font_face_get_type : font_face.
    ^SmallInteger value_: _
]
libcairo _cairo_font_face_get_type :_font_face {
  cairo_font_type_t _;
  _=(cairo_font_type_t)cairo_font_face_get_type((cairo_font_face_t *)(long)v__font_face);
  return (oop)(long)_;
}
libcairo _cairo_font_face_get_user_data :_font_face :_key {
  void * _;
  _=(void *)cairo_font_face_get_user_data((cairo_font_face_t *)(long)v__font_face, (cairo_user_data_key_t *)(long)v__key);
  return (oop)(long)_;
}
libcairo cairo_font_face_set_user_data :font_face :key :user_data :destroy [
    | _ |
    _ := self _cairo_font_face_set_user_data : font_face : key : user_data : destroy.
    ^SmallInteger value_: _
]
libcairo _cairo_font_face_set_user_data :_font_face :_key :_user_data :_destroy {
  cairo_status_t _;
  _=(cairo_status_t)cairo_font_face_set_user_data((cairo_font_face_t *)(long)v__font_face, (cairo_user_data_key_t *)(long)v__key, (void *)(long)v__user_data, (void *)(long)v__destroy);
  return (oop)(long)_;
}
libcairo _cairo_scaled_font_create :_font_face :_font_matrix :_ctm :_options {
  cairo_scaled_font_t * _;
  _=(cairo_scaled_font_t *)cairo_scaled_font_create((cairo_font_face_t *)(long)v__font_face, (cairo_matrix_t *)(long)v__font_matrix, (cairo_matrix_t *)(long)v__ctm, (cairo_font_options_t *)(long)v__options);
  return (oop)(long)_;
}
libcairo _cairo_scaled_font_reference :_scaled_font {
  cairo_scaled_font_t * _;
  _=(cairo_scaled_font_t *)cairo_scaled_font_reference((cairo_scaled_font_t *)(long)v__scaled_font);
  return (oop)(long)_;
}
libcairo cairo_scaled_font_destroy :scaled_font [
    | _ |
    _ := self _cairo_scaled_font_destroy : scaled_font.
    ^_
]
libcairo _cairo_scaled_font_destroy :_scaled_font {
  cairo_scaled_font_destroy((cairo_scaled_font_t *)(long)v__scaled_font);
}
libcairo cairo_scaled_font_status :scaled_font [
    | _ |
    _ := self _cairo_scaled_font_status : scaled_font.
    ^SmallInteger value_: _
]
libcairo _cairo_scaled_font_status :_scaled_font {
  cairo_status_t _;
  _=(cairo_status_t)cairo_scaled_font_status((cairo_scaled_font_t *)(long)v__scaled_font);
  return (oop)(long)_;
}
libcairo cairo_scaled_font_get_type :scaled_font [
    | _ |
    _ := self _cairo_scaled_font_get_type : scaled_font.
    ^SmallInteger value_: _
]
libcairo _cairo_scaled_font_get_type :_scaled_font {
  cairo_font_type_t _;
  _=(cairo_font_type_t)cairo_scaled_font_get_type((cairo_scaled_font_t *)(long)v__scaled_font);
  return (oop)(long)_;
}
libcairo cairo_scaled_font_extents :scaled_font :extents [
    | _ |
    _ := self _cairo_scaled_font_extents : scaled_font : extents.
    ^_
]
libcairo _cairo_scaled_font_extents :_scaled_font :_extents {
  cairo_scaled_font_extents((cairo_scaled_font_t *)(long)v__scaled_font, (cairo_font_extents_t *)(long)v__extents);
}
libcairo cairo_scaled_font_text_extents :scaled_font :utf8 :extents [
    | _ |
    _ := self _cairo_scaled_font_text_extents : scaled_font : utf8 _stringValue : extents.
    ^_
]
libcairo _cairo_scaled_font_text_extents :_scaled_font :_utf8 :_extents {
  cairo_scaled_font_text_extents((cairo_scaled_font_t *)(long)v__scaled_font, (char *)(long)v__utf8, (cairo_text_extents_t *)(long)v__extents);
}
libcairo cairo_scaled_font_glyph_extents :scaled_font :glyphs :num_glyphs :extents [
    | _ |
    _ := self _cairo_scaled_font_glyph_extents : scaled_font : glyphs : num_glyphs _integerValue : extents.
    ^_
]
libcairo _cairo_scaled_font_glyph_extents :_scaled_font :_glyphs :_num_glyphs :_extents {
  cairo_scaled_font_glyph_extents((cairo_scaled_font_t *)(long)v__scaled_font, (cairo_glyph_t *)(long)v__glyphs, (int)(long)v__num_glyphs, (cairo_text_extents_t *)(long)v__extents);
}
libcairo _cairo_scaled_font_get_font_face :_scaled_font {
  cairo_font_face_t * _;
  _=(cairo_font_face_t *)cairo_scaled_font_get_font_face((cairo_scaled_font_t *)(long)v__scaled_font);
  return (oop)(long)_;
}
libcairo cairo_scaled_font_get_font_matrix :scaled_font :font_matrix [
    | _ |
    _ := self _cairo_scaled_font_get_font_matrix : scaled_font : font_matrix.
    ^_
]
libcairo _cairo_scaled_font_get_font_matrix :_scaled_font :_font_matrix {
  cairo_scaled_font_get_font_matrix((cairo_scaled_font_t *)(long)v__scaled_font, (cairo_matrix_t *)(long)v__font_matrix);
}
libcairo cairo_scaled_font_get_ctm :scaled_font :ctm [
    | _ |
    _ := self _cairo_scaled_font_get_ctm : scaled_font : ctm.
    ^_
]
libcairo _cairo_scaled_font_get_ctm :_scaled_font :_ctm {
  cairo_scaled_font_get_ctm((cairo_scaled_font_t *)(long)v__scaled_font, (cairo_matrix_t *)(long)v__ctm);
}
libcairo cairo_scaled_font_get_font_options :scaled_font :options [
    | _ |
    _ := self _cairo_scaled_font_get_font_options : scaled_font : options.
    ^_
]
libcairo _cairo_scaled_font_get_font_options :_scaled_font :_options {
  cairo_scaled_font_get_font_options((cairo_scaled_font_t *)(long)v__scaled_font, (cairo_font_options_t *)(long)v__options);
}
libcairo cairo_get_operator :cr [
    | _ |
    _ := self _cairo_get_operator : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_get_operator :_cr {
  cairo_operator_t _;
  _=(cairo_operator_t)cairo_get_operator((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo _cairo_get_source :_cr {
  cairo_pattern_t * _;
  _=(cairo_pattern_t *)cairo_get_source((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_get_tolerance :cr [
    | _ |
    _ := Float new.
    self _cairo_get_tolerance : cr : _.
    ^_
]
libcairo _cairo_get_tolerance :_cr :floatResult {
  double _;
  _=(double)cairo_get_tolerance((cairo_t *)(long)v__cr);
  memcpy(v_floatResult, &_, sizeof(double));
}
libcairo cairo_get_antialias :cr [
    | _ |
    _ := self _cairo_get_antialias : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_get_antialias :_cr {
  cairo_antialias_t _;
  _=(cairo_antialias_t)cairo_get_antialias((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_get_current_point :cr :x :y [
    | _ |
    _ := self _cairo_get_current_point : cr : x : y.
    ^_
]
libcairo _cairo_get_current_point :_cr :_x :_y {
  cairo_get_current_point((cairo_t *)(long)v__cr, (double *)(long)v__x, (double *)(long)v__y);
}
libcairo cairo_get_fill_rule :cr [
    | _ |
    _ := self _cairo_get_fill_rule : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_get_fill_rule :_cr {
  cairo_fill_rule_t _;
  _=(cairo_fill_rule_t)cairo_get_fill_rule((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_get_line_width :cr [
    | _ |
    _ := Float new.
    self _cairo_get_line_width : cr : _.
    ^_
]
libcairo _cairo_get_line_width :_cr :floatResult {
  double _;
  _=(double)cairo_get_line_width((cairo_t *)(long)v__cr);
  memcpy(v_floatResult, &_, sizeof(double));
}
libcairo cairo_get_line_cap :cr [
    | _ |
    _ := self _cairo_get_line_cap : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_get_line_cap :_cr {
  cairo_line_cap_t _;
  _=(cairo_line_cap_t)cairo_get_line_cap((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_get_line_join :cr [
    | _ |
    _ := self _cairo_get_line_join : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_get_line_join :_cr {
  cairo_line_join_t _;
  _=(cairo_line_join_t)cairo_get_line_join((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_get_miter_limit :cr [
    | _ |
    _ := Float new.
    self _cairo_get_miter_limit : cr : _.
    ^_
]
libcairo _cairo_get_miter_limit :_cr :floatResult {
  double _;
  _=(double)cairo_get_miter_limit((cairo_t *)(long)v__cr);
  memcpy(v_floatResult, &_, sizeof(double));
}
libcairo cairo_get_matrix :cr :matrix [
    | _ |
    _ := self _cairo_get_matrix : cr : matrix.
    ^_
]
libcairo _cairo_get_matrix :_cr :_matrix {
  cairo_get_matrix((cairo_t *)(long)v__cr, (cairo_matrix_t *)(long)v__matrix);
}
libcairo _cairo_get_target :_cr {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_get_target((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo _cairo_get_group_target :_cr {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_get_group_target((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
" enum cairo_path_data_type_t "
libcairo CAIRO_PATH_MOVE_TO [ ^SmallInteger value_: self _CAIRO_PATH_MOVE_TO ]
libcairo _CAIRO_PATH_MOVE_TO { return (oop)(0); }
libcairo CAIRO_PATH_LINE_TO [ ^SmallInteger value_: self _CAIRO_PATH_LINE_TO ]
libcairo _CAIRO_PATH_LINE_TO { return (oop)(1); }
libcairo CAIRO_PATH_CURVE_TO [ ^SmallInteger value_: self _CAIRO_PATH_CURVE_TO ]
libcairo _CAIRO_PATH_CURVE_TO { return (oop)(2); }
libcairo CAIRO_PATH_CLOSE_PATH [ ^SmallInteger value_: self _CAIRO_PATH_CLOSE_PATH ]
libcairo _CAIRO_PATH_CLOSE_PATH { return (oop)(3); }
" union _cairo_path_data_t "
" struct _cairo_path_data_t_point "
" struct _cairo_path_data_t_header "
" struct cairo_path_t "
libcairo _cairo_copy_path :_cr {
  cairo_path_t * _;
  _=(cairo_path_t *)cairo_copy_path((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo _cairo_copy_path_flat :_cr {
  cairo_path_t * _;
  _=(cairo_path_t *)cairo_copy_path_flat((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_append_path :cr :path [
    | _ |
    _ := self _cairo_append_path : cr : path.
    ^_
]
libcairo _cairo_append_path :_cr :_path {
  cairo_append_path((cairo_t *)(long)v__cr, (cairo_path_t *)(long)v__path);
}
libcairo cairo_path_destroy :path [
    | _ |
    _ := self _cairo_path_destroy : path.
    ^_
]
libcairo _cairo_path_destroy :_path {
  cairo_path_destroy((cairo_path_t *)(long)v__path);
}
libcairo cairo_status :cr [
    | _ |
    _ := self _cairo_status : cr.
    ^SmallInteger value_: _
]
libcairo _cairo_status :_cr {
  cairo_status_t _;
  _=(cairo_status_t)cairo_status((cairo_t *)(long)v__cr);
  return (oop)(long)_;
}
libcairo cairo_status_to_string :status [
    | _ |
    _ := self _cairo_status_to_string : status _integerValue.
    ^String value_: _
]
libcairo _cairo_status_to_string :_status {
  char * _;
  _=(char *)cairo_status_to_string((cairo_status_t)(long)v__status);
  return (oop)(long)_;
}
libcairo _cairo_surface_create_similar :_other :_content :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_surface_create_similar((cairo_surface_t *)(long)v__other, (cairo_content_t)(long)v__content, (int)(long)v__width, (int)(long)v__height);
  return (oop)(long)_;
}
libcairo _cairo_surface_reference :_surface {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_surface_reference((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_surface_finish :surface [
    | _ |
    _ := self _cairo_surface_finish : surface.
    ^_
]
libcairo _cairo_surface_finish :_surface {
  cairo_surface_finish((cairo_surface_t *)(long)v__surface);
}
libcairo cairo_surface_destroy :surface [
    | _ |
    _ := self _cairo_surface_destroy : surface.
    ^_
]
libcairo _cairo_surface_destroy :_surface {
  cairo_surface_destroy((cairo_surface_t *)(long)v__surface);
}
libcairo cairo_surface_status :surface [
    | _ |
    _ := self _cairo_surface_status : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_status :_surface {
  cairo_status_t _;
  _=(cairo_status_t)cairo_surface_status((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
" enum cairo_surface_type_t "
libcairo CAIRO_SURFACE_TYPE_IMAGE [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_IMAGE ]
libcairo _CAIRO_SURFACE_TYPE_IMAGE { return (oop)(0); }
libcairo CAIRO_SURFACE_TYPE_PDF [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_PDF ]
libcairo _CAIRO_SURFACE_TYPE_PDF { return (oop)(1); }
libcairo CAIRO_SURFACE_TYPE_PS [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_PS ]
libcairo _CAIRO_SURFACE_TYPE_PS { return (oop)(2); }
libcairo CAIRO_SURFACE_TYPE_XLIB [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_XLIB ]
libcairo _CAIRO_SURFACE_TYPE_XLIB { return (oop)(3); }
libcairo CAIRO_SURFACE_TYPE_XCB [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_XCB ]
libcairo _CAIRO_SURFACE_TYPE_XCB { return (oop)(4); }
libcairo CAIRO_SURFACE_TYPE_GLITZ [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_GLITZ ]
libcairo _CAIRO_SURFACE_TYPE_GLITZ { return (oop)(5); }
libcairo CAIRO_SURFACE_TYPE_QUARTZ [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_QUARTZ ]
libcairo _CAIRO_SURFACE_TYPE_QUARTZ { return (oop)(6); }
libcairo CAIRO_SURFACE_TYPE_WIN32 [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_WIN32 ]
libcairo _CAIRO_SURFACE_TYPE_WIN32 { return (oop)(7); }
libcairo CAIRO_SURFACE_TYPE_BEOS [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_BEOS ]
libcairo _CAIRO_SURFACE_TYPE_BEOS { return (oop)(8); }
libcairo CAIRO_SURFACE_TYPE_DIRECTFB [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_DIRECTFB ]
libcairo _CAIRO_SURFACE_TYPE_DIRECTFB { return (oop)(9); }
libcairo CAIRO_SURFACE_TYPE_SVG [ ^SmallInteger value_: self _CAIRO_SURFACE_TYPE_SVG ]
libcairo _CAIRO_SURFACE_TYPE_SVG { return (oop)(10); }
libcairo cairo_surface_get_type :surface [
    | _ |
    _ := self _cairo_surface_get_type : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_get_type :_surface {
  cairo_surface_type_t _;
  _=(cairo_surface_type_t)cairo_surface_get_type((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_surface_get_content :surface [
    | _ |
    _ := self _cairo_surface_get_content : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_get_content :_surface {
  cairo_content_t _;
  _=(cairo_content_t)cairo_surface_get_content((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_surface_write_to_png :surface :filename [
    | _ |
    _ := self _cairo_surface_write_to_png : surface : filename _stringValue.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_write_to_png :_surface :_filename {
  cairo_status_t _;
  _=(cairo_status_t)cairo_surface_write_to_png((cairo_surface_t *)(long)v__surface, (char *)(long)v__filename);
  return (oop)(long)_;
}
libcairo cairo_surface_write_to_png_stream :surface :write_func :xclosure [
    | _ |
    _ := self _cairo_surface_write_to_png_stream : surface : write_func : xclosure.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_write_to_png_stream :_surface :_write_func :_xclosure {
  cairo_status_t _;
  _=(cairo_status_t)cairo_surface_write_to_png_stream((cairo_surface_t *)(long)v__surface, (void *)(long)v__write_func, (void *)(long)v__xclosure);
  return (oop)(long)_;
}
libcairo _cairo_surface_get_user_data :_surface :_key {
  void * _;
  _=(void *)cairo_surface_get_user_data((cairo_surface_t *)(long)v__surface, (cairo_user_data_key_t *)(long)v__key);
  return (oop)(long)_;
}
libcairo cairo_surface_set_user_data :surface :key :user_data :destroy [
    | _ |
    _ := self _cairo_surface_set_user_data : surface : key : user_data : destroy.
    ^SmallInteger value_: _
]
libcairo _cairo_surface_set_user_data :_surface :_key :_user_data :_destroy {
  cairo_status_t _;
  _=(cairo_status_t)cairo_surface_set_user_data((cairo_surface_t *)(long)v__surface, (cairo_user_data_key_t *)(long)v__key, (void *)(long)v__user_data, (void *)(long)v__destroy);
  return (oop)(long)_;
}
libcairo cairo_surface_get_font_options :surface :options [
    | _ |
    _ := self _cairo_surface_get_font_options : surface : options.
    ^_
]
libcairo _cairo_surface_get_font_options :_surface :_options {
  cairo_surface_get_font_options((cairo_surface_t *)(long)v__surface, (cairo_font_options_t *)(long)v__options);
}
libcairo cairo_surface_flush :surface [
    | _ |
    _ := self _cairo_surface_flush : surface.
    ^_
]
libcairo _cairo_surface_flush :_surface {
  cairo_surface_flush((cairo_surface_t *)(long)v__surface);
}
libcairo cairo_surface_mark_dirty :surface [
    | _ |
    _ := self _cairo_surface_mark_dirty : surface.
    ^_
]
libcairo _cairo_surface_mark_dirty :_surface {
  cairo_surface_mark_dirty((cairo_surface_t *)(long)v__surface);
}
libcairo cairo_surface_mark_dirty_rectangle :surface :x :y :width :height [
    | _ |
    _ := self _cairo_surface_mark_dirty_rectangle : surface : x _integerValue : y _integerValue : width _integerValue : height _integerValue.
    ^_
]
libcairo _cairo_surface_mark_dirty_rectangle :_surface :_x :_y :_width :_height {
  cairo_surface_mark_dirty_rectangle((cairo_surface_t *)(long)v__surface, (int)(long)v__x, (int)(long)v__y, (int)(long)v__width, (int)(long)v__height);
}
libcairo cairo_surface_set_device_offset :surface :x_offset :y_offset [
    | _ |
    _ := self _cairo_surface_set_device_offset : surface : x_offset asFloat : y_offset asFloat.
    ^_
]
libcairo _cairo_surface_set_device_offset :_surface :_x_offset :_y_offset {
  double x_offset;
  double y_offset;
  memcpy(&x_offset, v__x_offset, sizeof(double));
  memcpy(&y_offset, v__y_offset, sizeof(double));
  cairo_surface_set_device_offset((cairo_surface_t *)(long)v__surface, x_offset, y_offset);
}
libcairo cairo_surface_get_device_offset :surface :x_offset :y_offset [
    | _ |
    _ := self _cairo_surface_get_device_offset : surface : x_offset : y_offset.
    ^_
]
libcairo _cairo_surface_get_device_offset :_surface :_x_offset :_y_offset {
  cairo_surface_get_device_offset((cairo_surface_t *)(long)v__surface, (double *)(long)v__x_offset, (double *)(long)v__y_offset);
}
libcairo cairo_surface_set_fallback_resolution :surface :x_pixels_per_inch :y_pixels_per_inch [
    | _ |
    _ := self _cairo_surface_set_fallback_resolution : surface : x_pixels_per_inch asFloat : y_pixels_per_inch asFloat.
    ^_
]
libcairo _cairo_surface_set_fallback_resolution :_surface :_x_pixels_per_inch :_y_pixels_per_inch {
  double x_pixels_per_inch;
  double y_pixels_per_inch;
  memcpy(&x_pixels_per_inch, v__x_pixels_per_inch, sizeof(double));
  memcpy(&y_pixels_per_inch, v__y_pixels_per_inch, sizeof(double));
  cairo_surface_set_fallback_resolution((cairo_surface_t *)(long)v__surface, x_pixels_per_inch, y_pixels_per_inch);
}
" enum cairo_format_t "
libcairo CAIRO_FORMAT_ARGB32 [ ^SmallInteger value_: self _CAIRO_FORMAT_ARGB32 ]
libcairo _CAIRO_FORMAT_ARGB32 { return (oop)(0); }
libcairo CAIRO_FORMAT_RGB24 [ ^SmallInteger value_: self _CAIRO_FORMAT_RGB24 ]
libcairo _CAIRO_FORMAT_RGB24 { return (oop)(1); }
libcairo CAIRO_FORMAT_A8 [ ^SmallInteger value_: self _CAIRO_FORMAT_A8 ]
libcairo _CAIRO_FORMAT_A8 { return (oop)(2); }
libcairo CAIRO_FORMAT_A1 [ ^SmallInteger value_: self _CAIRO_FORMAT_A1 ]
libcairo _CAIRO_FORMAT_A1 { return (oop)(3); }
libcairo CAIRO_FORMAT_RGB16_565 [ ^SmallInteger value_: self _CAIRO_FORMAT_RGB16_565 ]
libcairo _CAIRO_FORMAT_RGB16_565 { return (oop)(4); }
libcairo _cairo_image_surface_create :_format :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_image_surface_create((cairo_format_t)(long)v__format, (int)(long)v__width, (int)(long)v__height);
  return (oop)(long)_;
}
libcairo _cairo_image_surface_create_for_data :_data :_format :_width :_height :_stride {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_image_surface_create_for_data((unsigned char *)(long)v__data, (cairo_format_t)(long)v__format, (int)(long)v__width, (int)(long)v__height, (int)(long)v__stride);
  return (oop)(long)_;
}
libcairo _cairo_image_surface_get_data :_surface {
  unsigned char * _;
  _=(unsigned char *)cairo_image_surface_get_data((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_image_surface_get_format :surface [
    | _ |
    _ := self _cairo_image_surface_get_format : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_image_surface_get_format :_surface {
  cairo_format_t _;
  _=(cairo_format_t)cairo_image_surface_get_format((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_image_surface_get_width :surface [
    | _ |
    _ := self _cairo_image_surface_get_width : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_image_surface_get_width :_surface {
  int _;
  _=(int)cairo_image_surface_get_width((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_image_surface_get_height :surface [
    | _ |
    _ := self _cairo_image_surface_get_height : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_image_surface_get_height :_surface {
  int _;
  _=(int)cairo_image_surface_get_height((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_image_surface_get_stride :surface [
    | _ |
    _ := self _cairo_image_surface_get_stride : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_image_surface_get_stride :_surface {
  int _;
  _=(int)cairo_image_surface_get_stride((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo _cairo_image_surface_create_from_png :_filename {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_image_surface_create_from_png((char *)(long)v__filename);
  return (oop)(long)_;
}
libcairo _cairo_image_surface_create_from_png_stream :_read_func :_xclosure {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_image_surface_create_from_png_stream((void *)(long)v__read_func, (void *)(long)v__xclosure);
  return (oop)(long)_;
}
libcairo _cairo_pattern_create_rgb :_red :_green :_blue {
  cairo_pattern_t * _;
  double red;
  double green;
  double blue;
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  _=(cairo_pattern_t *)cairo_pattern_create_rgb(red, green, blue);
  return (oop)(long)_;
}
libcairo _cairo_pattern_create_rgba :_red :_green :_blue :_alpha {
  cairo_pattern_t * _;
  double red;
  double green;
  double blue;
  double alpha;
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  memcpy(&alpha, v__alpha, sizeof(double));
  _=(cairo_pattern_t *)cairo_pattern_create_rgba(red, green, blue, alpha);
  return (oop)(long)_;
}
libcairo _cairo_pattern_create_for_surface :_surface {
  cairo_pattern_t * _;
  _=(cairo_pattern_t *)cairo_pattern_create_for_surface((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo _cairo_pattern_create_linear :_x0 :_y0 :_x1 :_y1 {
  cairo_pattern_t * _;
  double x0;
  double y0;
  double x1;
  double y1;
  memcpy(&x0, v__x0, sizeof(double));
  memcpy(&y0, v__y0, sizeof(double));
  memcpy(&x1, v__x1, sizeof(double));
  memcpy(&y1, v__y1, sizeof(double));
  _=(cairo_pattern_t *)cairo_pattern_create_linear(x0, y0, x1, y1);
  return (oop)(long)_;
}
libcairo _cairo_pattern_create_radial :_cx0 :_cy0 :_radius0 :_cx1 :_cy1 :_radius1 {
  cairo_pattern_t * _;
  double cx0;
  double cy0;
  double radius0;
  double cx1;
  double cy1;
  double radius1;
  memcpy(&cx0, v__cx0, sizeof(double));
  memcpy(&cy0, v__cy0, sizeof(double));
  memcpy(&radius0, v__radius0, sizeof(double));
  memcpy(&cx1, v__cx1, sizeof(double));
  memcpy(&cy1, v__cy1, sizeof(double));
  memcpy(&radius1, v__radius1, sizeof(double));
  _=(cairo_pattern_t *)cairo_pattern_create_radial(cx0, cy0, radius0, cx1, cy1, radius1);
  return (oop)(long)_;
}
libcairo _cairo_pattern_reference :_pattern {
  cairo_pattern_t * _;
  _=(cairo_pattern_t *)cairo_pattern_reference((cairo_pattern_t *)(long)v__pattern);
  return (oop)(long)_;
}
libcairo cairo_pattern_destroy :pattern [
    | _ |
    _ := self _cairo_pattern_destroy : pattern.
    ^_
]
libcairo _cairo_pattern_destroy :_pattern {
  cairo_pattern_destroy((cairo_pattern_t *)(long)v__pattern);
}
libcairo cairo_pattern_status :pattern [
    | _ |
    _ := self _cairo_pattern_status : pattern.
    ^SmallInteger value_: _
]
libcairo _cairo_pattern_status :_pattern {
  cairo_status_t _;
  _=(cairo_status_t)cairo_pattern_status((cairo_pattern_t *)(long)v__pattern);
  return (oop)(long)_;
}
" enum cairo_pattern_type_t "
libcairo CAIRO_PATTERN_TYPE_SOLID [ ^SmallInteger value_: self _CAIRO_PATTERN_TYPE_SOLID ]
libcairo _CAIRO_PATTERN_TYPE_SOLID { return (oop)(0); }
libcairo CAIRO_PATTERN_TYPE_SURFACE [ ^SmallInteger value_: self _CAIRO_PATTERN_TYPE_SURFACE ]
libcairo _CAIRO_PATTERN_TYPE_SURFACE { return (oop)(1); }
libcairo CAIRO_PATTERN_TYPE_LINEAR [ ^SmallInteger value_: self _CAIRO_PATTERN_TYPE_LINEAR ]
libcairo _CAIRO_PATTERN_TYPE_LINEAR { return (oop)(2); }
libcairo CAIRO_PATTERN_TYPE_RADIAL [ ^SmallInteger value_: self _CAIRO_PATTERN_TYPE_RADIAL ]
libcairo _CAIRO_PATTERN_TYPE_RADIAL { return (oop)(3); }
libcairo cairo_pattern_get_type :pattern [
    | _ |
    _ := self _cairo_pattern_get_type : pattern.
    ^SmallInteger value_: _
]
libcairo _cairo_pattern_get_type :_pattern {
  cairo_pattern_type_t _;
  _=(cairo_pattern_type_t)cairo_pattern_get_type((cairo_pattern_t *)(long)v__pattern);
  return (oop)(long)_;
}
libcairo cairo_pattern_add_color_stop_rgb :pattern :offset :red :green :blue [
    | _ |
    _ := self _cairo_pattern_add_color_stop_rgb : pattern : offset asFloat : red asFloat : green asFloat : blue asFloat.
    ^_
]
libcairo _cairo_pattern_add_color_stop_rgb :_pattern :_offset :_red :_green :_blue {
  double offset;
  double red;
  double green;
  double blue;
  memcpy(&offset, v__offset, sizeof(double));
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  cairo_pattern_add_color_stop_rgb((cairo_pattern_t *)(long)v__pattern, offset, red, green, blue);
}
libcairo cairo_pattern_add_color_stop_rgba :pattern :offset :red :green :blue :alpha [
    | _ |
    _ := self _cairo_pattern_add_color_stop_rgba : pattern : offset asFloat : red asFloat : green asFloat : blue asFloat : alpha asFloat.
    ^_
]
libcairo _cairo_pattern_add_color_stop_rgba :_pattern :_offset :_red :_green :_blue :_alpha {
  double offset;
  double red;
  double green;
  double blue;
  double alpha;
  memcpy(&offset, v__offset, sizeof(double));
  memcpy(&red, v__red, sizeof(double));
  memcpy(&green, v__green, sizeof(double));
  memcpy(&blue, v__blue, sizeof(double));
  memcpy(&alpha, v__alpha, sizeof(double));
  cairo_pattern_add_color_stop_rgba((cairo_pattern_t *)(long)v__pattern, offset, red, green, blue, alpha);
}
libcairo cairo_pattern_set_matrix :pattern :matrix [
    | _ |
    _ := self _cairo_pattern_set_matrix : pattern : matrix.
    ^_
]
libcairo _cairo_pattern_set_matrix :_pattern :_matrix {
  cairo_pattern_set_matrix((cairo_pattern_t *)(long)v__pattern, (cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_pattern_get_matrix :pattern :matrix [
    | _ |
    _ := self _cairo_pattern_get_matrix : pattern : matrix.
    ^_
]
libcairo _cairo_pattern_get_matrix :_pattern :_matrix {
  cairo_pattern_get_matrix((cairo_pattern_t *)(long)v__pattern, (cairo_matrix_t *)(long)v__matrix);
}
" enum cairo_extend_t "
libcairo CAIRO_EXTEND_NONE [ ^SmallInteger value_: self _CAIRO_EXTEND_NONE ]
libcairo _CAIRO_EXTEND_NONE { return (oop)(0); }
libcairo CAIRO_EXTEND_REPEAT [ ^SmallInteger value_: self _CAIRO_EXTEND_REPEAT ]
libcairo _CAIRO_EXTEND_REPEAT { return (oop)(1); }
libcairo CAIRO_EXTEND_REFLECT [ ^SmallInteger value_: self _CAIRO_EXTEND_REFLECT ]
libcairo _CAIRO_EXTEND_REFLECT { return (oop)(2); }
libcairo CAIRO_EXTEND_PAD [ ^SmallInteger value_: self _CAIRO_EXTEND_PAD ]
libcairo _CAIRO_EXTEND_PAD { return (oop)(3); }
libcairo cairo_pattern_set_extend :pattern :extend [
    | _ |
    _ := self _cairo_pattern_set_extend : pattern : extend _integerValue.
    ^_
]
libcairo _cairo_pattern_set_extend :_pattern :_extend {
  cairo_pattern_set_extend((cairo_pattern_t *)(long)v__pattern, (cairo_extend_t)(long)v__extend);
}
libcairo cairo_pattern_get_extend :pattern [
    | _ |
    _ := self _cairo_pattern_get_extend : pattern.
    ^SmallInteger value_: _
]
libcairo _cairo_pattern_get_extend :_pattern {
  cairo_extend_t _;
  _=(cairo_extend_t)cairo_pattern_get_extend((cairo_pattern_t *)(long)v__pattern);
  return (oop)(long)_;
}
" enum cairo_filter_t "
libcairo CAIRO_FILTER_FAST [ ^SmallInteger value_: self _CAIRO_FILTER_FAST ]
libcairo _CAIRO_FILTER_FAST { return (oop)(0); }
libcairo CAIRO_FILTER_GOOD [ ^SmallInteger value_: self _CAIRO_FILTER_GOOD ]
libcairo _CAIRO_FILTER_GOOD { return (oop)(1); }
libcairo CAIRO_FILTER_BEST [ ^SmallInteger value_: self _CAIRO_FILTER_BEST ]
libcairo _CAIRO_FILTER_BEST { return (oop)(2); }
libcairo CAIRO_FILTER_NEAREST [ ^SmallInteger value_: self _CAIRO_FILTER_NEAREST ]
libcairo _CAIRO_FILTER_NEAREST { return (oop)(3); }
libcairo CAIRO_FILTER_BILINEAR [ ^SmallInteger value_: self _CAIRO_FILTER_BILINEAR ]
libcairo _CAIRO_FILTER_BILINEAR { return (oop)(4); }
libcairo CAIRO_FILTER_GAUSSIAN [ ^SmallInteger value_: self _CAIRO_FILTER_GAUSSIAN ]
libcairo _CAIRO_FILTER_GAUSSIAN { return (oop)(5); }
libcairo cairo_pattern_set_filter :pattern :filter [
    | _ |
    _ := self _cairo_pattern_set_filter : pattern : filter _integerValue.
    ^_
]
libcairo _cairo_pattern_set_filter :_pattern :_filter {
  cairo_pattern_set_filter((cairo_pattern_t *)(long)v__pattern, (cairo_filter_t)(long)v__filter);
}
libcairo cairo_pattern_get_filter :pattern [
    | _ |
    _ := self _cairo_pattern_get_filter : pattern.
    ^SmallInteger value_: _
]
libcairo _cairo_pattern_get_filter :_pattern {
  cairo_filter_t _;
  _=(cairo_filter_t)cairo_pattern_get_filter((cairo_pattern_t *)(long)v__pattern);
  return (oop)(long)_;
}
libcairo cairo_matrix_init :matrix :xx :yx :xy :yy :x0 :y0 [
    | _ |
    _ := self _cairo_matrix_init : matrix : xx asFloat : yx asFloat : xy asFloat : yy asFloat : x0 asFloat : y0 asFloat.
    ^_
]
libcairo _cairo_matrix_init :_matrix :_xx :_yx :_xy :_yy :_x0 :_y0 {
  double xx;
  double yx;
  double xy;
  double yy;
  double x0;
  double y0;
  memcpy(&xx, v__xx, sizeof(double));
  memcpy(&yx, v__yx, sizeof(double));
  memcpy(&xy, v__xy, sizeof(double));
  memcpy(&yy, v__yy, sizeof(double));
  memcpy(&x0, v__x0, sizeof(double));
  memcpy(&y0, v__y0, sizeof(double));
  cairo_matrix_init((cairo_matrix_t *)(long)v__matrix, xx, yx, xy, yy, x0, y0);
}
libcairo cairo_matrix_init_identity :matrix [
    | _ |
    _ := self _cairo_matrix_init_identity : matrix.
    ^_
]
libcairo _cairo_matrix_init_identity :_matrix {
  cairo_matrix_init_identity((cairo_matrix_t *)(long)v__matrix);
}
libcairo cairo_matrix_init_translate :matrix :tx :ty [
    | _ |
    _ := self _cairo_matrix_init_translate : matrix : tx asFloat : ty asFloat.
    ^_
]
libcairo _cairo_matrix_init_translate :_matrix :_tx :_ty {
  double tx;
  double ty;
  memcpy(&tx, v__tx, sizeof(double));
  memcpy(&ty, v__ty, sizeof(double));
  cairo_matrix_init_translate((cairo_matrix_t *)(long)v__matrix, tx, ty);
}
libcairo cairo_matrix_init_scale :matrix :sx :sy [
    | _ |
    _ := self _cairo_matrix_init_scale : matrix : sx asFloat : sy asFloat.
    ^_
]
libcairo _cairo_matrix_init_scale :_matrix :_sx :_sy {
  double sx;
  double sy;
  memcpy(&sx, v__sx, sizeof(double));
  memcpy(&sy, v__sy, sizeof(double));
  cairo_matrix_init_scale((cairo_matrix_t *)(long)v__matrix, sx, sy);
}
libcairo cairo_matrix_init_rotate :matrix :radians [
    | _ |
    _ := self _cairo_matrix_init_rotate : matrix : radians asFloat.
    ^_
]
libcairo _cairo_matrix_init_rotate :_matrix :_radians {
  double radians;
  memcpy(&radians, v__radians, sizeof(double));
  cairo_matrix_init_rotate((cairo_matrix_t *)(long)v__matrix, radians);
}
libcairo cairo_matrix_translate :matrix :tx :ty [
    | _ |
    _ := self _cairo_matrix_translate : matrix : tx asFloat : ty asFloat.
    ^_
]
libcairo _cairo_matrix_translate :_matrix :_tx :_ty {
  double tx;
  double ty;
  memcpy(&tx, v__tx, sizeof(double));
  memcpy(&ty, v__ty, sizeof(double));
  cairo_matrix_translate((cairo_matrix_t *)(long)v__matrix, tx, ty);
}
libcairo cairo_matrix_scale :matrix :sx :sy [
    | _ |
    _ := self _cairo_matrix_scale : matrix : sx asFloat : sy asFloat.
    ^_
]
libcairo _cairo_matrix_scale :_matrix :_sx :_sy {
  double sx;
  double sy;
  memcpy(&sx, v__sx, sizeof(double));
  memcpy(&sy, v__sy, sizeof(double));
  cairo_matrix_scale((cairo_matrix_t *)(long)v__matrix, sx, sy);
}
libcairo cairo_matrix_rotate :matrix :radians [
    | _ |
    _ := self _cairo_matrix_rotate : matrix : radians asFloat.
    ^_
]
libcairo _cairo_matrix_rotate :_matrix :_radians {
  double radians;
  memcpy(&radians, v__radians, sizeof(double));
  cairo_matrix_rotate((cairo_matrix_t *)(long)v__matrix, radians);
}
libcairo cairo_matrix_invert :matrix [
    | _ |
    _ := self _cairo_matrix_invert : matrix.
    ^SmallInteger value_: _
]
libcairo _cairo_matrix_invert :_matrix {
  cairo_status_t _;
  _=(cairo_status_t)cairo_matrix_invert((cairo_matrix_t *)(long)v__matrix);
  return (oop)(long)_;
}
libcairo cairo_matrix_multiply :result :a :b [
    | _ |
    _ := self _cairo_matrix_multiply : result : a : b.
    ^_
]
libcairo _cairo_matrix_multiply :_result :_a :_b {
  cairo_matrix_multiply((cairo_matrix_t *)(long)v__result, (cairo_matrix_t *)(long)v__a, (cairo_matrix_t *)(long)v__b);
}
libcairo cairo_matrix_transform_distance :matrix :dx :dy [
    | _ |
    _ := self _cairo_matrix_transform_distance : matrix : dx : dy.
    ^_
]
libcairo _cairo_matrix_transform_distance :_matrix :_dx :_dy {
  cairo_matrix_transform_distance((cairo_matrix_t *)(long)v__matrix, (double *)(long)v__dx, (double *)(long)v__dy);
}
libcairo cairo_matrix_transform_point :matrix :x :y [
    | _ |
    _ := self _cairo_matrix_transform_point : matrix : x : y.
    ^_
]
libcairo _cairo_matrix_transform_point :_matrix :_x :_y {
  cairo_matrix_transform_point((cairo_matrix_t *)(long)v__matrix, (double *)(long)v__x, (double *)(long)v__y);
}
libcairo cairo_debug_reset_static_data [
    | _ |
    _ := self _cairo_debug_reset_static_data.
    ^_
]
libcairo _cairo_debug_reset_static_data {
  cairo_debug_reset_static_data();
}
libcairo _cairo_xlib_surface_create :_dpy :_drawable :_visual :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_xlib_surface_create((Display *)(long)v__dpy, (Drawable)(long)v__drawable, (Visual *)(long)v__visual, (int)(long)v__width, (int)(long)v__height);
  return (oop)(long)_;
}
libcairo _cairo_xlib_surface_create_for_bitmap :_dpy :_bitmap :_screen :_width :_height {
  cairo_surface_t * _;
  _=(cairo_surface_t *)cairo_xlib_surface_create_for_bitmap((Display *)(long)v__dpy, (Pixmap)(long)v__bitmap, (Screen *)(long)v__screen, (int)(long)v__width, (int)(long)v__height);
  return (oop)(long)_;
}
libcairo cairo_xlib_surface_set_size :surface :width :height [
    | _ |
    _ := self _cairo_xlib_surface_set_size : surface : width _integerValue : height _integerValue.
    ^_
]
libcairo _cairo_xlib_surface_set_size :_surface :_width :_height {
  cairo_xlib_surface_set_size((cairo_surface_t *)(long)v__surface, (int)(long)v__width, (int)(long)v__height);
}
libcairo cairo_xlib_surface_set_drawable :surface :drawable :width :height [
    | _ |
    _ := self _cairo_xlib_surface_set_drawable : surface : drawable : width _integerValue : height _integerValue.
    ^_
]
libcairo _cairo_xlib_surface_set_drawable :_surface :_drawable :_width :_height {
  cairo_xlib_surface_set_drawable((cairo_surface_t *)(long)v__surface, (Drawable)(long)v__drawable, (int)(long)v__width, (int)(long)v__height);
}
libcairo _cairo_xlib_surface_get_display :_surface {
  Display * _;
  _=(Display *)cairo_xlib_surface_get_display((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_drawable :_surface {
  Drawable _;
  _=(Drawable)cairo_xlib_surface_get_drawable((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_screen :_surface {
  Screen * _;
  _=(Screen *)cairo_xlib_surface_get_screen((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo _cairo_xlib_surface_get_visual :_surface {
  Visual * _;
  _=(Visual *)cairo_xlib_surface_get_visual((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_depth :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_depth : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_depth :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_depth((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_width :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_width : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_width :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_width((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
libcairo cairo_xlib_surface_get_height :surface [
    | _ |
    _ := self _cairo_xlib_surface_get_height : surface.
    ^SmallInteger value_: _
]
libcairo _cairo_xlib_surface_get_height :_surface {
  int _;
  _=(int)cairo_xlib_surface_get_height((cairo_surface_t *)(long)v__surface);
  return (oop)(long)_;
}
