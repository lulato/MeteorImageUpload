Meteor.publish 'images', (limit) ->
  check limit, Number
  Images.find {}, limit: limit