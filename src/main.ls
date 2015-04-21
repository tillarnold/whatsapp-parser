createElement = (t, cssClass, text)->
  ele = document.createElement t
  ele.classList.add cssClass if cssClass
  ele.innerText = text if text
  ele

removeDomElement = (el) ->
  el.parentNode.removeChild el

createDiv = (cssClass, text) ->
  createElement \div cssClass, text

appendOptions = (elems, domElement) ->
  elems.forEach (el) ->
    option = createElement \option void el
    option.value = el
    domElement.appendChild option

appendChildren = (parent, childs) ->
  childs.forEach (el) ->
    parent.appendChild el
  parent

toArray = (list) ->
  Array.prototype.slice.call list
#END UTILS




filterUI = (initProps, compairMethods, initData, userRender) ->
  storedUiData = initData

  #CreateUI
  rootElement = createDiv \filterUI-root
  filterElement = createDiv \filterUI-filter
  displayElement = createDiv \filterUI-display
  buttonPanel = createDiv \filterUI-buttonPanel
  filterButton = createElement \button \filterUI-filterButton \filter
  filterAddButton = createElement \button \filterUI-filterButton \+

  #style classes
  filterElement.classList.add \filterUI-coll
  displayElement.classList.add \filterUI-coll

  buttonPanel `appendChildren`[filterButton, filterAddButton]

  filterElement.appendChild buttonPanel

  rootElement `appendChildren` [displayElement, filterElement]

  filterButton.addEventListener 'click' (ev) ->
    filters = getFilterFormDom!
    renderAllData storedUiData , filters

  filterAddButton.addEventListener 'click' (ev) ->
    filterElement.appendChild createFilterBox!

   #Methods

  renderEntry = (entry) ->
    box = createDiv \filterUI-msgBox
    box.classList.add \filterUI-box
    box `appendChildren` userRender(entry)

  createFilterBox = ->
     box = createDiv \filterUI-filterBox 'where '
     propSelect = createElement \select \filterUI-propSelect
     methodSelect = createElement \select \filterUI-methodSelect
     textBox = createElement \input \filterUI-filterInput
     remove = createElement \button void \X

     box.classList.add \filterUI-box
     remove.addEventListener \click ->
       removeDomElement box

     appendOptions initProps, propSelect
     appendOptions Object.keys(compairMethods), methodSelect

     box `appendChildren` [propSelect, methodSelect, textBox, remove]



  createFilter = (prop, pattern, method ) ->
    (el) ->
      method el[prop], pattern

  getFilterFormDom = ->
    filters = toArray filterElement.querySelectorAll \.filterUI-filterBox
    filters.map (el) ->
      prop = el.querySelector \.filterUI-propSelect .value
      methodName  = el.querySelector \.filterUI-methodSelect .value
      method = compairMethods[methodName]
      pattern = el.querySelector \.filterUI-filterInput .value
      createFilter prop, pattern, method

  renderAllData = (data, filters)->
    displayElement.innerHTML = ''
    filters.forEach (filter) ->
      data := data.filter filter
    data.forEach (el) ->
     displayElement.appendChild renderEntry el

  setData: (newData) ->
    storedUiData := newData
    renderAllData storedUiData, getFilterFormDom!
  start: (parent = document.body) ->
    filterElement.appendChild createFilterBox!
    renderAllData storedUiData, []
    parent.appendChild rootElement
  addSkin: (skin) -> rootElement.classList.add skin


##APPP

let
  whatsapp = require 'whatsapp-parser'
  fields = <[name msg date]>
  methods =
    is: (val, pattern) ->
      val == pattern
    contains: (val, pattern) ->
      val.indexOf(pattern) > -1
    regex: (val, pattern) ->
      val.match new RegExp pattern
  render = (e) ->
    meta = createDiv \meta
    name = createDiv \name e.name
    date = createDiv \date e.date
    msg = createDiv \msg e.msg

    meta `appendChildren` [ name, date ]
    [ meta, msg ]


  ui = filterUI fields, methods, [], render
  ui.start!
  ui.addSkin \basic-flex-layout
  ui.addSkin \color-skin
  ui.addSkin \padding-skin

  handleFileSelect = (evt ) ->
    file = evt.target.files[0]
    reader = new FileReader()

    reader.onload = (e) ->
      data = whatsapp.parse(e.target.result)
      ui.setData data
    reader.readAsText file

  document.getElementById \upload .addEventListener \change handleFileSelect

###########
