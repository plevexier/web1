(in-package :cl-user)
(defpackage web1.db
  (:use :cl)
  (:import-from :web1.config
                :config)
  (:import-from :datafly
                :*connection* :retrieve-all)
  (:import-from :sxql
		:select :from :where)
  (:import-from :cl-dbi
                :connect-cached)
  (:export :connection-settings
           :db
           :with-connection
	   :all-authors-db
	   :all-posts-db
	   :posts-by-author))
(in-package :web1.db)

(defun connection-settings (&optional (db :maindb))
  (cdr (assoc db (config :databases))))

(defun db (&optional (db :maindb))
  (apply #'connect-cached (connection-settings db)))

(defmacro with-connection (conn &body body)
  `(let ((*connection* ,conn))
     ,@body))

(defun all-authors-db ()
  (with-connection (db)
    (retrieve-all
     (select :*
       (from :authors)))))

(defun all-posts-db ()
  (with-connection (db)
    (retrieve-all
     (select :*
       (from :posts)))))

(defun posts-by-author (author-id)
  (with-connection (db)
    (retrieve-all
     (select :*
       (from :posts)
       (where (:= :author_id author-id))))))
