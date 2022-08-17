pipeline {

agent any

stages {

stage('Checkout') {

steps {

git branch: 'main', credentialsId: 'vprasadk111', url: 'https://github.com/vprasadk111/terrafoem_2022.git'

}

}


stage('terraform initialize') {

steps {

sh 'terraform init'

}

}

stage('terraform plan') {

steps {

sh 'terraform plan'

}

}

}

}
