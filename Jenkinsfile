pipeline {
    environment {
        IMAGEN = "robertorm/django_tutorial"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent {
        docker { image 'python:3'
        args '-u root:root'
        }
    }
    stages {
        stage('Clone') {
            steps {
                git branch:'master',url:'https://github.com/robertorodriguez98/django_tutorial'
            }
        }
        stage('Install') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage('Test')
        {
            steps {
                sh 'python3 manage.py test'
            }
        }
        stage("Construccion") {
            agent any
            stages {
                stage('CloneAnfitrion') {
                    steps {
                        git branch:'master',url:'https://github.com/robertorodriguez98/django_tutorial.git'
                    }
                }
                stage('BuildImage') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('UploadImage') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('RemoveImage') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
            }
        }           
    }
    post {
        always {
            mail to: 'robertorodriguezmarquez98@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
