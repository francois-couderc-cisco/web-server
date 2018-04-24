def CONTAINER_NAME="web-server"
def CONTAINER_TAG="v2.1.0"
def CONTAINER_LATEST_TAG="latest"

node {

    stage('Checkout') {
        checkout scm
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
        imageBuild(CONTAINER_NAME, CONTAINER_LATEST_TAG)
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
            pushToImage(CONTAINER_NAME, CONTAINER_LATEST_TAG, USERNAME, PASSWORD)
        }
    }


    stage('Deploy'){
        withCredentials([usernamePassword(credentialsId: 'kubernetes', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            print 'ssh to laptop and update deployment'
            sh "sudo sshpass -p $PASSWORD ssh -oStrictHostKeyChecking=no $USERNAME@10.60.9.41 kubectl set image deployment web-server-deployment web-server=fcouderc/web-server:v2.1.0 --record"
        }
    }

}

def imageBuild(containerName, tag){
    sh "sudo docker build -t $containerName:$tag ."
    echo "Image build complete"
}

def pushToImage(containerName, tag, dockerUser, dockerPassword){
    sh "sudo docker login -u $dockerUser -p $dockerPassword"
    sh "sudo docker push $dockerUser/$containerName:$tag"
    echo "Image push complete"
}

