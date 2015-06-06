
/*
 FS Collection
 */
var profileStore, profileThumbsStore;

profileThumbsStore = new FS.Store.S3('thumb', {
  accessKeyId: 'holaboyperu',
  secretAccessKey: 'grkWzWWz/MX2d/dO45oeNVzM2B2nQ+jd2N7rjoo',
  bucket: 'meteor-file-uploader',
  folder: 'thumb',
  transformWrite: function(fileObj, readStream, writeStream) {
    gm(readStream, fileObj.name()).resize("100", "100").stream().pipe(writeStream);
  }
});

profileStore = new FS.Store.S3('original', {
  accessKeyId: 'holaboyperu',
  secretAccessKey: 'grkWzWWz/MX2d/dO45oeNVzM2B2nQ+jd2N7rjoo',
  bucket: 'meteor-file-uploader',
  folder: 'original'
});

this.Images = new FS.Collection('profiles', {
  stores: [profileStore, profileThumbsStore]
});



if (Meteor.isClient) {

  /*
   Template Events
   */

  Template.my_template.events({
    'change .profile-image': function(event, template) {
      var files, i, ln;
      files = event.target.files;
      i = 0;
      ln = files.length;
      while (i < ln) {
        Images.insert(files[i], function(err, fileObj) {
          return console.log(fileObj);
        });
        i++;
      }
    }
  });

}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}

