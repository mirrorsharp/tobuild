// pipeline {
//   agent {
//     kubernetes {
//       yaml '''
//         apiVersion: v1
//         kind: Pod
//         spec:
//           containers:
//           - name: hadolint
//             image: hadolint/hadolint:latest-debian
//             imagePullPolicy: Always
//             command:
//             - cat
//             tty: true
//           containers:
//           - name: ubuntu
//             image: ubuntu:latest
//             imagePullPolicy: Always
//             command:
//             - cat
//             tty: true
//         '''
//     }
//   }
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
            image: docker:latest
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
                sh 'docker build -t testpython . && docker run -d -p 5000:5000 testpython'
                }
            }
        }
    }
}
