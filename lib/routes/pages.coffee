Router.route '/',
  name: 'pageHome'
  template: 'pageHome'
  data: ->
    nick: "hello!"

AccountsTemplates.configureRoute 'signIn',
    name: 'pageSignin'
    path: '/signin'
    template: 'pageSignin'
    layoutTemplate: 'layout',
    fastRender: true

Router.route '/signout',
  onBeforeAction: ->
    Meteor.logout ->
      Materialize.toast("Signed out.", 5000)
      Router.go('/')
