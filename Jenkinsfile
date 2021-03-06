pipeline {
  agent {
    kubernetes { // Pod definition
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
          sh """#!/busybox/sh
            /kaniko/executor --context `pwd` --dockerfile Dockerfile --destination iangodbx/testpython:${env.ENV}
          """ 
        }
      }
    }
    stage('Push to Chartmuseum') { //Push to chartmuseum via cm-push plugin
      steps {
        container('pushchart') {
          sh 'helm plugin install https://github.com/chartmuseum/helm-push --version 0.10.1'
          sh 'helm repo add chartmuseum http://10.100.4.120:8080 && helm cm-push --force charts/ chartmuseum'
                }
            }
        }
    stage('Pull from Chartmuseum') { 
      environment { // Environmental variables for Jenkins secrets 
              DEV_SECRET=credentials('secret-dev')
              PROD_SECRET=credentials('secret-prod')
        }      
      steps {
        container('pullchart') {
          script {
            if (env.ENV == "dev") {
              sh 'helm repo add chartmuseum http://10.100.4.120:8080'
              sh 'helm repo update'
              sh 'helm install mychart -n ml-onboarding-dev --set label.env=dev --set container.tag=dev --set replicaCount=1 chartmuseum/jchart' 
              sh 'kubectl create secret generic secret-dev --from-literal=password=$DEV_SECRET -n ml-onboarding-dev'
                    }
            if (env.ENV == "prod") {
              sh 'helm repo add chartmuseum http://10.100.4.120:8080'
              sh 'helm repo update'
              sh 'helm install mychart -n ml-onboarding-prod --set label.env=prod --set container.tag=prod --set replicaCount=3 chartmuseum/jchart'
              sh 'kubectl create secret generic secret-prod --from-literal=password=$PROD_SECRET -n ml-onboarding-prod' 
                    }
                  }
                }
            }
        }
  }
}