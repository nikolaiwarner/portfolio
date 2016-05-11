Template.metaverseShow.onRendered ->
  $('a-entity[selectable]').on 'selected', (e) ->
    id = e.target.data('id')
    console.log(id);
