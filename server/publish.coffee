Meteor.publish "projects", () ->
  Projects.find {}, sort: {name: 1}
