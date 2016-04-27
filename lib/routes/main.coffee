Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'page_loading'
  notFoundTemplate: 'page_notfound'

Router.plugin 'dataNotFound', {notFoundTemplate: 'page_notfound'}

Router.before ->
  # Subscribe on all routes
  if Meteor.isClient
    Meteor.subscribe 'projects'
  this.next()

Router.route 'Anything',
  path: '/:everything(.*)'
  fastRender: true
  waitOn: ->
    Meteor.subscribe 'project_by_slug', @params.everything
  data: ->
    slug = @params.everything
    if project = Projects.findOne({slug: slug})
      Router.go('/projects/'+project.slug)
