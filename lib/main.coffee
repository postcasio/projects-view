ProjectsView = require './projects-view'

projectsUri = 'atom://projects'

createProjectsView = (params) ->
  ProjectsView ?= require './projects-view'
  projectsView = new ProjectsView(params)

module.exports =
  activate: ->
    atom.workspace.registerOpener (uri) ->
      createProjectsView({uri}) if uri is projectsUri
    atom.workspaceView.command 'projects:open', ->
      atom.workspaceView.open(projectsUri)

  deactivate: ->
