Meteor.publish "projects", () ->
  Projects.find {}, sort: {name: 1}

Meteor.publish "metaverses", () ->
  Metaverses.find {}, sort: {name: 1}

Meteor.publish "metaverse", (id) ->
  [
    Metaverses.find({_id: id})
    MetaverseObjects.find({metaverseId: id})
  ]
