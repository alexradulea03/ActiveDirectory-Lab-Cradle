# ActiveDirectory-Lab-Cradle
A fully automated Active Directory home lab environment built using PowerShell and Infrastructure as Code. Features automated domain promotion, bulk user provisioning, and GPO deployment for security testing and systems administration training.

## Project Overview
This repository contains the architecture, configuration scripts, and documentation for a functional, isolated enterprise network environment deployed via **VirtualBox**. The purpose of this project is to simulate an enterprise infrastructure, demonstrating core skills in Windows Server administration, network layer debugging, Active Directory Domain Services (AD DS), and PowerShell automation.

---

## Network Architecture & Topology

The environment is hosted on a VirtualBox **NAT Network**, allowing fully private, isolated communications between virtual machines while mimicking enterprise subnet routing structures.



| Virtual Machine | Operating System | Hostname | Network Role | IP Address | DNS Server |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **DC01** | Windows Server 2022 | `DC01` | Primary Domain Controller / DNS Server | `10.0.0.10/24` | `127.0.0.1` |
| **Client01** | Windows 10/11 Pro | `DESKTOP-TLMC8SJ` | Domain Member Workstation | `10.0.0.50/24` | `10.0.0.10` |

---

## Repository Directory Structure

```text
📂 ActiveDirectory-Lab-Deployment
 ┣ 📂 assets
 ┃ ┣ 📂 screenshots
 ┃ ┗ 📜 topology-diagram
 ┣ 📂 docs
 ┃ ┣ 📜 journal.md
 ┃ ┣ 📜 active-directory-design.md
 ┃ ┣ 📜 architecture.md
 ┃ ┣ 📜 Installation-Guide.md
 ┃ ┗ 📜 Testing-Scenarios.md
 ┣ 📂 infrastructure
 ┣ 📂 provisioning
 ┃ ┣ 📜 01-setup-domain.ps1
 ┃ ┣ 📜 02-provision-users.ps1
 ┃ ┣ 📜 03-configure-gpo.ps1
 ┃ ┗ 📜 04-join-domain.ps1
 ┣ 📜 .gitignore
 ┣ 📜 LICENSE
 ┗ 📜 README.md