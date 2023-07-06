(uart-start 115200)
(defun proc-data (data)
    (if (= (bufget-i8 data 0) 102) (uart-write data))  ;write to uart when the data has the magic number
)

(defun event-handler ()
    (loopwhile t
        (recv
            ((event-data-rx . (? data)) (proc-data data)) ;handle the data when received
            (_ nil) ; Ignore other events
)))

;Create a thread
(event-register-handler (spawn event-handler))

;Enable the 0x24 custom data command
(event-enable 'event-data-rx)
