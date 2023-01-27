# team-magenta-group-two
## Final Project - Sprint 2

# Introduction 
The aim of this project is to automate the development workflows and deployment of the Spring Pet Clinic application and migrate it to the cloud. This project will involve concepts from all core training modules; more specifically, this will involve:
* Agile methodology & Project Management 
* Databases & Cloud Fundamentals
* Programming & Testing Fundamentals
* Continuous Integration
* Infrastructure as Code & Configuration Management
* Containerisation & Orchestration
* Cloud Configuration and Management

# Team Members

* Ciara Fennessy
* Adam Coakley
* Kiishi Ifebajo
* Diego Pascual
* Niall O'Keefe

# Review of Sprint 1

Sprint 1 spanned from Monday the 16th to Thursday the 19th of January, with presentations following on Friday of the same week. The solution that Group 2 aimed to follow for in the first sprint was comprised of version control (Github), CI/CD pipeline (CodeBuild, CodePipeline, CodeDeploy) and deployment service (ECS). The team failed on delivering the final MVP by the deadline due to a number of organisational and technical issues:
* Uncertainty of design
* Lack of planning
* Underestimation and unfamiliarity regarding technologies
* Neglect of infrastructure as code

# Sprint 2

## What are we solving for?

### Regarding the project brief:
1. As provided, the application code requires the installation of dependencies, is not packaged in its environment and thus, is not easily or quickly  portable, deployed or flexible.
2. The development, testing, building and deployment of the application all have to be done manually, wasting time, money and effort and leaving little room for updates, experimentation, new features and responding to customer needs. 

### Regarding improving on our first sprint:
3. We lacked clarity in design and plan which led to time loss, cooperation breakdown and poorly thought through decision making.
4. We selected technologies based on their integration with AWS but with which we were rather unfamiliar. As a result, we ran into unknown blockers that cost us time and rocked our confidence in our already sparse plan. Furthermore, our anxiety to get to a grasp of the individual technologies  meant that we wrongfully neglected IaC.

# Design

