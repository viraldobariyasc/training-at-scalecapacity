# 1. Networking Basics (CIDR, IPv4, IPv6, Subnet Mask)

## 1.1 What is Networking?

Networking is the process of connecting devices so they can communicate and exchange data.

In AWS, networking is handled primarily through **Amazon VPC (Virtual Private Cloud)**.

---

## 1.2 IPv4

IPv4 is a 32-bit addressing scheme.

Example:

```
192.168.1.10
10.0.0.5
172.31.20.100
```

Maximum addresses:

```
2^32 ≈ 4.3 Billion
```

---

## 1.3 IPv6

IPv6 is a 128-bit addressing scheme introduced to overcome IPv4 address exhaustion.

Example:

```
2001:db8:85a3::8a2e:370:7334
```

Advantages:

- Huge address space.
- Better routing.
- Improved security support.

---

## 1.4 CIDR (Classless Inter-Domain Routing)

CIDR defines the network size using prefix notation.

Example:

```
10.0.0.0/16
```

Meaning:

- First 16 bits represent the network.
- Remaining bits are available for hosts.

Common CIDR Blocks:

| CIDR | Total IPs |
|------|-----------|
| /24 | 256 |
| /23 | 512 |
| /22 | 1024 |
| /21 | 2048 |
| /20 | 4096 |
| /16 | 65,536 |

**Note:** AWS reserves 5 IP addresses in every subnet.

---

## 1.5 Subnet Mask

A subnet mask separates the network portion from the host portion of an IP address.

Example:

```
CIDR: /24

Subnet Mask:

255.255.255.0
```

---

# 2. Default VPC

When a new AWS account is created, AWS automatically creates a **Default VPC** in each Region.

Features:

- Public subnets.
- Internet Gateway attached.
- Route Table configured.
- Default Security Group.
- Default Network ACL.

Suitable for:

- Learning.
- Testing.
- Small applications.

Production environments usually use a custom VPC.

---

# 3. Subnet (Public V/S Private)

## 3.1 What is a Subnet?

A subnet divides a VPC into smaller networks.

Example:

```
VPC

10.0.0.0/16

│

├── Public Subnet
│      10.0.1.0/24
│
└── Private Subnet
       10.0.2.0/24
```

---

## 3.2 Public Subnet

A subnet is public when its route table contains a route to an **Internet Gateway (IGW)**.

Typical resources:

- Load Balancer
- Bastion Host
- NAT Gateway

---

## 3.3 Private Subnet

A subnet without a route to the Internet Gateway.

Typical resources:

- Application Servers
- Databases
- Internal Services

Private subnets access the internet through a NAT Gateway when required.

---

## 3.4 Public vs Private Subnet

| Public Subnet | Private Subnet |
|---------------|----------------|
| Internet accessible | Not directly accessible |
| Route to IGW | No direct route to IGW |
| Hosts ALB, Bastion, NAT | Hosts EC2, RDS, ECS |

---

# 4. NACL (Network Access Control List)

A Network ACL is a subnet-level firewall.

It controls inbound and outbound traffic entering or leaving a subnet.

Features:

- Stateless.
- Supports Allow and Deny rules.
- Evaluated in rule order.

Example:

| Rule | Action |
|------|--------|
| Allow HTTP | Allow |
| Deny SSH | Deny |

---

# 5. Internet Gateway

An Internet Gateway (IGW) allows resources in a VPC to communicate with the internet.

```
Internet

│

Internet Gateway

│

Public Subnet

│

EC2
```

Requirements for internet access:

- Public IP or Elastic IP.
- Route to IGW.
- Security Group allowing traffic.

---

# 6. NAT Gateway

A NAT Gateway allows instances in a **Private Subnet** to access the internet without exposing them to inbound internet traffic.

Example:

```
Private EC2

│

NAT Gateway

│

Internet Gateway

│

Internet
```

Common use cases:

- Software updates.
- Download packages.
- Access external APIs.

NAT Gateway must be deployed in a Public Subnet.

---

# 7. VPC Peering

VPC Peering connects two VPCs, enabling private communication between them.

```
VPC A

│

Peering Connection

│

VPC B
```

Requirements:

- Non-overlapping CIDR blocks.
- Route table updates.

No internet is used.

---

# 8. VPC Endpoints

VPC Endpoints enable private access to AWS services without using the public internet.

Example:

```
Private EC2

│

VPC Endpoint

│

Amazon S3
```

Benefits:

- Improved security.
- Reduced latency.
- No NAT Gateway required for supported services.

Types:

- Gateway Endpoint (S3, DynamoDB)
- Interface Endpoint (Most AWS services)

---

# 9. Network Firewall

