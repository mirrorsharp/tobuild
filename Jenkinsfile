pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: hadolint
            image: hadolint/hadolint:latest-debian
            command:
            - cat
            tty: true
          - name: docker
            image: docker:19.03.1-dind
            command:
            - cat
            tty: true
        '''
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
        stage('Dockerfile build') {
            steps {
                container('docker') {
                sh 'docker build -t testpython .'
                }
            }
        }
    }
}
