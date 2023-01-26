pipeline {
    agent any

    stages {
        stage('Install Dependencise') {
            steps {
                echo 'Installing dependencies....'
                dir("scripts") {
                    // install ansible
                    sh "ls"
                    sh "chmod +x install-ansible.sh"
                    sh "./install-ansible.sh"
                    //install terraform
                    sh "ls"
                    sh "chmod +x install-terraform.sh"
                    sh "./install-terraform.sh"
                }
                // added check to see if terraform tfstate exists
                // then run terraform destroy (destroys all network/ec2)
                script{
                    if(fileExists('terraform/terraform.tfstate')){
                        sh 'terraform -chdir="terraform/" destroy -auto-approve'
                    }
                }
            }
        }
        stage('Run Terraform') {
            steps {
                echo 'Build infrastructure....'
                dir("terraform") {
                    sh "cd terraform/"
                    sh "terraform init"
                    sh "terraform plan"
                    sh "terraform apply"
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Ansible..'
                ansiblePlaybook credentialsId: 'AMSKey', disableHostKeyChecking: true, installation: 'ansible-config', inventory: 'ansible/inventory.yaml', playbook: 'ansible/playbook.yaml'
            }
        }
    }
}