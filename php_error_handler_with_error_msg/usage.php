<?php
include_once("message_handle.php");
$message_handle = new message_handle( 'en_US' );
echo $message_handle->error_handle(
    'error_key',
    array( 'reason' => 'server explosion' )
);

?>
