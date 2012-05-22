#= require bone_tree/_namespace
#= require bone_tree/models/_directory

describe 'BoneTree.Models.Directory', ->
  it 'should be able to visualize the tree structure with Ascii characters', ->
    tree = new BoneTree.Views.Tree

    tree.file('src/main.coffee', { description: 'Entry point' })
    tree.file('src/player.coffee', { description: 'The hero' })
    tree.file('src/enemy.coffee', { description: 'The baddy' })

    expect(tree.root.collection.last().toAscii()).toEqual('+src\n -main.coffee\n -player.coffee\n -enemy.coffee')

  it 'should be able to return all files it contains', ->
    tree = new BoneTree.Views.Tree

    main = tree.file('src/main.coffee', { description: 'Entry point' })
    player = tree.file('src/player.coffee', { description: 'The hero' })
    enemy = tree.file('src/enemy.coffee', { description: 'The baddy' })

    expect(tree.root.collection.last().files()).toEqual([main, player, enemy])