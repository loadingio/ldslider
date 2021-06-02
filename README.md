# ldSlider

Slider Library in Vanilla JS. Support exponential scale.


## Usage


1. download and include ldSlider [JS](https://github.com/loadingio/ldSlider/releases/latest/download/ldrs.min.js) / [CSS](https://github.com/loadingio/ldSlider/releases/latest/download/ldrs.min.css):

    <link rel="stylesheet" type="text/css" href="ldrs.css"/>
    <script type="text/javascript" src="ldrs.js"></script>

you an use a CDN, such as, from jsDelivr:

    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/gh/loadingio/ldslider@v1.0.0/dist/ldrs.min.css"/>
    <script type="text/javascript" src="//cdn.jsdelivr.net/gh/loadingio/ldslider@v1.0.0/dist/ldrs.min.js"/>


2. create a new ldSlider instance for using ldSlider's API:

    ldrs = new ldSlider(configs);
    ldrs.set(value);

Example:

    <div class="ldrs"></div>
    <script> ldrs = new ldSlider({root: document.querySelector('.ldrs')}); </script>

You can also use an input box to initialize ldSlider:

    <input class="ldrs" data-class="form-control">
    <script> ldrs = new ldSlider({root: document.querySelector('.ldrs')}); </script>

In this case, a new `div` will be created and inserted before the `input` element, inherits all classes of the `input` element. The `input` element's type will be set to `hidden`.

You can use an optional `data-class` attribute in `input` to define the classes of the input element.


## API

 - `set(value, forceNotify)`: set slider's value. Notify listeners if forceNotify = true and value is changed.
 - `get()`: get slider's value.
 - `setConfig(config)1: update slider's config. 
 - `on("change", cb)`: listen to value change.
 - `edit(v)`: toggle input box on (v = true) or off (v = false). auto swtich if v is undefined.
   this only works if you init ldrs over input element.
 - `update()`: update ui. useful when your slider is out of place ( sometimes due to toggle display and set value when widget is not visible.)


## Configuration

 * root: when the range slider kicks in.
 * min: minimal value
 * max: maximal value
 * step: each step when dragging
 * from: default value
 * exp: setup exponential scale.
   - exp.percent: when slider to move this percent ...
   - exp.value: ... the value should be map to this percent. 
   - for example:
     - {output: 0.9, input: 0.1} lets the slider to output 90% from min to max when slider is in the 10% position.
     - {output: 0.5, input: 0.5} equals to linear scale.
 * label: custom label.
   - label.min - text for showing in minimal value label
   - label.max - text for showing in maximal value label
   - label.ptr(v) - function that convert v ( value ) to the returned customized string that representing v.


## Decorating Classes

Add following css classes to decorate your range slider:

 * up - force all tips toward up.
 * ldrs.sm - small size slider
 * ldrs.lg - large size slider
 * ldrs.auto - adjust slider size based on context font size
 * ldrs.auto.sm - adjust slider size based on context font size, while make it smaller
 * ldrs.auto.lg - adjust slider size based on context font size, while make it larger


Some quick and useful tweaks:

 * gap between bar and tips:
   - .ldrs { height: 34px; }
   - .ldrs .hint { top: 0; }
   - .ldrs .bar { top: 18px; }
   - .ldrs .ptr { top: 15px; }


## DOM Structure

    .ldrs
      .bar
        .cap
        .cap
        .bar-inner
          .bk
          .fg
          .line.p     //- indicator line for chosen value
          .line.lock  //- indicator line for lock value
          .hint.p     //- chosen value pointer
      .hint.l
      .hint.lock
      .hint.r


## License

MIT
