pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies....'
                dir("scripts") {
                    // install ansible
                    sh "ls"
                    sh "sudo chmod +x install-ansible.sh"
                    sh "./install-ansible.sh"
                    //install terraform
                    sh "ls"
                    sh "sudo chmod +x install-terraform.sh"
                    sh "./install-terraform.sh"
                    
                    // added check to see if terraform tfstate exists
                    // then run terraform destroy (destroys all network/ec2)
                    script{
                        if(fileExists('terraform/terraform.tfstate')){
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
        stage('Run Terraform') {
            steps {
                echo 'Build infrastructure....'
                dir("terraform") {
                    // sh "terraform destroy -auto-approve"
                    sh "terraform init"
                    sh "terraform plan"
                    sh "terraform apply -auto-approve"
                }
            }
        }
        stage('Install dependencies on EC2') {
            steps {
                echo 'Ansible connection..'
                ansiblePlaybook credentialsId: 'AMSKey', disableHostKeyChecking: true, installation: 'ansible-config', inventory: 'inventory.yaml', playbook: 'playbook.yaml'
            }
        }
        stage('Run config playbook'){
            steps{
                sh "git clone https://github.com/Adamcoakley/team-magenta-group-two.git"
                sh "ansible-playbook config.yaml"
            }
        }
        stage('Build and push docker images'){
            steps {
                dir('./spring-petclinic-angular/'){
                    sh "sudo docker build -t adamcoakley/petclinic-frontend:latest ."
                    // sh "docker push adamcoakley/petclinic-frontend:latest"
                }
                dir('./spring-petclinic-rest/'){
                    sh "sudo docker build -t adamcoakley/petclinic-backend:latest ."
                    // sh "docker push adamcoakley/petclinic-backend:latest"
                } 
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'DockerHubPwd', variable: 'DockerHubPwd')]) {
                        sh 'sudo docker login -u adamcoakley -p ${DockerHubPwd}'
                    }
                    sh "sudo docker push adamcoakley/petclinic-backend:latest"
                    sh "sudo docker push adamcoakley/petclinic-frontend:latest"
                }
            }
        }
        stage('Deploy'){
            steps{
                ansiblePlaybook credentialsId: 'AMSKey', disableHostKeyChecking: true, installation: 'ansible-config', inventory: 'inventory.yaml', playbook: 'images.yaml'
            }
        }
    }
}