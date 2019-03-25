# web1



## Usage

To launch in REPL, do:

(pushnew (truename "~/dev/lisp/web1") ql:*local-project-directories* )
(ql:register-local-projects)
(ql:quickload :web1)

and then:
(web1:start :server :hunchentoot :port 8080)

## Installation

## Author

* Patrice

## Copyright

Copyright (c) 2019 Patrice

