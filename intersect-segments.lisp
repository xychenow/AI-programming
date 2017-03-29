(defun intersect-segments (x1 y1 x2 y2 x3 y3 x4 y4)
  (let* ((l1 (list (- x4 x3) (- y4 y3)))
         (l2 (list (- x1 x3) (- y1 y3)))
         (l3 (list (- x2 x1) (- y2 y1)))
         (p1 (product l1 l2))
         (p2 (product l3 l2))
         (p3 (product l3 l1)))
    (cond ((/= 0 p3) (non-parallel-intersection x1 y1 l1 l2 l3 p3))
          ((and (= 0 p2) (= 0 p1))
           (parallel-intersection x1 y1 x2 y2 x3 y3 x4 y4))
          (t nil))))

(defun product (l1 l2)
  (- (* (car l1) (cadr l2)) (* (car l2) (cadr l1))))

(defun scalar-multiply (x1 x2 x3 l)
  (list (+ x2 (* (car l) x1)) (+ x3 (* (cadr l) x1))))

(defun overlap (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((l1-start (max x1 x2))
        (l2-start (max x3 x4))
        (l1-end (min x1 x2))
        (l2-end (min x3 x4)))
    (cond ((and (> l1-start l2-start) (< l1-end l2-end)) 
           (list x3 y3 x4 y4))
          ((and (< l1-start l2-start) (> l1-end l2-end)) 
           (list x1 y1 x2 y2))
          ((>= l1-start l2-end) 
           (list l1-start (max y1 y2) l2-end (min y3 y4)))
          (t nil))))


(defun non-parallel-intersection (x1 y1 l1 l2 l3 p)
  (let* ((p1 (product l1 l2))
         (p2 (product l3 l2))
         (temp1 (/ p1 p))
         (temp2 (/ p2 p)))
    (and (<= 0 temp1 1) (<= 0 temp2 1)
         (values-list (scalar-multiply temp1 x1 y1 l3)))))

(defun parallel-intersection (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((over-lap (overlap x1 y1 x2 y2 x3 y3 x4 y4)))
    (cond ((null over-lap) nil)
          (t (values-list over-lap)))))


;-----
(defun slope (x1 y1 x2 y2)
  (cond ((and (= x1 x2) (= y1 y2)) 't)
        ((= x1 x2) 'nil)
        (t (/ (- y1 y2) (- x1 x2)))))



;---
(defun overlap (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((l1-start (max x1 x2))
        (l2-start (max x3 x4))
        (l1-end (min x1 x2))
        (l2-end (min x3 x4)))
    (cond ((and (> l1-start l2-start) (< l1-end l2-end)) 
           (list x3 y3 x4 y4))
          ((and (< l1-start l2-start) (> l1-end l2-end)) 
           (list x1 y1 x2 y2))
          ((>= l1-start l2-end) 
           (list l1-start (max y1 y2) l2-end (min y3 y4)))
          (t nil))))
;----
(defun overlap (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((max1 (max x1 x2))
        (max2 (max x3 x4))
        (max3 (max y1 y2))
        (min1 (min x1 x2))
        (min2 (min x3 x4))
        (min3 (min y3 y4)))
    (cond ((and (> max1 max2) (< min1 min2)) (list x3 y3 x4 y4))
          ((and (< max1 max2) (> min1 min2)) (list x1 y1 x2 y2))
          ((>= max1 min2) (list max1 max3 min2 min3))
          (t nil))))
;-----

;----------------------------------------
(defun overlap (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((max1 (max x1 x2))
        (max2 (max x3 x4))
        (max3 (max y1 y2))
        (min1 (min x1 x2))
        (min2 (min x3 x4))
        (min3 (min y3 y4)))
    (cond ((and (> max1 max2) (< min1 min2)) (list x3 y3 x4 y4))
          ((and (< max1 max2) (> min1 min2)) (list x1 y1 x2 y2))
          ((>= max1 min2) (list max1 max3 min2 min3))
          (t nil))))

(defun parallel (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((over-lap (overlap x1 y1 x2 y2 x3 y3 x4 y4))
        (s1 (slope x1 y1 x2 y2))
        (s2 (slope x3 y3 x4 y4)))
    (cond ((null over-lap) nil)
          ((or (eql s1 't) (eql s2 't))
           (values (car over-lap) (cadr over-lap) (car over-lap) (cadr over-lap)))
          (t (values-list over-lap)))))

(defun parallel (x1 y1 x2 y2 x3 y3 x4 y4)
  (let ((over-lap (overlap x1 y1 x2 y2 x3 y3 x4 y4))
        (s1 (slope x1 y1 x2 y2))
        (s2 (slope x3 y3 x4 y4)))
    (cond ((null over-lap) nil)
          ((or (eql s1 't) (eql s2 't))
           (values (car over-lap) (cadr over-lap) (car over-lap) (cadr over-lap)))
          (t (values-list over-lap)))))


(defun non-parallel (x1 y1 l1 l2 l3 p)
  (let* ((p1 (product l1 l2))
         (p2 (product l3 l2))
         (temp1 (/ p1 p))
         (temp2 (/ p2 p)))
    (when (and (<= 0 temp1 1) (<= 0 temp2 1)) 
      (values (+ x1 (* (car l3) temp1)) (+ y1 (* (cadr l3) temp1))))))