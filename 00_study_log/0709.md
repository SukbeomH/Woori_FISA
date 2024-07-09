# 2일차 Scribble

## ! (셸 커맨드)
- 셸(Shell)에서 실행되며, 따라서 리눅스 기반의 명령어들을 사용할 수 있습니다.
- 셸 커맨드를 사용하여 파일 시스템 탐색, 외부 패키지 설치 등의 작업을 할 수 있습니다.
  ```python
  !python --help
  ```

  **이거 처음봄;;**

---

## PEP: Python Enhancement Proposals

### Whitespace

- 다른 언어들은 들여쓰기를 중요하게 여기지 않습니다.
    
  - 가. 들여쓰기는 4칸이 기본 << 가독성은 중요하다
    
  - 나. Tab or **Space**
    
    - 스페이스를 사용하는 것이 권장됩니다. 하나의 프로젝트에 탭과 스페이스를 섞어서 쓰는 일은 피해야 합니다.
    
  - 다. 한 줄의 코드 길이가 **79자 이하**여야 합니다.
    
- 코드가 길어지는 경우 백슬러시(\)를 이용해서 줄바꿈을 하면 됩니다.
    
  ```python
  with open('/path/to/some/file/you/want/to/read') as file_1, \
        open('/path/to/some/file/being/written() 'w') as file_2:
      file_2.write(file_1.read())
  ```
    
- 특별히 연산자들로 인해 길게 늘어지는 경우, 연산자 이전에 줄바꿈하는 것이 좋습니다.
    
  ```python
  income = (gross_wages 
            + taxable_interest
            + (dividends - qualified_dividends)
            - ira_deduction
            - student_loan_interest)
  ```
    
  - 라. 함수와 클래스는 다른 코드와 **빈 줄 두개**로 구분합니다.
    
    ```python
    class a():
        pass
    		
    
    class b():
        pass
    
    def c():
        pass
    # 빈줄
    # 빈줄
    
    ```
    
  - 마. 클래스에서 함수는 빈 줄 하나로 구분합니다.
    
    ```python
    class a():
    
        def b():
            pass
    
        def c():
            pass
    ```
    
### 이름 규칙
    
-  가. 변수명 앞에 **_(밑줄)**이 붙으면 함수 등의 내부에서만 사용되는 변수를 일컫습니다.
    
  ```python
  _my_list = []
  ```
    
- **나. 변수명 뒤에 _(밑줄) 이 붙으면 라이브러리 혹은 파이썬 기본 키워드와의 충돌을 피하고 싶을 때 사용합니다.**
    
  ```python
  import_ = "not_import"
  ```
    
- 다. 모듈(Module)명은 짧은 소문자로 구성되며, 필요하다면 밑줄로 나눕니다.
    
  ```
  my_module.py
  ```
    
- 라. 클래스명은 **파스칼 케이스(Pascal Case) 컨벤션***으로 작성합니다.
    
  ```python
  class MyClass():
      pass
  ```
    
- 마. 함수명은 소문자로 구성하되 필요하면 밑줄로 나눕니다.
    
  ```python
  def my_function():
      pass
  ```
    
### Naming Convention
    
통일성을 갖기 위해서는 사람들이 공유하는 코딩 스타일 가이드를 가지고 있는 것이 좋습니다.
    
- **snake_case**
  - 모든 공백을 “_“로 바꾸고 모든 단어는 소문자입니다.
  - 파이썬에서는 함수, 변수 등을 명명할 때 사용합니다.
  - ex) this_is_snake_case
- **PascalCase**
  - 모든 단어가 대문자로 시작합니다.
  - UpperCamelCase, CapWords라고도 불립니다.
  - 파이썬에서는 클래스를 명명할 때 사용합니다.
  - ex) ThisIsPascalCase
- **camelCase**
  - 처음은 소문자로 시작하고 이후 모든 단어의 첫 글자는 대문자로 합니다.
  - 파이썬에서는 거의 사용하지 않습니다. (java 등에서 사용)
  - ex) thisCamelCase
- **kebab-case**
  - 케밥이 꼬챙이에 꽂힌 모습에서 유래한 방법
  - 주로 HTML에서 많이 사용
  - 소문자로 시작하며, 띄어쓰기는 - 로 대체합니다


