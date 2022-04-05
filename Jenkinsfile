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
            imagePullPolicy: Always
            command:
            - cat
            tty: true
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
                container('hadolint') {
                sh 'hadolint Dockerfile'
                }
                container('alpine') {
                sh 'echo test several pods OK'
                }
            }
        }
    }
}
