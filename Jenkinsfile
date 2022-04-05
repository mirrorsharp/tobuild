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
                sh 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg'
                sh 'echo \
                    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null'
                sh 'apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io'
                sh 'docker build -t testpython . && docker run -d -p 5000:5000 testpython'
                }
            }
        }
    }
}
