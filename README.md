# GCP DevOps Blueprint: GitHub Actions → Google Cloud Platform

Welcome to the **Enterprise-grade Production Boilerplate** for automated cloud deployments. This repository provides a modular, agnostic and secure framework to deploy modern backend microservices and static frontends directly into **Google Cloud Platform (GCP)** using **GitHub Actions**, managed entirely under native **GitOps and SecOps** principles.

---

## 🚀 Architectural Superpowers

- **Zero Shared Secrets (SecOps):** Native authentication powered by **Workload Identity Federation (WIF)**, eliminating the security risk of long-lived JSON service account keys.
- **Aggressive Pipeline Caching:** Optimized build workflows that cache Go, Java (Maven), Node.js and Python dependencies to cut build times dramatically.
- **True GitOps via Kustomize:** Clean infrastructure orchestration with independent, isolated target layers (**Development, UAT/QA and Production**) with no copied or repeated base YAML.
- **Modern Serverless Ecosystems:** Verified support for **GKE (Kubernetes), Cloud Run, Cloud Storage (static sites) and Cloud Functions (2nd Gen)**.

---

## ⚡ Quick Start — Setup in 5 steps

This repo ships a minimal **Go "hello-world" service** at the root (`main.go` + `Dockerfile`), so the container pipelines deploy green **before** you add your own code. Swap it for your app whenever you're ready.

### 1. Pick ONE deployment target
All four workflows in `.github/workflows/` trigger on the same branches. Keep only the one you need and **delete the other three** (or they'll run and fail):

| Your app is… | Keep this workflow |
|---|---|
| A containerized service (serverless) | `ci-cloudrun-pipeline.yml` |
| A containerized service (Kubernetes) | `ci-gke-pipeline.yml` |
| An event/webhook function | `ci-functions-pipeline.yml` |
| A static site / SPA | `ci-gcs-pipeline.yml` |

### 2. Create your GCP foundations (per environment)
A project, an Artifact Registry repo, and the enabled APIs. See **Chapter 2** of the companion eBook, or:
```bash
gcloud artifacts repositories create main-apps-repo \
  --repository-format=docker --location=us-central1 --project=YOUR_PROJECT
```

### 3. Configure Workload Identity Federation
Create the Pool, the GitHub OIDC Provider and the deploy Service Account, then bind them to this repo. Full step-by-step in **Chapter 3** of the eBook.

### 4. Fill in the placeholders
Search & replace across your chosen workflow:

| Placeholder | Replace with |
|---|---|
| `YOUR_PROJECT_NUMBER` | Your GCP project **number** |
| `YOUR_POOL_ID` / `YOUR_PROVIDER_ID` | Your WIF pool / provider IDs |
| `your-gcp-project-dev/uat/prod` | Your real project IDs |
| `your-cluster` (GKE) | Your GKE cluster name |
| `your-enterprise-frontend-bucket-*` (GCS) | Your bucket names |

### 5. Push
```bash
git checkout -b develop && git push -u origin develop
```
Watch it run under the **Actions** tab. The example service deploys; then replace `main.go` + `Dockerfile` with your own app.

---

## 📁 Repository Structure

- `main.go`, `go.mod`, `Dockerfile` — minimal example service (replace with yours).
- `.github/workflows/` — one orchestration file per deployment scenario.
- `actions/` — reusable composite actions for build and containerization.
- `kustomize/base/` — shared Kubernetes manifests (deployment, service).
- `kustomize/overlays/` — per-environment layers (namespaces, config, resource limits).

---

## 🧩 Bring-your-own-app per scenario

- **Cloud Run / GKE:** any language, as long as there's a `Dockerfile` at the root (the included Go example works out of the box).
- **Cloud Functions:** a `main.py` exporting a `handle_event` function plus `requirements.txt`.
- **GCS:** a Node build that outputs a `dist/` folder.

---

## 🎯 Go from Zero to DevOps Expert

The repository gives you the structural skeleton. The complete guide walks you through, step by step:
1. **Configure WIF** on the GCP Console to establish secure trust networks.
2. **Advanced multi-stage Docker** strategies for Go, Java, Node and Python runtimes.
3. **FinOps hacks:** run the Actions Runner Controller (ARC) inside GKE to run pipelines for free.
4. **Deep-dive troubleshooting** for every architecture.

### 📖 Get the Complete eBook on Hotmart:
👉 **[CLICK HERE TO ACCESS THE COMPLETE ENTERPRISE GUIDE (eBook ES + EN)](https://go.hotmart.com/D108428923Y)**

---

## 📝 License
Open-source boilerplate intended for educational and production reference. For the complete architectural walkthrough, see the companion eBook.
