
@Images = new FS.Collection("images",
	stores: [
		new FS.Store.GridFS("images")
		new FS.Store.GridFS("thumbs",
			transformWrite: (fileObj, readStream, writeStream) ->

				gm(readStream, fileObj.name()).resize("40", "50").stream().pipe writeStream
				return
		)
	]
	filter:
		allow:
			contentTypes: ["image/*"]
)
