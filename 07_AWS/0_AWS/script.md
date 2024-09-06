1.  VPC 생성
    MY-NAME-PRD-VPC : 10.250.0.0/16 (65,563)

2.  Subnet 생성

    1. AZ : 2A
       MY-NAME-PRD-VPC-Docker-PUB-2A (10.250.4.0/24) - 251 MY-NAME-PRD-VPC-Docker-PUB-SG-2A (80,443)

    ### ec2 name: MY-NAME-PRD-VPC-Docker-PUB-2A : 10.250.4.107

    MY-NAME-PRD-VPC-DJANGO-PRI-2A (10.250.2.0/24) - 251 MY-NAME-PRD-VPC-DJANGO-PRI-SG-2A

    ### ec2 name: MY-NAME-PRD-VPC-DJANGO-PRI-2A : 10.250.2.115

2)  AZ : 2C

    MY-NAME-PRD-VPC-DJANGO-PRI-2C (10.250.12.0/24) - 251 MY-NAME-PRD-VPC-DJANGO-PRI-SG-2C

    ### ec2 name: MY-NAME-PRD-VPC-DJANGO-PRI-2C : 10.250.12.254

3.  Routing 테이블 생성

    MY-NAME-PRD-RT-PUB-2A MY-NAME-PRD-RT-PUB
    MY-NAME-PRD-RT-PRI-2A MY-NAME-PRD-RT-PRI
    MY-NAME-PRD-RT-PRI-2C

4.  Internet Gateway 생성  
    (Pubic Subnet에 있는 인스턴스가 인터넷을 사용할 수 있도록 해주기 위함)
    MY-NAME-PRD-IGW

5.  NAT GATEWAY 생성  
    (Private Subnet에 있는 인스턴스가 인터넷을 사용할 수 있도록 해주기 위함)
    (연결유형 Public / 탄력적 IP 부여하고 PUB SUBNET에 붙입니다)
    MY-NAME-PRD-NGW-2A -- 우리 실습환경

    # 우리는 만들지 않음. MY-NAME-PRD-NGW-2C -- 이중화를 위해 구성하는 것을 권고함.

6.  KeyPair 이름 : 본인키페어.pem

7.  Linux 연결사용자계정 : ubuntu 패스워드는 없음.
    EC2 2개 IP (DJANGO)

8.  ALB Security Name(보안그룹) : MY-NAME-PRD-ALB-SG (80,443)

9.  Target Group(대상 그룹, EC2로 이동 후 작업) : MY-NAME-PRD-ALB-TG

10. ALB Name : MY-NAME-PRD-ALB

11. Autoscaling Name : MY-NAME-PRD-NGINX-Auto

12. 시작템플릿 이름 : MY-NAME-PRD-NGINX-TEMP
