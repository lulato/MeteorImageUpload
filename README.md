This is my attempt to make an image uploader to meteor framework


I am following these tuts


- Install imagemagick

brew install imagemagick


- Update Bucket policy

{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::meteor-file-uploader/*"
        }
    ]
}


[Medium Article](https://medium.com/@victorleungtw/how-to-upload-files-with-meteor-js-7b8e811510fa)

[Github Readme](https://github.com/CollectionFS/Meteor-CollectionFS#installation)