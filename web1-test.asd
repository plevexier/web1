(defsystem "web1-test"
  :defsystem-depends-on ("prove-asdf")
  :author "Patrice"
  :license ""
  :depends-on ("web1"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "web1"))))
  :description "Test system for web1"
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
