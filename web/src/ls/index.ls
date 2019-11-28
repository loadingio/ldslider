(->
  ldrs = new ldSlider root: '.ldrs', min: 0
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 30

  ldrs = new ldSlider root: ld$.find(document,'.ldrs',1), min: 0
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(document,'.ldrs',2), min: 0, exp: {output: 0.9, input: 0.5}
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(document,'.ldrs',3), min: 0, exp: {output: 0.9, input: 0.5}, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(document,'.ldrs',4), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 8

  ldrs = new ldSlider root: ld$.find(document,'.ldrs',5), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 8

  ldcv = new ldCover root: ld$.find(document, '.ldcv', 0)

  ldrs = window.ldrsInput = new ldSlider root: ld$.find(document,'.ldrs',6), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 5

  window.popup = -> ldcv.toggle true

)!
