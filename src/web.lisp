(in-package :cl-user)
(defpackage web1.web
  (:use :cl
        :caveman2
        :web1.config
        :web1.view
        :web1.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :web1.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"
	  (list :authors (all-authors-db))))

(defroute "/authors" ()
  (let ((authors (all-authors-db)))
    (render-json authors)))

(defroute "/posts" ()
  (let ((posts (all-posts-db)))
    (render-json posts)))


(defroute "/posts/author/:author-id" (&key author-id)
  (let ((posts (posts-by-author author-id)))
    (render-json posts)))
;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
