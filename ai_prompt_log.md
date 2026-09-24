# AI Prompt Log

## Prompt 1

Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng nhưng trong
WHERE lại sử dụng YEAR(created_at), tại sao Index có thể không được
sử dụng hiệu quả?

## Kiến thức thu được

Việc bao cột bằng hàm có thể khiến điều kiện trở thành Non-SARGable.
MySQL không thể dùng trực tiếp thứ tự của B-Tree Index để xác định
khoảng thời gian cần tìm như khi dùng >= và <.


## Prompt 2

SARGable trong SQL là gì?

## Kiến thức thu được

SARGable là điều kiện tìm kiếm được viết theo cách cho phép hệ quản
trị cơ sở dữ liệu tận dụng Index hiệu quả.


## Prompt 3

Tại sao Composite Index cho truy vấn này được thiết kế theo thứ tự
(transaction_type, created_at)?

## Kiến thức thu được

Truy vấn sử dụng điều kiện equality trên transaction_type và range
trên created_at. Thứ tự này phù hợp với cách sử dụng Composite
B-Tree Index.


## Prompt 4

Index Seek khác Index Scan như thế nào?

## Kiến thức thu được

Index Seek chỉ truy cập vùng Index phù hợp với điều kiện tìm kiếm,
trong khi Index Scan phải đọc một phần lớn hoặc toàn bộ Index.


## Prompt 5

Using index condition khác Using index trong EXPLAIN như thế nào?

## Kiến thức thu được

Using index condition thường liên quan đến Index Condition Pushdown,
trong đó MySQL lọc điều kiện tại tầng Index trước khi đọc đầy đủ
dòng dữ liệu.

Using index thường cho biết truy vấn có thể lấy dữ liệu cần thiết
trực tiếp từ Index, tức Index có khả năng đóng vai trò Covering Index.
