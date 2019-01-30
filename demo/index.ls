
ldrs = new ldSlider root: '.ldrs', min: 20
ldrs.on \change, -> console.log 'changed:', it
ldrs.set 30

ldrs = new ldSlider root: ld$.find(document,'.ldrs',1), min: 20
ldrs.on \change, -> console.log 'changed:', it
ldrs.set 50
