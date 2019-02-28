ldSlider = (opt={}) ->
  @ <<< evt-handler: {}, opt: {min: 0, max: 100, from: 0, step: 1} <<< opt
  @value = @opt.from
  @root = root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  if @root.tagName == \INPUT =>
    @input = @root
    ld$.attr @input, \type, \hidden
    @root = root = document.createElement("div")
    @input.parentNode.insertBefore @root, @input
  @root._ldrs = @
  @root.classList.add \ldrs
  @root.innerHTML = """
    <div class="bar">
      <div class="cap"></div>
      <div class="cap"></div>
      <div class="bar-inner">
        <div class="bk"></div>
        <div class="fg"></div>
        <div class="ptr"></div>
        <div class="lock-line"></div>
        <div class="hint p"></div>
      </div>
    </div>
    <div class="hint l"></div>
    <div class="hint lock"></div>
    <div class="hint r"></div>
  """

  @el = el = do
    b: fg: ld$.find(root, '.fg', 0)
    p: ld$.find(root, '.ptr', 0)
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
      @el.h.p.innerText = Math.round(10000 * @value) / 10000
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
  prepare: ->
    @el.h.l.innerText = @opt.min
    @el.h.r.innerText = @opt.max
    @el.h.lock.innerHTML = """<i class="i-lock"></i>"""
    @el.h.p.innerText = @opt.from
    @root.classList[if @opt.limit-max? => \add else \remove] \limit
    @update!
  set-config: (opt={}) -> @opt = {} <<< opt; @prepare!
  set: (v, force-notify=false) -> @repos v, force-notify
  get: -> @value

  /* v is e.clientX or value, depends on is-event */
  repos: (v, force-notify=false, is-event=false)->
    /* normalize value and position */
    old = @value
    max = if @opt.limit-max? => @opt.limit-max / 0.6 else @opt.max
    rbox = @el.p.parentNode.getBoundingClientRect!
    if is-event =>
      x = ( v - rbox.x ) >? 0 <? rbox.width
      @value = (max - @opt.min) * (x / rbox.width) + @opt.min
    else @value = v
    @value = v = (Math.round(@value / @opt.step) * @opt.step) >? @opt.min <? max
    x = 100 * ((@value - @opt.min) / (max - @opt.min))
    if @opt.limit-max? =>
      if x > 60 => x = 60
      if @value > @opt.limit-max => @value = v = @opt.limit-max

    /* update value and position into view */
    hbox = @el.h.p.getBoundingClientRect!
    @el.h.p.innerText = Math.round(10000 * v) / 10000
    @el.h.p.style.left = "#{100 * (0.01 * x * rbox.width) / rbox.width}%"
    @el.h.p.style.transform = "translate(-50%,0)"
    @el.p.style.left = "#x%"
    @el.b.fg.style.width = "#x%"

    /* notification if necessary*/
    if v != old and force-notify => @fire \change, @value