---

## Colab or  Jupyter Functions

```
%%time
```

### %, %% : 매직커맨드

파이썬 코드는 아니나 코랩 환경 내에서 특정 기능을 실행하도록 설계된 명령어.  

-   '%' 또는 '%%' 기호를 사용하여 실행됩니다.
-   '%'는 한 줄에 대해 적용
-   '%%'는 셀 전체에 대해 적용됩니다.

## REPL(Read, Evaluation, Print, Loop)

인터프리터는 REPL 과정을 따라서 동작을 하게 된다.

-   **Read**: 입력된 명령어를 읽고
    -   이 과정에서 인터프리터가 번역을 합니다 => 기계어
    -   문자로 된 명령어를 숫자(기계어/binary)로 변환
-   **Evaluation**: 명령어를 실행
-   **Print**: 명령어를 실행한 결과를 **돌려줍니다**
-   **Loop**: 이 과정을 계속 반복할 수 있습니다

## CRLF
Enter를 누르면 줄바꿈이 되는데, 이때 줄바꿈을 표현하는 방식이 두 가지가 있다.

-   **CR(Carriage Return)**: 커서를 맨 앞으로 이동
-   **LF(Line Feed)**: 커서를 한 줄 아래로 이동

타자기를 사용하던 시절에 사용하던 방식이 내려오는 것

- Carriage Return은 타자기의 카트리지를 맨 앞으로 이동시키는 것
- Line Feed는 종이를 한 줄 아래로 이동시키는 것

윈도우는 CRLF를 사용하고, 리눅스는 LF를 사용한다.
**요즘은 LF 하나로만 표현하는게 추세**

## 빈 문자와 공백은 다른 문자 입니다.
- 공백도 문자입니다.
  - 공백을 쓴다라고 표현하지 않고, 띄어쓰기라고 표현
  - 사람은 대개 공백은 그냥 문자와 문자 사이의 공백 정도로 생각, 문자라고 인식하지는 않는데, 공백도 문자입니다.
  - 원고지처럼 공백도 한 문자로 취급합니다.
- 빈(empty) 문자도 문자입니다.
  - 빈 문자와 공백은 엄연히 다른 문자입니다.


## Swap & Unpack & Zip

### Swap
- 두 변수의 값을 바꾸는 방법
  ```python
  a, b = b, a
  ```
- 3개 이상의 변수를 바꾸는 방법
  ```python
  a, b, c = c, a, b
  ```

### Unpack
- 리스트나 튜플 등의 자료형을 여러 변수에 할당하는 것
  ```python
  a, b, c = [1, 2, 3]
  # a = 1, b = 2, c = 3

  a, b, c = (1, 2, 3)
  # a = 1, b = 2, c = 3

  a, b, c = 1, 2, 3
  # a = 1, b = 2, c = 3
  ```
- 변수의 개수와 리스트의 원소 개수가 일치해야 합니다.
- 변수의 개수가 더 많을 경우, 에러가 발생합니다.
  - \*를 사용하여 나머지 변수에 할당할 수 있습니다.
    ```python
    a, *b = [1, 2, 3]
    # a = 1, b = [2, 3]

    a, *b, c = [1, 2, 3, 4, 5]
    # a = 1, b = [2, 3, 4], c = 5
    
    ```

### Zip
- 두 개 이상의 시퀀스 자료형을 짝지어서 튜플로 묶어주는 함수
  ```python
  list(zip([1, 2, 3], [4, 5, 6]))
  # [(1, 4), (2, 5), (3, 6)]

  list(zip([1, 2, 3], [4, 5]))
  # [(1, 4), (2, 5)]
  ```
- 두 개 이상의 시퀀스 자료형의 길이가 다를 경우, 가장 짧은 길이에 맞춰서 짝지어줍니다.
- zip 함수는 zip object를 반환합니다. list로 변환해주어야 합니다.

## List Comprehension
- 리스트를 만드는 간결한 방법
  ```python
  [i for i in range(10)]
  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  [i for i in range(10) if i % 2 == 0]
  # [0, 2, 4, 6, 8]
  ```
- List Comprehension은 리스트뿐만 아니라, 딕셔너리, 집합 등 다양한 자료형에 사용할 수 있습니다.
  ```python
  {i: i**2 for i in range(10)}
  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16, 5: 25, 6: 36, 7: 49, 8: 64, 9: 81}
  ```
