#= require ./_nodes

BoneTree.namespace "BoneTree.Models", (Models) ->
  class Models.Directory extends Models.Node
    defaults:
      name: "New Directory"
      sortPriority: "0"
      type: "directory"

    toggleOpen: =>
      currentState = @get 'open'

      @set {open: not currentState}

