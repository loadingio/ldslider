# ldSlider

tiny range slider library.


## Usage

```
    ldrs = new ldSlider(configs);
    ldrs.set(value);
```

Available methods:

 * set(value, forceNotify): set slider's value. Notify listeners if forceNotify = true and value is changed.
 * get: get slider's value.
 * setConfig(config): update slider's config. 
 * on("change", cb): listen to value change.
 * update: update ui. useful when your slider is out of place ( sometimes due to toggle display and set value when widget is not visible.)


configs: 

 * root: when the range slider kicks in.
 * min: minimal value
 * max: maximal value
 * step: each step when dragging
 * from: default value


## Decorating Classes

Add following css classes to decorate your range slider:

 * up - force all tips toward up.


Some quick and useful tweaks:

 * gap between bar and tips:
   - .ldrs { height: 34px; }
   - .ldrs .hint { top: 0; }
   - .ldrs .bar { top: 18px; }
   - .ldrs .ptr { top: 15px; }


## License

MIT
