# AWS ALB vs NLB – Quick Notes

## ALB vs NLB

| Feature | ALB | NLB |
|---------|-----|-----|
| Layer | L7 (HTTP/HTTPS) | L4 (TCP/UDP/TLS) |
| Static Public IP | ❌ No | ✅ Yes |
| Elastic IP | ❌ No | ✅ Yes |
| Path/Host Routing | ✅ Yes | ❌ No |

---

## ALB

- One ALB resource.
- AWS manages multiple ALB nodes internally.
- Nodes can be added/removed as traffic changes.
- **IPs may change**, so always use the ALB DNS name.

```
Internet
    │
 ALB DNS
    │
Dynamic ALB Nodes
    │
 EC2/ECS
```

---

## NLB

- One NLB resource.
- **One NLB node per enabled Availability Zone.**
- Each node gets **one static public IP** (or one Elastic IP).
- Clients can whitelist these IPs.

```
          One NLB
             │
     ┌───────┼───────┐
     │       │       │
   AZ-a    AZ-b    AZ-c
 Static    Static   Static
   IP        IP       IP
```

---

## Does NLB Scale?

**Yes.**

- You only see **one public-facing node/IP per AZ**.
- AWS scales the infrastructure **behind** that node.
- **Static IP never changes.**

---

## Remember

### ALB
- ❌ No Static IP
- ❌ No Elastic IP
- ✅ Use DNS name

### NLB
- ✅ Static IP
- ✅ One static IP per enabled AZ
- ✅ Elastic IP supported

---

## Interview Points

- **ALB scales by changing nodes → IPs can change.**
- **NLB scales internally while keeping the same static IPs.**
- **One NLB node per enabled AZ.**
- **Use NLB when a fixed public IP is required (e.g., firewall whitelisting).**
- **Use ALB for HTTP features like path-based routing, host-based routing, and WAF.**