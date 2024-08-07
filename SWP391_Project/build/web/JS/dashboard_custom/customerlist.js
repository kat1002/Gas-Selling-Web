//#region Customer

var isUsernameValid = true;
var isPasswordValid = true;
var isGmailValid = true;
var isPhoneValid = true;

function openCustomerDetails(customerId) {
    $.ajax({
        url: 'userlist/handle',   // Update with your actual servlet URL
        type: 'GET',
        data: {action: 'customerDetails', customerId: customerId}, // Pass customerId and action
        dataType: 'json',
        success: function (response) {

            console.log(response);

            // Update Modal Fields
            $('#username').val(response.customer.username);
            $('#userId').val(response.customer.customerId); // Match with JSON key
            $('#firstName').val(response.customer.first_name); // Adjust these if different
            $('#lastName').val(response.customer.last_name);
            $('#email').val(response.customer.gmail);
            $('#phoneNumber').val(response.customer.phone_number);

            // Set Select Option based on Customer Type
            $('#customerType').val(response.customer.customerType);

            // Check/Uncheck Checkbox
            $('#receiveEmail').prop('checked', response.customer.receiveEmail === 1); // Assuming 1 means true

            // Update Address Fields
            $('#address1').val(response.customer.address_line1);
            $('#address2').val(response.customer.address_line2);
            $('#postalCode').val(response.customer.postal_code);
            $('#city').val(response.customer.city);

            // Show the Modal
            $('#customerDetailsModal').modal('show');
        },
        error: function (xhr, status, error) {
            console.error("Error fetching customer details:", error);
            // Add error handling here (e.g., show a message to the user)
        }
    });
}

function saveChangeDetails() {
// Attach submit event handler to the form
    $('#customerDetailsForm').submit(function (event) {
        event.preventDefault(); // Prevent default form submission

        // Collect updated customer data from the form
        const updatedCustomerData = {
            action: 'updateCustomer', // Indicate the action to the servlet
            customerId: $('#userId').val(),
            firstName: $('#firstName').val(),
            lastName: $('#lastName').val(),
            phoneNumber: $('#phoneNumber').val(),
            customerType: $('#customerType').val(),
            receiveEmail: $('#receiveEmail').is(':checked') ? 1 : 0, // Convert checkbox state to 1 or 0
            address1: $('#address1').val(),
            address2: $('#address2').val(),
            postalCode: $('#postalCode').val(),
            city: $('#city').val()
        };

        console.log('Updatedata:' + updatedCustomerData);

        // AJAX call to update the customer in the database
        $.ajax({
            url: 'userlist/handle',   // Update with your actual servlet URL
            type: 'POST',         // Use POST for updating data
            data: updatedCustomerData,
            dataType: 'json',
            success: function (response) {
                // Update the table to reflect the changes
                fetchCustomers();

                // Optionally, display a success message
                alert("Customer details updated successfully!");

                // Close the modal
                $('#customerDetailsModal').modal('hide');
            },
            error: function (xhr, status, error) {
                console.error("Error updating customer:", error);
                console.log(xhr.responseText)
                // Add error handling (e.g., show error message)
                alert("Failed to update customer. Please try again.");
            }
        });
    });
}


let currentPage = 1;
let total = 0;
let rowsPerPage = 10;
let searchType = 'customer_id';
let searchQuery = '';
let sortBy = 'customer_id';

document.addEventListener("DOMContentLoaded", function () {
    fetchCustomers();
});

function fetchCustomers() {
    console.log(currentPage + " " + $('#rowsPerPage').val() + " " + searchType + " " + searchQuery + " " + $('#sortBy').val());

    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {
            action: 'customerView',
            page: currentPage,
            rowsPerPage: $('#rowsPerPage').val(),
            searchType: searchType,
            searchQuery: searchQuery,
            sortBy: $('#sortBy').val()
        },
        dataType: 'json',
        success: function (data) {
            console.log(data);
            total = data.totalCustomers;
            populateCustomerTable(data.customers, currentPage, $('#rowsPerPage').val());
            updatePagination();
        },
        error: function (xhr, status, error) {
            console.error('Error fetching customer data:', error);
            console.log("Response Headers:", xhr.getAllResponseHeaders());
            console.log("Raw Response:", xhr.responseText);

            let errorMessage = "An error occurred while fetching customer data. Please try again later.";
            if (xhr.status === 404) {
                errorMessage = "Servlet not found. Please check the URL.";
            } else if (xhr.status === 500) {
                errorMessage = "Server error. Please try again or contact support.";
            }
        }
    });
}


