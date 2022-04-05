pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: alpine
            image: alpine:latest
            command:
            - cat
            tty: true
        '''
    }
  }
    stages {    
        stage('Dockerfile Linting') {
            steps {
                container('alpine') {
                sh 'export HADOLINT_V=v2.9.3'
                sh 'apk --no-cache add curl'                
                sh 'curl -LO https://github.com/hadolint/hadolint/releases/download/${HADOLINT_V}/hadolint-Linux-x86_64'
                sh 'chmod +x hadolint-Linux-x86_64'
                sh 'mv hadolint-Linux-x86_64 /bin/hadolint && hadolint Dockerfile'
                }
            }
        }
    }
}
