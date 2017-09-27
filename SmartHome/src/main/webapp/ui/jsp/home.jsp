<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description"
	content="Propeller is a front-end responsive framework based on Material design & Bootstrap.">
<meta content="width=device-width, initial-scale=1, user-scalable=no"
	name="viewport">
<title>Smart Home</title>
</head>

<%@include file="header.jsp"%>
<body onload="connect()">

	<noscript>
		<h2 style="color: #ff0000">Seems your browser doesn't support
			Javascript! WebSocket relies on Javascript being enabled. Please
			enable Javascript and reload this page!</h2>
	</noscript>


	<sec:authorize access="hasRole('USER')">
		<div class="row" id="card-masonry">
			<br> <br> <br> <br> <br>
			<div class="col-md-4 col-sm-6">
				<div class="pmd-card pmd-card-default pmd-z-depth">
					<div class="pmd-card-title">
						<div class="media-body media-middle">
							<div class="pmd-card-body" align="middle">
								<h3 class="pmd-card-title-text" align="middle">
									<font size="5" color="green"><b> Light Controller </b> </font>
								</h3>
							</div>
						</div>
					</div>

					<div class="pmd-card-media" align="middle">

						<img src="http://www.w3schools.com/js/pic_bulboff.gif" width="250"
							height="100" class="img-responsive" id="light">

					</div>

					<section class="row component-section">

					<div class="generic-container" style="height: 95%; width: 95%">
						<div class="pmd-card-body" align="center">
							<!-- <div class="media-left">
						      <a class="avatar-list-img" href="javascript:void(0);">
			
						</a>
					  </div> -->
							<button type="button" value="ON" id="LEDON"
								class="btn pmd-btn-outline pmd-ripple-effect btn-primary">ON</button>


							<button type="button" value="OFF" id="LEDOFF"
								class="btn pmd-btn-outline pmd-ripple-effect btn-danger">OFF</button>

						</div>
					</div>
					</section>
				</div>
			</div>


			<div class="col-md-4 col-sm-6">
				<div class="pmd-card pmd-card-default pmd-z-depth">
					<div class="pmd-card-title">

						<div class="media-body media-middle">
							<div class="pmd-card-body" align="middle">
								<h3 class="pmd-card-title-text"">
									<font size="5" color="green"><b> Temperature Monitor
									</b> </font>
								</h3>
							</div>
						</div>
					</div>
					<div class="pmd-card-media">
						<label id="container" style="height: 450px; width: 100%;"></label>
					</div>


					<section class="row component-section"> <!-- Raised button title and description -->

					<div class="col-md-5">
						<div id="raised-button">

							<div class="generic-container" style="height: 1200%; width: 250%">
								<div class="pmd-card-body" align="middle">
									<!--Default raised button with ripple effect-->


									<!--Primary raised button with ripple effect -->
									<button type="button"
										class="btn pmd-btn-outline pmd-ripple-effect btn-primary"
										id="TempSub" value="TempSub">Current Temperature</button>

								</div>
							</div>
						</div>
					</div>



					</section>
				</div>
			</div>


			<div class="col-md-4 col-sm-6">
				<div class="pmd-card pmd-card-default pmd-z-depth">
					<div class="pmd-card-title">

						<div class="media-body media-middle">
							<div class="pmd-card-body" align="middle">
								<h3 class="pmd-card-title-text" align="middle">
									<font size="5" color="green"><b> RFID Monitor </b> </font>
								</h3>
							</div>
						</div>
					</div>
					<div>
						<div class="generic-container" style="height: 210%; width: 100%">
							<div class="pmd-card-body" align="middle">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>Sl.no</th>
											<th>RFID Data</th>
											<th>Date</th>

										</tr>

									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td><label id="rfid"></label></td>
											<td>2016-05-02 10:06</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="generic-container" style="height: 210%; width: 100%">
							<div class="pmd-card-body" align="middle">
								<br>
								<h3 class="pmd-card-title-text" align="middle">
									<font size="5" color="green"><b> Previous Rfid Data
									</b> </font>
								</h3>
								<br> <br>
								<table class="table table-striped">
									<thead>
										<tr>
											<th>Sl.no</th>
											<th>RFID Data</th>
										</tr>

									</thead>
									<tbody>
										<c:forEach var="messag" items="${listRfid}" varStatus="status">
											<tr>
												<td>${status.index + 1}</td>
												<td>${messag}</td>

											</tr>
										</c:forEach>
									</tbody>
								</table>
								<br>
							</div>
						</div>


						<section class="row component-section"> <!-- Raised button title and description -->
						<div class="col-md-4 col-sm-6">
							<div class="generic-container" style="height: 1220%; width: 325%">
								<div class="pmd-card-body" align="middle">

									<div id="raised-button">
										<button type="button"
											class="btn pmd-btn-outline pmd-ripple-effect btn-primary"
											id="RFIDSub" value="RFIDSub">Current RFID Details</button>


									</div>
								</div>
							</div>
						</div>


						</section>

					</div>
				</div>


			</div>
		</div>
	</sec:authorize>
	<sec:authorize access="hasRole('ADMIN')">
		<div class="generic-container">

			<div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">
					<span class="lead">List of Users </span>
				</div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th>ID</th>
							<th>name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>DOB</th>

							<th width="100"></th>


							<th width="100"></th>


						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userlist}" var="user">
							<tr>
								<td>${user.id}</td>
								<td>${user.name}</td>
								<td>${user.email}</td>
								<td>${user.phone}</td>
								<td>${user.dob}</td>
								<sec:authorize access="hasRole('ADMIN')">
									<td>
										<a href="<c:url value='/edit-user-${user.id}' />"
									class="btn btn-success custom-width">edit</a>
										<!-- <button data-target="#form-dialog" data-toggle="modal"
											class="btn pmd-ripple-effect btn-primary pmd-z-depth"
											type="button">Form Modal</button> -->
									</td>
								</sec:authorize>
								<sec:authorize access="hasRole('ADMIN')">
									<td><a href="<c:url value='/delete-user-${user.id}' />"
										class="btn btn-danger custom-width">delete</a></td>
								</sec:authorize>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</sec:authorize>
