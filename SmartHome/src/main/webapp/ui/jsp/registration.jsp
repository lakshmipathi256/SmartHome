<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<title>Login | CDI Smart Home - Admin Dashboard</title>
<!-- <link rel="shortcut icon" type="image/x-icon" href="images/home.png"> -->

<!-- Google icon -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<!-- Bootstrap css -->
<!-- build:[href] assets/css/ -->
<link rel="stylesheet" type="text/css" href="/bootstrap.min.css">
<!-- /build -->

<!-- Propeller css -->
<!-- build:[href] assets/css/ -->
<link rel="stylesheet" type="text/css" href="/propeller.min.css">
<!-- /build -->

<!-- Propeller theme css-->
<link rel="stylesheet" type="text/css" href="/propeller-theme.css" />

<!-- Propeller admin theme css-->
<link rel="stylesheet" type="text/css" href="/propeller-admin.css">

<!-- datepicker css -->
<link rel="stylesheet" type="text/css"
	href="http://propeller.in/components/datetimepicker/css/bootstrap-datetimepicker.css">
<link rel="stylesheet" type="text/css"
	href="http://propeller.in/components/datetimepicker/css/pmd-datetimepicker.css">

<!-- Scripts Starts -->
<!-- build:[src] assets/js/ -->
<script src="/jquery-1.12.2.min.js"></script>
<script src="/bootstrap.min.js"></script>
<script src="/propeller.min.js"></script>
<!-- Propeller textfield js -->
<script type="text/javascript"
	src="http://propeller.in/components/textfield/js/textfield.js"></script>
<!-- Datepicker moment with locales -->
<script type="text/javascript" language="javascript"
	src="http://propeller.in/components/datetimepicker/js/moment-with-locales.js"></script>
<style>
/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: relative; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 10px; /* Location of the box */
	left: 0;
	top: 5;
	width: 100%; /* Full width */
	height: 50%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	position: relative;
	background-color: #fefefe;
	margin: auto;
	padding: 0;
	border: 1px solid #888;
	width: 80%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	-webkit-animation-name: animatetop;
	-webkit-animation-duration: 0.4s;
	animation-name: animatetop;
	animation-duration: 0.4s
}

