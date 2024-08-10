# 전체 흐름 요약

1. **Istio Gateway**가 클러스터 외부에서 들어오는 트래픽을 수신합니다.
2. 이 트래픽은 **VirtualService**에 의해 지정된 규칙에 따라 라우팅됩니다.
3. **DestinationRule**은 라우팅된 트래픽에 대한 로드 밸런싱 및 연결 정책을 정의합니다.
4. 트래픽은 **Kubernetes Service**로 전달되며, 서비스는 트래픽을 적절한 포드(Pod)로 분산시킵니다.
5. **Deployment**는 애플리케이션의 복제본을 관리하며, 정의된 포드들이 항상 실행되도록 보장합니다.
6. **HPA**는 포드의 수를 애플리케이션 부하에 따라 동적으로 조정하여 성능을 최적화합니다.
7. **Pod**는 실제 애플리케이션 인스턴스를 실행하고, 클라이언트 요청을 처리하여 응답을 생성합니다.

이 과정을 통해 Istio와 Kubernetes의 여러 리소스가 함께 동작하여, 클러스터 외부의 요청을 내부 서비스로 안전하고 효율적으로 라우팅하고 관리하게 됩니다.

### 1. Istio Gateway

**Gateway**는 Istio에서 클러스터 외부의 트래픽을 수신하는 진입점입니다. Gateway는 클러스터 외부에서 들어오는 트래픽을 받아들이고, 이후 이 트래픽을 어떻게 처리할지 정의합니다.

- **역할**: 외부 트래픽(예: HTTP, HTTPS, TCP)을 수신하고, 지정된 호스트 및 포트에 따라 트래픽을 VirtualService로 전달합니다.
- **예시**: HTTP 프로토콜로 `example.com`에 대한 요청을 수신하는 Gateway 설정

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: my-gateway
spec:
  selector:
    istio: ingressgateway # Istio Ingress Gateway 선택자
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "example.com"
```

### 2. Istio VirtualService

**VirtualService**는 Gateway가 수신한 트래픽을 클러스터 내의 특정 서비스로 라우팅하는 규칙을 정의합니다. 여기에는 URL 경로 기반 라우팅, 트래픽 분할, 요청 리트라이 등의 고급 트래픽 관리 기능이 포함됩니다.

- **역할**: Gateway에서 들어온 트래픽을 특정 Kubernetes Service로 라우팅하고, 트래픽이 어떻게 처리될지 세밀하게 제어합니다.
- **예시**: `/api` 경로로 들어오는 요청을 `my-service`로 라우팅

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: my-service
spec:
  hosts:
  - "example.com"
  gateways:
  - my-gateway
  http:
  - match:
    - uri:
        prefix: /api
    route:
    - destination:
        host: my-service
        port:
          number: 80
```

### 3. Istio DestinationRule

**DestinationRule**은 VirtualService에 의해 라우팅된 트래픽이 실제로 대상 서비스에 도달했을 때 적용할 정책을 정의합니다. 여기에는 트래픽의 로드 밸런싱 전략, 연결 풀 관리, 장애 회복(Circuit Breaking) 설정 등이 포함됩니다.

- **역할**: 대상 서비스에 대한 세부 트래픽 제어 및 연결 정책을 정의하여, 서비스의 안정성과 성능을 보장합니다.
- **예시**: `my-service`에 대한 트래픽을 라운드 로빈 방식으로 로드 밸런싱

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: my-destination-rule
spec:
  host: my-service
  trafficPolicy:
    loadBalancer:
      simple: ROUND_ROBIN
```

### 4. Kubernetes Service

**Kubernetes Service**는 클러스터 내의 포드(Pod)들에 대한 네트워크 접근을 제공하는 리소스입니다. 서비스는 트래픽을 로드 밸런싱하여 여러 포드에 분산시킵니다.

- **역할**: 클러스터 내의 포드들을 하나의 엔드포인트로 묶어, 외부 요청이 특정 포드로 분산되도록 합니다. VirtualService와 DestinationRule을 통해 이 서비스로 트래픽이 전달됩니다.
- **예시**: `my-service`라는 이름의 Kubernetes Service 설정

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

### 5. Kubernetes Deployment

**Deployment**는 Kubernetes에서 애플리케이션의 배포와 관리를 자동화하는 리소스입니다. Deployment는 정의된 포드의 복제본을 관리하며, 애플리케이션의 상태를 유지합니다.

- **역할**: 지정된 수의 포드가 항상 실행되도록 보장하며, 애플리케이션 업데이트 시 롤링 업데이트와 같은 전략을 통해 중단 없이 배포합니다.
- **예시**: `my-app`이라는 이름의 애플리케이션을 실행하는 Deployment 설정

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app-container
        image: my-app-image:latest
        ports:
        - containerPort: 8080
```

### 6. Kubernetes Horizontal Pod Autoscaler (HPA)

**Horizontal Pod Autoscaler (HPA)**는 Kubernetes에서 포드의 수를 자동으로 확장하거나 축소하는 기능을 제공합니다. CPU 사용량, 메모리 사용량 또는 커스텀 메트릭을 기반으로 포드의 수를 동적으로 조정합니다.

- **역할**: 애플리케이션의 부하에 따라 포드의 수를 자동으로 조정하여, 리소스 사용을 최적화하고 성능을 보장합니다.
- **예시**: CPU 사용량이 50% 이상일 때 포드를 확장하는 HPA 설정

