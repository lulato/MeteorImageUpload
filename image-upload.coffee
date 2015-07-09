# if Meteor.isClient

#   # Template Events
#   Template.my_template.events
#     'change .profile-image': (event, template) ->
#       files = event.target.files
#       i = 0
#       ln = files.length

#       while i < ln
#         Images.insert files[i], (err, fileObj) ->
#           console.log fileObj
#         i++
#       return

#   Template.imageView.helpers images: ->
#     Images.find()


# if Meteor.isServer
#   Meteor.startup ->

#     # FS Collection
#     profileThumbsStore = new FS.Store.S3('thumb',
#       accessKeyId     : 'AKIAJVOYXK4HVIZCPBWQ'
#       secretAccessKey : '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'
#       bucket          : 'meteor-file-uploader'
#       folder          : 'thumb'
#       transformWrite  : (fileObj, readStream, writeStream) ->
#         gm(readStream, fileObj.name()).resize("100", "100").stream().pipe writeStream
#         return
#     )
     
#     profileStore = new FS.Store.S3('original',
#       accessKeyId     : 'AKIAJVOYXK4HVIZCPBWQ'
#       secretAccessKey : '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'
#       bucket          : 'meteor-file-uploader'
#       folder          : 'original'
#     )
     
#     @Images = new FS.Collection('profiles',
#       stores: [profileStore, profileThumbsStore]
#     )

#     return




# # Store the full S3 url in the file
# getS3Url = (storageName, copy) ->
#   storage = getStorageByName(storageName)
#   if storage
#     urlHost = 'https://s3-' + s3options.region + '.amazonaws.com'
#     urlPath = path.join('/', s3options.bucket, storage.folder, copy.key)
#     urlHost + urlPath
#   else
#     null

# Images.find({}).observeChanges changed: (id, fields) ->
#   if fields.copies
#     newUrlsCount = 0
#     urls = {}
#     _.forOwn fields.copies, (copy, storageName) ->
#       if !copy.url
#         urls['copies.' + storageName + '.url'] = getS3Url(storageName, copy)
#         newUrlsCount += 1
#       return
#     if newUrlsCount > 0
#       Images.update id, $set: urls
#   return