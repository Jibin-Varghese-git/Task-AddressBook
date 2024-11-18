<html>
    <head>
        <link rel="stylesheet" href="../bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div>
            <form>
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

               <div class="containerMain h-100 mt-5">
                    <div class="containerBody border  d-flex bg-white">

                        <div class="subcontainerLeft d-flex align-items-center p-5">
                            <img src="Assets/Images/addressBook.png" class="ms-5" alt="No image found" height="100" width="100">
                        </div>

                        <div class="subcontainerRight d-flex flex-column align-items-center justify-content-around">
                            <span class="signUpHeading">SIGN UP</span>
                            <input type="text" class="fullName" name="fullName" placeholder="Full Name">
                            <input type="text" class="emailId" name="emailId"  placeholder="Email Id">
                            <input type="text" class="userName" name="userName" placeholder="User Name">
                            <input type="text" class="password" name="password" placeholder="Password">
                            <input type="text" class="confirmPassword"  name="confirmPassword" placeholder="Confirm Password">
                            <div class="userImageContainer p-2">
                                <input type="file" class="userImage" name="userImage">
                                <span>Upload User Image</span>
                            </div>
                            <button class="registerButton">REGISTER</button>
                            <span>Already have an account? <a class="text-decoration-none" href="Login.cfm"> Login</a></span>
                        </div>

                    </div>                   
               </div>
            </form>
        </div>
    </body>    
</html>