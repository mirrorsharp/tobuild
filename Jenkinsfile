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
          - name: ubuntu
            image: ubuntu:latest
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
                container('ubuntu') {
                sh 'apt-get update'
                sh 'apt-get install -y \
                    ca-certificates \
                    curl \
                    gnupg \
                    lsb-release'
                }
            }
        }
    }
}
