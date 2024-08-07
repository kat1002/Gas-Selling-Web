/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function validateDiscountValue() {
        var discountValue = document.getElementById('discountValue').value;
        if (discountValue > 1) {
            alert("Discount value must be between 0 and 1.");
            return false;
        }
        return true;
    }

function doDeleteDiscount(discountId, discountTitle) {
    // Confirm the deletion
    if (confirm("Are you sure you want to delete the discount: " + discountTitle + " ?")) {
        // Find and submit the specific form for this discountId
        document.getElementById("deleteForm" + discountId).submit();
    }
}

function submitForm(formId) {
    var form = document.getElementById(formId);
    // Thực hiện xử lý dữ liệu ở đây (nếu cần)
    form.submit(); // Gửi form đi
}

function openAddDiscountForm() {
    console.log("openAddDiscountForm");
    // Show the modal
    $('#addDiscountModal').modal('show');
}

function closeAddDiscountForm() {
    $('#addDiscountModal').modal('hide');
}

function fetchDiscount(discountId) {
    $.ajax({
        url: 'editdiscount',
        method: 'GET',
        data: {id: discountId},
        success: function (response) {
            if (response) {
                $('#editDiscountId').val(response.discount.discountId);
                $('#editDiscountTitle').val(response.discount.title);
                $('#editDiscountDescription').val(response.discount.description);
                $('#editDiscountValue').val(response.discount.discountValue);
                $('#editDiscountProductId').val(response.discount.productId);

                $('#editDiscountModal').modal('show');
            } else {
                // Handle error or empty response
                console.error('Error fetching discount details');
            }
        },
        error: function (xhr, status, error) {
            // Handle AJAX error
            console.error('Error fetching discount details:', error);
        }
    });
}


function openEditDiscountModal(id, title, description, discountValue, productId) {
    // Mở modal
    $('#editDiscountModal').modal('show');

    // Giải mã description trước khi in vào form
    description = unescape(description);

    // In thông tin discount vào form
    $('#editDiscountId').val(id);
    $('#editDiscountTitle').val(title);
    $('#editDiscountDescription').val(description);
    $('#editDiscountValue').val(discountValue);

    if (productId === 'None') {
        productId = 0;
    }

    $('select[name="pid"]').val(productId); // Chọn option trong dropdown sản phẩm
}

function closeEditDiscountForm() {
    $('#editDiscountModal').modal('hide');
}