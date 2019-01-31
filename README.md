# ldSlider

tiny range slider library.


## Usage

```
    ldrs = new ldSlider(configs);
    ldrs.set(value);
```

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
