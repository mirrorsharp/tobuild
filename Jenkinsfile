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
          - name: centos
            image: openshift/jenkins-slave-base-centos7:v3.11
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
                container('centos') {
                sh 'yum install -y yum-utils'
                sh 'yum-config-manager \
                    --add-repo \
                    https://download.docker.com/linux/centos/docker-ce.repo'
                sh 'yum install docker-ce docker-ce-cli containerd.io'
                sh 'docker --version'
                }
            }
        }
    }
}
