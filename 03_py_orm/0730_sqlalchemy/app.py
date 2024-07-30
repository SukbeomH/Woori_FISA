from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, sessionmaker, declarative_base

# 데이터베이스 연결 설정
engine = create_engine("mysql+pymysql://root:@localhost/fisa_erd")
Base = declarative_base()


# 테이블 정의
class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True)
    name = Column(String(50))
    posts = relationship("Post", back_populates="user")


class Post(Base):
    __tablename__ = "posts"
    id = Column(Integer, primary_key=True)
    title = Column(String(100))
    user_id = Column(Integer, ForeignKey("users.id"))
    user = relationship("User", back_populates="posts")


# 데이터베이스에 테이블 생성
Base.metadata.create_all(engine)

# 세션 생성
Session = sessionmaker(bind=engine)
session = Session()

# 데이터 삽입 예제
new_user = User(name="John Doe")
session.add(new_user)

session.commit()

# 데이터 조회 예제
users = session.query(User).all()
for user in users:
    # print(user.name)
    pass

# 연결 종료
session.close()