```yaml
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: my-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-app-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

### 7. Kubernetes Pod

**Pod**는 Kubernetes에서 가장 작은 배포 단위로, 하나 이상의 컨테이너를 포함합니다. Deployment에 의해 관리되며, 실제 애플리케이션 코드가 실행되는 장소입니다.

- **역할**: 애플리케이션의 인스턴스가 실행되는 환경을 제공하며, 클러스터 내에서 서비스 트래픽을 처리합니다.
- **동작 과정**: Kubernetes Service로부터 전달된 트래픽을 처리하고, 요청에 대한 응답을 생성합니다.

**ClusterIP**, **LoadBalancer**, **NodePort**는 Kubernetes에서 서비스(Service)를 외부 및 내부 클라이언트에 노출하기 위해 사용되는 세 가지 주요 서비스 타입입니다. 이들은 각각 트래픽을 클러스터 내의 포드(Pod)로 라우팅하는 방식에 차이가 있으며, 애플리케이션이 클러스터 내부 또는 외부에서 접근될 수 있도록 하는 다양한 네트워크 옵션을 제공합니다. 아래에서 각 서비스 타입의 개념과 그 차이점을 상세히 설명하겠습니다.

### Kubernetes 서비스 유형

#### 1. ClusterIP

**ClusterIP**는 Kubernetes 서비스의 기본 서비스 유형으로, 클러스터 내부에서만 접근 가능한 가상 IP를 제공합니다.

- **동작 방식**: ClusterIP 타입의 서비스는 클러스터 내부에서만 접근 가능하며, 외부에서 직접 접근할 수 없습니다. 클러스터 내의 다른 포드들은 이 ClusterIP를 통해 서비스에 접근할 수 있습니다.
- **사용 시나리오**: 클러스터 내부에서만 동작하는 백엔드 서비스, 마이크로서비스 간의 통신 등 외부 노출이 필요 없는 경우에 사용됩니다.

**예시**:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

#### 2. NodePort

**NodePort**는 ClusterIP를 확장하여, 클러스터의 각 노드에서 특정 포트를 열어 외부에서 접근할 수 있도록 하는 서비스 유형입니다.

- **동작 방식**: NodePort 타입의 서비스는 클러스터의 모든 노드에서 지정된 포트(30000-32767 사이의 포트)를 열어줍니다. 클라이언트는 노드의 IP 주소와 이 포트를 통해 서비스에 접근할 수 있습니다. 내부적으로는 ClusterIP가 생성되어 포드에 트래픽을 라우팅합니다.
- **사용 시나리오**: 간단하게 외부에서 클러스터 내부 서비스에 접근해야 할 때 사용됩니다. 클라우드 로드밸런서 없이 외부 트래픽을 노드에 직접 노출할 때 유용합니다.

**예시**:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30007
```

#### 3. LoadBalancer

**LoadBalancer**는 NodePort와 ClusterIP를 확장하여, 클라우드 제공자의 로드밸런서를 사용해 외부에서 서비스에 접근할 수 있게 해주는 서비스 유형입니다.

- **동작 방식**: LoadBalancer 타입의 서비스는 클라우드 환경(예: AWS, GCP, Azure 등)에서 외부 IP 주소를 할당받아, 클라이언트가 이 IP 주소를 통해 서비스에 접근할 수 있도록 합니다. 내부적으로는 NodePort 및 ClusterIP를 사용하여 트래픽을 포드로 라우팅합니다. 클라우드 제공자가 관리하는 로드밸런서가 생성되며, 이 로드밸런서가 클러스터의 노드로 트래픽을 분산시킵니다.
- **사용 시나리오**: 클라우드 환경에서 애플리케이션을 외부에 직접 노출해야 할 때 가장 많이 사용됩니다. 특히, 고가용성이 필요한 경우 유용합니다.

**예시**:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

### 주요 차이점 요약

| **특징**           | **ClusterIP**                       | **NodePort**                     | **LoadBalancer**                             |
| ------------------ | ----------------------------------- | -------------------------------- | -------------------------------------------- |
| **접근 가능 범위** | 클러스터 내부                       | 외부 및 클러스터 내부            | 외부 및 클러스터 내부                        |
| **외부 접근 방식** | 없음                                | 각 노드의 IP와 지정된 포트 사용  | 클라우드 로드밸런서 사용                     |
| **노출 포트**      | 가상 IP를 사용, 포트 지정 가능      | 30000-32767 사이의 포트          | 클라우드에서 제공한 외부 IP 및 포트          |
| **로드 밸런싱**    | 클러스터 내부의 포드 간 로드 밸런싱 | 모든 노드로 트래픽이 전달됨      | 클라우드 제공자의 로드밸런서에서 노드로 분산 |
| **사용 사례**      | 클러스터 내부에서만 접근하는 서비스 | 간단한 외부 노출이 필요한 서비스 | 클라우드 환경에서의 외부 서비스 노출         |

#### 3가지 서비스 유형의 특징

- **ClusterIP**는 클러스터 내부에서만 접근 가능한 서비스를 제공하여, 외부로 노출되지 않도록 보호할 수 있습니다.
- **NodePort**는 각 노드의 고유한 포트를 통해 외부에서 접근 가능하게 하며, 간단한 외부 노출이 필요할 때 유용하지만, 노드 IP와 포트를 클라이언트가 알고 있어야 하는 제약이 있습니다.
- **LoadBalancer**는 클라우드 환경에서 외부 IP를 통해 서비스에 접근할 수 있게 하며, 클라우드 제공자의 로드밸런서를 사용해 트래픽을 분산시키는 기능을 제공합니다. 이는 고가용성 애플리케이션에 적합합니다.

이 세 가지 서비스 유형은 각각의 목적에 맞게 선택할 수 있으며, 클러스터 내부 또는 외부에서 애플리케이션을 어떻게 노출할지 결정하는 데 중요한 역할을 합니다.