- List Comprehension은 for문을 사용하여 리스트를 만드는 방법입니다.
- List Comprehension은 가독성을 높이고, 코드를 간결하게 만들어줍니다.
- List Comprehension은 리스트뿐만 아니라, 딕셔너리, 집합 등 다양한 자료형에 사용할 수 있습니다.

## Generator
- List Comprehension과 유사하지만, 리스트를 반환하는 대신, **Generator를 반환**합니다.
- Generator는 **iterator**를 생성해주는 **함수**입니다.
- Generator는 **yield** 키워드를 사용하여 값을 반환합니다.
  ```python
  def gen():
      yield 1
      yield 2
      yield 3

  g = gen()
  print(next(g)) # 1
  print(next(g)) # 2
  print(next(g)) # 3
  ```
- Generator는 **한 번에 하나의 값만을 반환**합니다.

## Data Type
- **Mutable**: 변경 가능한 자료형
  - 리스트, 딕셔너리, 집합

- **Immutable**: 변경 불가능한 자료형
  - 숫자, 문자열, 튜플
  - Immutable한 자료형은 값을 변경할 수 없습니다.
  - Immutable한 자료형은 변수에 새로운 값을 할당하면, 새로운 메모리 주소에 할당됩니다.

## Mutable & Immutable
- Mutable한 자료형은 값이 변해도 메모리 주소가 변하지 않습니다.
- Immutable한 자료형은 값이 변하면 새로운 메모리 주소에 할당됩니다.
- Mutable한 자료형은 메모리를 효율적으로 사용할 수 있습니다.
- Immutable한 자료형은 값이 변할 때마다 새로운 메모리 주소에 할당되기 때문에 메모리를 많이 사용합니다.

### Float
- 실수를 표현하는 자료형

#### 부동소수점(floating-point) 방식
- 소수점이 고정되어 있지 않고, 소수점의 위치가 움직입니다.
- 부동소수점 방식은 **가수부**와 **지수부**로 나누어서 저장합니다.
- 부동소수점 방식은 소수점의 위치를 움직일 수 있습니다.
- 부동소수점 방식은 정밀도가 낮지만, **표현할 수 있는 범위가 넓습니다.**
- 부동소수점 방식은 컴퓨터에서 실수를 표현하는 방식으로, 실수를 정확하게 표현할 수 **없습니다.**
- 부동소수점 방식은 컴퓨터에서 실수를 **근사적**으로 표현합니다.

### Decimal
- 실수를 정확하게 표현하는 자료형
- Decimal은 실수를 정확하게 표현할 수 있습니다.
- Decimal은 정밀도가 높지만, **표현할 수 있는 범위가 좁습니다.**

```python
from decimal import Decimal

a = Decimal('0.1')
b = Decimal('0.3')

print(a + b) # 0.4
```

#### Fixed-point 방식(고정 소수점 방식)
- 소수점의 위치가 고정되어 있습니다.

### 컨테이너(Container) 자료형
- 여러 자료형을 저장할 수 있는 자료형
- 리스트, 튜플, 딕셔너리, 집합 등이 있습니다.

#### 리스트(List)
- 리스트는 **순서가 있고, 중복을 허용**합니다.
- 리스트는 **변경 가능(Mutable)**합니다.
- 리스트는 **대괄호([])**를 사용하여 만듭니다.

#### 튜플(Tuple)
- 튜플은 **순서가 있고, 중복을 허용**합니다.
- 튜플은 **변경 불가능(Immutable)**합니다.
- 튜플은 **소괄호**를 사용하여 만듭니다.

#### 딕셔너리(Dictionary)
- 딕셔너리는 **순서가 없고, 중복을 허용**하지 않습니다.
- 딕셔너리는 **키(Key)와 값(Value)의 쌍**으로 이루어져 있습니다.
- 딕셔너리는 **중괄호({})**를 사용하여 만듭니다.

#### 집합(Set)
- 집합은 **순서가 없고, 중복을 허용하지 않습니다.**
- 집합은 **중괄호({})**를 사용하여 만듭니다.
- 집합은 **set** 함수를 사용하여 만들 수 있습니다.
- 집합은 **교집합(&), 합집합(|), 차집합(-)** 등의 집합 연산을 할 수 있습니다.

