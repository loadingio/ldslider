ldSlider = (opt={}) ->
  @ <<< evt-handler: {}, opt: {min: 0, max: 100, from: 0, step: 1} <<< opt
  @root = root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  if @root.tagName == \INPUT =>
    @input = @root
    ld$.attr @input, \type, \hidden
    @root = root = document.createElement("div")
    @input.parentNode.insertBefore @root, @input
    @input.classList
    for i from 0 til @input.classList.length => @root.classList.add @input.classList[i]
    @input.setAttribute \class, ''
    if @input.getAttribute(\data-class) => @input.classList.add.apply @input.classList, that.split(' ')
    handle = ~> @repos @input.value, true, false, true
    @input.addEventListener \change, handle
    @input.addEventListener \input, handle

  @root._ldrs = @
  @root.classList.add \ldrs
  @root.innerHTML = """
    <div class="bar">
      <div class="cap"></div>
      <div class="cap"></div>
      <div class="bar-inner">
        <div class="bk"></div>
        <div class="fg"></div>
        <div class="line p"></div>
        <div class="line lock"></div>
        <div class="hint p"></div>
      </div>
    </div>
    <div class="hint l"></div>
    <div class="hint lock"></div>
    <div class="hint r"></div>
  """

  @el = el = do
    b: fg: ld$.find(root, '.fg', 0)
    p: ld$.find(root, '.line.p', 0)
    h:
      p: ld$.find(root, '.hint.p', 0)
      l: ld$.find(root, '.hint.l', 0)
      r: ld$.find(root, '.hint.r', 0)
      lock: ld$.find(root, '.hint.lock', 0)
      lock-line: ld$.find(root, '.lock-line', 0)

  mouse = do
    move: (e) ~> @repos e.clientX, true, true

    up: ~>
      document.removeEventListener \mouseup, mouse.up
      document.removeEventListener \mousemove, mouse.move
      @el.h.p.innerText = @label.ptr(Math.round(10000 * @value) / 10000)
    prepare: ->
      document.addEventListener \mousemove, mouse.move
      document.addEventListener \mouseup, mouse.up

  el.p.addEventListener \mousedown, mouse.prepare
  root.addEventListener \click, mouse.move
  root.addEventListener \mousedown, mouse.prepare

  @prepare!
  @

ldSlider.prototype = Object.create(Object.prototype) <<< do
  on: (n, cb) -> @evt-handler.[][n].push cb
  fire: (n, ...v) -> for cb in (@evt-handler[n] or []) => cb.apply @, v
  update: -> @set @value
  # use internally for updating input box
  update-input: ({now} = {now: false}) ->
    clearTimeout @debounce
    @debounce = setTimeout (~> if @input.value != @value => @input.value = @value), (if now => 0 else 500)
  edit: (v) ->
    if !@input => return
    if !(v?) => v = @input.getAttribute(\type) == \hidden
    @input.setAttribute \type, if v => \text else \hidden
    @root.style.display = if v => \none else ''
    if !v => @update!

  prepare: ->
    if @opt.from? => @value = @opt.from
    # exponential slider. use exp: {value, percent} to control its shape.
    if @opt.exp => @exp-factor = Math.log(@opt.exp.output or (@opt.max - @opt.min)) / Math.log(@opt.exp.input)
    @label = {
      ptr: ~>
        if it == @opt.min and @label.min? => @label.min
        else if it == @opt.max and @label.max? => @label.max
        else it
    } <<< (@opt.label or {})
    @el.h.l.innerText = if @label.min? => @label.min else @opt.min
    @el.h.r.innerText = if @label.max? => @label.max else @opt.max
    @el.h.lock.innerHTML = """<i class="i-lock"></i>"""
    @el.h.p.innerText = @label.ptr(@opt.from)
    @root.classList[if @opt.limit-max? => \add else \remove] \limit
    @update!
  set-config: (opt={}) -> @opt = {} <<< opt; @prepare!
  set: (v, force-notify=false) -> @repos v, force-notify
  get: -> @value

  /* v is e.clientX or value, depends on is-event */
  repos: (v, force-notify=false, is-event=false, from-input=false)->
    /* normalize value and position */
    old = @value
    rbox = @el.p.parentNode.getBoundingClientRect!
    w06 = rbox.width * 0.6
    if is-event =>
      x = ( v - rbox.x ) >? 0 <? rbox.width
      dx = (x / rbox.width)
      if @exp-factor => dx = Math.pow(dx, @exp-factor)
      @value = @opt.min + (@opt.max - @opt.min) * dx
      if @opt.limit-max? =>
        if x > w06 => @value = @opt.limit-max + (@opt.max - @opt.limit-max) * (x - w06) / ( rbox.width - w06 )
        else
          dx = (x / w06)
          if @exp-factor => dx = Math.pow dx, @exp-factor
          @value = @opt.min + @opt.limit-max * dx
    else @value = v
    @value = v = (@opt.min + Math.round((@value - @opt.min) / @opt.step) * @opt.step) >? @opt.min <? @opt.max
    if @opt.limit-max? =>
      if v > @opt.limit-max => x = (v - @opt.limit-max) / (@opt.max - @opt.limit-max) * 40 + 60
      else
        if @exp-factor => x = 60 * Math.pow((v - @opt.min) / (@opt.limit-max - @opt.min), 1/@exp-factor)
        else x = 60 * (v - @opt.min) / (@opt.limit-max - @opt.min)
    else
      if @exp-factor => x = 100 * Math.pow(((@value - @opt.min) / (@opt.max - @opt.min)), 1/@exp-factor)
      else x = 100 * ((@value - @opt.min) / (@opt.max - @opt.min))

    if @opt.limit-max? and @opt.limit-hard =>
      if x > 60 => x = 60
      if @value > @opt.limit-max => @value = v = @opt.limit-max

    /* update value and position into view */
    hbox = @el.h.p.getBoundingClientRect!
    @el.h.p.innerText = @label.ptr(Math.round(10000 * v) / 10000)
    @el.h.p.style.left = "#{100 * (0.01 * x * rbox.width) / rbox.width}%"
    @el.h.p.style.transform = "translate(-50%,0)"
    @el.p.style.left = "#x%"
    @el.b.fg.style.width = "#x%"

    /* notification if necessary*/
    # force-notify is true when repos is triggered by mouse dragging the slider.
    if v != old and force-notify => @fire \change, @value
    # if input available, update its value.
    # if from-input = true: repos is triggered from user input of input box,
    # so we have to debounce if v is modified.
    if @input => @update-input {now: !from-input}
