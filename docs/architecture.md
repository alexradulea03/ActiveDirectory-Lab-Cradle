# Network & Active Directory Architecture

## Domain Details
*   **Root Domain:** `gatekeeper.local`
*   **NetBIOS Name:** `GATEKEEPER`
*   **Functional Level:** Windows Server 2022

## Network Segmentation
| Hostname | Role | OS | IP Address | Subnet Mask | Gateway | DNS 1 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **DC01** | Domain Controller / DNS | Windows Server 2022 | `10.0.0.10` | `255.255.255.0` | `10.0.0.1` | `127.0.0.1` |
| **WS01** | Finance Workstation | Windows 10/11 Pro | `10.0.0.20` | `255.255.255.0` | `10.0.0.1` | `10.0.0.10` |
| **WS02** | IT Workstation | Windows 10/11 Pro | `10.0.0.21` | `255.255.255.0` | `10.0.0.1` | `10.0.0.10` |

## Organizational Unit Plan
gatekeeper.local (Root)
│
└── 🏢 Corp-OUs
    ├── 👥 Groups (Security & Distribution groups)
    ├── 🖥️ Computers
    │   ├── 💻 Workstations
    │   └── 🖥️ Servers
    └── 🧑‍🤝‍🧑 Users
        ├── 💼 Finance
        ├── 🛠️ IT-Admin
        └── 📢 Marketing