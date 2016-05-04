@MetaverseObjects = new Meteor.Collection "metaverseObjects"
@MetaverseObjects.friendlySlugs('name')

metaverseObjectsSchema = new SimpleSchema
  ownerUserId:
    type: String
    denyUpdate: true
    index: true
    autoValue: ->
      if @isInsert
        Meteor.userId()
        
  createdAt:
    type: Date
    denyUpdate: true
    autoValue: ->
      if @isInsert
        new Date()

  slug:
    type: String
    optional: true
    max: 140

  name:
    type: String
    max: 140
    optional: true

  description:
    type: String
    max: 100000
    optional: true

  userId:
    type: String
    optional: true

  metaverseId:
    type: String
    max: 140

  position:
    type: String
    max: 140
    optional: true

  rotation:
    type: String
    max: 140
    optional: true

  geometry:
    type: String
    max: 140
    optional: true

  material:
    type: String
    max: 140
    optional: true



@MetaverseObjects.attachSchema(metaverseObjectsSchema, {transform: true})

@MetaverseObjects.allow
  insert: (userId, doc) ->
    # Anyone can insert as long as you created it
    userId && (doc.ownerUserId == userId)

  update: (userId, doc, fieldNames, modifier) ->
    # Only admins can update or the owner
    Roles.userIsInRole(userId, 'admin') ||
      (userId && (doc.ownerUserId == userId))

  remove: (userId, doc, fieldNames, modifier) ->
    # Only admins can remove or the owner
    Roles.userIsInRole(userId, 'admin') ||
      (userId && (doc.ownerUserId == userId))
