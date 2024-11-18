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
                        <button class="text-white"><img src="Assets/Images/logout.png" alt="No image found" height="15" width="18" class="mb-1 me-1">Logout</button>
                    </div>
                </header>

                <div class="contentConatainer d-flex flex-column">

                    <div class="contentTopBox  bg-white pe-5 py-3">
                        <div class=" d-flex justify-content-end">
                            <a><img src="Assets/Images/pdf.png" class="mx-2" alt="No image found" height="35" width="35"></a>
                            <a><img src="Assets/Images/excel.png" class="mx-2" alt="No image found" height="35" width="35"></a>
                            <a><img src="Assets/Images/printer.png" class="mx-2" alt="No image found" height="35" width="35"></a>
                        </div>
                    </div>

                    <div class="contentSecondBox  d-flex justify-content-between">
                        <div class="contentBoxLeft bg-white p-3 d-flex flex-column justify-content-between align-items-center">
                            <div class="userImageDiv">
                                <img src="Assets/Images/user.png" class="rounded-circle" alt="No image found">
                            </div>
                            <h6 class="userNameSpan ms-3">USER NAME<h6>
                            <button class="createContactBtn mt-3 py-2">CREATE CONTACT</button>
                        </div>
                        <div class="contentBoxRight bg-white p-2">

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

                            <!--- Contact --->
                            <div class="singleContact px-2 py-3 d-flex align-items-center">
                                <div class="ContactImageDiv">
                                    <img src="Assets/Images/user.png" class="rounded-circle" alt="No image found">
                                </div>
                                <div class="contactDetails p-1 d-flex justify-content-between">
                                    <div class="contactUserName">User Name</div>
                                    <div class="contactUserEmail">User@ email</div>
                                    <div class="contactPhnNo">7822227364</div>
                                </div>
                                <div class="contactButtons d-flex justify-content-around ms-4">
                                    <button type="button" class="" data-bs-toggle="modal" data-bs-target="#modalEdit">EDIT</button>
                                    <button>DELETE</button>
                                    <button data-toggle="modal" data-target="#modalView">VIEW</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--- Modal Edit--->
                <div class="modal fade" id="modalEdit" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modalEditBox modal-content">
                            <div class="d-flex">
                                <div class="modalEditLeftBox bg-white p-5">
                                    <div class="modalEditHeading p-2 my-2 text-center">
                                        <span>CREATE  CONTACT<span>
                                    </div>
                                    <div class="modalEditSubHeading my-3">
                                        <span>Personal  Contact<span>
                                    </div>
                                    <div class="personalInfoDiv1 d-flex my-3">
                                        <div class="titleDiv">
                                            <span>Title*</span><br>
                                            <select class="selectTitle">
                                                <option value="selected"></option>
                                                <option value="selected">Favourites</option>
                                            </select>
                                        </div>
                                        <div class="firstNameDiv me-2">
                                            <span>First Name*</span>
                                            <input type="text" name="firstName" placeholder="Your First Name">
                                        </div>
                                        <div class="lastNameDiv ms-2">
                                            <span>Last Name*</span>
                                            <input type="text" name="lastName" placeholder="Your Last Name">
                                        </div>
                                    </div>
                                    <div class="personalInfoDiv2 d-flex my-3">
                                        <div class="genderDiv me-4">
                                            <span>Gender*</span><br>
                                            <select class="selectGender">
                                                <option value="selected"></option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                            </select>
                                        </div>
                                        <div class="dateOfBirthDiv">
                                            <span>Date of Birth*</span><br>
                                            <input type="date" name="dateOfBirth" placeholder="dd-mm-yyyy">
                                        </div>
                                    </div>
                                    <div class="personalInfoDiv3 my-3">
                                        <span>Upload Photo</span><br>
                                        <input type="file" name="contactImage" >
                                    </div>

                                    <div class="modalEditSubHeading my-3">
                                        <span>Contact Details<span>
                                    </div>
                                    <div class="contactInfoDiv1 d-flex my-3">
                                        <div>
                                            <span>Address*</span>
                                            <input type="text" name="address" placeholder="Your Address">
                                        </div>
                                        <div>
                                            <span>Street*</span>
                                            <input type="text" name="street" placeholder="Your Street">
                                        </div>
                                    </div>
                                    <div class="contactInfoDiv2 d-flex my-3">
                                        <div>
                                            <span>District*</span>
                                            <input type="text" name="district" placeholder="Your District">
                                        </div>
                                        <div>
                                            <span>State*</span>
                                            <input type="text" name="state" placeholder="Your State">
                                        </div>
                                    </div>
                                    <div class="contactInfoDiv3 d-flex my-3">
                                        <div>
                                            <span>Nationality*</span>
                                            <input type="text" name="natonality" placeholder="Your Country">
                                        </div>
                                        <div>
                                            <span>Pincode*</span>
                                            <input type="text" name="pincode" placeholder="Your Pincode">
                                        </div>
                                    </div>
                                    <div class="contactInfoDiv4 d-flex my-3">
                                        <div>
                                            <span>Email Id*</span>
                                            <input type="email" name="email" placeholder="Your Email Id">
                                        </div>
                                        <div>
                                            <span>Phone Number*</span>
                                            <input type="text" name="phoneno" placeholder="Your Phone Number">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="modalEditBtn" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="modalEditBtn">Save changes</button>
                                    </div>
                                </div>

                                <div class="modalEditRightBox ps-4 pt-5">
                                    <div class="userImageDiv border bg-white mt-5">
                                        <img src="Assets/Images/user.png" class="rounded-circle" alt="No image found">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--- Modal edit end --->   
            </form>
        </div>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>    
</html>