---

## 'is' vs '==' in Python
- 'is'는 두 객체의 **메모리 주소**를 비교합니다.
- '=='는 두 객체의 **값**을 비교합니다.

```python
a = [1, 2, 3]
b = a
c = [1, 2, 3]

print(a is b) # True
print(a == b) # True
print(a is c) # False
print(a == c) # True
print(id(a), id(b), id(c)) 
# 1784  1784  1792
```

---

## Python Methods

대충 Cntrl + Space 누르면 나오는 메서드들

```python
dir() # 객체가 가지고 있는 메서드를 보여줍니다.
```

### list
- **append**: 리스트의 끝에 요소를 추가합니다.
- **extend**: 리스트의 끝에 다른 리스트를 추가합니다.
- **clear**: 리스트의 모든 요소를 삭제합니다.
- **copy**: 리스트를 복사합니다.
- **count**: 리스트에서 특정 요소의 개수를 반환합니다.
- **index**: 리스트에서 특정 요소의 인덱스를 반환합니다.
- **insert**: 리스트의 특정 위치에 요소를 추가합니다.
- **pop**: 리스트의 특정 위치에 있는 요소를 삭제합니다.
- **remove**: 리스트에서 특정 요소를 삭제합니다.
- **reverse**: 리스트의 요소를 역순으로 정렬합니다.
- **sort**: 리스트를 정렬합니다.

### tuple
- **count**: 튜플에서 특정 요소의 개수를 반환합니다.
- **index**: 튜플에서 특정 요소의 인덱스를 반환합니다.


### dict
- **items**: 딕셔너리의 키와 값을 튜플로 묶은 값을 반환합니다.
- **keys**: 딕셔너리의 키를 반환합니다.
- **values**: 딕셔너리의 값을 반환합니다.
- **get**: 딕셔너리의 값을 가져옵니다.
- **pop**: 딕셔너리의 값을 삭제합니다.
- **popitem**: 딕셔너리의 마지막 키와 값을 삭제합니다.
- **update**: 딕셔너리의 값을 업데이트합니다.
- **clear**: 딕셔너리의 모든 값을 삭제합니다.
- **copy**: 딕셔너리를 복사합니다.
- **fromkeys**: 키와 값을 생성합니다.
- **setdefault**: 딕셔너리의 값을 가져오거나 생성합니다.

### set
- **add**: 집합에 요소를 추가합니다.
- **clear**: 집합의 모든 요소를 삭제합니다.
- **copy**: 집합을 복사합니다.
- **difference**: 두 집합의 차집합을 반환합니다.
- **difference_update**: 두 집합의 차집합을 집합에 업데이트합니다.
- **discard**: 집합에서 특정 요소를 삭제합니다.
- **intersection**: 두 집합의 교집합을 반환합니다.
- **intersection_update**: 두 집합의 교집합을 집합에 업데이트합니다.
- **isdisjoint**: 두 집합이 교집합이 없으면 True를 반환합니다.
- **issubset**: 집합이 다른 집합의 부분집합이면 True를 반환합니다.
- **issuperset**: 집합이 다른 집합의 상위집합이면 True를 반환합니다.
- **pop**: 집합에서 임의의 요소를 삭제하고 반환합니다.
- **remove**: 집합에서 특정 요소를 삭제합니다.
- **symmetric_difference**: 두 집합의 대칭차집합을 반환합니다.
- **symmetric_difference_update**: 두 집합의 대칭차집합을 집합에 업데이트합니다.
- **union**: 두 집합의 합집합을 반환합니다.
- **update**: 집합에 다른 집합을 추가합니다.

> * 대칭차집합: 두 집합의 합집합에서 교집합을 뺀 집합

