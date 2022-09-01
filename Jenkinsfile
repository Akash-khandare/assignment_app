pipeline{
    agent any
    environment{
    DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('build Docker image'){
            steps{
                sh "docker image build . -t akashkhandare/node:${DOCKER_TAG}"
            }
        }
        stage('Dockerhub push'){
            steps{
                withCredentials( [string(credentialsID: 'docker-hub', variable: 'dockerHubPwd')]){
                    sh "docker login -u akashkhandare -p ${dockerHubPwd}"
                    sh "docker push akashkhandare/node:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./chnageTag.sh ${DOCKER_TAG}"
                sshagent(['k8s-machine']) {
                    sh "scp -o strctHostkeychecking=no service.yaml node-app-deploy.yaml ec2-user@0.0.0.0:/home/ec2-user/ "
                    script{
                        try{
                            sh "ssh ec2-user@35.77.107.125 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ec2-user@35.77.107.125 kubectl create -f ."
                        }
                    }
                }
            }
        }
    }
}                            
