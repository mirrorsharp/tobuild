pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  containers:
  - name: hadolint
    image: hadolint/hadolint:latest-debian
    command:
    - cat
    tty: true
  - name: jenkins-agent
    image: iangodbx/jenkins-agent:latest
    command:
    - cat
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-credentials
          items:
            - key: .dockerconfigjson
              path: config.json
"""
    }
  }
  stages {
    stage('Dockerfile Linting') {
      steps {
        container('hadolint') {
          sh 'hadolint Dockerfile'
                }
            }
        }
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh
            /kaniko/executor --context `pwd` --dockerfile Dockerfile --destination iangodbx/testpython:latest
          '''
        }
      }
    }
    stage('Push to Chartmuseum') {
      steps {
        container('jenkins-agent') {
          sh 'helm plugin list'
                }
            }
        }
  }
}