### str
- **capitalize**: 문자열의 첫 글자를 대문자로 변환합니다.
- **casefold**: 문자열을 소문자로 변환합니다.
- **center**: 문자열을 가운데 정렬합니다.
- **count**: 문자열에서 특정 문자열의 개수를 반환합니다.
- **encode**: 문자열을 인코딩합니다. (utf-8, ascii 등)
- **endswith**: 문자열이 특정 문자열로 끝나면 True를 반환합니다.
- **expandtabs**: 문자열의 탭을 공백으로 변환합니다.
- **find**: 문자열에서 특정 문자열의 인덱스를 반환합니다.
- **index**: 문자열에서 특정 문자열의 인덱스를 반환합니다.
- **isalnum**: 문자열이 알파벳과 숫자로만 이루어져 있으면 True를 반환합니다.
- **isalpha**: 문자열이 알파벳으로만 이루어져 있으면 True를 반환합니다.
- **isascii**: 문자열이 ASCII 문자로만 이루어져 있으면 True를 반환합니다.
- **isdecimal**: 문자열이 10진수로만 이루어져 있으면 True를 반환합니다.
- **isdigit**: 문자열이 숫자로만 이루어져 있으면 True를 반환합니다.
- **isidentifier**: 문자열이 식별자로 사용할 수 있으면 True를 반환합니다.
- **islower**: 문자열이 소문자로만 이루어져 있으면 True를 반환합니다.
- **isnumeric**: 문자열이 숫자로만 이루어져 있으면 True를 반환합니다.
- **isprintable**: 문자열이 출력 가능하면 True를 반환합니다.
- **isspace**: 문자열이 공백으로만 이루어져 있으면 True를 반환합니다.
- **istitle**: 문자열이 제목 형식으로 되어 있으면 True를 반환합니다.
- **isupper**: 문자열이 대문자로만 이루어져 있으면 True를 반환합니다.
- **join**: 문자열을 연결합니다.
- **ljust**: 문자열을 왼쪽 정렬합니다.
- **lower**: 문자열을 소문자로 변환합니다.
- **lstrip**: 문자열의 왼쪽 공백을 삭제합니다.
- **maketrans**: 문자열을 변환할 수 있는 테이블을 만듭니다.
- **partition**: 문자열을 특정 문자열을 기준으로 나눕니다.
- **removeprefix**: 문자열의 접두사를 삭제합니다.
- **removesuffix**: 문자열의 접미사를 삭제합니다.
- **replace**: 문자열을 다른 문자열로 대체합니다.
- **rfind**: 문자열에서 특정 문자열의 인덱스를 반환합니다.ㄴ
- **rindex**: 문자열에서 특정 문자열의 인덱스를 반환합니다.
- **rjust**: 문자열을 오른쪽 정렬합니다.
- **rpartition**: 문자열을 특정 문자열을 기준으로 나눕니다.
- **rsplit**: 문자열을 오른쪽부터 나눕니다.
- **rstrip**: 문자열의 오른쪽 공백을 삭제합니다.
- **split**: 문자열을 나눕니다.
- **splitlines**: 문자열을 라인 단위로 나눕니다.
- **startswith**: 문자열이 특정 문자열로 시작하면 True를 반환합니다.
- **strip**: 문자열의 양쪽 공백을 삭제합니다.
- **swapcase**: 문자열의 대문자를 소문자로, 소문자를 대문자로 변환합니다.
- **title**: 문자열을 제목 형식으로 변환합니다.
- **translate**: 문자열을 변환합니다.
- **upper**: 문자열을 대문자로 변환합니다.
- **zfill**: 문자열의 길이를 지정하고, 나머지 공간을 0으로 채웁니다.
- **format**: 문자열의 포맷을 지정합니다. (f-string)
- **format_map**: 문자열의 포맷을 지정합니다.

## slice & indexing & range

### slice
- **시작 인덱스**: slice의 시작 인덱스
- **끝 인덱스**: slice의 끝 인덱스
- **간격**: slice의 간격

```python
a = [1, 2, 3, 4, 5]
print(a[1:3]) # [2, 3]
print(a[:3]) # [1, 2, 3]
print(a[1:]) # [2, 3, 4, 5]
print(a[::2]) # [1, 3, 5]
```

### indexing
- **양수 인덱싱**: 0부터 시작
- **음수 인덱싱**: -1부터 시작

```python
a = [1, 2, 3, 4, 5]
print(a[0]) # 1
print(a[-1]) # 5
```

### range
- **시작**: range의 시작
- **끝**: range의 끝
- **간격**: range의 간격

