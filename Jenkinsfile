pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven-3"
       // jdk "jdk11"
    }
parameters {
  string defaultValue: 'giturl', description: 'Repourl', name: 'https://github.com/mrashutoshmuduli/my-project.git'
  string defaultValue: 'Branch', description: 'Branch Name', name: 'main'
  string defaultValue: 'sample-api',description: 'projectname', name: 'project'
}
environment {
  giturl = "https://github.com/mrashutoshmuduli/my-project.git"
  BUILD_NUM = "${currentBuild.getNumber()}"
  PROJ_NAME = "${params.project}"
}
    stages {
        stage('Build') {
            steps {
                
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/mrashutoshmuduli/my-project.git'
               
                sh "mvn clean install -Dmaven.test.skip=true -Dmaven.test.failure.ignore=true"
            }

        }
        stage("Docker Build") {	 
	    steps{
		    echo "WorkSpace:  $WORKSPACE"
            echo "PROJ_NAME: $PROJ_NAME"
		    echo "BUILD_NUM:$BUILD_NUM"
		    //sh "cd $WORKSPACE && sudo docker build . --no-cache --compress -t $PROJ_NAME:$BUILD_NUM"
            script {
                    // Your build commands go here
                    sh 'docker build -t $PROJ_NAME:$BUILD_NUM .'
                }
            }	
	    }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }

                    // Push the Docker image
                    sh 'docker push ${PROJ_NAME}:${BUILD_NUM}'
                }
            }
        }
    }
}
