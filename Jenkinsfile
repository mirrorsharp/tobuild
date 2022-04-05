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
//   stages {
//     stage('Run maven') {
//       steps {
//         container('maven') {
//           sh 'mvn -version'
//         }
//       }
//     }
//   }
stages{    
        stage('Dockerfile Linting') {
            steps {
                sh 'chmod +x linter.sh'                
                sh './linter.sh Dockerfile'
        }
    }
}