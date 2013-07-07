;;; package --- Summary
;;; Small minor mode to control spotify from emacs.
 
;;; Commentary:
;;; Forked from mattdeboard, modified by iiSeymour.
;;; Save as ~/.emacs.d/spotify.el and throw a (require 'spotify) in your ~/.emacs
 
;;; Key Bindings:
;;; F9  - spotify-playpause()
;;; F8  - spotfiy-next()
;;; F10 - spotify-previous()
 
;;; Code:
(defun spotify-query ()
  "Display if Spotify is playing or paused."
  (interactive)
  (replace-regexp-in-string "\n$" ""
  (shell-command-to-string
   "qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus")))
 
(defun spotify-playpause ()
  "Play/Pause Spotify."
  (interactive)
  (shell-command-to-string
   "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause")
  (message "Spotify - %s" (spotify-query))
 
(defun spotify-next ()
  "Next song in Spotify."
  (interactive)
  (shell-command-to-string
   "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next")
  (message "Spotify - Next Track"))
 
(defun spotify-previous ()
  "Previous song in Spotify."
  (interactive)
  (shell-command-to-string
   "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
  (sit-for 0.1)
  (shell-command-to-string
   "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous")
  (message "Spotify - Previous Track")))
 
(global-set-key [f8] 'spotify-previous)
(global-set-key [f9] 'spotify-playpause)
(global-set-key [f10] 'spotify-next)
 
(provide 'spotify)
;;; spotify ends here
