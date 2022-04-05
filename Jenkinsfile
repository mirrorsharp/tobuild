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
                sh 'apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common'
                sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
                sh 'apt-key fingerprint 0EBFCD88 sudo add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/ubuntu$(lsb_release -cs) stable"'
                sh 'apt-get install -y docker-ce docker-ce-cli containerd.io'
                }
            }
        }
    }
}
