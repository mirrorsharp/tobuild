pipeline {
  agent {
    kubernetes {
      yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
      - name: ml-jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: ml-enkins-docker-cfg
    projected:
      sources:
      - secret:
          name: ml-docker-credentials
          items:
            - key: .dockerconfigjson
              path: config.json
'''
    }
  }
  stages {
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh
            /kaniko/executor --context `pwd` --dockerfile Dockerfile --destination iangodbx/testpython:latest
          '''
        }
      }
    }
  }
}