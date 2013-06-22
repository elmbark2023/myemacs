(defun chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

(defun copy-paste-with-prefix (buffer prefix)
  "split the line and paste with prefix"
  (interactive "bBuffer to insert: \nsPrefix for each string: ")
  (let* ((oldbuf (current-buffer))
         (p (region-beginning))
         (end (region-end))
         (line (buffer-substring p end))
         (strs (split-string line)))
    (save-excursion 
      (chomp prefix)
      (set-buffer (get-buffer-create buffer))
      (while strs
        (setq str (concat prefix (car strs)))
        (chomp str)
        (insert str)
        (insert "\n")
        (setq strs (cdr strs))))))


(defun f1 (start1)
  (interactive "nPosition for Source: ")
  (let* ((s (point))
         (e (+ s 51))
         (end1 (+ start1 3))
         (start2 (+ start1 3))
         (end2 (+ start1 6))
         (str (buffer-substring-no-properties s e))
         (src (substring str start1 end1))
         (trg (substring str start2 end2)))
    (setq lp (concat src "-" trg))
    (if (file-exists-p (concat str "/rc/lisa.xml"))
        (setq lp (concat lp "-lisa"))
      (setq lp (concat lp "-pbmt")))
    lp))

(defun apply-all ()
  (interactive)
  (let* ((e (line-number-at-pos (point-max)))
         (p (line-number-at-pos))
         lps)
    (while (<= p e)
      (setq lp (f1 32))
      (if (not (member lp lps))
          (progn
            (setq lps (cons lp lps))
            (insert lp)
            (insert " : ")
            (beginning-of-line)
            (setq p (line-number-at-pos))
            (next-line))
        (progn
          (kill-line))
      ))))

 
(defun temp-fun ()
  (interactive)
  (while 1
    (zap-to-char 2 ? )
    (next-line)))

(defun cpp-make-region-string ()
  "make the selected region a cpp string"
  (interactive)
  (let* ((s (line-number-at-pos (region-beginning)))
         (e (line-number-at-pos (region-end))))
    (save-excursion
      (goto-line s)
      (while (<= s e)
        (search-forward-regexp "\\s-*")
        (save-excursion 
          (replace-string "\"" "\\\"" nil (point) (point-at-eol)))
        (insert "\"")
        (end-of-line)
        (insert "\\n\"")
        (beginning-of-line)
        (next-line)
        (setq s (line-number-at-pos))))))
