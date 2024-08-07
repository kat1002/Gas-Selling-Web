//#region Manager

var isUsernameValid = true;
var isPasswordValid = true;
var isGmailValid = true;
var isPhoneValid = true;


function openManagerDetails(managerId) {
    $.ajax({
        url: 'userlist/handle',   // Update with your actual servlet URL
        type: 'GET',
        data: { action: 'managerDetails', managerId: managerId }, // Pass managerId and action
        dataType: 'json',
        success: function (response) {

            console.log(response);

            // Update Modal Fields
            $('#username').val(response.manager.username);
            $('#managerId').val(response.manager.managerId); // Match with JSON key
            $('#firstName').val(response.manager.first_name); // Adjust these if different
            $('#lastName').val(response.manager.last_name);
            $('#email').val(response.manager.email);
            $('#phoneNumber').val(response.manager.phone_number);

            // Set Select Option based on Manager Role
            $('#role').val(response.manager.role);

            // Show the Modal
            $('#managerDetailsModal').modal('show');
        },
        error: function (xhr, status, error) {
            console.error("Error fetching manager details:", error);
            // Add error handling here (e.g., show a message to the user)
        }
    });
}

function saveManagerDetails() {
    // Attach submit event handler to the form
    $('#managerDetailsForm').submit(function (event) {
        event.preventDefault(); // Prevent default form submission

        // Collect updated manager data from the form
        const updatedManagerData = {
            action: 'updateManager', // Indicate the action to the servlet
            managerId: $('#managerId').val(),
            firstName: $('#firstName').val(),
            lastName: $('#lastName').val(),
            role: $('#role').val(),
            email: $('#email').val(),
            phoneNumber: $('#phoneNumber').val()
        };

        console.log(updatedManagerData);

        // AJAX call to update the manager in the database
        $.ajax({
            url: 'userlist/handle',   // Update with your actual servlet URL
            type: 'POST',         // Use POST for updating data
            data: updatedManagerData,
            dataType: 'json',
            success: function (response) {
                // Update the table to reflect the changes
                fetchManagers();

                // Optionally, display a success message
                alert("Manager details updated successfully!");

                // Close the modal
                $('#managerDetailsModal').modal('hide');
            },
            error: function (xhr, status, error) {
                console.error("Error updating manager:", error);
                console.log(xhr.responseText)
                // Add error handling (e.g., show error message)
                alert("Failed to update manager. Please try again.");
            }
        });
    });
}

let currentPage = 1;
let total = 0;
let rowsPerPage = 10;
let searchType = 'manager_id';
let searchQuery = '';
let sortBy = 'manager_id';

document.addEventListener("DOMContentLoaded", function () {
    fetchManagers();
});

function fetchManagers() {

    console.log(currentPage + " " + $('#rowsPerPage').val() + " " + searchType + " " + searchQuery + " " + sortBy);

    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {
            action: 'managerView',
            page: currentPage,
            rowsPerPage: $('#rowsPerPage').val(),
            searchType: searchType,
            searchQuery: searchQuery,
            sortBy: $('#sortBy').val()
        },
        dataType: 'json',
        success: function (data) {
            console.log(data);
            total = data.totalManagers;
            populateManagerTable(data.managers);
            updatePagination();
        },
        error: function (xhr, status, error) {
            console.error('Error fetching manager data:', error);
            console.log("Response Headers:", xhr.getAllResponseHeaders());
            console.log("Raw Response:", xhr.responseText);

            let errorMessage = "An error occurred while fetching manager data. Please try again later.";
            if (xhr.status === 404) {
                errorMessage = "Servlet not found. Please check the URL.";
            } else if (xhr.status === 500) {
                errorMessage = "Server error. Please try again or contact support.";
            }
        }
    });
}