function populateCustomerTable(customers, currentPage, rowsPerPage) {
    const tbody = document.querySelector('#customerTable tbody');
    tbody.innerHTML = '';

    customers.forEach((customer, index) => {
        const row = document.createElement('tr');
        const rowNumber = ((currentPage - 1) * rowsPerPage) + (index + 1);

        row.innerHTML = `
            <td>${rowNumber}</td>
            <td>${customer.customerId}</td>
            <td>${customer.username}</td>
            <td>${customer.gmail}</td>
            <td>${customer.phone_number}</td>
            <td>${customer.first_name}</td>
            <td>${customer.last_name}</td>
            <td class="no-print">
                <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#userDetailsModal" onclick="openCustomerDetails(${customer.customerId})">Details</button>
                <button type="button" class="btn btn-danger btn-sm" onclick="deleteCustomer(${customer.customerId})">Delete</button>
            </td>
        `;

        console.log(customer, rowNumber);

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
            fetchCustomers();
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
            fetchCustomers();
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
            fetchCustomers();
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
                fetchCustomers();
            }
        }
    });

    searchLi.appendChild(searchInput);
    pagination.appendChild(searchLi);
}


function searchCustomers() {
    searchQuery = document.getElementById('searchQuery').value;
    currentPage = 1;
    fetchCustomers();
}

function setSearchType(type) {
    searchType = type;
    fetchCustomers();
}

function deleteCustomer(customerId) {
    console.log('delete customer');

    $.ajax({
        url: 'userlist/handle',
        type: 'POST',
        data: {action: 'deleteCustomer', customerId: customerId},
        dataType: 'json',
        success: function (data) {

            // Refresh customer list
            fetchCustomers();

            // Display success message
            alert("Customer added successfully!");
        },
        error: function (xhr, status, error) {
            console.error('Error fetching all customer data:', error);
            alert('An error occurred while fetching all customer data. Please try again later.');
        }
    });
}

function getAllCustomers(callback) {
    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {action: 'customerViewAll'},
        dataType: 'json',
        success: function (data) {
            const customers = data.customers;
            callback(customers);
        },
        error: function (xhr, status, error) {
            console.error("Error delete customer:", error);
            console.log(xhr.responseText);
            alert("Failed to delete customer. Please try again.");
        }
    });
}

function exportAllDataToCSV() {
    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {action: 'customerViewAll'},
        dataType: 'json',
        success: function (data) {
            if (!data || !data.customers || data.customers.length === 0) {
                console.error('No data received from the server.');
                alert('No customer data available to export.');
                return;
            }

            const customers = data.customers;

            // Define all fields you want to include in the CSV export
            const fields = [
                {label: 'Customer ID', key: 'customerId'},
                {label: 'Username', key: 'username'},
                {label: 'Gmail', key: 'gmail'},
                {label: 'Phone Number', key: 'phone_number'},
                {label: 'First Name', key: 'first_name'},
                {label: 'Last Name', key: 'last_name'},
                {label: 'Address Line 1', key: 'address_line1'},
                {label: 'Address Line 2', key: 'address_line2'},
                {label: 'City', key: 'city'},
                {label: 'Postal Code', key: 'postal_code'},
                {label: 'Customer Type', key: 'customerType'}
                // Add more fields as needed
            ];

            // Prepare CSV header row
            let csvContent = '\uFEFF';
            csvContent += fields.map(field => field.label).join(',') + '\n';

            // Prepare CSV rows for each customer
            customers.forEach(customer => {
                const csvRow = fields.map(field => {
                    // Handle cases where field value might be empty or undefined
                    const value = customer[field.key] !== undefined ? `"${customer[field.key]}"` : '';
                    return value;
                }).join(',');
                csvContent += csvRow + '\n';
            });

            // Create Blob and initiate download
            const blob = new Blob([csvContent], {type: 'text/csv;charset=utf-8;'});
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'customers.csv';
            a.click();
            URL.revokeObjectURL(url);
        },
        error: function (xhr, status, error) {
            console.error('Error fetching all customer data:', error);
            alert('An error occurred while fetching all customer data. Please try again later.');
        }
    });
}

