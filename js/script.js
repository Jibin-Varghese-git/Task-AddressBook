function signUpVal(event){

    let fullName = document.getElementById("fullName").value;
    let emailId = document.getElementById("emailId").value;
    let userName = document.getElementById("userName").value;
    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;
    let userImage = document.getElementById("userImage").value;

    const name_pattern=/[^\w-]/;
    const nameSpace=/[\s]/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const psw_lower=/[a-z]/;
	const psw_upper=/[A-Z]/;
	const psw_digit=/[0-9]/;
	const psw_special=/[^a-zA-Z0-9]/;
    const allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;

    document.getElementById("errorFullName").innerHTML = "";
    document.getElementById("errorEmailId").innerHTML = "";
    document.getElementById("errorUserName").innerHTML = "";
    document.getElementById("errorPassword").innerHTML = "";
    document.getElementById("errorConfirmPassword").innerHTML = "";
    document.getElementById("errorImage").innerHTML = "";

    if(fullName.length == 0)
    {
        document.getElementById("errorFullName").innerHTML="Enter the Full Name";
        event.preventDefault();
    }

    if(emailId.length == 0)
    {
        document.getElementById("errorEmailId").innerHTML="Enter the email id";
        event.preventDefault();
    }
    else if(!emailRegex.test(emailId))
    {
        document.getElementById("errorEmailId").innerHTML="Format not  valid";
        event.preventDefault();
    }

    if(userName.length == 0)
    {
        document.getElementById("errorUserName").innerHTML="Enter the user name";
        event.preventDefault();
    }
    else if(nameSpace.test(userName)==true)
    {
        document.getElementById("errorUserName").innerHTML="User name shouldn't contain whitesapce ";
        event.preventDefault();
    }
    else if(name_pattern.test(userName)==true)
    {
        document.getElementById("errorUserName").innerHTML="User name shouldn't contain special characters";
        event.preventDefault();
    }

    if(password.length==0)
    {
        document.getElementById("errorPassword").innerHTML= "Enter the password";
        event.preventDefault();
    }   
    else if(/\s/.test(password)==true)
    {
        document.getElementById("errorPassword").innerHTML= "Should not contain whitespace ,. or -";
        event.preventDefault();
    }	
    else if(psw_lower.test(password)!=true)
    {
        document.getElementById("errorPassword").innerHTML= "Must contain atleast a lower case letter";
        event.preventDefault();
    }
    else if(psw_upper.test(password)!=true)
    {
        document.getElementById("errorPassword").innerHTML= "Must contain atleast an upper case letter";
        event.preventDefault();
    }
    else if(psw_digit.test(password)!=true)
    {
        document.getElementById("errorPassword").innerHTML= "Must contain atleast a digit";
        event.preventDefault();
    }
    else if(psw_special.test(password)!=true)
    {
        document.getElementById("errorPassword").innerHTML= "Must contain atleast a special character";
        event.preventDefault();
    }
    else if(password.length<8)
    {
        document.getElementById("errorPassword").innerHTML= "Password must contain 8 chars";
        event.preventDefault();
    }
        
    if(password != confirmPassword)
    {
        document.getElementById("errorConfirmPassword").innerHTML="Password mismatch";
        event.preventDefault();
    }

    if(userImage.length == 0)
    {
        document.getElementById("errorImage").innerHTML="Upload User Image";
        event.preventDefault();
    }
    else if(!allowedExtensions.exec(userImage))
    {
        document.getElementById("errorImage").innerHTML="Invalid File Type";
        event.preventDefault();
    }

}

function funlogout(){
    if(confirm("Do you want to logout?"))
    {
        alert("hello")
        $.ajax({
            type:"GET",
            url:"components/addressBook.cfc?method=logout",
            success:function(result){
                if(result)
                {
                    location.reload();
                }
                else
                {
                   alert("logout error")
                }
            }
        });
    } 
    else{
        alert("error")
    } 
}

