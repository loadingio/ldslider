(->
  root1 = ld$.find('#root1',0)
  root2 = ld$.find('#root2',0)

  ldrs = new ldSlider root: ld$.find(root1, '.ldrs',0), min: 0
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 30

  ldrs = new ldSlider root: ld$.find(root1,'.ldrs',1), min: 0
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root1,'.ldrs',2), min: 0, exp: {output: 0.9, input: 0.5}
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root1,'.ldrs',3), min: 0, exp: {output: 0.9, input: 0.5}, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root1,'.ldrs',4), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 8

  ldrs = new ldSlider root: ld$.find(root1,'.ldrs',5), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 8

  ldcv = new ldCover root: ld$.find('.ldcv', 0)

  ldrs = window.ldrsInput = new ldSlider root: ld$.find(root1,'.ldrs',6), min: 1, max: 11, step: 2
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 5


  ldrs = new ldSlider root: ld$.find(root2, '.ldrs',0), min: 0, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 30

  ldrs = new ldSlider root: ld$.find(root2,'.ldrs',1), min: 0, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root2,'.ldrs',2), min: 0, exp: {output: 0.9, input: 0.5}, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root2,'.ldrs',3), min: 0, exp: {output: 0.9, input: 0.5}, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 50

  ldrs = new ldSlider root: ld$.find(root2,'.ldrs',4), min: 1, max: 11, step: 2, limit-max: 7
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set 8

  ldrs = new ldSlider root: ld$.find(root2,'.ldrs',5), min: 1, max: 100, step: 0.01, limit-max: 60
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set {from: 2, to: 8}


  ldrs = window.ldrsInput = new ldSlider root: ld$.find(root2,'.ldrs',6), min: 1, max: 11, step: 2, range: true
  ldrs.on \change, -> console.log 'changed:', it
  ldrs.set {from: 2, to: 8}


  window.popup = -> ldcv.toggle true

)!
