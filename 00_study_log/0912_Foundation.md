# Foundation Model

## 1. Foundation Model vs Machine Learning Model

> **Foundation Model**은 **Machine Learning Model**의 일종이다.
> 하지만 머신러닝 모델과는 다르게 **Foundation Model**은 **Pre-trained**된 모델을 사용한다. (사전학습된 모델을 사용한다.)
> 머신러닝 모델은 데이터를 통해 학습을 하지만, **Foundation Model**은 이미 학습된 모델을 사용하기 때문에 **Fine-tuning**만으로도 높은 성능을 보인다.

## 2. Foundation Model의 종류

### 1) Text to Text Model (LLM)

- **Text to Text Model**은 **Language Model**을 의미한다.
- 자연어를 이해하고 생성하는 모델이다.

### 2) Diffusion Model

- **Diffusion Model**은 이미지를 이해하고 생성하는 모델이다.
- 원본 이미지에 노이즈를 추가하여 학습한다. (forward diffusion)
- 노이즈가 추가된 이미지를 원본 이미지로 복원한다. (reverse diffusion)

**Diffusion: 확산, 전파**

- 이미지에 노이즈를 추가하여 학습하고, 노이즈가 추가된 이미지를 원본 이미지로 복원하는 모델이다.
- 이 과정에서 이미지의 특징을 파악하고 생성할 수 있다.

### 3) Embeddings

- **Embedding**은 문서/데이터의 연관성을 파악하는 모델이다.
- 문맥을 파악하고 질문에 대한 답변을 생성하는 모델이다.
- 기본적으로 입력되는 데이터를 **Embedding**하여 **Vector**로 변환한다.

### 4) Multi-Modal

- 여러 종류의 데이터를 입력으로 받아 처리하는 모델이다.
- 이미지, 텍스트, 음성 등 다양한 데이터를 입력으로 받아 처리한다.

## 2-1. LLM (Large Language Model)

- Context Window를 통해 문맥을 파악한다.
  - **Context Window**: 주어진 문장에서 중심 단어를 기준으로 좌우로 몇 개의 단어를 볼 것인지를 결정하는 것
  - 규모가 큰 **Context Window**를 사용할수록 더 많은 문맥을 파악할 수 있다.
  - **Context Window**의 크기가 커질수록 **Embedding**의 차원이 커진다.
- 기본적으로 다음 단어를 예측하는 모델이다.
  - 질문에 답변하는 것이 아니라 다음에 올 단어를 예측하는 것이 목적이다.
- Attention Mechanism을 사용한다.
  - **Attention Mechanism**: 입력된 데이터의 중요도를 파악하여 가중치를 부여하는 것
  - **Attention Mechanism**을 사용하면 입력된 데이터의 중요도를 파악할 수 있다.
  - 기울기 소실 문제를 해결할 수 있다.
  - 기울기 소실 문제: **RNN** 모델에서 발생하는 문제로, 입력된 데이터의 중요도를 파악하지 못하는 문제
    - 뒤로 갈수록 중요도가 줄어들어 문맥을 잊고 다른 이야기를 하는 문제
  - 대명사와 긴 문장을 처리할 때 유용하다.

### Transformer

- Attention Mechanism을 사용하는 모델이다.
  - **Transformer**: **Attention Mechanism**을 사용하여 입력된 데이터의 중요도를 파악하는 모델
  - **Transformer**는 **Self-Attention**을 사용하여 입력된 데이터의 중요도를 파악한다.
    - **Self-Attention**: 입력된 데이터의 중요도를 파악하는 것
- 시계열 데이터는 전후 관계가 중요하다.
  - **Transformer**는 시계열 데이터를 처리할 때 전후 관계를 파악할 수 있다.
  - 각 데이터의 시계열 순서를 부여하고 병렬처리를 한다.

## 2-2. Embeddings

- **Embedding**은 입력된 데이터를 **Vector**로 변환하는 것이다.
- 단어에 대한 수많은 속성을 저장하기 위해서 단순히 scalar 값으로 표현하지 않고 **Vector**로 변환한다.

> 비슷한 의미를 가진 단어는 비슷한 **Vector** 값을 가진다.
> 따라서, 비슷한 의미를 가진 단어를 찾아낼 수 있다.

- **Embedding**은 **Word2Vec**, **GloVe**, **FastText** 등 다양한 방법으로 구현할 수 있다.

## 2-3. Multi-Modal

- 여러 종류의 데이터를 입력으로 받아 처리하는 모델
- 이미지, 텍스트, 음성 등 다양한 데이터를 입력으로 받아 처리하고, 다양한 형태로 다시 출력한다.

> 이미지를 입력으로 받아 텍스트로 출력하는 모델
> 텍스트를 입력으로 받아 이미지로 출력하는 모델
> 음성을 입력으로 받아 텍스트로 출력하는 모델
> 등등등등