</body>

<c:url value="/simplemessages" var="socketDest" />
<script type="text/javascript">
		/***********************************************/
		/* PLEASE READ UP ON STOMP AND SOCKJS          */
		/* 1) http://jmesnil.net/stomp-websocket/doc/  */
		/* 2) https://github.com/sockjs/sockjs-client  */
		/***********************************************/

		//Declare a stompclient which will connect to the server
		var stompClient = null;
		$(document).ready(function() {
			//Also all text in server message should be empty
			$("#txtSendMessage").val("");
			//Remove any server responses from previous interactions
			$("#response").empty();
			//Hide the validation and info alerts on page load
			$(".alert").hide();
	//=============================================TEMPERATURE BUTTON====================
			// Event handler: Send to Temp button
			$("#TempSub").on("click", function(e) {

				// Find the input text element for the server message
				var messageTotemp = $("#TempSub").val();

				if (messageTotemp === "") {

					// If message is empty prevent submission and show the alert
					e.preventDefault();
					

				} else {

					stompClient.send("/app/tempsub", {}, JSON.stringify({
						'message' : messageTotemp
					}));
				}
			});
			// Event handler: Send to RFID button
			
			$("#RFIDSub").on("click", function(e) {

				// Find the input text element for the server message
				var messageToRFID = $("#RFIDSub").val();

				if (messageToRFID === "") {

					// If message is empty prevent submission and show the alert
					e.preventDefault();
					

				} else {

					stompClient.send("/app/rfidsub", {}, JSON.stringify({
						'message' : messageToRFID
					}));
				}
			});

		});
		
		
	//=============================================LED BUTTON====================
		$("#LEDON").on("click", function(e) {

				// Find the input text element for the server message
				var messageToLED = $("#LEDON").val();

				if (messageToLED === "") {

					// If message is empty prevent submission and show the alert
					e.preventDefault();

				} else {
          	// Send message to server. The message for the server must 
					// be in JSON format. 
					// Also refer SimpleMessage.java POJO.
					stompClient.send("/app/LedON", {}, JSON.stringify({
						'message' : messageToLED
					}));
				
				}
			});
	
		$("#LEDOFF").on("click", function(e) {

			// Find the input text element for the server message
			var messageToLED = $("#LEDOFF").val();

			if (messageToLED === "") {

				// If message is empty prevent submission and show the alert
				e.preventDefault();

			} else {
      	// Send message to server. The message for the server must 
				// be in JSON format. 
				// Also refer SimpleMessage.java POJO.
				stompClient.send("/app/LedOFF", {}, JSON.stringify({
					'message' : messageToLED
				}));
			
			}
		});
		//=======================================LED BUTTON ENDS==================================

		// Function to connect the web client to the websocket server
		function connect() {
			//Remove any server responses from previous interactions
			$("#response").empty();
			//Also all text in server message input field should be empty
			$("#txtSendMessage").val("");
			$("#txtSendMessage").focus();
			$("#txtSendMessage").select();
			// Register a websocket endpoint using SockJS and stomp.js
			// Refer to Java class Refer to Java class 
			// WebSocketConfig.java#registerStompEndpoints(StompEndpointRegistry registry)
			var socket = new SockJS('${socketDest}');
			stompClient = Stomp.over(socket);
			// Now that a stomp client is defined, its time to open a connection
			// 1) First we connect to the websocket server
			// Notice that we dont pass in username and password as Spring Security
			// has already provided the server with the Principal object containing user credentials
			// 2) The last argument is a callback function which is called when connection succeeds
			stompClient
					.connect(
							'',
							'',
							function(frame) {
								//set the connect and disconnect button state. (disable connect button)

								// In production code remove the next line
								console.log("Connected: " + frame);
								
								// Now subscribe to a topic of interest.
								// Refer to Java class WebsocketBroadcastController.java#processMessageFromClient(SimpleMessage message)
								// WebsocketBroadcastController is waiting for connections. Upon successful connection, it subscribes to
								// the "/topic/simplemessagesresponse" destination where the server will echo the messages.
								// When a broadcast message is received by the client on that destination, it will be shown by appending
								// a paragraph to the DOM in the client browser.
								stompClient
										.subscribe(
												"/topic/simplemessagesresponse",
												function(servermessage) {//Callback when server responds
												
													console
															.log(JSON
																	.parse(servermessage.body));
													
												});

								//new function for led 
								stompClient
										.subscribe(
												"/user/${userId}/tempsub",
												function(servermessage) {//Callback when server responds
													console.log("/user/${userId}/tempsub");
													/* document
															.getElementById("iot").innerHTML = servermessage.body */
													/* console
															.log(JSON
																	.parse(servermessage.body)+"from "${userId}); */
												
													window.serverData=servermessage.body;
												
													
												});
								stompClient
								.subscribe(
										"/user/${userId}/rfidsub",
										function(servermessage) {//Callback when server responds
										console.log("/user/${userId}/rfidsub");
											document
													.getElementById("rfid").innerHTML = (servermessage.body);
											console
													.log(servermessage.body);
										});
								
								stompClient
								.subscribe(
										"/user/${userId}/ledON",
										function(servermessage) {//Callback when server responds
                                              var img=document.getElementById("light");
										if(servermessage.body=="LED ON")
										{
									          img.src = "http://www.w3schools.com/js/pic_bulbon.gif";
											/*  $('.light').toggleClass('night'); */
										}	else{
											img.src = "http://www.w3schools.com/js/pic_bulboff.gif";	
											
										}
											console
													.log(servermessage.body); 
										});
								stompClient
								.subscribe(
										"/user/${userId}/ledOFF",
										function(servermessage) {//Callback when server responds
                                              var img=document.getElementById("light");
										if(servermessage.body=="LED OFF")
										{
									       img.src = "http://www.w3schools.com/js/pic_bulboff.gif";
										
										}	else  {
											img.src = "http://www.w3schools.com/js/pic_bulbon.gif";	
										}
											console
													.log(servermessage.body); 
										});
							});
		}

		// Function to send the message typed in by the user to the "/app/simplemessages" destination on the server.
		// WebsocketBroadcastController will receive this message and broadcast the results after 
		// an artificially introduced delay.
		function sendMessageToServer(messageForServer) {
			// The message for the server must be in JSON format. Also refer SimpleMessage.java POJO.
			stompClient.send("/app/simplemessages", {}, JSON.stringify({
				'message' : messageForServer
			}));
		}

		/**
		 * Utility function to return the date time in simple format
		 * like Tue Jan 07 2014 @ 11:47:24 AM
		 */
		function getCurrentDateTime() {
			var date = new Date();
			var n = date.toDateString();
			var time = date.toLocaleTimeString();
			return n + " @ " + time;
		}
	</script>