/* Add Animation */
@
-webkit-keyframes animatetop {
	from {top: -300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}
@
keyframes animatetop {
	from {top: -300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}

/*  The Close Button 
.close {
    color: red;
    float: left;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}
 */
.modal-header {
	padding: 2px 16px;
	background-color: #5cb85c;
	color: white;
}

.modal-body {
	padding: 2px 16px;
}
</style>


</head>
<!-- <script type="text/javascript">
	function isPasswordMatch() {

		var pass1 = document.getElementById("password").value;
		var pass2 = document.getElementById("Cpassword").value;
		if (pass1 = "" && pass1 != pass2) {
			alert("Passwords is not Match!!!");
		}
	}
</script> -->

<body class="body-custom">

	<div class="logincard">
		<div class="pmd-card card-default pmd-z-depth">
			<div class="login-card">
				<form:form method="post" action="/registration"
					modelAttribute="userForm">

					<div class="pmd-card-body">

						<div class="pmd-card-title card-header-border text-center">
							<div class="loginlogo">
								<a href="javascript:void(0);"><img
									src="https://lh3.googleusercontent.com/CrsG2PZ00eFmkBt4YSvcCHCHDhmdWyvhEB7a-PwUNHWmLtYIl8ECQjYOLA6Wpe-aLT8Nua0DzlXVsJDqD6Pa3EPKQVidz7UXB8SBi
									tMeC5idfJy1P56YRSmEaLiHiVVN4P2U5G4=w677-h278-no"
									alt="Basu" ></a>
							</div>
							<h3>
								Register <span>with <strong>CDI Smart Home</strong></span>
							</h3>
							<h4>fields marked with an asterisk (*) are required</h4>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Full Name *</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">perm_identity</i>
								</div>
								<form:input type="text" class="form-control" id="name"
									path="name" onChange="nameCheck();" required="required" />
								<span id="confirmMessage2" class="confirmMessage2"></span>
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">phone No *</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">phone</i>
								</div>
								<form:input type="text" class="form-control" id="phone"
									required="required" path="phone" onChange="phoneCheck();" />
								<span id="confirmMessage3" class="confirmMessage3"></span>
							</div>
						</div>


						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Email *</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">email</i>
								</div>
								<form:input type="email" class="form-control" id="email"
									path="email" onChange="emailCheck();" required="required" />
								<span id="confirmMessage4" class="confirmMessage4"></span>
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">DOB </label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">event</i>
								</div>
								<form:input type="text" id="datetimepicker-default" path="dob"
									class="form-control" />
							</div>
						</div>
						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Address </label>
							<div class="form:input-group">
								<div class="form:input-group-addon">

									<i class="material-icons md-dark pmd-sm">home</i>
								</div>
								<form:textarea type="text" class="form-control" id="addr"
									path="address" onChange="addCheck();" />
								<span id="confirmMessage6" class="confirmMessage6"></span>
							</div>

						</div>


				<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label>Select the role</label> <form:select path="userType"
								class="select-simple form-control pmd-select2">
								<option></option>
								
								<c:forEach var="role" items="${roleList}">

									<option value="${role.id}"><c:out
											value="${role.userType}" /></option>
								
								</c:forEach>
							</form:select>
						</div>



						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Create
								Password *</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">lock_outline</i>
								</div>
								<form:input type="password" class="form-control" id="password"
									path="password" onChange="checkPs(); return false;"
									required="required" />
								<span id="confirmMessage1" class="confirmMessage1"></span>
							</div>
						</div>
						<!-- <button id="myBtn">Criteria</button> -->
						<a onmouseover="enableCriteria();" onmouseout="disableCriteria();">password
							criteria</a>
						<!-- The Modal -->
						<div id="myModal" class="modal">

							<!-- Modal content -->
							<div class="modal-content">
								<div class="modal-header">

									<h2>Password Criteria</h2>
								</div>
								<div class="modal-body">
									<p>It must contain minimum 6 letters</p>
									<p>password must contain 1 number, one lowercase and one
										uppercase letter</p>
								</div>

							</div>

						</div>
						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Confirm
								Password *</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">lock_outline</i>
								</div>
								<input type="password" class="form-control" id="Cpassword"
									onkeyup="checkPass(); return false;" />
								<p id="validate-status"></p>
								<span id="confirmMessage" class="confirmMessage"></span>
							</div>
						</div>



						<button class="btn btn-lg btn-primary btn-block" type="submit"  id="register" value="Register" disabled = "disabled">Submit</button>

						<p class="redirection-link">
							Already have an account? <a href="/login" class="register-login">Sign
								In</a>
						</p>
					</div>
				</form:form>

			</div>
		</div>
	</div>
	<script type="text/javascript" language="javascript"
		src="http://propeller.in/components/datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script>
		// Default date and time picker
		$('#datetimepicker-default').datetimepicker();
	</script>
	<script type="text/javascript">
	function nameCheck()
	{
		var name = document.getElementById('name');
		var message = document.getElementById('confirmMessage2');
		 var goodColor = "#66cc66";
		    var badColor = "#ff6666";
		    var letters ="^[A-Za-z\\s]+$";
		    
		    
		if(name.value.length < 5 || name.value.length > 20 )
			{
			name.value = "";
			//name.style.backgroundColor = badColor;
	        message.style.color = badColor;
	        message.innerHTML = "Enter valid name!"
	        	
	       
			}
		
		else if(name.value.match(letters))
			{
			//name.style.backgroundColor = goodColor;
	        message.style.color = goodColor;
	        message.innerHTML = "Nice name"
	        
			}
		else{
			name.value = "";
			//name.style.backgroundColor = badColor;
	        message.style.color = badColor;
	        message.innerHTML = "Name must have alphabet characters only!"     
		}	
		
		
		
		
	}
	</script>


	<script type="text/javascript">
	function phoneCheck()
	{
		var phone = document.getElementById('phone');
		var message = document.getElementById('confirmMessage3');
		 var goodColor = "#66cc66";
		    var badColor = "#ff6666";
		    var phoneno = /^\d{10}$/;  
		   
		 if(phone.value.match(phoneno))
			{
			//phone.style.backgroundColor = goodColor;
	        message.style.color = goodColor;
	        message.innerHTML = "Verified"
			}
		else{
			//phone.style.backgroundColor = badColor;
			phone.value="";
	        message.style.color = badColor;
	        message.innerHTML = "invalid number!"
			
		}
		 
		 
	}
	</script>
	<script type="text/javascript">
	function emailCheck()
	{
		var email = document.getElementById('email');
		var message = document.getElementById('confirmMessage4');
		 var goodColor = "#66cc66";
		    var badColor = "#ff6666";
		    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
		   
		 if(email.value.match(mailformat))
			{
			//phone.style.backgroundColor = goodColor;
	        message.style.color = goodColor;
	        message.innerHTML = "Verified "
			}
		else{
			//email.style.backgroundColor = badColor;
			email.value = "";
	        message.style.color = badColor;
	        message.innerHTML = "You have entered an invalid email address !"
			
		}	
		
	}
	</script>
	<script type="text/javascript">
	function addCheck()
	{
		var add = document.getElementById('addr');
		var message = document.getElementById('confirmMessage6');
		 var goodColor = "#66cc66";
		    var badColor = "#ff6666";
		   
		    
		if(add.value.length < 10 || add.value.length > 50 )
			{
			//add.style.backgroundColor = badColor;
			add.value = "";
	        message.style.color = badColor;
	        message.innerHTML = "Enter valid Address!"
			}
		
		else 
			{
			//add.style.backgroundColor = goodColor;
	        message.style.color = goodColor;
	        message.innerHTML = "valid"
			}
		
	}
	</script>

	<script type="text/javascript">
	 function checkPs()
	 {
		 var pass1 = document.getElementById('password');
		 
		 var message = document.getElementById('confirmMessage1');
		 
		    var goodColor = "#66cc66";
		    var badColor = "#ff6666";
		    
		    var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/;  
		  
			     if(pass1.value.match(re))
		    	{
		    	//pass1.style.backgroundColor = goodColor;
		        message.style.color = goodColor;
		        message.innerHTML = "valid Password!"
		    	}
		    else
		    	{
		    	// pass1.style.backgroundColor = badColor;
		    	pass1.value = "";
		         message.style.color = badColor;
		         message.innerHTML = "please check password criteria "
		    	
		    	}
			 
	 }
	
	
	</script>

	<script type="text/javascript">
	
	function checkPass()
   {
    //Store the password field objects into variables ...
    var pass1 = document.getElementById('password');
    var pass2 = document.getElementById('Cpassword');
    var message = document.getElementById('confirmMessage');
 
    var goodColor = "#66cc66";
    var badColor = "#ff6666";

       if(pass1.value == pass2.value)
       {       
        //pass2.style.backgroundColor = goodColor;
         $('#register').removeAttr('disabled');
        message.style.color = goodColor;
        message.innerHTML = "Passwords Match!"
       }
       else
       {
        //pass2.style.backgroundColor = badColor;
       $('#register').attr('disabled', 'disabled');
        message.style.color = badColor;
        message.innerHTML = "Passwords Do Not Match!"
       }
       
      
       

}
	</script>


	<script type="text/javascript">
// Get the modal
var modal = document.getElementById('myModal');

// Get the button that opens the modal
var btn = document.getElementById("myBtn");

function enableCriteria(){
	 modal.style.display = "block";
}
function disableCriteria(){
	 modal.style.display = "none";
}
</script>

</body>
</html>