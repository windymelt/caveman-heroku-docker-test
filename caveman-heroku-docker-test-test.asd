(in-package :cl-user)
(defpackage caveman-heroku-docker-test-test-asd
  (:use :cl :asdf))
(in-package :caveman-heroku-docker-test-test-asd)

(defsystem caveman-heroku-docker-test-test
  :author ""
  :license ""
  :depends-on (:caveman-heroku-docker-test
               :prove)
  :components ((:module "t"
                :components
                ((:file "caveman-heroku-docker-test"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
