#
# FS Collection
#

profileThumbsStore = new FS.Store.S3('thumb',
  accessKeyId     : 'accessKeyId'
  secretAccessKey : 'secretAccessKey'
  bucket          : 'meteor-file-uploader'
  folder          : 'thumb'
  transformWrite  : (fileObj, readStream, writeStream) ->
    gm(readStream, fileObj.name()).resize("100", "100").stream().pipe writeStream
    return
)
 
profileStore = new FS.Store.S3('original',
  accessKeyId     : 'accessKeyId'
  secretAccessKey : 'secretAccessKey'
  bucket          : 'meteor-file-uploader'
  folder          : 'original'
)
 
@Images = new FS.Collection('profiles',
  stores: [profileStore, profileThumbsStore]
)


# @Images = new FS.Collection('profiles',
#   stores: [profileStore]
# )


if Meteor.isClient

  # Template Events
  Template.my_template.events

    'change .profile-image': (event, template) ->
      files = event.target.files
      i = 0
      ln = files.length

      while i < ln
        Images.insert files[i], (err, fileObj) ->
          console.log fileObj
        i++
      return


if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
    return