# Why SSH Fails via SG Reference but Works with 0.0.0.0/0 (AWS Security Groups)

## The Setup
- Windows EC2 instance trying to SSH into a Linux EC2 instance.
- Linux instance's inbound rule for port 22 (TCP) allows traffic from the **Windows instance's Security Group** (SG reference), not a CIDR block.
- SSH fails when connecting to the Linux instance's **public IP**.
- SSH works when the rule is opened to **0.0.0.0/0** (any IP).

## Why This Happens
When you reference a Security Group as the *source* in an inbound rule, AWS matches traffic based on the **private IP / ENI** of instances in that SG — not the public IP.

That match only works reliably when:
1. Both instances are in the **same VPC** (or peered VPCs with SG-referencing enabled), **and**
2. The connection is made to the target's **private IP address**.

If you SSH to the Linux instance's **public IP**, the traffic path goes out through the Internet Gateway and back in. AWS can no longer attribute that inbound traffic to the Windows instance's SG, so the SG-reference rule doesn't match — connection gets blocked. Opening to `0.0.0.0/0` "fixes" it only because it removes the source restriction entirely, not because the SG logic changed.

## Practical Fix
Connect using the **private IP** of the Linux instance instead of the public IP: (if private ip is reachable)

```powershell
ssh -i ".\linux-key-pair.pem" ec2-user@<linux-private-ip>
```

Find the private IP:
- EC2 Console → Instances → select instance → "Private IPv4 addresses"
- Or via CLI:
```powershell
aws ec2 describe-instances --instance-ids i-xxxxxxxx --query "Reservations[].Instances[].PrivateIpAddress"
```

## Checklist If It Still Doesn't Work
- [ ] Both instances are in the **same VPC**
- [ ] If in different subnets: route tables and NACLs allow traffic between them
- [ ] If in different VPCs: SG references don't work across VPCs unless using **VPC peering with SG-referencing enabled** — otherwise use CIDR-based rules
- [ ] Once private-IP SSH works, remove the `0.0.0.0/0` rule and rely solely on the SG reference for tighter security

## Key Takeaway
SG-to-SG rules are a **private-network** mechanism, not a public-IP allowlist. Use private IPs for intra-VPC access — it's both the fix and the more secure pattern.