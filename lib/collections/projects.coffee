@Projects = new Meteor.Collection "projects"

projectsSchema = new SimpleSchema
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

  published:
    type: Boolean
    defaultValue: false

  featured:
    type: Boolean
    defaultValue: false

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

  thumbnailUrl:
    type: String
    max: 1000
    optional: true

  tags:
    type: [String]
    max: 140
    optional: true

  tagsTitles:
    type: String
    max: 10000
    optional: true

@Projects.attachSchema(projectsSchema, {transform: true})

@Projects.allow
  insert: (userId, doc) ->
    Roles.userIsInRole(userId, 'admin')
  update: (userId, doc, fieldNames, modifier) ->
    # Only admins can update
    Roles.userIsInRole(userId, 'admin') ||
  remove: (userId, doc, fieldNames, modifier) ->
    # Only admins can remove
    Roles.userIsInRole(userId, 'admin')
