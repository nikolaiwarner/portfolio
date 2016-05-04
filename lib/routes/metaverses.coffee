Router.route '/metaverses',
  name: 'metaverseIndex'
  waitOn: ->
    Meteor.subscribe('metaverses')
  data: ->
    metaverses: Metaverses.find()

Router.route '/metaverses/:metaverseId',
  name: 'metaverseShow'
  waitOn: ->
    Meteor.subscribe('metaverse', @params.metaverseId)
  data: ->
    metaverse: Metaverses.findOne(@params.metaverseId)
    metaverseObjects: MetaverseObjects.find(metaverseId: @params.metaverseId)

Router.route '/metaverses/:metaverseId/edit',
  name: 'metaverseEdit'
  waitOn: ->
    Meteor.subscribe('metaverse', @params.metaverseId)
  data: ->
    metaverse: Metaverses.findOne(@params.metaverseId)
    metaverseObjects: MetaverseObjects.find(metaverseId: @params.metaverseId)
