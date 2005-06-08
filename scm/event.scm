;;; event.scm: Event definitions
;;;
;;; Copyright (c) 2004-2005 uim Project http://uim.freedesktop.org/
;;;
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;; 3. Neither the name of authors nor the names of its contributors
;;;    may be used to endorse or promote products derived from this software
;;;    without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
;;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
;;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;;; SUCH DAMAGE.
;;;;

;; These events will cooperate with the composer framework which will
;; be appeared as composer.scm to enable flexible input method
;; component organization such as nested composer (input method) based
;; on loose relationships.  -- YamaKen 2005-02-18

(require "util.scm")
(require "ng-key.scm")


;;
;; utext
;;

;; The name 'utext' is inspired by Mtext of the m17n library
(define-record 'utext
  '((str      "")
    (language "")
    (encoding "")
    (props    ())))  ;; arbitrary properties alist

;; TODO:
;; - character encoding conversion
;; - encoding-aware string split
;; - encoding name canonicalization
;; - comparison

;;
;; event definitions
;;

(define valid-event-types
  '(timer
    reset
    action
    commit
    insert
    key))

(define event-rec-spec
  '((type      unknown)
    (consumed  #f)
    (loopback  #f)    ;; instructs re-injection into local composer
    (timestamp -1)    ;; placeholder
    (ext-state #f)))
(define-record 'event event-rec-spec)

(define event-external-state
  (lambda (ev state-id)
    (let ((state-reader (event-ext-state ev)))
      (and (procedure? state-reader)
	   (state-reader state-id)))))

(define-record 'timer-event
  event-rec-spec)

(define-record 'reset-event
  event-rec-spec)

(define-record 'commit-event
  (append
   event-rec-spec
   '((utexts        ())
     (clear-preedit #t))))

;; insert a text into preedit
(define-record 'insert-event
  (append
   event-rec-spec
   '((utext #f))))


;; action, chooser, and indicator events may be canged drastically
;; -- YamaKen 2005-06-09

;; action

(define-record 'action-event
  (append
   event-rec-spec
   '((action-id #f))))  ;; 'action_input_mode_direct

(define-record 'action-groups-req-event
  event-rec-spec)

(define-record 'action-groups-export-event
  (append
   event-rec-spec
   '((action-groups ()))))  ;; list of action-group-id

(define-record 'actions-req-event
  (append
   event-rec-spec
   '((action-group-id #f))))  ;; 'action_group_input_mode

(define-record 'actions-export-event
  (append
   event-rec-spec
   '((action-group-id #f)
     (actions         ()))))  ;; list of action objects (!= action-id)

;; chooser  

(define-record 'chooser-event
  (append
   event-rec-spec
   '((chooser-id #f)  ;; 'chooser_candidate_selector
     (index      -1)  ;; negative value means no spot
     (scope-top  -1)
     (finish     #t))))

(define-record 'chooser-req-event
  (append
   event-rec-spec
   '((chooser-id   #f)  ;; 'chooser_candidate_selector 'chooser_all etc.
     (config       #f)
     (items-top    -1)
     (items-length -1))))

(define-record 'chooser-config-event
  (append
   event-rec-spec
   '((chooser-id      #f)
     (label           "")
     (desc            "")
     (scope-size-hint 10)  ;; number of items displayable at a time
     (scope-top       0)   ;; initial position of scope
     (nr-items        0)
     ;;(spot-pos        -1)
     ;;(initial-items-top -1)
     ;;(initial-items     ())
     )))

(define-record 'chooser-update-event
  (append
   event-rec-spec
   '((chooser-id        #f)
     (transition        'none)  ;; 'activate 'deactivate 'none
     (scope-top         -1)
     (spot-pos          -1)
     (updated-items-top -1)
     (updated-items     ()))))

;; indicator

(define-record 'indicator-req-event
  (append
   event-rec-spec
   '((indicator-id #f)  ;; 'indicator_candidate_selector 'indicator_all etc.
     (config       #f))))

(define-record 'indicator-config-event
  (append
   event-rec-spec
   '((indicator-id #f)             ;; 'indicator_input_mode
     (indicator-indication #f)     ;; indication object for indicator itself
     (state-indication     #f))))  ;; indication object for the content

(define-record 'indicator-update-event
  (append
   event-rec-spec
   '((indicator-id     #f)
     (state-indication #f))))


;; #f means "don't care" for lkey, pkey, str, press and autorepeat
;; when comparing with other key-event. But modifiers require exact
;; match.
(define-record 'key-event
  (append
   event-rec-spec
   (list
    ;;(list text       #f)        ;; replace raw string with utext in future
    (list 'str        #f)        ;; precomposed string
    (list 'lkey       #f)        ;; logical keysym
    (list 'pkey       #f)        ;; physical keysym
    (list 'modifier   mod_None)  ;; set of modifiers
    (list 'press      #t)        ;; indicates press/release
    (list 'autorepeat #f))))     ;; whether generated by autorepeat or not
(define key-event-new-internal key-event-new)

(define key-event-new
  (lambda args
    (apply key-event-new-internal
	   (append (event-new 'key) args))))

(define key-release-event-new
  (lambda args
    (let ((ev (apply key-event-new args)))
      (key-event-set-press! ev #f)
      ev)))

;; TODO: make encoding sensitive
(define key-event-char
  (lambda (ev)
    (let ((str (key-event-str ev)))
      (and (string? str)
	   (string->char str)))))

(define key-event-extract-press-str
  (lambda (ev)
    (and (key-event-press ev)
	 (key-event-str ev))))

(define key-event-char-upcase!
  (lambda (ev)
    (let ((str ((compose charcode->string
			 char-upcase
			 key-event-char)
		ev)))
      (key-event-set-str! ev str))))

(define key-event-char-downcase!
  (lambda (ev)
    (let ((str ((compose charcode->string
			 char-downcase
			 key-event-char)
		ev)))
      (key-event-set-str! ev str))))

;; TODO: write test
(define key-event-covers?
  (lambda (self other)
    (and (every (lambda (getter)
		  (let ((self-val (getter self))
			(other-val (getter other)))
		    (and self-val ;; #f means "don't care"
			 (equal? self-val other-val))))
		(list key-event-lkey
		      key-event-pkey
		      key-event-str))
	 (modifier-match? (key-event-modifier self)
			  (key-event-modifier other))
	 ;; exact matches
	 (every (lambda (getter)
		  (equal? (getter self)
			  (getter other)))
		(list key-event-press
		      key-event-autorepeat)))))

;; TODO: write test
(define key-event-inspect
  (lambda (ev)
    (string-append
     (if (key-event-str ev)
	 (string-append "\"" (key-event-str ev) "\"")
	 "-")
     " "
     (symbol->string (or (key-event-lkey ev)
			 '-))
     " "
     (symbol->string (or (key-event-pkey ev)
			 '-))
     " ("
     (string-join
      " "
      (filter-map (lambda (mod-sym)
		    (and (not (= (bitwise-and (symbol-value mod-sym)
					      (key-event-modifier ev))
				 0))
			 (symbol->string mod-sym)))
		  valid-modifiers))
     ") "
     (if (key-event-press ev)
	 "press"
	 "release")
     " "
     (if (key-event-autorepeat ev)
	 "autorepeat"
	 "nonrepeat")
     " "
     (if (event-consumed ev)
	 "consumed"
	 "not-consumed")
     "\n")))

(define key-event-print-inspected
  (lambda (msg ev)
    (if inspect-key-event-translation?
	(puts (string-append msg
			     (key-event-inspect ev))))))
