BoneTree.namespace "Github", (Github) ->
  API_ROOT = "https://api.github.com"

  Github.Client = (token) ->
    # Raw API call, just setting up jsonp and adding the token
    callAPI: (url, data, callback)->
      if typeof data is "function"
        callback = data
        data = {}

      console.log "GITHUB GET: ", url, data

      # Add the jsonp callback to the url
      $.getJSON "#{url}?callback=?", data, (data) ->
          console.log "GITHUB RESPONSE: ", data
          # Ignoring metadata for now, just returning the main data
          callback(data.data)

    get: (path, data, callback) ->
      @callAPI("#{API_ROOT}#{path}", data, callback)

    post: (path, data, callback) ->
      if typeof data is "function"
        callback = data
        data = {}

      url = "#{API_ROOT}#{path}"

      console.log "GITHUB POST: ", url, data

      $.ajax
        contentType: 'application/json'
        data: JSON.stringify(data)
        dataType: 'json'
        success: (data) ->
          console.log "GITHUB RESPONSE: ", data
          callback(data)
        error: (data) ->
          console.log(data)
        processData: false
        type: 'POST'
        url: "#{url}?access_token=#{token}"

    createRepo: (data, callback) ->
      @post("/user/repos", data, callback)

    forkRepo: (user, repo, callback) ->
      @post "/repos/#{user}/#{repo}/forks", callback

    commit: () ->

    initialCommit: () ->
      # Not possible through API right now
      # One option is to use the collaborators API
      # to add a collaborator then hit our server to
      # have it set up the initial commit.

    # TODO: Move this to a member of a Repo object
    createBlob: (file, callback, user="STRd6", repo="Testie") ->
      @post("/repos/#{user}/#{repo}/git/blobs")

    # Make sure all files are blobs is the repo
    ingestFiles: (files) ->
      for file in files
        @createBlob file, (data) ->
          # TODO: Verify SHA

          # Update SHA
          file.set data

    postTree: (tree, callback, user="STRd6", repo="Testie") ->
      files = tree.files().map (file) ->
        {path, contents} = file.attributes

        path: path
        mode: "100644"
        type: "blob"
        content: contents

      @post "/repos/#{user}/#{repo}/git/trees",
        tree: files
      , callback

    populateTree: (tree) ->
      self = this

      tree.toArray().select (file) ->
        file.isFile()
      .each (file) ->
        url = file.get "url"
        self.fileContents url, (contents) ->
          file.set
            contents: contents

    fileContents: (url, callback) ->
      @callAPI url, ({content, encoding}) ->

        if encoding is "base64"
          content = Base64.decode(content)

        callback(content)

    # TODO: Clean these up to integrate with BoneTree better
    getRepo: (user, repo, callback, sha="pixie") ->
      @get "/repos/#{user}/#{repo}/git/trees/#{sha}",
        recursive: 1
      , (data) ->
        # Add each file
        for file in data.tree
          continue if file.type is "tree"
          tree.add(file.path, $.extend({}, file))

        callback(tree)

  Github.loadRepoInTree = (user="STRd6", repo="PixieDemo") ->
    client = Github.Client() #githubToken)

    client.getRepo user, repo, (tree) ->
      client.populateTree(tree)

