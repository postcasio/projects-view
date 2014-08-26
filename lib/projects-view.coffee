_ = require 'underscore-plus'
{ScrollView, $, $$} = require 'atom'
path = require 'path'
season = require 'season'

module.exports =
class ProjectsView extends ScrollView
  @content: ->
    @div class: 'projects-view native-key-bindings pane-item', tabindex: -1, =>
      @div class: 'panel', =>
        @div class: 'panel-heading', =>
          @raw 'Projects'

        @div class: 'panel-body padded', =>
          @div class: 'btn-toolbar', =>
            @div class: 'btn-group', =>
              @button class: 'btn', =>
                @span class: 'icon icon-plus'
                @raw 'Add Project'
          @div class: 'projects', outlet: 'projectsContainer'

  initialize: ->
    super
    try
        @projects = season.readFileSync(path.join(atom.getConfigDirPath(), 'projects.cson')).projects.map(@fetchMetadata)
    catch e
        @projects = []
    @renderProjects()

  fetchMetadata: (project) ->
    name: path.basename project
    path: project

  getTitle: -> 'Projects'

  renderProjects: ->
    for project in @projects
      $btn = $("<button class=\"btn\">
          <span class=\"project-icon\">\uf016</span>
          #{project.name}
      </button>")

      $div = $("<div class=\"project\">")

      $btn.on 'click', do (project) -> -> atom.open pathsToOpen: [project.path]
      $div.append($btn)

      @projectsContainer.append $div

    width = @projectsContainer.width()
    @projectsContainer.find('.project').width(Math.max(width / 10, 160))
