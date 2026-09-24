# Phân tích EXPLAIN trước và sau tối ưu

Truy vấn ban đầu sử dụng YEAR(created_at) và MONTH(created_at)
trong mệnh đề WHERE. Đây là dạng điều kiện Non-SARGable vì cột
created_at bị bao quanh bởi các hàm. Điều này làm giảm khả năng
tận dụng B-Tree Index để xác định trực tiếp khoảng dữ liệu cần tìm.

Trước khi tối ưu, EXPLAIN có thể cho thấy type = ALL, nghĩa là
MySQL phải quét nhiều hoặc toàn bộ các dòng của bảng Transactions.

Giải pháp là tạo Composite Index:

CREATE INDEX idx_type_date
ON Transactions(transaction_type, created_at);

Sau đó truy vấn được viết lại bằng điều kiện khoảng:

created_at >= '2026-06-01 00:00:00'
AND created_at < '2026-07-01 00:00:00'

Điều kiện mới là SARGable. Với lượng dữ liệu đủ lớn, MySQL có thể
sử dụng idx_type_date và chọn access type như range, từ đó giảm số
dòng cần kiểm tra và cải thiện thời gian xử lý báo cáo.
