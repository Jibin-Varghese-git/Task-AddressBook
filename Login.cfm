<html>
    <head>
        <link rel="stylesheet" href="../bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div>
            <form method="post">
                <header class="py-2 px-5 d-flex justify-content-between">
                    <div class="">
                        <img src="Assets/Images/addressBook.png" alt="No image found" height="35" width="35">
                        <span class="text-white">ADDRESS BOOK</span>
                    </div>
                    <div class="headerButtons">
                        <button class="text-white"> <img src="Assets/Images/signup.png" alt="No image found" height="18" width="18" class="mb-2 me-1">Sign Up</button>
                        <button class="text-white"><img src="Assets/Images/login_icon.png" alt="No image found" height="15" width="18" class="mb-1 me-1">Login</button>
                    </div>
                </header>

               <div class="containerMain mt-5">
                    <div class="containerBody border  d-flex bg-white">

                        <div class="subcontainerLeft d-flex align-items-center p-5">
                            <img src="Assets/Images/addressBook.png" class="ms-5" alt="No image found" height="100" width="100">
                        </div>

                        <div class="subcontainerRight d-flex flex-column align-items-center justify-content-around">
                            <span class="loginHeading">LOGIN</span>
                            <input type="text" class="userName" name="userName" placeholder="User Name">
                            <input type="password" class="password" name="password" placeholder="Password">
                            <button class="registerButton" name="login">LOGIN</button>
                             <div>
                                <span class="textLogin p-3">Or Sign In Using</span>
                                <div class="d-flex p-2">
                                    <a><img src="Assets/Images/facebook.png" class="me-2" alt="No image found" height="60" width="60"></a>
                                    <a><img src="Assets/Images/Google.png" class="" alt="No image found" height="60" width="60"></a>
                                </div>
                            </div>
                            <span class="textLogin">Already have an account? <a class="text-decoration-none" href="SignUp.cfm">Register Here</a></span>
                        </div>

                    </div>                   
               </div>
            </form>
            <cfif structKeyExists(form, "login")>
                <cfset local.obj = createObject("component", "components.addressBook")>
                <cfset local.result = local.obj.userLogin(form.userName,form.password)>
                <cfif local.result>
                    <cflocation  url="Home.cfm" addToken="no">
                <cfelse>
                    <span class="fw-bold text-danger">Invalid User Name and Password</span>
                </cfif>
            </cfif>
        </div>
    </body>    
</html>