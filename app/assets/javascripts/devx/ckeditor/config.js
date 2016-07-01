CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
CKEDITOR.config.entities = false;
CKEDITOR.config.allowedContent = true
CKEDITOR.config.protectedSource.push(/<i[^>]*><\/i>/g);
CKEDITOR.dtd.$removeEmpty['i'] = false