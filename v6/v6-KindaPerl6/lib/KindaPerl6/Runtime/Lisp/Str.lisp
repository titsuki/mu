(in-package #:kp6-cl)

; TODO: subclass Value
(defclass kp6-str ()
  ((value :initarg :value)))
  
(defmethod str ((s kp6-str)) s)
