#= require bone_tree/_namespace
#= require bone_tree/views/_menu

beforeEach ->
  setFixtures("<div id='test'></div>")

  @model = new Backbone.Model

  @settings = new Backbone.Model
    confirmDeletes: false

  @menu = new BoneTree.Views.Menu
    model: @model
    settings: @settings

  $('#test').append @menu.render().el

afterEach ->
  $('#test').empty()

describe "rendering", ->
  it "should render the correct DOM elements", ->
    expect($('#test .filetree_context_menu')).toExist()
    expect($('#test .filetree_context_menu').length).toEqual(1)

    expect($('#test .filetree_context_menu li').length).toEqual(2)
    expect($('#test .filetree_context_menu li.rename')).toExist()
    expect($('#test .filetree_context_menu li.delete')).toExist()

describe "interactions", ->
  it "should delete", ->
    spy = sinon.spy()

    @model.bind 'destroy', spy

    $('#test .delete').click()

    expect(spy).toHaveBeenCalled()
    expect($('#test .filetree_context_menu')).toBeHidden()

