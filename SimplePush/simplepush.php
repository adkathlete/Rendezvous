<?php



// Put your device token here (without spaces):
$deviceTokenDeniz = '5a06ed6c9bf0f27f8de413e18a6f750ebef0128ff086915479e215b04ff8d022';
$deviceTokenAaron = '856a58b4a6f2e070548a29fc65ca653d81a1e366ff605049adada369f8347352';
$deviceTokenBabchick = '949901c8b5738a692e3e2e06fef04a379d0ac0b79b071289ea578e3dc8f853500';
$deviceToken = $deviceTokenAaron;
// Put your private key's passphrase here:
$passphrase = 'rendezvous1989';

// Put your alert message here:
$message = 'trololol';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'default'
	);

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg1 = chr(0) . pack('n', 32) . pack('H*', $deviceTokenDeniz) . pack('n', strlen($payload)) . $payload;
$msg2 = chr(0) . pack('n', 32) . pack('H*', $deviceTokenAaron) . pack('n', strlen($payload)) . $payload;
$msg3 = chr(0) . pack('n', 32) . pack('H*', $deviceTokenBabchick) . pack('n', strlen($payload)) . $payload;


// Send it to the server
$result = fwrite($fp, $msg1, strlen($msg1));
$result = fwrite($fp, $msg2, strlen($msg2));
$result = fwrite($fp, $msg3, strlen($msg3));

if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);

?>
