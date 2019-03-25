(in-package :cl-user)
(defpackage web1.config
  (:use :cl)
  (:import-from :envy
                :config-env-var
                :defconfig)
  (:export :config
           :*application-root*
           :*static-directory*
           :*template-directory*
           :appenv
           :developmentp
           :productionp))
(in-package :web1.config)

(setf (config-env-var) "APP_ENV")

(defparameter *application-root*   (asdf:system-source-directory :web1))
(defparameter *static-directory*   (merge-pathnames #P"static/" *application-root*))
(defparameter *template-directory* (merge-pathnames #P"templates/" *application-root*))

(defconfig :common
  `(:databases ((:maindb :mysql :database-name "test" :username "root" :password "toto"))))

(defconfig |development|
  '(:databases
    ((:maindb :mysql :database-name "test" :username "root" :password "toto"))))

(defconfig |production|
  '(:databases
    ((:maindb :mysql :database-name "test" :username "root" :password "toto"))))

(defconfig |test|
  '(:databases
    ((:maindb :mysql :database-name "test" :username "root" :password "toto"))))

(defun config (&optional key)
  (envy:config #.(package-name *package*) key))

(defun appenv ()
  (uiop:getenv (config-env-var #.(package-name *package*))))

(defun developmentp ()
  (string= (appenv) "development"))

(defun productionp ()
  (string= (appenv) "production"))
