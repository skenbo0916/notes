<?php
class message_handle {
    function __construct( $language ) {
	$this->language = $language ? : 'zh_TW';
	$file_name = "message_pool_{$this->language}.php";
	if( file_exists($file_name) ) {
	    include_once("message_pool_{$this->language}.php");
	} else {
	    include_once("message_pool_zh_TW.php");
	}
	$this->error_pool = $error_pool;
    }

    private function process_message_to_return( $message ) {
	$message['title']   = rawurlencode( $message['title'] );
	$message['message'] = rawurlencode( $message['message'] );

	if( !preg_match('/ to match test enviroment DNS /', $_SERVER['SERVER_NAME']) ) {
	    unset( $message['internal_msg'] );
	}

	die( json_encode($message) );
    }

    private function message_repalcer( $message_to_process, $extend_arguements ) {
	foreach( $extend_arguements as $replace_key => $replace_pattern ) {
	    foreach( $message_to_process as $message_key => $message_to_replace ) {
		preg_match( "/\^_<$replace_key\^_</", $message_to_replace, $preg_cache );
		foreach( $preg_cache as $cached_replace_string ) {
		    $cached_replace_string = str_replace( "^_<", '', $cached_replace_string ); //delete ^_<^_< symbol
		    $message_to_process[$message_key] =
			str_replace( "^_<$cached_replace_string^_<", $replace_pattern, $message_to_replace );
		}
	    }
	}
	return $message_to_process;
    }

    function error_handle( $error_key = 'default_error_key', $extend_arguements = array() ) {
	if( ($message_to_process = $this->error_pool[$error_key]) && $extend_arguements ) {
	    $message_to_process = $this->message_repalcer( $message_to_process, $extend_arguements );
	}elseif( $message_to_process = $this->error_pool[$error_key] ) {
	    $this->process_message_to_return( $message_to_process );
	}else{
	    $message_to_process = $this->error_pool['default_error_key'];
	    $message_to_process['internal_msg'] .= ", original_key = $error_key.";
		// error_key maybe wrong... put it into internal_msg
	}
	$this->process_message_to_return( $message_to_process );
    }
}
?>
