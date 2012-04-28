<!DOCTYPE html>
<html>
<head>
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.0/themes/base/jquery-ui.css" type="text/css" rel="stylesheet"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.9/jquery-ui.min.js"></script>
    <script src="jquery.ui.mouse.touch.js"></script>
    <style type="text/css">
        div {
            float: left;
            width: 100px;
            height: 100px;
            margin-left: 100px;
        }
        #a {
            background: red;
        }
        #b {
            background: green;
        }
    
	    #sortable1, #sortable2 { list-style-type: none; margin: 0; padding: 0; float: left; margin-right: 10px; }
	    #sortable1 li, #sortable2 li { margin: 0 5px 5px 5px; padding: 5px; font-size: 1.2em; width: 120px; }
    </style>    
    
</head>        
<body>
    <div id="a"></div>
    <div id="b"></div>
    
        
    <script>
        $('div').draggable();
    </script>
    
    <div class="demo">
    
        <ul id="sortable1" class="connectedSortable">
        	<li class="ui-state-default">Item 1</li>
        	<li class="ui-state-default">Item 2</li>
        	<li class="ui-state-default">Item 3</li>
        	<li class="ui-state-default">Item 4</li>
        	<li class="ui-state-default">Item 5</li>
        </ul>
        <ul id="sortable2" class="connectedSortable">
        	<li class="ui-state-highlight">Item 1</li>
        	<li class="ui-state-highlight">Item 2</li>
        	<li class="ui-state-highlight">Item 3</li>
        	<li class="ui-state-highlight">Item 4</li>
        	<li class="ui-state-highlight">Item 5</li>
        </ul>
    
    </div><!-- End demo -->


	<script>
		$( "#sortable1, #sortable2" ).sortable({
			connectWith: ".connectedSortable"
		}).disableSelection();
	</script>

</body>
</html>