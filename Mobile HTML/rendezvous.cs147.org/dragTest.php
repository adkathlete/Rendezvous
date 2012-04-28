<!DOCTYPE html>
<html>
<head>
	<title>Drag & Drop</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.0/themes/base/jquery-ui.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script> 
	<script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js"></script>
    <script src="jquery.ui.mouse.touch.js"></script>
	
    
</head>        
<body>
    
    <div class="demo">
    
        <ul id="sortable1" class="connectedSortable">
        	<li class="ui-state-default">Item 1</li>
        	<li class="ui-state-default">Item 2</li>
        	<li class="ui-state-default">Item 3</li>
        	<li class="ui-state-default">Item 4</li>
        	<li class="ui-state-default">Item 5</li>
        </ul>
    
    </div><!-- End demo -->


	<script>
		$( "#sortable1" ).sortable();
	</script>

</body>
</html>