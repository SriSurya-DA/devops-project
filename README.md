# DevOps End-to-End Project

## Overview

This project demonstrates an end-to-end DevOps workflow where an application is automatically built, deployed, and monitored. The goal was to understand how different components like CI/CD, Docker, Kubernetes, and monitoring tools work together in a real setup.

Whenever code is pushed to the repository, a pipeline is triggered that builds the application, pushes it to a container registry, and deploys it to a Kubernetes cluster running on an EC2 instance.

---

## Architecture

Code is pushed to GitHub, which triggers a GitHub Actions workflow. The workflow builds a Docker image and pushes it to Docker Hub. Kubernetes running on an EC2 instance pulls this image and deploys it as a pod. Prometheus collects metrics from the cluster, and Grafana is used to visualize them.

---

## Tools and Technologies

- GitHub for source code management  
- GitHub Actions for CI/CD  
- Docker for containerization  
- Docker Hub as image registry  
- Kubernetes for deployment and orchestration  
- Prometheus for metrics collection  
- Grafana for monitoring dashboards  
- Terraform for provisioning the EC2 instance  

---

## CI/CD Pipeline Flow

1. Code is pushed to the main branch  
2. GitHub Actions pipeline is triggered  
3. The pipeline scans the repository for secrets  
4. A Docker image is built  
5. The image is pushed to Docker Hub  
6. kubectl is used to deploy the application to Kubernetes  
7. Slack notification is sent if the pipeline fails  

---

## Kubernetes Deployment

The application is deployed using Kubernetes Deployment and Service manifests.

The Deployment ensures the required number of pods are running. The Service exposes the application.

Initially, Grafana was exposed using ClusterIP, which only allows internal access. To access it from the browser, the service was changed to NodePort.

Access format:
http://<EC2_PUBLIC_IP>:<NodePort>

---

## Monitoring

Prometheus is used to scrape metrics from the Kubernetes cluster. Grafana is used to visualize these metrics.

The dashboards show CPU and memory usage at the pod level.

At first, some panels showed no data. This was due to missing resource requests and limits in the deployment configuration. After adding them, the metrics were displayed correctly.

---

## Issues Faced and Fixes

Git push was rejected because the remote repository had changes that were not present locally. This was fixed using git pull with rebase.

The Gitleaks step failed because the pipeline did not have full git history. This was resolved by setting fetch-depth to 0.

Kubernetes deployment initially failed with a connection timeout. This happened because port 6443 was not open in the EC2 security group. Opening the port resolved the issue.

A TLS certificate error occurred because the Kubernetes API server certificate was generated with internal IP addresses, while the pipeline accessed it using the public IP. This was temporarily fixed by skipping TLS verification.

Grafana was not accessible from the browser because the service type was ClusterIP. Changing it to NodePort and opening the required port range in the security group fixed the issue.

Grafana login failed because the default credentials were not valid. The correct password was retrieved from a Kubernetes secret.

---

## Key Learnings

This project helped in understanding how CI/CD pipelines interact with Kubernetes clusters. It also provided hands-on experience in debugging real-world issues such as networking problems, certificate mismatches, and service exposure.

It also clarified how Kubernetes components like the API server, scheduler, and kubelet work together to run applications.

---

## Future Improvements

- Expose services using Ingress with a domain name  
- Add application-level metrics  
- Configure autoscaling  
- Improve security by properly configuring TLS  

---

![Alert Config](https://github.com/SriSurya-DA/devops-project/blob/main/image%20(3).png)

![Grafana Dashboard](https://github.com/SriSurya-DA/devops-project/blob/main/image%20(4).png)

---

## Author

Sri Surya
