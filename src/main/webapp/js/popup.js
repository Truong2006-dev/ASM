// Đợi trang web load xong hoàn toàn mới chạy code
document.addEventListener('DOMContentLoaded', function () {
    
    // Lấy phần tử Modal theo ID
    const editModal = document.getElementById('editUserModal');

    if (editModal) {
        editModal.addEventListener('show.bs.modal', event => {
            
            // 1. Lấy nút bấm kích hoạt modal (nút Edit màu vàng)
            const button = event.relatedTarget;

            const id = button.getAttribute('data-id');
            const fullname = button.getAttribute('data-fullname');
            const email = button.getAttribute('data-email');
            
            // Chuyển chuỗi 'true'/'false' thành kiểu boolean thực sự
            const isAdmin = button.getAttribute('data-admin') === 'true'; 

            editModal.querySelector('#modalId').value = id;
            editModal.querySelector('#modalFullname').value = fullname;
            editModal.querySelector('#modalEmail').value = email;

            // 4. Xử lý Radio button (Admin/User)
            if (isAdmin) {
                editModal.querySelector('#roleAdmin').checked = true;
            } else {
                editModal.querySelector('#roleUser').checked = true;
            }
        });
    }
});