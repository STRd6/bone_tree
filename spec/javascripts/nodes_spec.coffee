#= require bone_tree/_namespace
#= require bone_tree/models/_nodes

describe 'BoneTree.Models.Node', ->
  beforeEach ->
    {Models} = BoneTree

    @file = new Models.Node
      nodeType: 'file'
      name: 'config'
      extension: 'json'

    @directory = new Models.Node
      nodeType: 'directory'
      name: 'src'

  it 'should return the correct constantized type', ->
    expect(@file.constantize()).toEqual('File')
    expect(@directory.constantize()).toEqual('Directory')

  it 'should return the full name with extension when appropriate', ->
    expect(@file.nameWithExtension()).toEqual('config.json')
    expect(@directory.nameWithExtension()).toEqual('src')

  it 'should return just the fileName when no extension is present', ->
    @file = new BoneTree.Models.Node
      nodeType: 'file'
      name: 'something'

    expect(@file.nameWithExtension()).toEqual('something')

    @anotherFile = new BoneTree.Models.Node
      nodeType: 'file'
      name: 'main'
      extension: ''

    expect(@anotherFile.nameWithExtension()).toEqual('main')
