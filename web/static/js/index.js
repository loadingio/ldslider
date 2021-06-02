(function(){
  var root1, root2, ldrs, ldcv;
  root1 = ld$.find('#root1', 0);
  root2 = ld$.find('#root2', 0);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 0),
    min: 0
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(30);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 1),
    min: 0
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 2),
    min: 0,
    exp: {
      output: 0.9,
      input: 0.5
    }
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 3),
    min: 0,
    exp: {
      output: 0.9,
      input: 0.5
    },
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 4),
    min: 1,
    max: 11,
    step: 2
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(8);
  ldrs = new ldSlider({
    root: ld$.find(root1, '.ldrs', 5),
    min: 1,
    max: 11,
    step: 2
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(8);
  ldcv = new ldCover({
    root: ld$.find(root1, '.ldcv', 0)
  });
  ldrs = window.ldrsInput = new ldSlider({
    root: ld$.find(root1, '.ldrs', 6),
    min: 1,
    max: 11,
    step: 2
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(5);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 0),
    min: 0,
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(30);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 1),
    min: 0,
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 2),
    min: 0,
    exp: {
      output: 0.9,
      input: 0.5
    },
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 3),
    min: 0,
    exp: {
      output: 0.9,
      input: 0.5
    },
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(50);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 4),
    min: 1,
    max: 11,
    step: 2,
    limitMax: 7
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set(8);
  ldrs = new ldSlider({
    root: ld$.find(root2, '.ldrs', 5),
    min: 1,
    max: 100,
    step: 0.01,
    limitMax: 60
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set({
    from: 2,
    to: 8
  });
  ldcv = new ldCover({
    root: ld$.find(root2, '.ldcv', 0)
  });
  ldrs = window.ldrsInput = new ldSlider({
    root: ld$.find(root2, '.ldrs', 6),
    min: 1,
    max: 11,
    step: 2,
    range: true
  });
  ldrs.on('change', function(it){
    return console.log('changed:', it);
  });
  ldrs.set({
    from: 2,
    to: 8
  });
  return window.popup = function(){
    return ldcv.toggle(true);
  };
})();