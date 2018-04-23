def CONTAINER_NAME="web-server"
def CONTAINER_TAG="v2.0.0"

node {

    stage('Checkout') {
        checkout scm
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
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

