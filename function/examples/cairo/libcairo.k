(dlopen "libcairo")
(define cairolib (dlopen "cairolib"))
((_dlsym cairolib "__id__init__"))

(define libcairo	(import "libcairo"))
