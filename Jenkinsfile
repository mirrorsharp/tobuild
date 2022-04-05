pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: maven
            image: maven:alpine
            command:
            - cat
            tty: true
        '''
    }
  }
    stages {    
        stage('Dockerfile Linting') {
            steps {
                sh 'export HADOLINT_V=v2.9.3'                
                sh 'curl -LO https://github.com/hadolint/hadolint/releases/download/${HADOLINT_V}/hadolint-Linux-x86_64'
                sh 'chmod +x hadolint-Linux-x86_64'
                sh 'mv hadolint-Linux-x86_64 /bin/hadolint'
                sh 'hadolint Dockerfile'
            }
        }
    }
}
