<link rel="stylesheet" type="text/css" href="/css/swfupload.css" media="all" />
        <script type="text/javascript" src="/js/swfup/swfupload.js"></script>
        <script type="text/javascript" src="/js/swfup/swfupload.queue.js"></script>
        <script type="text/javascript" src="js/swfup/fileprogress.js"></script>
        <script type="text/javascript" src="/js/swfup/handlers.js"></script>

        <script>
        var upload_url = '{url_path('file','upload')}';
        
        function createSwfUpload(index,allowSize, allowFile, handlers){
            var upload = new SWFUpload({
                // Backend Settings
                upload_url: upload_url,
                post_params: {},
                // File Upload Settings
                file_size_limit : allowSize,
                file_types : allowFile ,
                file_types_description : "选择文件",
                file_upload_limit : "0",
                file_queue_limit : "0",
                // Event Handler Settings (all my handlers are in the Handler.js file)
                file_dialog_start_handler : fileDialogStart,
                file_queued_handler : fileQueued,
                file_queue_error_handler : fileQueueError,
                file_dialog_complete_handler : fileDialogComplete,
                upload_start_handler : uploadStart,
                upload_progress_handler : uploadProgress,
                upload_error_handler : uploadError,
                upload_success_handler : handlers.success ? handlers.success : uploadSuccess,
                upload_complete_handler : uploadComplete,
                button_placeholder_id : "UploaderPlaceholder_" + index,
                // Button Settingsimg/fee
                /*
                button_image_url : "/static/images/XPButtonUploadText_61x22.png",
                */
                button_width: 55,
                button_height: 26,
                button_text : '浏览',
                button_text_left_padding: 12,
                button_text_top_padding: 3,
                button_window_mode: "TRANSPARENT",
                button_cursor: SWFUpload.CURSOR.HAND,
                // Flash Settings
                flash_url : "/js/swfupload.swf",
                custom_settings : {
                    progressTarget : "UploaderProgress_" + index,
                    cancelButtonId : "UploaderCancelBtn_" + index
                },
                // Debug Settings
                debug: false
            });

            return upload;
        }
        
        </script>