AWS Network Firewall is a managed network security service.

It filters traffic entering or leaving a VPC.

Capabilities:

- Stateful inspection.
- Intrusion prevention.
- Domain filtering.
- Traffic monitoring.

Typically deployed between subnets and the internet.

---

# 10. Client VPN

AWS Client VPN enables secure remote access to a VPC over an encrypted connection.

Example:

```
Developer Laptop

│

AWS Client VPN

│

Private VPC

│

EC2
```

Use Cases:

- Remote employees.
- Secure access to private resources.
- Hybrid cloud connectivity.

---

# 11. Practical

## Objective

Create a VPC with public and private subnets and provide secure internet access.

---

## Prerequisites

- AWS Account
- IAM permissions for VPC

---

## Steps

### Create a VPC

1. Open the VPC Console.
2. Click **Create VPC**.
3. Enter a CIDR block (e.g., `10.0.0.0/16`).

---

### Create Subnets

1. Create one Public Subnet (e.g., `10.0.1.0/24`).
2. Create one Private Subnet (e.g., `10.0.2.0/24`).

---

### Create an Internet Gateway

1. Create an IGW.
2. Attach it to the VPC.

---

### Configure Route Tables

- Public Route Table:
  - Add route `0.0.0.0/0 → Internet Gateway`.

- Private Route Table:
  - Add route `0.0.0.0/0 → NAT Gateway` (after creating a NAT Gateway).

---

### Launch Instances

- Launch one EC2 in the Public Subnet.
- Launch one EC2 in the Private Subnet.

---

### Verification

- SSH to the Public EC2.
- Verify the Private EC2 has no public IP.
- Confirm the Private EC2 can access the internet through the NAT Gateway (e.g., run `sudo apt update` or `yum update`).

---

## Expected Outcome

- Successfully created a VPC.
- Configured Public and Private Subnets.
- Enabled secure internet access for private resources.
- Understood the flow of traffic through IGW and NAT Gateway.

---

# 12. Extra Topics

## 12.1 Route Tables

A Route Table determines where network traffic is directed.

Example:

| Destination | Target |
|-------------|--------|
| 10.0.0.0/16 | Local |
| 0.0.0.0/0 | Internet Gateway |

Every subnet must be associated with a Route Table.

---

## 12.2 Elastic Network Interface (ENI)

An ENI is a virtual network card attached to an EC2 instance.

It includes:

- Private IP addresses.
- Public/Elastic IP (optional).
- Security Groups.
- MAC Address.

---

## 12.3 Security Groups vs NACL

| Security Group | Network ACL |
|----------------|-------------|
| Instance level | Subnet level |
| Stateful | Stateless |
| Allow rules only | Allow and Deny rules |
| Evaluated together | Evaluated by rule number |

---

## 12.4 Bastion Host

A Bastion Host is an EC2 instance in a Public Subnet used to securely SSH into EC2 instances located in Private Subnets.

This prevents exposing private instances directly to the internet.

---

## 12.5 Transit Gateway

AWS Transit Gateway simplifies networking by connecting multiple VPCs and on-premises networks through a central hub.

Benefits:

- Easier management.
- Scalable architecture.
- Reduces the need for multiple VPC Peering connections.

---

# 13. Interview Questions

### Q1. What is a VPC?

A Virtual Private Cloud (VPC) is a logically isolated virtual network within AWS where you launch AWS resources.

---

### Q2. What is the difference between a Public and a Private Subnet?

A Public Subnet has a route to an Internet Gateway, while a Private Subnet does not have direct internet access.

---

### Q3. Why is a NAT Gateway used?

A NAT Gateway allows instances in a Private Subnet to access the internet without allowing inbound internet connections.

---

### Q4. What is the difference between a Security Group and a Network ACL?

Security Groups are stateful and operate at the instance level, while Network ACLs are stateless and operate at the subnet level.

---

### Q5. What is a VPC Endpoint?

A VPC Endpoint enables private communication between a VPC and supported AWS services without traversing the public internet.

---

### Q6. What is VPC Peering?

VPC Peering allows two VPCs with non-overlapping CIDR ranges to communicate privately.

---

# 14. Summary

- Amazon VPC provides isolated networking for AWS resources.
- CIDR defines IP address ranges, while IPv4 and IPv6 identify network devices.
- Public and Private Subnets separate internet-facing and internal resources.
- Internet Gateways provide public internet access, whereas NAT Gateways enable outbound internet access for private resources.
- Network ACLs protect subnets, and Security Groups protect instances.
- VPC Peering and VPC Endpoints enable secure private communication.
- AWS Network Firewall and Client VPN strengthen network security and remote access.