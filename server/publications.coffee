Meteor.publish 'images', (limit, userSlug) ->
  check limit, Number

  findQuery = {}

  if userSlug
    check userSlug, String
    findQuery = userSlug: userSlug

  Images.find findQuery,
    limit: limit
    sort: uploadedAt: -1
