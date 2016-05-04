Meteor.startup ->
  # Add authentication configuration
  ServiceConfiguration.configurations.update {"service": "google"},
    {$set: {
      "clientId": Meteor.settings.authentication.google.clientId,
      "secret": Meteor.settings.authentication.google.secret
    }}, { upsert: true }

  # Set default admin user on first run
  defaultAdmin = Meteor.settings.defaultAdmin
  unless Accounts.findUserByEmail(defaultAdmin.email)
    adminId = Accounts.createUser
      username: defaultAdmin.username
      email: defaultAdmin.email
      password: defaultAdmin.password
    Roles.addUsersToRoles(adminId, 'admin')
    #Houston._admins.insert(user_id: adminId)

Accounts.validateNewUser (user) ->
  # return true if Roles.userIsInRole(this.userId, ['admin'])
  # throw new Meteor.Error(403, "Not authorized to create new users")
  return user

Accounts.onCreateUser (options, user) ->
  Roles.addUsersToRoles(user._id, 'user')
  return user
