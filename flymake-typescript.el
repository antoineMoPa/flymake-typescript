;;; flymake-typescript.el --- Typescript Flymake backend  -*- lexical-binding: t; -*-

;;; URL: https://github.com/antoineMoPa/flymake-typescript
;;; Contributor: Antoine Morin-Paulhus

;;; Package-Requires: ((emacs "26.0"))

;;; Version: 0.0.1
;; Package-Version: 0.0.1

;; Copyright (c) 2021 Antoine Morin-Paulhus

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Usage:
;;   (require 'flymake-typescript)
;;   (add-hook 'typescript-mode-hook 'flymake-mode)
;;

;;; Code:

(require 'flymake)

(defun get-node-project-dir ()
 "Find first parent folder with node_modules."
 (let ((project_dir "."))
   (while (and
           (not (string= (expand-file-name project_dir) "/"))
           (eq nil (member "package.json" (directory-files project_dir))))
     (setq project_dir (concat project_dir "/.."))
     )
   (if (string= (expand-file-name project_dir) "/") nil project_dir)
   ))

(defun flymake-proc-typescript-init ()
  "Typescript flymake initialization."
  (let* ((project-dir (get-node-project-dir))
         (flymake-typescript-executable-name
          (concat (expand-file-name project-dir) "/node_modules/typescript/bin/tsc"))
         (temp-file (flymake-proc-init-create-temp-buffer-copy
                     'flymake-proc-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-typescript-executable-name (list "--pretty" "false" local-file))
    ))

(setq flymake-proc-allowed-file-name-masks
      (cons '(".+\\.ts$"
              flymake-proc-typescript-init
              flymake-proc-simple-cleanup
              flymake-proc-get-real-file-name)
            flymake-proc-allowed-file-name-masks))

(setq flymake-proc-err-line-patterns
      (cons
       '(("\\(.+\\)(\\([0-9]+\\),\\([0-9]+\\)): \\(error TS.+\\)" 1 2 3 4))
       flymake-proc-err-line-patterns
       ))

(provide 'flymake-typescript)
;;; flymake-typescript.el ends here
