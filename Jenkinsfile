pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Ansible Test') {
            steps {
                echo 'Ansible..'
                ansiblePlaybook credentialsId: 'AMSKey', disableHostKeyChecking: true, installation: 'ansible-config', inventory: 'ansible/inventory.yaml', playbook: 'ansible/playbook.yaml'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}