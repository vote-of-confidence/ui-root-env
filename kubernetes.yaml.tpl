# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

apiVersion: apps/v1
kind: Deployment
metadata:
  name: ui-root-deployment
  labels:
    app: ui-root
    version: COMMIT_SHA
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ui-root
  template:
    metadata:
      labels:
        app: ui-root
        version: COMMIT_SHA
    spec:
      containers:
        - name: ui-root
          image: eu.gcr.io/GOOGLE_CLOUD_PROJECT/voc-ui-root:COMMIT_SHA
          ports:
            - name: nginx-http
              containerPort: 8080
          resources:
            requests:
              cpu: 50m
---
apiVersion: v1
kind: Service
metadata:
  name: ui-root
spec:
  ports:
    - name: http
      port: 80
      targetPort: nginx-http
      protocol: TCP
  selector:
    app: ui-root
  type: NodePort
