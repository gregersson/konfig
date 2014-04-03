(defun get-image-dimensions-imk (img-file-path)
  "Returns a image file's width and height as a vector.
This function requires ImageMagick's “identify” shell command."
  (let ( widthHeightList )
    (setq widthHeightList (split-string (shell-command-to-string (concat "identify -format \"%w %h\" " img-file-path))) )
    (vector
     (string-to-number (elt widthHeightList 0))
     (string-to-number (elt widthHeightList 1)) ) ))
(defun image-torpedify ()
  (interactive)
  (let (imgPath pathBoundaries imgDimen iWidth iHeight altText myResult)
    (setq imgPath (thing-at-point 'filename))
    (setq pathBoundaries (bounds-of-thing-at-point 'filename))
    (setq altText imgPath)
    (setq altText (replace-regexp-in-string "_" " " altText t t))
    (setq altText (replace-regexp-in-string "\\.[A-Za-z]\\{3,4\\}$" "" altText t t))
    (setq imgDimen (get-image-dimensions-imk imgPath))
    (setq iWidth (number-to-string (elt imgDimen 0)))
    (setq iHeight (number-to-string (elt imgDimen 1)))
    (setq myResult (concat imgPath "\""
                           ",
"
                           "width:" iWidth ",
"
                           "height:" iHeight ","
                           ))
    (save-excursion
      (delete-region (car pathBoundaries) (+ (cdr pathBoundaries) 2))
      (insert myResult))
    ))
