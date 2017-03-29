(defparameter *map-color-kb*
  '(
    (color green)
    (color red)
    (color blue)
    (color yellow)
    (-> (all-different (cons ?color1 (cons ?color2 ?l)))
        (all-different (cons ?color1 ?l))
        (all-different (cons ?color2 ?l))
        (different ?color1 ?color2))
    (-> (different ?color1 ?color2) (different ?color2 ?color1))
   
    (all-different (cons red (cons blue (cons green (cons yellow nil)))))
    
    (<- (colors-for map1 ?x ?y ?l ?z)
        (different ?x ?y)
        (different ?x ?l)
        (different ?y ?l)
        (different ?x ?z)
        (different ?y ?z)
        (different ?l ?z))

    (<- (colors-for map2 ?x ?y ?l ?z ?h)
        (color ?x)
        (color ?y)
        (color ?l)
        (color ?z)
        (color ?h)
        (different ?x ?y)
        (different ?x ?l)
        (different ?y ?l)
        (different ?x ?z)
        (different ?l ?z)
        (different ?x ?h)
        (different ?y ?h)
        (different ?l ?h)
        (different ?z ?h))

    (<- (colors-for map3 ?x ?y ?l ?z ?h ?f)
        (color ?x)
        (color ?y)
        (color ?l)
        (color ?z)
        (color ?h)
        (color ?f)
        (different ?x ?y)
        (different ?y ?z)
        (different ?x ?l)
        (different ?y ?l)
        (different ?x ?h)
        (different ?y ?h)
        (different ?x ?z)
        (different ?l ?z)
        (different ?z ?h)
        (different ?x ?f)
        (different ?z ?f)
        (different ?h ?f))
    ))