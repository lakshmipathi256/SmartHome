<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!doctype html>
<html lang="">
<head>
 	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="description" content="Propeller is a front-end responsive framework based on Material design & Bootstrap.">
	<meta content="width=device-width, initial-scale=1, user-scalable=no" name="viewport">
    <title> Smart Home</title>
   
	

	<link  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"   type="text/css" rel="stylesheet" /> 
	

	<link href="http://propeller.in/components/list/css/list.css" type="text/css" rel="stylesheet" />
	
	
	<link href="http://propeller.in/components/textfield/css/textfield.css" type="text/css" rel="stylesheet" />

	<link rel="icon" href="http://propeller.in/assets/images/favicon.ico" type="image/x-icon">
	
	<!-- Bootstrap --> 
	<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />  -->
	
	<!-- Example docs (CSS for helping component example file)-->
	<link href="http://propeller.in/docs/css/example-docs.css" type="text/css" rel="stylesheet" />

	<!-- Propeller card (CSS for helping component example file) -->
	<link href="http://propeller.in/components/card/css/card.css" type="text/css" rel="stylesheet" />

	<!-- Propeller typography -->
	<link href="http://propeller.in/components/typography/css/typography.css" type="text/css" rel="stylesheet" />

	<!-- Google Icon Font -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link href="http://propeller.in/components/icons/css/google-icons.css" type="text/css" rel="stylesheet" />

	<!-- Propeller dropdown -->
	<link href="http://propeller.in/components/dropdown/css/dropdown.css" type="text/css" rel="stylesheet"/>

	<!-- Propeller navbar -->
	<link href="http://propeller.in/components/navbar/css/navbar.css" type="text/css" rel="stylesheet"/>
	
	<!-- Propeller button  -->
	<link href="http://propeller.in/components/button/css/button.css" type="text/css" rel="stylesheet"/>
	
	<!-- Propeller model  -->
	<link href="http://propeller.in/components/modal/css/modal.css" type="text/css" rel="stylesheet"/>
	
		<!-- Propeller model  -->
	<link href="http://propeller.in/components/list/css/list.css" type="text/css" rel="stylesheet"/>
	
		<!-- Propeller model  -->
	<link href="http://propeller.in/components/radio/css/radio.css" type="text/css" rel="stylesheet"/>
	
		<!-- Propeller model  -->
	<link href="http://propeller.in/components/textfield/css/textfield.css" type="text/css" rel="stylesheet"/>
	
		<!-- Propeller model  -->
	<link href="http://propeller.in/components/checkbox/css/checkbox.css" type="text/css" rel="stylesheet"/>
	
	</head>

<body>

	<!-- Nav menu with user information -->
	<nav class="navbar navbar-inverse navbar-fixed-top pmd-navbar pmd-z-depth" >
		<div class="container-fluid">
			<!-- User information -->
			<div class="dropdown pmd-dropdown pmd-user-info pull-right">
				<a href="javascript:void(0);" class="btn-user dropdown-toggle media" data-toggle="dropdown" aria-expanded="false">
					<div class="media-left">
						<img src="http://propeller.in/assets/images/avatar-icon-40x40.png" width="40" height="40" alt="avatar">
					</div>
					<div class="media-body media-middle">
						<c:out value="${userId}"></c:out>
					</div>
					<div class="media-right media-middle">
						<i class="material-icons md-light pmd-sm">more_vert</i>
					</div>
				</a>
				<ul class="dropdown-menu dropdown-menu-right" role="menu">
					<li><a href="/profile"><i class="material-icons media-left media-middle">person</i> <span class="media-body">Edit Profile</span></a></li>
					<li><a href="javascript:void(0);"><i class="material-icons media-left media-middle">settings</i> <span class="media-body">Settings</span></a></li>
					
					<li><a href="${pageContext.request.contextPath}/logout"><i class="material-icons media-left media-middle">history</i> <span class="media-body">Logout</span></a></li>
				</ul>
			</div>
		
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
			  <a href="javascript:void(0);" class="navbar-brand navbar-brand-custome">CDI Smart Home</a>
			</div>
		</div>
		
	</nav>

<!-- Jquery js -->

<script src="http://code.jquery.com/jquery.min.js"   type="text/javascript"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<!-- Bootstrap js -->
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!-- Propeller Sidebar js -->
<script type="text/javascript" language="javascript" src="http://propeller.in/components/sidebar/js/sidebar.js"></script>

<!-- Propeller Dropdown js -->
<script type="text/javascript" language="javascript" src="http://propeller.in/components/dropdown/js/dropdown.js"></script>

<!-- Propeller ripple effect js -->
<script type="text/javascript" language="javascript" src="http://propeller.in/components/button/js/ripple-effect.js"></script>

<!-- Propeller checkbox js -->
<script type="text/javascript" src="http://propeller.in/components/checkbox/js/checkbox.js"></script>

<!-- Propeller radio js -->
<script type="text/javascript" src="http://propeller.in/components/radio/js/radio.js"></script>

<!-- Propeller textfield js -->
<script type="text/javascript" src="http://propeller.in/components/textfield/js/textfield.js"></script>

<!-- Propeller modal js -->
<script type="text/javascript" src="http://propeller.in/components/modal/js/modal.js"></script>

<script type="text/javascript" src="/sockjs.js"></script>
	<script type="text/javascript" src="/stomp.js"></script>
	
	<script type="text/javascript" src="/ChartStock.js"></script>
	<!-- <script type="text/javascript" src="/ChartStock.js"></script> -->


</body>
</html>