function funModalVal(event){
    let contactTitle=document.getElementById("contactTitle").value;
    let fname=document.getElementById("firstName").value;
    let lname=document.getElementById("lastName").value;
    let gender=document.getElementById("contactGender").value;
    let dob=document.getElementById("dateOfBirth").value;
    let contactImage=document.getElementById("contactImage").value;
    let address=document.getElementById("address").value;
    let street=document.getElementById("street").value;
    let district=document.getElementById("district").value;
    let state=document.getElementById("district").value;
    let country=document.getElementById("country").value;
    let pincode=document.getElementById("pincode").value;
    let emailId=document.getElementById("emailId").value;
    let phoneNo=document.getElementById("phoneNo").value;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    document.getElementById("errorTitle").innerHTML="";
    document.getElementById("errorFname").innerHTML="";
    document.getElementById("errorLname").innerHTML="";
    document.getElementById("errorGender").innerHTML="";
    document.getElementById("errorDob").innerHTML="";
    document.getElementById("errorAddress").innerHTML="";
    document.getElementById("errorStreet").innerHTML="";
    document.getElementById("errorDistrict").innerHTML="";
    document.getElementById("errorState").innerHTML="";
    document.getElementById("errorCountry").innerHTML="";
    document.getElementById("errorPincode").innerHTML="";
    document.getElementById("errorEmail").innerHTML="";
    document.getElementById("errorPhoneNo").innerHTML="";




    if(contactTitle == "selected")
    {
        document.getElementById("errorTitle").innerHTML="Select title";
        event.preventDefault();
    }

    if( fname.trim().length == "" )
    {
        document.getElementById("errorFname").innerHTML="Enter Firstname";
        event.preventDefault();
    }

    if( lname.trim().length == "" )
    {
        document.getElementById("errorLname").innerHTML="Enter Lastname";
        event.preventDefault();
    }

    if(gender == "selected")
    {
        document.getElementById("errorGender").innerHTML="Select your gender";
        event.preventDefault();
    }

    if(dob.length == "")
    {
        document.getElementById("errorDob").innerHTML="Select your Date of Birth";
        event.preventDefault();
    }

    if(address.length == "")
    {
        document.getElementById("errorAddress").innerHTML="Enter  address";
        event.preventDefault();
    }

    if(street.length == "")
    {
        document.getElementById("errorStreet").innerHTML="Enter Street";
        event.preventDefault();
    }

    if(district.length == "")
    {
        document.getElementById("errorDistrict").innerHTML="Enter Distict";
        event.preventDefault();
    }

    if(state.length == "")
    {
        document.getElementById("errorState").innerHTML="Enter State";
        event.preventDefault();
    }

    if(country.length == "")
    {
        document.getElementById("errorCountry").innerHTML="Enter Country";
        event.preventDefault();
    }

    if(pincode.length == "")
    {
        document.getElementById("errorPincode").innerHTML="Enter Pincode";
        event.preventDefault();
    } 
    else if(isNaN(pincode))
    {
        document.getElementById("errorPincode").innerHTML="Invalid!";
    }
    else if(pincode.length < 6)
    {
        document.getElementById("errorPincode").innerHTML="Invalid! Must Contain 6 digits";
    }
    else if(pincode.length > 6)
    {
        document.getElementById("errorPincode").innerHTML="Invalid! 6 digits only";
    }

    if(emailId.trim().length == "")
    {
        document.getElementById("errorEmail").innerHTML="Enter Email Id";
        event.preventDefault();
    }
    else if(!emailRegex.test(emailId))
    {
        document.getElementById("errorEmail").innerHTML="Format not  valid";
        event.preventDefault();
    }

    if(phoneNo.trim().length == "")
    {
        document.getElementById("errorPhoneNo").innerHTML="Enter Phone Number";
        event.preventDefault();
    }
    else if(isNaN(phoneNo))
    {
        document.getElementById("errorPhoneNo").innerHTML="Phone Number only contains number";
    }
    else if(phoneNo.length < 10)
    {
        document.getElementById("errorPhoneNo").innerHTML="Invalid! Must Contain 10 digits";
    }
    else if(phoneNo.length > 10)
    {
        document.getElementById("errorPhoneNo").innerHTML="Invalid! 10 digits only";
    }
    
    
}
