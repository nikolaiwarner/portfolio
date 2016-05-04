Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'pageLoading'
  notFoundTemplate: 'pageNotfound'

Router.plugin 'dataNotFound', {notFoundTemplate: 'pageNotfound'}

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