function populateManagerTable(managers) {
    const tbody = document.querySelector('#managerTable tbody');
    tbody.innerHTML = '';

    managers.forEach(manager => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td>${manager.managerId}</td>
            <td>${manager.username}</td>
            <td>${manager.role}</td>
            <td>${manager.email}</td>
            <td>${manager.phone_number}</td>
            <td>${manager.first_name}</td>
            <td>${manager.last_name}</td>
            <td>
                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#managerDetailsModal" onclick="openManagerDetails(${manager.managerId})">Details</button>
                <button type="button" class="btn btn-danger btn-sm" onclick="deleteManager(${manager.managerId})">Delete</button>
            </td>
        `;

        tbody.appendChild(row);
    });
}

function updatePagination() {
    const totalPages = Math.ceil(total / rowsPerPage);
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = '';

    // Calculate start and end of visible page links
    let startPage = Math.max(1, currentPage - 3);
    let endPage = Math.min(totalPages, currentPage + 3);

    // Adjust start and end to show exactly 7 pages if possible
    if (endPage - startPage + 1 <= 7) {
        if (startPage === 1) {
            endPage = Math.min(totalPages, startPage + 6);
        } else if (endPage === totalPages) {
            startPage = Math.max(1, endPage - 6);
        }
    }

    // Previous Button
    const prevLi = document.createElement('li');
    prevLi.classList.add('page-item');
    if (currentPage === 1) {
        prevLi.classList.add('disabled');
    } else {
        const prevLink = document.createElement('a');
        prevLink.classList.add('page-link');
        prevLink.href = '#';
        prevLink.textContent = 'Previous';
        prevLink.addEventListener('click', (e) => {
            e.preventDefault();
            currentPage--;
            fetchManagers();
        });
        prevLi.appendChild(prevLink);
    }
    pagination.appendChild(prevLi);

    // Numbered Pages
    for (let i = startPage; i <= endPage; i++) {
        const li = document.createElement('li');
        li.classList.add('page-item');
        if (i === currentPage) li.classList.add('active');

        const a = document.createElement('a');
        a.classList.add('page-link');
        a.href = '#';
        a.textContent = i;
        a.addEventListener('click', (e) => {
            e.preventDefault();
            currentPage = i;
            fetchManagers();
        });

        li.appendChild(a);
        pagination.appendChild(li);
    }

    // Next Button
    const nextLi = document.createElement('li');
    nextLi.classList.add('page-item');
    if (currentPage === totalPages || totalPages === 0) {
        nextLi.classList.add('disabled');
    } else {
        const nextLink = document.createElement('a');
        nextLink.classList.add('page-link');
        nextLink.href = '#';
        nextLink.textContent = 'Next';
        nextLink.addEventListener('click', (e) => {
            e.preventDefault();
            currentPage++;
            fetchManagers();
        });
        nextLi.appendChild(nextLink);
    }
    pagination.appendChild(nextLi);

    // Search Page Input
    const searchLi = document.createElement('li');
    searchLi.classList.add('page-item');

    const searchInput = document.createElement('input');
    searchInput.classList.add('form-control', 'page-link');
    searchInput.type = 'number';
    searchInput.min = 1;
    searchInput.max = totalPages;
    searchInput.value = currentPage;
    searchInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            let page = parseInt(searchInput.value);
            if (!isNaN(page) && page >= 1 && page <= totalPages) {
                currentPage = page;
                fetchManagers();
            }
        }
    });

    searchLi.appendChild(searchInput);
    pagination.appendChild(searchLi);
}

function searchManagers() {
    searchQuery = document.getElementById('searchQuery').value;
    currentPage = 1;
    fetchManagers();
}

function setSearchType(type) {
    searchType = type;
}

function deleteManager(managerId) {
    if (confirm("Are you sure you want to delete this manager?")) {
        $.ajax({
            url: 'userlist/handle',
            type: 'POST',
            data: { action: 'deleteManager', managerId: managerId },
            success: function (response) {
                // Refresh the manager list after deletion
                fetchManagers();
            },
            error: function (xhr, status, error) {
                console.error("Error deleting manager:", error);
                alert("Failed to delete manager. Please try again.");
            }
        });
    }
}

function addNewManager() {
    $('#addManagerForm').submit(function(event) {
        event.preventDefault(); // Prevent default form submission

        if(!isUsernameValid){
            console.error("`Invalid Username`");
            alert("Invalid Username");
            return;
        }

        if(!isGmailValid) {
            console.error("Invalid Email");
            alert("Invalid Email");
            return;
        }

        if(!isPhoneValid) {
            console.error("Invalid Phone");
            alert("Invalid Phone");
            return;
        }

        const newManagerData = {
            action: 'addManager', // Indicate the action to the servlet
            username: $('#newUsername').val(),
            password: $('#newPassword').val(),
            firstName: $('#newFirstName').val(),
            lastName: $('#newLastName').val(),
            email: $('#newEmail').val(),
            phoneNumber: $('#newPhoneNumber').val(),
            role: $('#newRole').val()
        };

        console.log(newManagerData);

        $.ajax({
            url: 'userlist/handle', // Update with your actual servlet URL
            type: 'POST',
            data: newManagerData,
            dataType: 'json',
            success: function(response) {
                // Refresh Manager list
                fetchManagers();

                // Display success message
                alert("Manager added successfully!");

                // Close the modal
                $('#addManagerModal').modal('hide');
            },
            error: function(xhr, status, error) {
                console.error("Error adding Manager:", error);
                console.log(xhr.responseText);
                alert("Failed to add Manager. Please try again.");
            }
        });
    });
}

function openAddManagerForm() {
    console.log("openAddManagerForm");
    // Show the modal
    $('#addManagerModal').modal('show');
}

function checkUsernameValid() {
    // Perform AJAX request to check for username uniqueness
    $.ajax({
        url: 'userlist/handle', // Update with your actual servlet URL
        type: 'POST',
        data: {
            action: 'usernameCheckManager',
            username: $('#newUsername').val()
        },
        dataType: 'json',
        success: function(response) {
            let messageElement = $('#usernameMessage');
            if (response.usernameStatus === 'available') {
                isUsernameValid = true;
                messageElement.text(response.usernameMessage).css('color', 'green');
            } else if (response.usernameStatus === 'taken') {
                isUsernameValid = false;
                messageElement.text(response.usernameMessage).css('color', 'red');
            } else if (response.usernameStatus === 'invalid') {
                isUsernameValid = false;
                messageElement.text(response.usernameMessage).css('color', 'red');
            } else if (response.usernameStatus === 'error') {
                isUsernameValid = false;
                messageElement.text('An error occurred: ' + response.usernameMessage).css('color', 'orange');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error checking uniqueness:", error);
            console.log(xhr.responseText);
            alert("Failed to check uniqueness. Please try again.");
        }
    });
}

function checkPasswordValid() {

    // Perform AJAX request to check for password validity
    $.ajax({
        url: 'userlist/handle', // Update with your actual servlet URL
        type: 'POST',
        data: {
            action: 'passwordCheck',
            password: $('#newPassword').val()
        },
        dataType: 'json',
        success: function(response) {
            let messageElement = $('#passwordMessage');
            if (response.passwordStatus === 'success') {
                isPasswordValid = true;
                messageElement.text(response.passwordMessage).css('color', 'green');
            } else if (response.passwordStatus === 'failure') {
                isPasswordValid = false;
                messageElement.text(response.passwordMessage).css('color', 'red');
            } else if (response.passwordStatus === 'error') {
                isPasswordValid = false;
                messageElement.text('An error occurred: ' + response.passwordMessage).css('color', 'orange');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error checking password validity:", error);
            console.log(xhr.responseText);
            alert("Failed to check password validity. Please try again.");
        }
    });
}

function checkGmailValid() {

    //console.log($('#newEmail').val().trim());

    // Perform AJAX request to check Gmail validity
    $.ajax({
        url: 'userlist/handle', // Update with your actual servlet URL
        type: 'POST',
        data: {
            action: 'gmailCheckManager',
            email: $('#newEmail').val().trim()
        },
        dataType: 'json',
        success: function(response) {
            // Select the message element
            let messageElement = $('#gmailMessage');

            // Handle different response statuses
            if (response.gmailStatus === 'success') {
                isGmailValid = true;
                messageElement.text(response.gmailMessage).css('color', 'green');
            } else if (response.gmailStatus === 'failure') {
                isGmailValid = false;
                messageElement.text(response.gmailMessage).css('color', 'red');
            } else if (response.gmailStatus === 'error') {
                isGmailValid  = false;
                messageElement.text('An error occurred: ' + response.gmailMessage).css('color', 'orange');
            }
        },
        error: function(xhr, status, error) {
            // Log and alert the error
            console.error("Error checking Gmail validity:", error);
            console.log(xhr.responseText);
            alert("Failed to check Gmail validity. Please try again.");
        }
    });
}

function checkPhoneValid(){
    // Perform AJAX request to check for username, email, and phone number uniqueness
    $.ajax({
        url: 'userlist/handle', // Update with your actual servlet URL
        type: 'POST',
        data: {
            action: 'phoneCheck',
            phone: $('#newPhoneNumber').val()
        },
        dataType: 'json',
        success: function(response) {
            // Select the message element
            let messageElement = $('#phoneMessage');

            // Handle different response statuses
            if (response.phoneStatus === 'success') {
                isPhoneValid = true;
                messageElement.text(response.phoneMessage).css('color', 'green');
            } else if (response.phoneStatus === 'failure') {
                isPhoneValid = false;
                messageElement.text(response.phoneMessage).css('color', 'red');
            } else if (response.phoneStatus === 'error') {
                isPhoneValid = false;
                messageElement.text('An error occurred: ' + response.phoneMessage).css('color', 'orange');
            }
        },
        error: function(xhr, status, error) {
            console.error("Error checking uniqueness:", error);
            console.log(xhr.responseText);
            alert("Failed to check uniqueness. Please try again.");
        }
    });
}

function togglePasswordVisibility() {
    var passwordField = document.getElementById('newPassword');
    var eyeIcon = document.getElementById('togglePasswordVisibility');
    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        eyeIcon.classList.remove('mdi-eye');
        eyeIcon.classList.add('mdi-eye-off');
    } else {
        passwordField.type = 'password';
        eyeIcon.classList.remove('mdi-eye-off');
        eyeIcon.classList.add('mdi-eye');
    }
}

//#endregion