function printAllCustomerData() {
    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {action: 'customerViewAll'},
        dataType: 'json',
        success: function (data) {
            if (!data || !data.customers || data.customers.length === 0) {
                console.error('No data received from the server.');
                alert('No customer data available to print.');
                return;
            }

            const customers = data.customers;
            let printContent = `
                <style>
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        border: 1px solid #ccc;
                    }
                    th, td {
                        border: 1px solid #ccc;
                        padding: 8px;
                        text-align: left;
                        min-width: 100px; /* Adjust as needed */
                        word-wrap: break-word; /* Wrap long words */
                    }
                    th {
                        background-color: #f2f2f2;
                    }
                    h1 {
                        text-align: center;
                    }
                </style>
                <h1>Customer Data</h1>
                <table>
                    <thead>
                        <tr>
                            ${Object.keys(customers[0]).map(key => `<th>${key}</th>`).join('')}
                        </tr>
                    </thead>
                    <tbody>
                        ${customers.map(customer => `
                            <tr>
                                ${Object.keys(customers[0]).map(key => `<td>${customer[key] !== undefined ? customer[key] : ''}</td>`).join('')}
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            `;

            // Open a new window and write the customer data to it
            const printWindow = window.open('', '_blank');
            printWindow.document.open();
            printWindow.document.write(printContent);
            printWindow.document.close();

            // Print the window content
            printWindow.print();
            printWindow.close();
        },
        error: function (xhr, status, error) {
            console.error('Error fetching all customer data:', error);
            alert('An error occurred while fetching all customer data. Please try again later.');
        }
    });
}

function shareAllCustomerData() {
    $.ajax({
        url: 'userlist/handle',
        type: 'GET',
        data: {action: 'customerViewAll'},
        dataType: 'json',
        success: function (data) {
            if (!data || !data.customers || data.customers.length === 0) {
                console.error('No data received from the server.');
                alert('No customer data available to share.');
                return;
            }

            const customers = data.customers;

            // Prepare CSV header with all available fields
            let csvContent = '';
            if (customers.length > 0) {
                const fields = Object.keys(customers[0]);
                csvContent = fields.map(field => `"${field}"`).join(',') + '\n';
            }

            // Add data rows
            customers.forEach(customer => {
                const csvRow = Object.values(customer).map(value => value !== undefined ? `"${value}"` : '""').join(',');
                csvContent += csvRow + '\n';
            });

            // Create Blob and File
            const blob = new Blob([csvContent], {type: 'text/csv;charset=utf-8;'});
            const file = new File([blob], 'customers.csv', {type: 'text/csv'});

            // Check if Web Share API is supported
            if (navigator.canShare && navigator.canShare({files: [file]})) {
                navigator.share({
                    files: [file],
                    title: 'Customer Data',
                    text: 'Here is the customer data you requested.'
                }).then(() => {
                    console.log('Share was successful.');
                }).catch(error => {
                    console.error('Sharing failed', error);
                    alert('Failed to share customer data.');
                });
            } else {
                alert('Your browser does not support the Web Share API.');
            }
        },
        error: function (xhr, status, error) {
            console.error('Error fetching all customer data:', error);
            alert('An error occurred while fetching all customer data. Please try again later.');
        }
    });
}


function addNewCustomer() {
    $('#addCustomerForm').submit(function(event) {
        event.preventDefault(); // Prevent default form submission

        if(!isUsernameValid){
            console.error("`Invalid Username`");
            alert("Invalid Username");
            return;
        }

        if(!isPasswordValid) {
            console.error("Invalid Password");
            alert("Invalid Password");
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

        const newCustomerData = {
            action: 'addCustomer', // Indicate the action to the servlet
            username: $('#newUsername').val(),
            password: $('#newPassword').val(),
            firstName: $('#newFirstName').val(),
            lastName: $('#newLastName').val(),
            email: $('#newEmail').val(),
            phoneNumber: $('#newPhoneNumber').val(),
            customerType: $('#newCustomerType').val(),
            address1: $('#newAddress1').val(),
            address2: $('#newAddress2').val(),
            postalCode: $('#newPostalCode').val(),
            city: $('#newCity').val()
        };

        console.log(newCustomerData);

        $.ajax({
            url: 'userlist/handle', // Update with your actual servlet URL
            type: 'POST',
            data: newCustomerData,
            dataType: 'json',
            success: function(response) {
                // Refresh customer list
                fetchCustomers();

                // Display success message
                alert("Customer added successfully!");

                // Close the modal
                $('#addCustomerModal').modal('hide');
            },
            error: function(xhr, status, error) {
                console.error("Error adding customer:", error);
                console.log(xhr.responseText);
                alert("Failed to add customer. Please try again.");
            }
        });
    });
}

function openAddCustomerForm() {
    console.log("openAddCustomerForm");
    // Show the modal
    $('#addCustomerModal').modal('show');
}

function checkUsernameValid() {
    // Perform AJAX request to check for username uniqueness
    $.ajax({
        url: 'userlist/handle', // Update with your actual servlet URL
        type: 'POST',
        data: {
            action: 'usernameCheckCustomer',
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
            action: 'gmailCheckCustomer',
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