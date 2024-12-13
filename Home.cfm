<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="bootstrap-5.3.3-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <div>
            <div>
                <header class="py-2 px-5 d-flex justify-content-between">
                    <div class="">
                        <img src="Assets/Images/addressBook.png" alt="No image found" height="35" width="35">
                        <span class="text-white">ADDRESS BOOK</span>
                    </div>
                    <div class="headerButtons">
                        <button class="text-white" onclick="funlogout()"><img src="Assets/Images/logout.png" alt="No image found" height="15" width="18" class="mb-1 me-1">Logout</button>
                    </div>
                </header>

                <div class="contentConatainer d-flex flex-column">

                    <div class="contentTopBox  bg-white pe-5 py-3">
                        
                            <div class=" d-flex justify-content-end">
                                <form method="post">
                                    <button  class="topBtn" id="pdfBtn" name="pdfBtn" onclick="return funPdf()"><img src="Assets/Images/pdf.png" class="mx-2" alt="No image found" height="35" width="35"></button>
                                    <button type="button" class="topBtn" onclick="funXls()"><img src="Assets/Images/excel.png" class="mx-2" alt="No image found" height="35" width="35"></button>
                                    <button type="submit" class="topBtn"  onclick="funPrint()"><img src="Assets/Images/printer.png" class="mx-2" alt="No image found" height="35" width="35"></button>
                                </form>
                            </div>
                    </div>
                    <cfoutput>
                   
                        <div class="contentSecondBox  d-flex justify-content-between">
                        
                            <div class="contentBoxLeft bg-white p-3 d-flex flex-column justify-content-between align-items-center">
                                <div class="userImageDiv">
                                    <img src="#session.structUserDetails["userImage"]#" class="rounded-circle" alt="No image found">
                                </div>
                                <h6 class="userNameSpan ms-3">#session.structUserDetails["fullName"]#<h6>
                                <button type="button" class="createContactBtn mt-3 py-2" onclick="funCreateContact()" data-bs-toggle="modal" data-bs-target="##modalEdit">CREATE CONTACT</button>
                                <button type="button" class="uploadFileBtn mt-3 py-2"  data-bs-toggle="modal" data-bs-target="##modalUpload">UPLOAD FILE</button>
                            </div>

                            <div class="contentBoxRight bg-white p-2" id="contentBoxRight">

                                <div class="contactsHeading d-flex p-3">
                                    <div class="nameHeading ps-5">
                                        <h6 class="contactHeadingSpan">NAME<h6>
                                    </div>
                                    <div class="emailHeading ps-3">
                                        <h6 class="contactHeadingSpan">EMAIL ID<h6>
                                    </div>
                                    <div class="phnnoHeading">
                                        <h6 class="contactHeadingSpan">PHONE NUMBER<h6>
                                    </div>
                                </div>

                                <!--- Contact Listing --->
                                <cfset ormReload()>
                                <cfset local.activeValue = 1>
                                <cfset  qryReadContact = entityLoad("fetchUserOrm",{_createdBy = #session.structUserDetails["userId"]#,active = local.activeValue})>
                                 
                                <cfoutput>
                                
                                    <cfloop array="#qryReadContact#" item="item">
                                    
                                        <div class="singleContact px-2 py-3 d-flex align-items-center" id="#item.getcontactId()#">
                                            <div class="ContactImageDiv">
                                                <img src="#item.getcontactImage()#" class="rounded-circle" alt="No image found">
                                            </div>
                                            <div class="contactDetails p-1 d-flex justify-content-between">
                                                <div class="contactUserName">#item.getfirstName()# #item.getlastName()#</div>
                                                <div class="contactUserEmail overflow-hidden">#item.getemailId()#</div>
                                                <div class="contactPhnNo">#item.getphoneNo()#</div>
                                            </div>
                                            <div class="contactButtons d-flex justify-content-around ms-4">
                                                <button  class="contactBtnClass" type="button" value="#item.getcontactId()#" onclick="funEditContact(this)" id="editBtn" data-bs-toggle="modal" data-bs-target="##modalEdit">EDIT</button>
                                                <button class="contactBtnClass" value="#item.getcontactId()#" onclick="funDelete(this)" id="deleteBtn">DELETE</button>
                                                <button class="contactBtnClass" type="button" value="#item.getcontactId()#" id="viewBtn" onclick="funViewContact(this)" data-bs-toggle="modal" data-bs-target="##modalView">VIEW</button>
                                            </div>
                                        </div>

                                    </cfloop>
                                  
                                </cfoutput>
                            </div>
                        </div>
                    </cfoutput>
                </div>
                <!--- Modal Upload File --->
                <div class="modal fade" id="modalUpload" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modalUploadBox modal-content p-2">

                            <div class="topBox d-flex">
                                    <button class="dataFileBtn me-1">File With Data</button>
                                    <button class="plainFileBtn ms-2">Plain File</button>
                            </div>

                            <div class="midBox  p-3">
                                <div class="heading my-4">
                                    <span>Upload Excel File</span>
                                </div>
                                <div class="uploadBox">
                                    <span>Upload Excel *</span><br>
                                    <input type="file">
                                </div>
                            </div>

                            <div class="modal-footer btmBox">
                                <button type="submit"    class="modalSubmitBtn">Submit</button>
                                <button type="button" class="modalCloseBtn" data-bs-dismiss="modal">Close</button>
                            </div>

                        </div>
                    </div>
                </div>
                <!--- Modal Edit/Add --->
                <div class="modal fade" id="modalEdit" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modalEditBox modal-content">
                            <form method="post" enctype="multipart/form-data" id="createForm" onsubmit="pageReload()">
                                <div class="d-flex">
                                    <div class="modalEditLeftBox bg-white p-5">
                                        <div class="modalEditHeading p-2 my-2 text-center">
                                            <span id="modalHeading">CREATE  CONTACT<span>
                                        </div>
                                        <div class="modalEditSubHeading my-3">
                                            <span>Personal  Contact<span>
                                        </div>
                                        <div class="personalInfoDiv1 d-flex my-3">
                                            <div class="titleDiv">
                                                <span >Title*</span><br>
                                                <select class="selectTitle" name="title" id="contactTitle">
                                                    <option value="selected"></option>
                                                    <option value="Mr">Mr.</option>
                                                    <option value="Mrs">Mrs</option>
                                                    <option value="Miss">Miss</option>
                                                </select><br>
                                                <span class="text-danger fs-6" id="errorTitle"></span>
                                            </div>
                                            <div class="firstNameDiv me-2">
                                                <span>First Name*</span>
                                                <input type="text" name="firstName" id="firstName" placeholder="Your First Name">
                                                <span class="text-danger fs-6" id="errorFname"></span>
                                            </div>
                                            <div class="lastNameDiv ms-2">
                                                <span>Last Name*</span>
                                                <input type="text" name="lastName" id="lastName" placeholder="Your Last Name">
                                                <span class="text-danger fs-6" id="errorLname"></span>
                                            </div>
                                        </div>
                                        <div class="personalInfoDiv2 d-flex my-3">
                                            <div class="genderDiv me-4">
                                                <span>Gender*</span><br>
                                                <select class="selectGender" id="contactGender" name="gender">
                                                    <option value="selected"></option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                                <span class="text-danger fs-6" id="errorGender"></span>
                                            </div>
                                            <div class="dateOfBirthDiv">
                                                <span>Date of Birth*</span><br>
                                                <input type="date" name="dateOfBirth" id="dateOfBirth" placeholder="dd-mm-yyyy">
                                                <span class="text-danger fs-6" id="errorDob"></span>
                                            </div>
                                        </div>
                                        <div class="personalInfoDiv3 my-3">
                                            <span>Upload Photo</span><br>
                                            <input type="hidden" value="null" name="imgHidden" id="imgHidden">
                                            <input type="file" id="contactImage" name="contactImage" >
                                        </div>
                                        <div class="personalInfoDiv4 my-3">
                                            <span>Select Role</span><br>
                                            <cfset selectRole = application.obj.selectRole()>
                                            <select class="roleSelect  border" name="roleSelect" multiple placeholder="Select Role" id="roleSelect" multiple data-live-search="true">
                                                <cfoutput>
                                                    <cfloop query="selectRole">
                                                        <option value="#selectRole.roleId#">#selectRole.roleName#</option>
                                                    </cfloop>
                                                </cfoutput>
                                            </select>
                                            <span class="text-danger fs-6" id="errorRole"></span>
                                        </div>

                                        <div class="modalEditSubHeading my-3">
                                            <span>Contact Details<span>
                                        </div>
                                        <div class="contactInfoDiv1 d-flex my-3">
                                            <div class="pe-2">
                                                <span>Address*</span><br>
                                                <input type="text" name="address" id="address" placeholder="Your Address"><br>
                                                <span class="text-danger fs-6" id="errorAddress"></span>
                                            </div>
                                            <div>
                                                <span>Street*</span><br>
                                                <input type="text" name="street" id="street" placeholder="Your Street"><br>
                                                <span class="text-danger fs-6" id="errorStreet"></span>
                                            </div>
                                        </div>
                                        <div class="contactInfoDiv2 d-flex my-3">
                                            <div class="pe-2">
                                                <span>District*</span><br>
                                                <input type="text" name="district" id="district" placeholder="Your District"><br>
                                                <span class="text-danger fs-6" id="errorDistrict"></span>
                                            </div>
                                            <div>
                                                <span>State*</span><br>
                                                <input type="text" name="state" id="state" placeholder="Your State"><br>
                                                <span class="text-danger fs-6" id="errorState"></span>
                                            </div>
                                        </div>
                                        <div class="contactInfoDiv3 d-flex my-3">
                                            <div class="pe-2">
                                                <span>Country*</span><br>
                                                <input type="text" name="country" id="country" placeholder="Your Country"><br>
                                                <span class="text-danger fs-6" id="errorCountry"></span>
                                            </div>
                                            <div>
                                                <span>Pincode*</span><br>
                                                <input type="text" name="pincode" id="pincode" placeholder="Your Pincode"><br>
                                                <span class="text-danger fs-6" id="errorPincode"></span>
                                            </div>
                                        </div>
                                        <div class="contactInfoDiv4 d-flex my-3">
                                            <div class="pe-2">
                                                <span>Email Id*</span><br>
                                                <input type="email" name="emailId" id="emailId" placeholder="Your Email Id"><br>
                                                <span class="text-danger fs-6" id="errorEmail"></span>
                                            </div>
                                            <div>
                                                <span>Phone Number*</span><br>
                                                <input type="text" name="phoneNo" id="phoneNo" placeholder="Your Phone Number"><br>
                                                <span class="text-danger fs-6" id="errorPhoneNo"></span>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="modalEditBtn" onclick="funClose()" data-bs-dismiss="modal">Close</button>
                                            <input type="hidden" value="" id="addContactHidden" name="addContactHidden">
                                            <button type="submit" onclick="funModalVal(event)"  value=""  id="addContact" name="addContact" class="modalEditBtn">Save</button>
                                        </div>
                                    </div>

                                    <div class="modalEditRightBox ps-4 pt-5">
                                        <div class="userImageDiv border bg-white mt-5">
                                            <img src="Assets/Images/user.png" class="rounded-circle" id="editModalImage" alt="No image found">
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--- Modal edit end --->   
                <!-- Modal View-->
                <div class="modal fade" id="modalView" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modalEditBox modal-content">
                            <div class="d-flex">
                                <div class="modalEditLeftBox bg-white p-5">
                                    <div class="modalEditHeading p-2 my-2 text-center">
                                        <span>CONTACT DETAILS<span>
                                    </div>
                                    <div class="contactDetailsDisplay">
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Name</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="userNameView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Gender</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="genderView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Date of Birth</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="dobView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Address</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails">
                                                <span id="addressView"></span>,
                                                <span id="streetView"></span>,
                                                <span id="stateView"></span>,
                                                <span id="districtView"></span>,
                                                <span id="countryView"></span>
                                            </div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Pincode</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="pincodeView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Email Id</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="emailIdView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Roles</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="userRoleView"></span></div>
                                        </div>
                                        <div class="infoDiv my-2 d-flex">
                                            <div class="headings">Phone</div>
                                            <div class="middle">:</div>
                                            <div class="userDetails"><span id="phoneNoView"></span></div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="modalEditBtn" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                                <div class="modalEditRightBox ps-4 pt-5">
                                    <div class="userImageDivView border bg-white mt-5">
                                        <img src="Assets/Images/user.png" id="userContactImage" class="" alt="No image found">
                                    </div>
                                </div>
                            </div>
                        </div>  
                    </div>
                </div>
                <!--Modal View End-->
            </div>
        </div>
<!---       Add contact CF        --->
        <cfoutput>
            <cfif structKeyExists(form, "addContact")>

                <cfif Len(form.addContactHidden) LT 1>

                    <cfif  len(form.contactImage) GT 1>
                        <cffile  action="upload" destination="#expandpath("Assets/Images")#" filefield="form.contactImage" result="imgUploaded" nameconflict="MAKEUNIQUE"> 
                        </cffile>
                        <cfset imagePath = "Assets/Images/#imgUploaded.SERVERFILE#">
                    <cfelse>
                        <cfset imagePath = "Assets/Images/user.png">
                    </cfif>

                    <cfloop collection="#form#" item="item">
                        <cfset structContactInfo[item] = form[item]>
                    </cfloop>
                    <cfset structContactInfo["contactImage"]="#imagePath#">
                    <cfdump  var="#structContactInfo["roleSelect"]#">
                    <cfset result = application.obj.addContact(structContactInfo=structContactInfo)>
                    <cfif result == "error">
                        <h2 class="text-danger">Phone Number  Already Exists</h2>
                    <cfelseif result == "error1">
                        <h2 class="text-danger">Email Id  Already Exists</h2>
                    <cfelseif result == "error2">
                        <h2 class="text-danger">Email Id  cannot use</h2>
                    <cfelse>
                        <cflocation  url="Home.cfm" addToken="no">
                    </cfif>         
                    
                </cfif>

                <cfif Len(form.addContactHidden) GT 0>

                    <cfif  len(form.contactImage) GT 1>
                        <cffile  action="upload" destination="C:\ColdFusion2021\cfusion\wwwroot\AdressBook-Task\Assets\Images" filefield="form.contactImage" result="imgUploaded" nameconflict="MAKEUNIQUE"> 
                        </cffile>
                        <cfset imagePath = "Assets/Images/#imgUploaded.SERVERFILE#">
                    <cfelse>
                        <cfset imagePath = "#form.imgHidden#">
                    </cfif>

                    <cfloop collection="#form#" item="item">
                        <cfset structContactInfo[item] = form[item]>
                    </cfloop>
                    <cfset structContactInfo["contactImage"]="#imagePath#">
                    
                    <cfset result = application.obj.editContact(structContactInfo=structContactInfo)>
                    <cfif result == "error">
                        <h2 class="text-danger">Phone Number  Already Exists</h2>
                    <cfelseif result == "error1">
                        <h2 class="text-danger">Email Id  Already Exists</h2>
                    <cfelseif result == "error2">
                        <h2 class="text-danger">Email Id  cannot use</h2>
                    <cfelse>
                        <cflocation  url="Home.cfm" addToken="no">
                    </cfif>

                </cfif>
            </cfif>

        </cfoutput>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="js/script.js"></script>
        
    </body>    
</html>