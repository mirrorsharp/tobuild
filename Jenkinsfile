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
  - name: pushchart
    image: dtzar/helm-kubectl
    command:
    - cat
    tty: true
  - name: pullchart
    image: dtzar/helm-kubectl
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
        container('pushchart') {
          sh 'helm plugin install https://github.com/chartmuseum/helm-push --version 0.10.1'
          sh 'helm repo add chartmuseum http://10.100.4.120:8080 && helm cm-push --force charts/ chartmuseum'
                }
            }
        }
    stage('Pull from Chartmuseum') {
      steps {
        container('pullchart') {
          sh 'helm repo update'
          sh 'helm repo list'
                }
            }
        }
  }
}