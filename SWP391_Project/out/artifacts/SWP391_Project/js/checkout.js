//#region Checkout Form Functions

let cartData = null; // Initialize cartData variable

// Function to handle checkout process
function checkout() {
    // Gather user details from form
    const userDetails = {
        firstName: $('#firstName').val(),
        lastName: $('#lastName').val(),
        email: $('#email').val(),
        phoneNumber: $('#phone_number').val(),
        addressLine1: $('#address_line1').val(),
        addressLine2: $('#address_line2').val(),
        city: $('#city').val(),
        postalCode: $('#zip').val()
    };

    // Combine user details and cart data into formData
    const formData = {
        action: 'checkout',
        userDetails: JSON.stringify(userDetails),
        cartData: JSON.stringify(cartData),
    };

    console.log(formData);

    $.ajax({
        url: 'checkout/handle', // Update with your endpoint URL
        method: 'POST',
        dataType: 'json',
        data: formData, // Convert formData to JSON string
        success: function (response) {

            console.log(response)

            if (response.success) {
                alert('Checkout successful');
                // Optionally redirect to a confirmation page or update UI
            } else {
                alert('Checkout failed: ' + response.message);
            }
        },
        error: function () {
            alert('Error during checkout. Please try again.');
        }
    });
}

//#endregion

//#region Fetch User Details and Cart Details

$(document).ready(function () {
    // Function to fetch user details via AJAX on page load
    function fetchUserDetails() {
        $.ajax({
            url: 'checkout/handle',
            method: 'GET',
            data: { action: 'getUserDetails' },
            dataType: 'json',
            success: function (response) {

                console.log(response)

                // Populate form fields with retrieved data
                $('#firstName').val(response.userDetails.first_name);
                $('#lastName').val(response.userDetails.last_name);
                $('#email').val(response.userDetails.gmail);
                $('#phone_number').val(response.userDetails.phone_number);
                $('#address_line1').val(response.userDetails.address_line1);
                $('#address_line2').val(response.userDetails.address_line2);
                $('#city').val(response.userDetails.city);
                $('#zip').val(response.userDetails.postal_code); // Assuming response includes postalCode
            },
            error: function () {
                alert('Failed to fetch user details.');
            }
        });
    }

    // Function to fetch and display cart details via AJAX on page load
    function fetchCartDetails() {
        $.ajax({
            url: 'checkout/handle', // Replace with your actual servlet URL for cart details
            method: 'GET',
            data: {action : 'getCartDetails'},
            dataType: 'json',
            success: function (response) {
                cartData = response;
                updateCartSection(response); // Update cart details on success
            },
            error: function () {
                alert('Failed to fetch cart details.');
            }
        });
    }

    // Initial fetch of user details and cart details on page load
    fetchUserDetails();
    fetchCartDetails();

    // Function to update the cart section with fetched data
    function updateCartSection(cartData) {
        $('#cartItemCount').text(cartData.count); // Update cart count badge

        // Clear existing product list items
        $('#cartItemList').empty();

        // Populate product list items
        cartData.productList.forEach(function(product) {
            var formattedPrice = product.totalPrice.toFixed(2);
            var listItem = `
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <small class="text-muted">${product.quantity}x ${product.title}</small>
                    </div>
                    <span class="text-muted">$${formattedPrice}</span>
                </li>`;
            $('#cartItemList').append(listItem);
        });

        // Update voucher code section if applicable
        if (cartData.voucherCode) {
            $('#voucherDetails').show();
            $('#voucherCode').text(cartData.voucherCode);
            $('#discountValue').text(`-$${cartData.discountValue.toFixed(2)}`);
        } else {
            $('#voucherDetails').hide();
            $('#voucherCode').text('');
            $('#discountValue').text('');
        }

        // Update total amount
        $('#totalValue').text(`$${cartData.total.toFixed(2)}`);
    }

    // Function to handle promo code redemption
    function redeemPromoCode(event) {
        event.preventDefault();
        var promoCode = $('#promo-code').val().trim();
        if (promoCode === '') {
            alert('Please enter a promo code.');
            return;
        }
        // Implement AJAX request to redeem promo code
        $.ajax({
            url: 'checkout/handle', // Replace with your servlet URL
            method: 'POST',
            data: { action: 'redeemPromoCode', promoCode: promoCode },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    alert('Promo code redeemed successfully.');
                    fetchCartDetails(); // Refresh cart details after redemption
                } else {
                    alert('Failed to redeem promo code: ' + response.message);
                }
            },
            error: function() {
                alert('Error redeeming promo code.');
            }
        });
    }
});

//#endregion
