;; gst-debug.el -- a mini mode for GStreamer debug logs

;; Copyright (C) 2014 Luis de Bethencourt <luis@debethencourt.com>
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

(defun gst-debug-jump ()
    (interactive)

    ;; get file and line in log
    (let* ((cl (thing-at-point 'line))
        (fln (pcase-let ((`(,file ,line ,name)
            (split-string (nth 5
                (split-string cl " " t) ) ":"))) (list :name name :file file :line line)))
        (file (nth 3 fln))
        (line (string-to-number (nth 5 fln))))

        ;; if more than one window, load file in the second window
        (unless (= (count-windows) 1)
            (let ((w2  (second  (window-list))))
                (select-window w2)))

        ;; open file to that line
        (find-tag file)
        (let ((linejump (- line (1+ (count-lines 1 (point))))))
            (forward-line linejump)
            (message "%s:%d" file linejump))))

(defun gst-debug ()
  (interactive)

  ;; set syntax, change behaviour of M-., and activate compilation-mode
  (add-to-list
    'compilation-error-regexp-alist-alist
    '(gst "^[0-9:.]+\\s-+[0-9]+\\s-+0x[[:xdigit:]]+\\s-+\\(?:\\(ERROR\\)\\|\\(WARNING\\)\\|\\([A-Z]+\\)\\)\\s-+\\S-+\\s-+\\(\\(.*?\\):\\([0-9]+\\)\\):" 5 6 nil (2 . 3) 4))
  (add-to-list 'compilation-error-regexp-alist 'gst)
  (add-hook 'compilation-mode-hook 
            '(lambda ()
               (local-set-key (kbd "M-.") 'gst-debug-jump)
               (local-set-key (kbd "RET") 'gst-debug-jump)))
  (compilation-mode t))

(provide 'gst-debug)

;; gst-debug.el ends here
