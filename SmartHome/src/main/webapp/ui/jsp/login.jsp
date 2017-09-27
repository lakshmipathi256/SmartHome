<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Login | Propeller - Admin Dashboard">
<meta content="width=device-width, initial-scale=1, user-scalable=no"
	name="viewport">
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

<!--Google Analytics code-->
<script>
	(function(i, s, o, g, r, a, m) {
		i['GoogleAnalyticsObject'] = r;
		i[r] = i[r] || function() {
			(i[r].q = i[r].q || []).push(arguments)
		}, i[r].l = 1 * new Date();
		a = s.createElement(o), m = s.getElementsByTagName(o)[0];
		a.async = 1;
		a.src = g;
		m.parentNode.insertBefore(a, m)
	})(window, document, 'script',
			'https://www.google-analytics.com/analytics.js', 'ga');

	ga('create', 'UA-124615-22', 'auto');
	ga('send', 'pageview');
</script>
</head>

<!-- Styles Ends -->
</head>

<body class="body-custom">
	<div class="logincard">
		<div class="pmd-card card-default pmd-z-depth">
			<div class="login-card">
				<c:if test="${param.error ne null}">
					<div style="color: red">Invalid credentials.</div>
				</c:if>
				<form action="/login" method="post">
					<div class="pmd-card-title card-header-border text-center">
						<div class="loginlogo">
							<a href="javascript:void(0);"><img src="https://lh3.googleusercontent.com/CrsG2PZ00eFmkBt4YSvcCHCHDhmdWyvhEB7a-PwUNHWmLtYIl8ECQjYOLA6Wpe-aLT8Nua0DzlXVsJDqD6Pa3EPKQVidz7UXB8SBitMeC5idfJy1P56YRSmEaLiHiVVN4P2U5G4=w677-h278-no" alt="Basu"></a>
						</div>
						<h3>
							Sign In <span>with <strong>CDI Smart Home</strong></span>
						</h3>
					</div>


					<div class="pmd-card-body">
						<div class="alert alert-success" role="alert">Oh snap!
							Change a few things up and try submitting again.</div>
						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="username" class="control-label pmd-input-group-label">Username</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">perm_identity</i>
								</div>
								<input type="text" class="form-control" id="username"
									name="username">
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="pwd" class="control-label pmd-input-group-label">Password</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">lock_outline</i>
								</div>
								<input type="password" class="form-control" id="pwd"
									name="password">
							</div>
						</div>
					</div>
					<div
						class="pmd-card-footer card-footer-no-border card-footer-p16 text-center">
						<div class="form-group clearfix">
							<div class="checkbox pull-left">
								<label class="pmd-checkbox checkbox-pmd-ripple-effect">
									<input type="checkbox" checked="" value=""> <span
									class="pmd-checkbox"> Remember me</span>
								</label>
							</div>
							<span class="pull-right forgot-password"> <a
								href="javascript:void(0);">Forgot password?</a>
							</span>
						</div>
						<!-- 	<a href="/login" type="button" class="btn pmd-ripple-effect btn-primary btn-block">Login</a> -->
						<button type="submit"
							class="btn pmd-ripple-effect btn-primary btn-block">Login</button>

						<p class="redirection-link">
							Don't have an account? <a href="/registration">Sign Up</a>.
						</p>

					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>

			</div>
          
			<!-- <div class="register-card">
				<div class="pmd-card-title card-header-border text-center">
					<div class="loginlogo">
							<a href="javascript:void(0);"><img src="https://lh3.googleusercontent.com/CrsG2PZ00eFmkBt4YSvcCHCHDhmdWyvhEB7a-PwUNHWmLtYIl8ECQjYOLA6Wpe-aLT8Nua0DzlXVsJDqD6Pa3EPKQVidz7UXB8SBitMeC5idfJy1P56YRSmEaLiHiVVN4P2U5G4=w677-h278-no" alt="Basu"></a>
						</div>
					<h3>
						Sign Up <span>with <strong>CDI Smart Home</strong></span>
					</h3>
				</div>
				<form>
					<div class="pmd-card-body">

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Username</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">perm_identity</i>
								</div>
								<input type="text" class="form-control" id="exampleInputAmount">
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Email
								address</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">email</i>
								</div>
								<input type="text" class="form-control" id="exampleInputAmount">
							</div>
						</div>

						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Password</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">lock_outline</i>
								</div>
								<input type="text" class="form-control" id="exampleInputAmount">
							</div>
						</div>
					</div>

					<div
						class="pmd-card-footer card-footer-no-border card-footer-p16 text-center">
						<a href="index.html" type="button"
							class="btn pmd-ripple-effect btn-primary btn-block">Sign Up</a>
						<p class="redirection-link">
							Already have an account? <a href="javascript:void(0);"
								class="register-login">Sign In</a>.
						</p>
					</div>
				</form>
			</div> -->

			<div class="forgot-password-card">
				<form>
					<div class="pmd-card-title card-header-border text-center">
						<div class="loginlogo">
							<a href="javascript:void(0);"><img src="https://lh3.googleusercontent.com/CrsG2PZ00eFmkBt4YSvcCHCHDhmdWyvhEB7a-PwUNHWmLtYIl8ECQjYOLA6Wpe-aLT8Nua0DzlXVsJDqD6Pa3EPKQVidz7UXB8SBitMeC5idfJy1P56YRSmEaLiHiVVN4P2U5G4=w677-h278-no" alt="Basu"></a>
						</div>
						<h3>
							Forgot password?<br> <span>Submit your email address
								and we'll send you a link to reset your password.</span>
						</h3>
					</div>
					<div class="pmd-card-body">
						<div class="form-group pmd-textfield pmd-textfield-floating-label">
							<label for="inputError1"
								class="control-label pmd-input-group-label">Email
								address</label>
							<div class="input-group">
								<div class="input-group-addon">
									<i class="material-icons md-dark pmd-sm">email</i>
								</div>
								<input type="text" class="form-control" id="exampleInputAmount">
							</div>
						</div>
					</div>
					<div
						class="pmd-card-footer card-footer-no-border card-footer-p16 text-center">
						<a href="index.html" type="button"
							class="btn pmd-ripple-effect btn-primary btn-block">Submit</a>
						<p class="redirection-link">
							Already registered? <a href="javascript:void(0);"
								class="register-login">Sign In</a>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Scripts Starts -->
	<!-- build:[src] assets/js/ -->
	<script src="/jquery-1.12.2.min.js"></script>
	<script src="bootstrap.min.js"></script>
	<script src="/propeller.min.js"></script>
	<!-- /build -->
	<script>
		$(document).ready(
				function() {
					var sPath = window.location.pathname;
					var sPage = sPath.substring(sPath.lastIndexOf('/') + 1);
					$(".pmd-sidebar-nav").each(
							function() {
								$(this).find("a[href='" + sPage + "']")
										.parents(".dropdown").addClass("open");
								$(this).find("a[href='" + sPage + "']")
										.parents(".dropdown").find(
												'.dropdown-menu').css(
												"display", "block");
								$(this).find("a[href='" + sPage + "']")
										.parents(".dropdown").find(
												'a.dropdown-toggle').addClass(
												"active");
								$(this).find("a[href='" + sPage + "']")
										.addClass("active");
							});
				});
	</script>
	<!-- login page sections show hide -->
	<script type="text/javascript">
		$(document).ready(function() {
			$('.app-list-icon li a').addClass("active");
			$(".login-for").click(function() {
				$('.login-card').hide()
				$('.forgot-password-card').show();
			});
			$(".signin").click(function() {
				$('.login-card').show()
				$('.forgot-password-card').hide();
			});
		});
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".login-register").click(function() {
				$('.login-card').hide()
				$('.forgot-password-card').hide();
				$('.register-card').show();
			});

			$(".register-login").click(function() {
				$('.register-card').hide()
				$('.forgot-password-card').hide();
				$('.login-card').show();
			});
			$(".forgot-password").click(function() {
				$('.login-card').hide()
				$('.register-card').hide()
				$('.forgot-password-card').show();
			});
		});
	</script>

	<!-- Scripts Ends -->

</body>
</html>