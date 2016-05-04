@Metaverses = new Meteor.Collection "metaverses"
@Metaverses.friendlySlugs('name')

metaversesSchema = new SimpleSchema
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

  updatedAt:
    type: Date
    denyInsert: true
    optional: true
    autoValue: ->
      if @isUpdate
        new Date()

  slug:
    type: String
    optional: true
    max: 140
    index: true
    unique: true

  name:
    type: String
    max: 140
    index: true

  description:
    type: String
    max: 100000
    optional: true

@Metaverses.attachSchema(metaversesSchema, {transform: true})

@Metaverses.allow
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