![fp-wireframe](https://user-images.githubusercontent.com/116156151/215071989-0a994327-2b75-4114-9b24-8404c173a2b7.png)

# Solution
### Addressing the issues outline above:
1. To combat the inflexibility and immovable nature of the code we want to containerise the application and create four separate images (frontend, backend, nginx, database) that we can then push to Dockerhub. The containers will contain all dependencies that the app needs and maintain an isolated environment for the component parts that can be spun up or down rapidly and with relative ease. 
2. To tackle the issues linked to manual deployment of the application we will configure a CI/CD pipeline that will take care of the testing, building and deployment of the application. This will consist of a central Github repository that, upon a push event, will trigger a webhook to Jenkins. On receiving the trigger, Jenkins will build and containerise the application, call on terraform to configure the necessary infrastructure and invoke ansible which will configure the instances in preparation for deployment. It will then deploy the code to an instance running as the manager node of a docker swarm which will take care of orchestrating the containers across its worker nodes. All of this should be triggered by the simple push of new code to the Github repository.
3. Upon starting our first sprint, we felt panicked by the lack of time and frazzled by a wide range of technologies. We ran too fast at the technologies, hoping to learn as we went, rather than taking the time to design, plan or research. Although we had even less time for this sprint, we made sure to allocate sufficient time and energy to designing and planning our solution. We started by outlining the issues we faced in Sprint 1 along with four clear user-stories for the client (Pet Clinic owner):
* As the owner/developer of Spring Pet Clinic, I want to containerise the application, so that it will be more portable, secure, faster to deploy and flexible.
* As the owner of Spring Pet Clinic, I want to migrate my application to the public cloud, to reduce costs and maintenance
* As the owner of Spring Pet Clinic, I want to be able to update my application easily and regularly, so that I can adapt to my customers' needs.
* As the owner of Spring Pet Clinic, I want to automate the building and testing of my code, so that I can save time and manpower
We discussed the necessary steps and technologies that we would need to resolve the issues we faced in the first sprint and to meet the client’s needs. We drew a wireframe diagram (above)  to help us visualize our solution and get on the same page as a team. We broke the user-stories down into manageable tasks that needed to be completed in order to fulfill them, all of which we added to the sprint backlog on Jira.
4. We recognised that one of the biggest technical faults we succumbed to in our first sprint was to begin configuring resources manually, in a feeble attempt to come to grips with them, rather than leveraging the power of IaC to automate the provisioning and configuration of infrastructure. So, in our second iteration of this project we wanted to roll back a couple of steps and incorporate Terraform into our solution. This also freed us up from the manual CodePipeline that we had configured that we ran into many issues with. These issues derived from our inexperience with CodePipeline as well as the permissions attached to our provisioned IAM users which prevented CodeDeploy from working with EC2 instances, which is originally what drove us to considering ECS and Beanstalk as our only deployment options. Now, having freed ourselves from the yoke of CodeDeploy, we could use Jenkins to configure our pipeline and deploy to docker swarm on EC2.

# Technologies and Why:

* Github - For version control, git was used, with the project repository hosted on GitHub. On top of that, the feature branch model was used, which means, a separate branch was created for each additional feature. Once the functionality was developed, the feature branch was merged with the master branch and our team repeated this process until the project was complete.
* Jenkins - We decided to make the change from using CodeBuild to Jenkins. We had spent more time with Jenkins during training and felt more comfortable with it. It’s cloud agnostic, easy to install, free and has a wide range of plugins. 
*Dockerhub, Docker, Docker Compose, Docker Swarm - Docker is the industry standard for containerisation tools. We switched from using ECR as our image repository in Sprint 1 to Dockerhub in Sprint 2 in keeping with our general shift away from an AWS native approach. In Sprint 1, our team chose ECS as our deployment tool, a tool we had absolutely no experience with. Science we had not gotten very far with ECS, we thought it best to scrap it and revert back to something we had used during training: Docker Compose combined with Docker Swarm on EC2 instances.
* Terraform - one of the biggest pitfalls that we fell into in Sprint 1 was rushing into using the technologies manually to try and understand them and ignore the infrastructure as code that would have made provisioning and configuring them easier. That’s why we wanted to take a step back in Sprint 2 and to leverage terraform to provision the infrastructure we needed.
* Ansible - in line with the above, we wanted to direct more focus to automating the provisioning and configuration of our infrastructure in Sprint 2. We decided to use Ansible to install dependencies on and configure the EC2 instances that Terraform created for us. 

# Project Management

We set-up a second sprint on Jira to track our progress and break down our user-stories into manageable chunks. These are our user stories and their descriptions:
* As the owner/developer of Spring Pet Clinic, I want to containerise the application, so that it will be more portable, secure, faster to deploy and flexible.
  - The owner/developer would like to opt-in for containerisation and the benefits that it would bring to their application:
    - portability
    - efficiency
    - agility
    - faster delivery
    - improved security
    - faster app startup
    - easier management
    - flexibility
* As the owner of Spring Pet Clinic, I want to migrate my application to the public cloud, to reduce costs and maintenance
  - By leveraging the public cloud the owner trades CapEx for OpEx, forgoes the maintenance of hardware and only pays for what they use.
  - They also get the added benefit of near-infinite scalability, and very high reliability.
* As the owner of Spring Pet Clinic, I want to be able to update my application easily and regularly, so that I can adapt to my customers' needs.
  - The owner wants to adapt to market changes, roll out seasonal features, and experiment. They don’t want to have to reinvent the wheel every time they make a minor or major change to the application code.
  - The owner wants a short timespan between development and production, quick deployments, and simple rollbacks.
* As the owner of Spring Pet Clinic, I want to automate the building and testing of my code, so that I can save time and manpowe
  - Opting for a CI/CD pipeline means that the owner of the application could benefit from a smooth path to production with faster bug fixes, better code quality and ultimately, faster deployment to their clients.
  - CI/CD pipeline also provides the owner with the possibility for measurable progress, tighter feedback loops and more efficient infrastructure
  
We devised a list of tasks that would help us fulfill each user-story and execute our design and plan. We assigned each task a story-point estimate and assigned them to one of two epics: containerisation and automation. We took a total of 110 story-points into Sprint 2, more than we ideally would have liked. Our first sprint consisted of 101 story-points, of which we completed 88. In a real working environment, we would be hoping to take between 79 and 97 story-points into our second sprint, based on our capabilities in the first. However, in this project we must take into account the halved timespan for sprint two, our poor estimation of the effort things would take due to this being our first project of this kind, and also the vast amount we learned from Sprint 1, it being our first ever sprint. We planned to work better as a team in Sprint 2, we also had a better grasp of the project brief and how to approach it, thus, we thought we could get more done than before, relative to the little time we had. This being said, we knew that 110 story-points was still going to be a tough ask of ourselves but we were determined to give it our best shot.

<img width="1440" alt="Screenshot 2023-01-26 at 21 39 36" src="https://user-images.githubusercontent.com/116156151/215075265-7778f0c8-4d84-423e-b77c-a169cbbe9ccb.png">

<img width="848" alt="Screenshot 2023-01-26 at 21 39 51" src="https://user-images.githubusercontent.com/116156151/215075336-a6b809b5-d39a-4f12-b6cb-461447e15f58.png">

<img width="1440" alt="Screenshot 2023-01-26 at 21 41 04" src="https://user-images.githubusercontent.com/116156151/215075355-fd4aa6d0-f989-41aa-b42e-c3ca97490e9a.png">

<img width="1130" alt="Screenshot 2023-01-26 at 21 40 00" src="https://user-images.githubusercontent.com/116156151/215075379-6ea09cfd-196a-4270-9303-40d093a75625.png">

# Risk Assessment 

Before embarking on the project our team devised a cursory risk assessment (shown below) which outlines possible hazards that the application could encounter. These risks influenced our choices when developing the CI/CD pipeline for the application. For example, we followed the principal of least privilege when assigning policies to the AWS resources and users needed for our pipeline. We also chose to use reputable repository services for our source code and container images as well as avoiding sharing or hardcoding sensitive information.  Going forward we would like to further increase the security and reliability of the application and our CI/CD pipeline by integrating AWS resources such as GuardDuty.
 
