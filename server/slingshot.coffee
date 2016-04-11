Slingshot.createDirective "fileUploads", Slingshot.S3Storage,
  allowedFileTypes: Meteor.settings.public.allowed_file_types
  maxSize: 1*0x400*0x400 * 10 #10MB
  acl: "public-read"
  authorize: ->
    #Deny uploads if user is not logged in.
    if !@userId
      message = "Please login before posting files"
      throw new Meteor.Error("Login Required", message)
    true

  key: (file) ->
    # create filename for uploaded file
    user = Meteor.users.findOne(@userId)
    Meteor._debug "File uploaded:", file
    user._id + "/" + Meteor.uuid() + "_" + file.name + ".jpg"
