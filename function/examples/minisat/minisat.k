
(define OrderedCollection (import "OrderedCollection"))
(define SatSolver (import "MiniSat"))

(define sat [SatSolver new])

;; load the sat problem:
(define cnf
	'( ( -1 3 -5 )             ;;           ( ~1 V  3 V ~5 ) ^
   	   ( -2 -4 5 )             ;;           ( ~2 V ~4 V  5 ) ^
   	   ( -1 2 -4 )             ;;           ( ~1 V  2 V ~4 ) ^
   	   ( -3 4 -5 )             ;;           ( ~3 V  4 V ~5 ) ^
   	   ( 2 3 -4 -5 )           ;;      ( 2  V  3 V ~4 V ~5 ) ^
   	   ( 1 -2 3 4 5 )          ;; (  1 V ~2 V  3 V  4 V  5 ) ^
   	   ( -1 -2 3 4 5 )         ;; ( ~1 V ~2 V  3 V  4 V  5 ) ^
   	   ( -2 -3 )               ;;                ( ~2 V ~3 ) ^
   	   ( 2 ) )                 ;;                      ( 2 ) 
	   )


(define i '0)
(define isSat 1)
(while (and isSat [i < [cnf size]])
       (set isSat [sat addClause: [cnf at: i]])
       (set i [i + '1]))

[sat printSummary]

(if (or [isSat not] [[sat simplify] not])
    (let () ['"solved by unit propagations" putln] ['"UNSAT" putln])	
    (let ((res [sat solve])) [sat printModel]))


