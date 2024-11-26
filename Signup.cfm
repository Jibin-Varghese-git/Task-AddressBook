<html>
    <head>
        <link rel="stylesheet" href="bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/script.js"></script>
    </head>

    <body>
        <div>
            <form method="post" enctype="multipart/form-data">
                <header class="py-2 px-5 d-flex justify-content-between">
                    <div class="">
                        <img src="Assets/Images/addressBook.png" alt="No image found" height="35" width="35">
                        <span class="text-white">ADDRESS BOOK</span>
                    </div>
                    <div class="headerButtons">
                        <a href="Login.cfm" class="text-decoration-none text-white"><img src="Assets/Images/login_icon.png" alt="No image found" height="15" width="18" class="mb-1 me-1">Login</a>
                    </div>
                </header>

               <div class="containerMain h-100 mt-5">
                    <div class="containerBody border  d-flex bg-white">

                        <div class="subcontainerLeft d-flex align-items-center p-5">
                            <img src="Assets/Images/addressBook.png" class="ms-5" alt="No image found" height="100" width="100">
                        </div>

                        <div class="subcontainerRight d-flex flex-column align-items-center justify-content-around">
                            <span class="signUpHeading">SIGN UP</span>
                            <input type="text" class="fullName" name="fullName" id="fullName" placeholder="Full Name">
                                <span id="errorFullName" class="text-danger"></span>
                            <input type="text" class="emailId"  name="emailId"  id="emailId"  placeholder="Email Id">
                                <span id="errorEmailId" class="text-danger"></span>
                            <input type="text" class="userName" name="userName" id="userName" placeholder="User Name">
                                <span id="errorUserName" class="text-danger"></span>
                            <input type="password" class="password" name="password" id="password" placeholder="Password">
                                <span id="errorPassword" class="text-danger"></span>
                            <input type="password" class="confirmPassword"  name="confirmPassword" id="confirmPassword" placeholder="Confirm Password">
                                <span id="errorConfirmPassword" class="text-danger"></span>
                            <div class="userImageContainer p-2">
                                <input type="file" class="userImage" name="userImage" id="userImage">
                                <span>Upload User Image</span>
                                <span id="errorImage" class="text-danger"></span>
                            </div>
                            <button type="submit" name="register" class="registerButton" onclick="signUpVal(event)">REGISTER</button>
                            <span>Already have an account? <a class="text-decoration-none" href="Login.cfm"> Login</a></span>
                             <!-- cf starts here -->
                            <cfif structKeyExists(form, "register")>
                                <cffile  action="upload" destination="C:\ColdFusion2021\cfusion\wwwroot\AdressBook-Task\Assets\Images" filefield="form.userImage" result="imgUploaded" nameconflict="MAKEUNIQUE"> 
                                </cffile>
                                <cfset local.imagePath = "Assets\Images\#imgUploaded.SERVERFILE#">
                                <cfloop collection="#form#" item="item">
                                    <cfset local.structUserInfo[item] = trim(form[item])>
                                </cfloop>
                                <cfset local.structUserInfo["imagePath"] = local.imagePath>
<!---                                 <cfset local.obj = createObject("component", "components.addressBook")> --->
                                <cfset local.result = application.obj.signUpInput(local.structUserInfo)>
                                <cfoutput>
                                    <span class="fw-bold bg-success text-white">#local.result#</span>
                                </cfoutput>
                            </cfif>
                        </div>
                    </div>                   
               </div>
            </form>
           
        </div>
    </body>    
</html>