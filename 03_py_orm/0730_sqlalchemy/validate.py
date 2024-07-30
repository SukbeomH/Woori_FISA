import pymysql

# 데이터베이스 연결 설정
connection = pymysql.connect(
    host="localhost", user="root", password="", database="fisa_erd"
)

# 커서 생성
cursor = connection.cursor()

# 테이블 및 칼럼 정보 조회
cursor.execute("SHOW TABLES")
tables = cursor.fetchall()

expected_schema = {"users": ["id", "name"], "posts": ["id", "title", "user_id"]}

errors = []

for table in tables:
    table_name = table[0]
    cursor.execute(f"DESCRIBE {table_name}")
    columns = cursor.fetchall()
    column_names = [column[0] for column in columns]

    if table_name not in expected_schema:
        errors.append(f"Unexpected table {table_name}")
    else:
        for expected_column in expected_schema[table_name]:
            if expected_column not in column_names:
                errors.append(f"Missing column {expected_column} in table {table_name}")

if errors:
    for error in errors:
        print(error)
else:
    print("Schema is correct")

# 연결 종료
cursor.close()
connection.close()
