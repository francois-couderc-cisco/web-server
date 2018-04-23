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

   stage('Deploy'){
     print "Install sshpass"
     sh "apt-get install -y sshpass"
     withCredentials([usernamePassword(credentialsId: 'kubernetes', usernameVariable: 'SSH_USER', passwordVariable: 'SSH_PASS')]) {
        print 'ssh to laptop and update deployment'
        sudo sh "sshpass -p $SSH_PASS ssh -oStrictHostKeyChecking=no $SSH_USER@10.60.9.41 touch TEST.2.0.0"
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

