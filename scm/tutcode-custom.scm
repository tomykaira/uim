;;; tutcode-custom.scm: Customization variables for tutcode.scm
;;;
;;; Copyright (c) 2003-2010 uim Project http://code.google.com/p/uim/
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
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
;;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE
;;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;;; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;;; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;;; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;;; SUCH DAMAGE.
;;;;

(require "i18n.scm")


(define tutcode-im-name-label (N_ "TUT-Code"))
(define tutcode-im-short-desc (N_ "uim version of TUT-Code input method"))

(define-custom-group 'tutcode
                     tutcode-im-name-label
                     tutcode-im-short-desc)

(define-custom-group 'tutcode-dict
                     (N_ "TUT-Code dictionaries")
                     (N_ "Dictionary settings for TUT-Code"))

(define-custom-group 'tutcode-prediction
                    (N_ "Prediction")
                    (N_ "long description will be here."))

;;
;; dictionary
;;

(define-custom 'tutcode-dic-filename (string-append (sys-datadir)
						 "/tc/mazegaki.dic")
  '(tutcode tutcode-dict)
  '(pathname regular-file)
  (N_ "Mazegaki dictionary file")
  (N_ "long description will be here."))

(define-custom 'tutcode-personal-dic-filename
  (string-append (or (home-directory (user-name)) "") "/.mazegaki.dic")
  '(tutcode tutcode-dict)
  '(pathname regular-file)
  (N_ "Personal mazegaki dictionary file")
  (N_ "long description will be here."))

(define-custom 'tutcode-rule-filename
  (string-append (sys-pkgdatadir) "/tutcode-rule.scm")
  '(tutcode)
  '(pathname regular-file)
  (N_ "Code table file")
  (N_ "Code table name is 'filename-rule' when code table file name is 'filename.scm'."))

(define-custom 'tutcode-enable-mazegaki-learning? #t
  '(tutcode)
  '(boolean)
  (N_ "Enable learning in mazegaki conversion")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-recursive-learning? #t
  '(tutcode)
  '(boolean)
  (N_ "Use recursive learning")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-with-vi? #f
  '(tutcode)
  '(boolean)
  (N_ "Enable vi-cooperative mode")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-dvorak? #f
  '(tutcode)
  '(boolean)
  (N_ "Use Dvorak keyboard")
  (N_ "long description will be here."))

;;
;; candidate window
;;

(define-custom 'tutcode-use-candidate-window? #t
  '(tutcode candwin)
  '(boolean)
  (N_ "Use candidate window")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-table-style-candidate-window? #f
  '(tutcode candwin)
  '(boolean)
  (N_ "Use table style candidate window")
  (N_ "long description will be here."))

