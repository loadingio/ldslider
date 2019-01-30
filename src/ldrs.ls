ldSlider = (opt={}) ->
  @ <<< evt-handler: {}, opt: {min: 0, max: 100, from: 0, step: 1} <<< opt
  @root = root = if typeof(opt.root) == \string => document.querySelector(opt.root) else opt.root
  if @root.tagName == \INPUT => 
    @input = @root
    ld$.attr @input, \type, \hidden
    @root = root = document.createElement("div")
    @input.parentNode.insertBefore @root, @input
  @root.classList.add \ldrs
  @root.innerHTML = """
    <div class="bar">
      <div class="cap"></div>
      <div class="bk"></div>
      <div class="fg"></div>
      <div class="cap"></div>
    </div>
    <div class="ptr"></div>
    <div class="hint l"></div>
    <div class="hint r"></div>
    <div class="hint p"></div>
  """

  @el = el = do
    b: fg: ld$.find(root, '.fg', 0)
    p: ld$.find(root, '.ptr', 0)
    h:
      p: ld$.find(root, '.hint.p', 0) 
      l: ld$.find(root, '.hint.l', 0) 
      r: ld$.find(root, '.hint.r', 0) 

  mouse = do
    move: (e) ~> 
      box = el.p.parentNode.getBoundingClientRect!
      b = [10, box.width - 10]
      x = ( e.clientX - box.x ) >? b.0 <? b.1
      old = @value
      @value = (@opt.max - @opt.min) * (( x - b.0 ) / (b.1 - b.0)) + @opt.min
      @value = Math.round(@value / @opt.step) * @opt.step
      if old == @value => return
      el.p.style.left = "#{x}px"
      el.h.p.innerText = Math.round( 10000 * @value ) / 10000
      box = el.h.p.getBoundingClientRect!
      el.h.p.style.left = "#{x - Math.round(box.width * 0.5) + 1}px"
      el.b.fg.style.width = "#{x - 10}px"
      @fire \change, @value
    up: ->
      document.removeEventListener \mouseup, mouse.up
      document.removeEventListener \mousemove, mouse.move
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
    @el.h.p.innerText = @opt.from
  set-config: (opt={}) -> @opt <<< opt; @prepare!
  set: (v) ->
    @value = v
    box = @root.getBoundingClientRect!
    b = [14, box.width - 10 - 4] # TODO as member
    v = Math.round((v >? @opt.min <? @opt.max) / @opt.step) * @opt.step
    x = ((v - @opt.min) / (@opt.max - @opt.min)) * (b.1 - b.0) + b.0
    @el.h.p.innerText = Math.round(10000 * v) / 10000
    box = @el.h.p.getBoundingClientRect!
    @el.h.p.style.left = "#{x - Math.round(box.width * 0.5) + 1}px"
    @el.p.style.left = "#{x}px"
    @el.b.fg.style.width = "#{x - 10}px"
  get: -> @value

