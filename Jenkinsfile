pipeline {

agent any

stages {

stage('Checkout') {

steps {

git branch: 'main', credentialsId: 'vprasadk111', url: 'https://github.com/vprasadk111/terrafoem_2022.git'

}

}


stage('persmission to script') {

steps {

sh 'chmod 755 test.sh'

}

}

stage('run script') {

steps {

sh './test.sh'

}

}

}

}