(define-custom 'tutcode-candidate-window-table-layout 'qwerty-jis
  '(tutcode candwin)
  (list 'choice
	(list 'qwerty-jis (N_ "qwerty-jis") (N_ "Qwerty JIS"))
	(list 'qwerty-us (N_ "qwerty-us") (N_ "Qwerty US"))
	(list 'dvorak (N_ "dvorak") (N_ "Dvorak")))
  (N_ "Key layout of table style candidate window")
  (N_ "long description will be here."))

(define-custom 'tutcode-commit-candidate-by-label-key? #t
  '(tutcode candwin)
  '(boolean)
  (N_ "Commit candidate by heading label keys")
  (N_ "long description will be here."))

(define-custom 'tutcode-candidate-op-count 5
  '(tutcode candwin)
  '(integer 0 99)
  (N_ "Conversion key press count to show candidate window")
  (N_ "long description will be here."))

(define-custom 'tutcode-nr-candidate-max 10
  '(tutcode candwin)
  '(integer 1 99)
  (N_ "Number of candidates in candidate window at a time")
  (N_ "long description will be here."))

(define-custom 'tutcode-nr-candidate-max-for-kigou-mode 10
  '(tutcode candwin)
  '(integer 1 99)
  (N_ "Number of candidates in candidate window at a time for kigou mode")
  (N_ "long description will be here."))

(define-custom 'tutcode-nr-candidate-max-for-prediction 10
  '(tutcode candwin)
  '(integer 1 99)
  (N_ "Number of candidates in candidate window at a time for prediction")
  (N_ "long description will be here."))

(define-custom 'tutcode-nr-candidate-max-for-guide 10
  '(tutcode candwin)
  '(integer 1 99)
  (N_ "Number of candidates in candidate window at a time for kanji combination guide")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-stroke-help-window? #f
  '(tutcode candwin)
  '(boolean)
  (N_ "Use stroke help window")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-auto-help-window? #f
  '(tutcode candwin)
  '(boolean)
  (N_ "Use auto help window")
  (N_ "long description will be here."))

(define-custom 'tutcode-auto-help-with-real-keys? #f
  '(tutcode candwin)
  '(boolean)
  (N_ "Show real keys on auto help window")
  (N_ "long description will be here."))

;; prediction/completion
(define-custom 'tutcode-use-completion? #f
  '(tutcode tutcode-prediction)
  '(boolean)
  (N_ "Enable completion")
  (N_ "long description will be here."))

(define-custom 'tutcode-completion-chars-min 2
  '(tutcode tutcode-prediction)
  '(integer 1 65535)
  (N_ "Minimum character length for completion")
  (N_ "long description will be here."))

(define-custom 'tutcode-completion-chars-max 5
  '(tutcode tutcode-prediction)
  '(integer 1 65535)
  (N_ "Maximum character length for completion")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-prediction? #f
  '(tutcode tutcode-prediction)
  '(boolean)
  (N_ "Enable input prediction for mazegaki conversion")
  (N_ "long description will be here."))

(define-custom 'tutcode-prediction-start-char-count 2
  '(tutcode tutcode-prediction)
  '(integer 1 65535)
  (N_ "Character count to start input prediction")
  (N_ "long description will be here."))

(define-custom 'tutcode-use-kanji-combination-guide? #f
  '(tutcode tutcode-prediction)
  '(boolean)
  (N_ "Enable Kanji combination guide")
  (N_ "long description will be here."))

;; activity dependency
(custom-add-hook 'tutcode-candidate-op-count
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-candidate-window?))

(custom-add-hook 'tutcode-nr-candidate-max
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-candidate-window?))

(custom-add-hook 'tutcode-nr-candidate-max-for-kigou-mode
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-candidate-window?))

(custom-add-hook 'tutcode-nr-candidate-max-for-prediction
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-candidate-window?))

(custom-add-hook 'tutcode-nr-candidate-max-for-guide
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-candidate-window?))

(custom-add-hook 'tutcode-auto-help-with-real-keys?
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-auto-help-window?))

(custom-add-hook 'tutcode-use-table-style-candidate-window?
  'custom-set-hooks
  (lambda ()
    (if tutcode-use-table-style-candidate-window?
      (begin
        (custom-set-value! 'tutcode-nr-candidate-max
          (length tutcode-table-heading-label-char-list))
        (custom-set-value!
          'tutcode-nr-candidate-max-for-kigou-mode
          (length tutcode-table-heading-label-char-list-for-kigou-mode))
        (custom-set-value!
          'tutcode-nr-candidate-max-for-prediction
          (length tutcode-heading-label-char-list-for-prediction))
        (custom-set-value!
          'tutcode-nr-candidate-max-for-guide
          (- (length tutcode-table-heading-label-char-list-for-kigou-mode)
             (length tutcode-heading-label-char-list-for-prediction))))
      (begin
        (custom-set-value! 'tutcode-nr-candidate-max 10)
        (custom-set-value! 'tutcode-nr-candidate-max-for-kigou-mode 10)
        (custom-set-value! 'tutcode-nr-candidate-max-for-prediction 10)
        (custom-set-value! 'tutcode-nr-candidate-max-for-guide 10)))))

(custom-add-hook 'tutcode-candidate-window-table-layout
		 'custom-activity-hooks
		 (lambda ()
		   tutcode-use-table-style-candidate-window?))