<script type="text/javascript">
$( document ).ready(function(){

	 data1 = new Array();
     var dat = new Array();
     var updateCount = 0 ;
     <c:forEach items="${listmessages}" var="msg">  
     countryDetails = new Object();
     countryDetails.msg = ${msg}; 
 	console.log( countryDetails.msg );
     data1.push(countryDetails);
 </c:forEach>
 
$(document).ready(function () {
 Highcharts.setOptions({
     global: {
         useUTC: false
     }
 });
 


//Create the chart
Highcharts.chart('container', {
 chart: {
     type: 'spline',
     animation: Highcharts.svg, // don't animate in old IE
     marginRight: 10,
     events: {
         load: function () {

             // set up the updating of the chart each second
             var series = this.series[0];

            setInterval(function () {
                 var x = (new Date()).getTime(), // current time
                
                 y=parseFloat(serverData)
                 series.addPoint([x, y], true, true);
             }, 5000); 
           
         }

     }
 },
 title: {
     text: ''
 },
 xAxis: {
     type: 'datetime',
     tickPixelInterval: 150
 },
 yAxis: {
     title: {
         text: 'Temparature'
     },
     plotLines: [{
         value: 0,
         width: 1,
         color: '#808080'
     }]
 },
 tooltip: {
     formatter: function () {
         return '<b>' + this.series.name + '</b><br/>' +
             Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
             Highcharts.numberFormat(this.y, 2);
     }
 },
 legend: {
     enabled: false
 },
 exporting: {
     enabled: false
 },
 series: [{
     name: 'Temparature data',
     data: (function () {
         // generate an array of random data
         var mySeries = [],
             time = (new Date()).getTime(),
             i;
       var len=data1.length;
		    for ( i = 0; i < data1.length; i++) {
		    	var dummy=data1[i];
		        mySeries.push({
		        	x : time + i * 1000,
		        	y :parseFloat(dummy.msg)
		        
		        });
		    	console.log("from dummy"+parseInt(dummy.msg));
		        }
         return mySeries;
     }())
 }]
});
});
});
	
	</script>
<script>
/* $( document ).ready(function() 
	{
  $('.bulb-light').click(function() 
	{
    $('.light').toggleClass('night');
  });
}); */
function ledOn(){
	 $('.light').toggleClass('night');
}
</script>

</html>