```python
print(list(range(5))) # [0, 1, 2, 3, 4]
print(list(range(1, 5))) # [1, 2, 3, 4]
print(list(range(1, 5, 2))) # [1, 3]
```

---

## Python Built-in Functions

### abs
- 절대값을 반환합니다.

```python
print(abs(-3)) # 3
```

### all
- 모든 요소가 참이면 True를 반환합니다.

```python
print(all([1, 2, 3])) # True
print(all([1, 2, 0])) # False
```

### any
- 하나의 요소라도 참이면 True를 반환합니다.

```python
print(any([1, 2, 3])) # True
print(any([1, 2, 0])) # True
print(any([0, 0, 0])) # False
```

### bin
- 2진수로 변환합니다.

```python
print(bin(3)) # 0b11
```

### oct
- 8진수로 변환합니다.

```python
print(oct(10)) # 0o12
```

### hex
- 16진수로 변환합니다.

```python
print(hex(10)) # 0xa
```

### bool
- 불리언 값을 반환합니다.

```python
print(bool(0)) # False
print(bool(1)) # True
```

### chr
- 아스키 코드 값을 문자로 변환합니다.

```python
print(chr(65)) # A
```

### ord
- 문자를 아스키 코드로 변환합니다.

```python
print(ord('A')) # 65
```

### dir
- 객체가 가지고 있는 메서드를 보여줍니다.

```python
print(dir([]))
``` 

### divmod
- 몫과 나머지를 반환합니다.

```python
print(divmod(7, 3)) # (2, 1)
```

### enumerate
- 인덱스와 값을 반환합니다.

```python
for i, v in enumerate(['a', 'b', 'c']):
    print(i, v)
```

### filter
- 함수를 통과한 요소만 반환합니다.

```python
def f(x):
    return x > 5

print(list(filter(f, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
```

### map
- 함수를 적용한 결과를 반환합니다.

```python
def f(x):
    return x + 1

print(list(map(f, [1, 2, 3])))
# [2, 3, 4]
```

### id
- 객체의 메모리 주소를 반환합니다.

```python
a = 3
print(id(a))
```

### input
- 사용자로부터 입력을 받습니다.

```python
a = input()
```

### int
- 정수로 변환합니다.

```python
print(int('3')) # 3
```

### len
- 길이를 반환합니다.

```python
print(len([1, 2, 3])) # 3
```

### list
- 리스트로 변환합니다.

```python
print(list((1, 2, 3))) # [1, 2, 3]
```

### max
- 최대값을 반환합니다.

```python
print(max([1, 2, 3])) # 3
```

### min
- 최소값을 반환합니다.

```python
print(min([1, 2, 3])) # 1
```

### pow
- 제곱을 반환합니다.

```python
print(pow(2, 3)) # 8
```

### range
- 범위를 반환합니다.

```python
print(list(range(5))) # [0, 1, 2, 3, 4]
```

### reversed
- 역순으로 반환합니다.

```python
print(list(reversed([1, 2, 3]))) # [3, 2, 1]
```

### round
- 반올림을 반환합니다.

```python
print(round(3.5)) # 4
```

### sorted
- 정렬된 값을 반환합니다.

```python
print(sorted([3, 2, 1])) # [1, 2, 3]
```

### str
- 문자열로 변환합니다.

```python
print(str(3)) # '3'
```

### sum
- 합을 반환합니다.

```python
print(sum([1, 2, 3])) # 6
```

### type
- 타입을 반환합니다.

```python
print(type(3)) # <class 'int'>
```

### zip
- 묶어서 반환합니다.

```python 
print(list(zip([1, 2, 3], [4, 5, 6]))) # [(1, 4), (2, 5), (3, 6)]
```

---

## Python Built-in Constants

### True
- 참을 나타내는 상수
- True는 1과 같습니다.

### False
- 거짓을 나타내는 상수
- False는 0과 같습니다.

### None
- 아무 값도 없음을 나타내는 상수
- None은 아무 값도 없음을 나타냅니다.
- null과 같은 의미입니다.

### NotImplemented
- 구현되지 않음을 나타내는 상수
- NotImplemented는 구현되지 않음을 나타냅니다.

### Ellipsis
- 생략을 나타내는 상수
- Ellipsis는 생략을 나타냅니다.
- Ellipsis는 ...으로 표현할 수 있습니다.
