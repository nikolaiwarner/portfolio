AutoForm.hooks
  metaverseForm:
    after:
      insert: (error, result, template) ->
        if error
          Materialize.toast(error.message, 5000)
        else
          Router.go("/metaverses/#{result}")
      update: (error, result, template) ->
        if error
          Materialize.toast(error.message, 5000)
        else
          Materialize.toast("Saved.", 5000)
          Router.go("/metaverses/#{this.currentDoc._id}")
      remove: (error, result, template) ->
        if error
          Materialize.toast(error.message, 5000)
        else
          Router.go("/metaverses/")
          Materialize.toast("Removed metaverse.", 5000)

Template.metaverseForm.helpers
  method: ->
    if @metaverse && @metaverse._id then 'update' else 'insert'
