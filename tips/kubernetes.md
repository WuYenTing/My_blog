how to deploy in k8s.
1. create deployment for front/backend/postgresql
DB_HOSTNAME = <service-name>.<namespace>.svc.cluster.local or cluster IP of service
(backend env: 1.SECRET_KEY_BASE={mix phx.gen.secret} 2.DATABASE_URL=ecto://{DB_USER}:{DB_PASSWORD}@{DB_HOSTNAME}/{DB_DATABASENAME})
2. create service for front/backend/postgresql
(front-svc <-> front-pod <-> back-svc <-> back-pod <-> db-svc <-> db-pod)
3. bind svc to pod use selector on svc to get the label on pod 
4. check if the svc bind to the pod
(kubectl get endpoints -n {namespace} {svc-name} -> this command should show IP addresses and ports of the pods that the Service points to)
5. run database migration on backend pod
(/app/bin/migrate)
6. 


apiVersion: apps/v1
kind: Deployment
metadata:
  name: roting-server
  namespace: roger-play
spec:
  replicas: 1
  selector:
    matchLabels:
      app: roting-server
  template:
    metadata:
      labels:
        app: roting-server
    spec:
      containers:
      - name: roting-server
        image: ap95071/rotingtest:latest
        imagePullPolicy: Always
        env:
        - name: DATABASE_URL
          value:
        - name: SECRET_KEY_BASE
          value:
---
apiVersion: v1
kind: Service
metadata:
  namespace: roger-play
  name: roting-svc
  labels:
    componet: roting-server
spec:
  ports:
  - port: 4000
    name: roting
  clusterIP:
  selector:
    app: roting-server
########################################
apiVersion: v1
kind: Service
metadata:
  namespace: roger-play
  name: localhost
  labels:
    group: db
spec:
  type: ClusterIP
  selector:
    app: postgres
  ports:
    - port: 5432
      targetPort: 5432
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: postgres-config
  namespace: roger-play
  labels:
    group: db
data:
  POSTGRES_DB: postgres
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: postgres
---
apiVersion: v1
kind: PersistentVolume
metadata:
  namespace: roger-play
  name: postgres-volume
  labels:
    type: local
    app: postgres
spec:
  storageClassName: default
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  namespace: roger-play
  name: postgres-volume-claim
  labels:
    app: postgres
spec:
  storageClassName: default
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: roger-play
  labels:
    app: postgres
    group: db
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
        type: db
    spec:
      volumes:
        - name: postgres-storage
          persistentVolumeClaim:
            claimName: postgres-volume-claim
      containers:
        - name: postgres
          image: postgres:17
          ports:
            - containerPort: 5432
          envFrom:
            - configMapRef:
                name: postgres-config
          volumeMounts:                 # indicates which Volume (from spec.template.spec.volumes) should be used
            - name: postgres-storage                # name of the Volume
              mountPath: /var/lib/postgresql/data  # path inside the container
              subPath: data 
          resources:
            limits:
              memory: "256Mi"
              cpu: "500m"

