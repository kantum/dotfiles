(defcfg
  process-unmapped-keys true
  danger-enable-cmd yes
)

(defvar
  tap-repress-timeout 200
  hold-timeout 160
)

(defalias
  err (cmd "play" "-q" "/System/Library/Sounds/Basso.aiff" "trim" "0" "0.1")

  z (tap-hold $tap-repress-timeout $hold-timeout z lsft)
  a (tap-hold $tap-repress-timeout $hold-timeout a lctl)
  s (tap-hold $tap-repress-timeout $hold-timeout s lalt)
  d (tap-hold $tap-repress-timeout $hold-timeout d lmet)
  f (tap-hold $tap-repress-timeout $hold-timeout f lsft)
  j (tap-hold $tap-repress-timeout $hold-timeout j rsft)
  k (tap-hold $tap-repress-timeout $hold-timeout k rmet)
  l (tap-hold $tap-repress-timeout $hold-timeout l lalt)
  ; (tap-hold $tap-repress-timeout $hold-timeout ; rctl)
  / (tap-hold $tap-repress-timeout $hold-timeout / lsft)
)

;; Emacs-style cursor movement
(defoverrides
  (lctrl n) (down)
  (rctrl n) (down)

  (lctrl p) (up)
  (rctrl p) (up)

  (lctrl m) (ret)
  (rctrl m) (ret)

  (lctrl h) (bspc)
  (rctrl h) (bspc)
  (lctrl [) (esc)

  ;; does not work in terminal or conflict with vim
  ;; (lctrl d) (del)
  ;; (lctrl u) (lmet bspc)
  ;; (lctrl w) (lalt bspc)
  ;; (rctrl w) (ralt bspc)
)

(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  fn lctl lalt lmet           spc            rmet ralt
)

(deflayer base
  grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
  lctrl @a   @s   @d   @f   g    h    @j   @k   @l   @;   '    ret
  lsft  @z   x    c    v    b    n    m    ,    .    @/    rsft
  fn    @err @err  bspc          spc            ret @err
)
