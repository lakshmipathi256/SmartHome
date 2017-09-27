
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Registration Page</title>
<script src="http://s.codepen.io/assets/libs/modernizr.js"
	type="text/javascript"></script>
<link rel='stylesheet prefetch'
	href='http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'>
<link rel='stylesheet prefetch'
	href='http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css'>
<link rel='stylesheet prefetch'
	href='http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css'>

	
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- Bootstrap css -->

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

<!-- my code goes here -->

<!--formden.js communicates with FormDen server to validate fields and submit via AJAX -->
<script type="text/javascript"
	src="https://formden.com/static/cdn/formden.js"></script>

<!-- Special version of Bootstrap that is isolated to content wrapped in .bootstrap-iso -->
<link rel="stylesheet"
	href="https://formden.com/static/cdn/bootstrap-iso.css" />

<!--Font Awesome (added because you use icons in your prepend/append)-->
<link rel="stylesheet"
	href="https://formden.com/static/cdn/font-awesome/4.4.0/css/font-awesome.min.css" />

<!-- Inline CSS based on choices in "Settings" tab -->
<style>
.bootstrap-iso .formden_header h2, .bootstrap-iso .formden_header p,
	.bootstrap-iso form {
	font-family: Arial, Helvetica, sans-serif;
	color: black
}

.bootstrap-iso form button, .bootstrap-iso form button:hover {
	color: white !important;
}

.asteriskField {
	color: red;
}
</style>

<!-- HTML Form (wrapped in a .bootstrap-iso div) -->
<style>
.upload-button {
    padding: 4px;
    border: 1px solid black;
    border-radius: 5px;
    display: block;
    float: left;
}

.profile-pic {
    max-width: 200px;
    max-height: 200px;
    display: block;
}

.file-upload {
    display: none;
}

</style>

<!-- Extra JavaScript/CSS added manually in "Settings" tab -->
<!-- Include jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Include Date Range Picker -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />




<style type="text/css">
fieldset.scheduler-border {
	
	 background-color: white;
    width: 1000px;
    height: 650px;
    margin: 100px;
   padding-top: 10px;
    padding-right: 0px !important; 
    padding-bottom: 50px;
    padding-left: 80px;
}


</style>

</head>
<%@include file="header.jsp"%>
<body>
	<div class="container">
	<br><br>

		
		<form:form ENCTYPE="multipart/form-data"  method="post" action="/success"
					modelAttribute="userForm" >
		
			<fieldset class="scheduler-border">
			
			
			<div class="pmd-card-title card-header-border text-center">
							<div class="loginlogo">
								<a href="javascript:void(0);"><img
									src="https://lh3.googleusercontent.com/CrsG2PZ00eFmkBt4YSvcCHCHDhmdWyvhEB7a-PwUNHWmLtYIl8ECQjYOLA6Wpe-aLT8Nua0DzlXVsJDqD6Pa3EPKQVidz7UXB8SBi
									tMeC5idfJy1P56YRSmEaLiHiVVN4P2U5G4=w677-h278-no"
									alt="Basu"   width="250"
						height="100"></a>
							</div>
					</div>	
					
					
					
					
					
			<div class="generic-container" align = "center">		
						
			<div class="row" id="card-masonry">
			
			
			<div class="col-md-4 col-sm-6">
			<div class="input-group-addon">
								
									
			<section class="row component-section">

				<div class="generic-container" style="height: 95%; width: 95%">
					<div class="pmd-card-body" >
						<!--    <div class="upload-button" onClick = "changeProfile() "  align = "center">Upload Image</div> -->
						<div class="imgcontainer" align = "center">
							
						
					 <img class="profile-pic" src="https://maxcdn.icons8.com/Share/icon/Users//user_male_circle_filled1600.png" /> 
						 <sec:authorize access="hasRole('USER')">
						  <input class="profile-pic" id="inputFileToLoad" type="file" onchange="loadImageFileAsURL();"  required="required" />
                            
							<div id="imgTest"  ></div>
						   </sec:authorize> 
                     <!--   <input class="file-upload" type="file"  onClick = "changeProfile() " value = "Upload" accept="image/*"/>  -->
							
 						

						</div>
					</div>
				</div>
				</section>			
									 
			</div>															
				</div>	
				<div class="col-md-4 col-sm-6">
							<h3>
								Edit your profile
							</h3>
						<br><br>	
				 <div class="form-group pmd-textfield pmd-textfield-floating-label">
							
								
								
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">perm_identity</i>
								</div>
								<form:input type="text" class="form-control" id="name"
									path="name" onChange="nameCheck();" required="required" value="${listprofile.name}" />
						          
									
								<span id="confirmMessage2" class="confirmMessage2"></span>
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">phone</i>
								</div>
								<form:input type="text" class="form-control" id="phone" value="${listprofile.phone}"
									required="required" path="phone" onChange="phoneCheck();" />
								<span id="confirmMessage3" class="confirmMessage3"></span>
							</div>
						</div>


						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">email</i>
								</div>
								<form:input type="email" class="form-control" id="email" value="${listprofile.email}"
									path="email" onChange="emailCheck();" required="required" />
								<span id="confirmMessage4" class="confirmMessage4"></span>
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">event</i>
								</div>
								<form:input type="text" id="datetimepicker" path="dob" value="${listprofile.dob}"
									class="form-control" />
							</div>
						</div>
						<div class="form-group pmd-textfield pmd-textfield-floating-label">
						
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">home</i>
								</div>
								<form:input type="text" id="datetimepicker-default" path="address" value="${listprofile.address}"
									class="form-control" />
							</div>
						</div>
        
				
			
			<!-- Button -->
			<br>
			<br>
	
			</div>
						
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label"></label>
				<div class="col-md-2">
					<button class="btn btn-lg btn-primary btn-block" type="submit"  id="register" value="Register" >Update</button>
					</button>
				</div>
			</div>
					
			</div>
			
		</fieldset>
		</form:form>
	</div>

<script type="text/javascript" language="javascript"
		src="http://propeller.in/components/datetimepicker/js/bootstrap-datetimepicker.js"></script>
	<script>
		// Default date and time picker
		$('#datetimepicker').datetimepicker();
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

<!--  <script type="text/javascript">
 
 function changeProfile()
 {
	 
	 var readURL = function(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();

	            reader.onload = function (e) {
	                $('.profile-pic').attr('src', e.target.result);
	            }
	    
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	    
	 $(".file-upload").on('change', function(){
	        readURL(this);
	    });
	    
	    $(".upload-button").on('click', function() {
	       $(".file-upload").click();
	       
	       
	       
	       
	       
	       
	    });
 }
 
 
 
 </script> -->
 
 
 <script type='text/javascript'>

function loadImageFileAsURL(){

    var filesSelected = document.getElementById("inputFileToLoad").files;
    if (filesSelected.length > 0){
        var fileToLoad = filesSelected[0];

        var fileReader = new FileReader();

        fileReader.onload = function(fileLoadedEvent) {
            var srcData = fileLoadedEvent.target.result; // <--- data: base64

            var divTest = document.getElementById("imgTest");
            var newImage = document.createElement('img');
            newImage.src = srcData;

            divTest.innerHTML = newImage.outerHTML;

        }

        fileReader.readAsDataURL(fileToLoad);
    }
}

</script>
</body>
</html>







