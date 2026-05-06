(defcfg
  process-unmapped-keys yes
  danger-enable-cmd yes
    macos-dev-names-exclude (
    "Corne"
  )
)

(defvar
  tap-repress-timeout 200
  hold-timeout 160
)

(defalias
  err (cmd "play" "-q" "/System/Library/Sounds/Basso.aiff" "trim" "0" "0.1")
  warn-ret (multi ret @err)
  warn-bspc (multi bspc @err)
  warn-esc (multi esc @err)
  warn-sft (multi lsft @err)

  mc  C-up ;; Mission Control
  sls M-spc ;; Spotlight Search
  esc (tap-hold 200 200 esc (layer-while-held layers))
  sun (tap-hold 200 200 🔅 (layer-while-held layers))
  ori (layer-switch original)
  bas (layer-switch base)
  ret (tap-hold $tap-repress-timeout $hold-timeout ret (layer-while-held symbols))
  bspc (tap-hold $tap-repress-timeout $hold-timeout bspc (layer-while-held symbols))
  cts  (layer-while-held controls)

  z   (tap-hold $tap-repress-timeout $hold-timeout z lsft)
  6   (tap-hold $tap-repress-timeout $hold-timeout 6 lsft)

  a   (tap-hold $tap-repress-timeout $hold-timeout a lctl)
  1   (tap-hold $tap-repress-timeout $hold-timeout 1 lctl)

  s   (tap-hold $tap-repress-timeout $hold-timeout s lalt)
  2   (tap-hold $tap-repress-timeout $hold-timeout 2 lalt)

  d   (tap-hold $tap-repress-timeout $hold-timeout d lmet)
  3   (tap-hold $tap-repress-timeout $hold-timeout 3 lmet)

  f   (tap-hold $tap-repress-timeout $hold-timeout f lsft)

  j   (tap-hold $tap-repress-timeout $hold-timeout j rsft)

  k   (tap-hold $tap-repress-timeout $hold-timeout k   rmet)
  S-[ (tap-hold $tap-repress-timeout $hold-timeout S-[ rmet)

  l   (tap-hold $tap-repress-timeout $hold-timeout l   lalt)
  S-] (tap-hold $tap-repress-timeout $hold-timeout S-] lalt)

  ;   (tap-hold $tap-repress-timeout $hold-timeout ; rctl)
  `   (tap-hold $tap-repress-timeout $hold-timeout ` rctl)

  /   (tap-hold $tap-repress-timeout $hold-timeout / lsft)
  S-`   (tap-hold $tap-repress-timeout $hold-timeout S-` lsft)
)

;; Emacs-style cursor movement
(defoverrides
  (lctrl n) (down)
  (rctrl n) (down)

  (lctrl p) (up)
  (rctrl p) (up)

  (lctrl m) (ret)
  (rctrl m) (ret)

  (lctrl [) (esc)
  (rctrl [) (esc)

  (lctrl h) (bspc)
  (rctrl h) (bspc)

  ;; does not work in terminal or conflict with vim
  ;; (lctrl d) (del)
  ;; (lctrl u) (lmet bspc)
  ;; (lctrl w) (lalt bspc)
  ;; (rctrl w) (ralt bspc)
)

(defsrc
  esc   f1    f2    f3    f4    f5    f6    f7    f8    f9    f10   f11   f12
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  fn lctl lalt lmet           spc            rmet ralt
)

(deflayer original
  @esc  @sun 🔆   @mc  @sls f5   f6   ◀◀   ▶⏸   ▶▶   🔇   🔉   🔊
  grv   1    2    3    4    5    6    7    8    9    0    -    =    @bspc
  tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
  lctrl @a   @s   @d   @f   g    h    @j   @k   @l   @;    '    ret
  lsft  z    x   c    v    b    n    m    ,    .     /   rsft
  fn lctl lalt lmet           spc            rmet ralt
)

(deflayer base
  @esc  🔅   🔆   @mc  @sls f5   f6   ◀◀   ▶⏸   ▶▶   🔇   🔉   🔊
  tab   q    w    e    r    t    y    u    i    o    p    esc    @err    @err
  lctrl @a   @s   @d   f    g    h    j    @k   @l   @;   '    @err @err
  lsft  @z   x    c    v    b    n    m    ,    .    @/   rsft @err
  @err  @err @err @cts @bspc spc @ret @err @err @err @err @err
  fn    @err @cts  @bspc          spc           @ret @err
)

(deflayer symbols
  @esc  🔅   🔆   @mc  @sls f5   f6   ◀◀   ▶⏸   ▶▶   🔇   🔉   🔊
  tab   1    2    3    4    5    6    7    8    9    0    @err @err    @err
  lctrl _    _    _    _    _    -    =    @S-[ @S-] @`   \    @err @err
  lsft  _    _    _    _    _    S--  S-=  [    ]    @S-`  rsft @err
  @err  @err @err @err @bspc spc @ret @err @err @err @err @err
  fn    @err @err  @bspc          spc            @ret @err
)

(deflayer controls
  @esc  🔅   🔆   @mc  @sls f5   f6   ◀◀   ▶⏸   ▶▶   🔇   🔉   🔊
  _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  _
  _    _    _    _    _    _    left down up   rght _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _              _              _    _    _
)

(deflayer layers
  _     @bas  @ori  _     _     _     _     _     _     _     _     _     _
  _     _     _     _     _     _     _     _     _     _     _     _     _  _
  _     _     _     _     _     _     _     _     _     _     _     _     _  _
  _     _     _     _     _     _     _     _     _     _     _     _     _
  _     _     _     _     _     _     _     _     _     _     _     _
  _     _     _     _                   _               _     _
)
