# 1. Shell Programming Basics

Unlike Linux commands, Shell Programming allows us to make **decisions**, **repeat tasks**, and **perform calculations**, just like programming languages such as Java or Python.

---

# 1.1 Arithmetic Expressions

Arithmetic expressions perform mathematical calculations.

Example:

```bash
#!/bin/bash

a=20
b=10

sum=$((a+b))

echo $sum
```

Output

```text
30
```

---

## Arithmetic Operators

| Operator | Meaning |
|----------|---------|
| + | Addition |
| - | Subtraction |
| * | Multiplication |
| / | Division |
| % | Modulus (Remainder) |

Example

```bash
a=15
b=4

echo $((a+b))
echo $((a-b))
echo $((a*b))
echo $((a/b))
echo $((a%b))
```

Output

```text
19
11
60
3
3
```

---

## Reading Input

```bash
read -p "Enter first number: " a
read -p "Enter second number: " b

echo "Sum = $((a+b))"
```

Output

```text
Enter first number: 5
Enter second number: 8

Sum = 13
```

---

# 1.2 Logical Conditions

Logical conditions help us compare values.

Example:

```
Age >= 18
Salary > 50000
Marks == 90
```

The result is either:

```text
True
```

or

```text
False
```

---

## Comparison Operators

| Operator | Meaning |
|----------|---------|
| -eq | Equal |
| -ne | Not Equal |
| -gt | Greater Than |
| -lt | Less Than |
| -ge | Greater Than or Equal |
| -le | Less Than or Equal |

Example

```bash
a=20
b=10

if [ $a -gt $b ]
then
    echo "A is greater"
fi
```

Output

```text
A is greater
```

---

## String Comparison

| Operator | Meaning |
|----------|---------|
| = | Equal |
| != | Not Equal |
| -z | Empty String |
| -n | Not Empty |

Example

```bash
name="Viral"

if [ "$name" = "Viral" ]
then
    echo "Welcome"
fi
```

---

# 1.3 If Condition

An **if statement** executes code only if the condition is true.

Syntax

```bash
if [ condition ]
then
    statements
fi
```

Example

```bash
marks=80

if [ $marks -ge 35 ]
then
    echo "Pass"
fi
```

Output

```text
Pass
```

---

## Real Example

```bash
disk=75

if [ $disk -gt 70 ]
then
    echo "Disk usage is high"
fi
```

This type of check is commonly used in DevOps monitoring scripts.

---

# 1.4 If Else

If the condition is false, the else block executes.

Syntax

```bash
if [ condition ]
then
    statements
else
    statements
fi
```

Example

```bash
age=16

if [ $age -ge 18 ]
then
    echo "Eligible to vote"
else
    echo "Not eligible"
fi
```

Output

```text
Not eligible
```

---

# 1.5 Else If (elif)

Used when multiple conditions need to be checked.

Syntax

```bash
if [ condition ]
then
    statements

elif [ condition ]
then
    statements

else
    statements
fi
```

Example

```bash
marks=82

if [ $marks -ge 90 ]
then
    echo "Grade A"

elif [ $marks -ge 75 ]
then
    echo "Grade B"

elif [ $marks -ge 50 ]
then
    echo "Grade C"

else
    echo "Fail"

fi
```

Output

```text
Grade B
```

---

# 1.6 Nested If

An if statement inside another if statement.

Example

```bash
age=20
citizen="yes"

if [ $age -ge 18 ]
then

    if [ "$citizen" = "yes" ]
    then
        echo "Eligible"
    fi

fi
```

---

# 1.7 Logical Operators

Sometimes one condition is not enough.

Example

```
Age >=18
AND
Citizen = Yes
```

---

## AND

```bash
&&
```

Example

```bash
if [ $age -ge 18 ] && [ "$citizen" = "yes" ]
then
    echo "Eligible"
fi
```

---

## OR

```bash
||
```

Example

```bash
if [ $marks -ge 35 ] || [ "$sports" = "yes" ]
then
    echo "Selected"
fi
```

---

## NOT

```bash
!
```

Example

```bash
if ! [ $age -lt 18 ]
then
    echo "Adult"
fi
```

---

# 1.8 Loops

Loops repeat the same task multiple times.

Instead of writing

```bash
echo Hello
echo Hello
echo Hello
echo Hello
```

We use loops.

---

## For Loop

Syntax

```bash
for variable in values
do
    statements
done
```

Example

```bash
for i in 1 2 3 4 5
do
    echo $i
done
```

Output

```text
1
2
3
4
5
```

---

## Another Example

```bash
for file in *.txt
do
    echo $file
done
```

Prints every text file.

---

## While Loop

Runs while the condition is true.

Syntax

```bash
while [ condition ]
do
    statements
done
```

Example

```bash
count=1

while [ $count -le 5 ]
do
    echo $count
    count=$((count+1))
done
```

Output

```text
1
2
3
4
5
```

---

## Until Loop

Runs until the condition becomes true.

Example

```bash
count=1

until [ $count -gt 5 ]
do
    echo $count
    count=$((count+1))
done
```

---

## Break

Stops the loop immediately.

Example

```bash
for i in 1 2 3 4 5
do

    if [ $i -eq 3 ]
    then
        break
    fi

    echo $i

done
```

Output

```text
1
2
```

---

## Continue

Skips the current iteration.

Example

```bash
for i in 1 2 3 4 5
do

    if [ $i -eq 3 ]
    then
        continue
    fi

    echo $i

done
```

Output

```text
1
2
4
5
```

---

# 1.9 Case Statement

The **case statement** is similar to Java's `switch`.

Instead of multiple if-else blocks, it compares one value against multiple options.

Syntax

```bash
case variable in

pattern1)
    commands
    ;;

pattern2)
    commands
    ;;

*)
    default commands
    ;;

esac
```

Example

```bash
read -p "Enter Choice: " choice

case $choice in

1)
    echo "Java"
    ;;

2)
    echo "Python"
    ;;

3)
    echo "Linux"
    ;;

*)
    echo "Invalid Choice"
    ;;

esac
```

Output

```text
Enter Choice: 2

Python
```

---

# 1.10 Extra Topics

## Comparison Operators

| Operator | Meaning |
|----------|---------|
| -eq | Equal |
| -ne | Not Equal |
| -gt | Greater Than |
| -lt | Less Than |
| -ge | Greater Than or Equal |
| -le | Less Than or Equal |

---

## Logical Operators

| Operator | Meaning |
|----------|---------|
| && | AND |
| || | OR |
| ! | NOT |

---

## Why Shell Programming is Important in DevOps

Shell scripting is widely used for:

- Deployment Automation
- Backup Scripts
- Log Monitoring
- Docker Automation
- Kubernetes Automation
- Jenkins Pipelines
- GitHub Actions
- AWS EC2 Server Management

Example

```bash
#!/bin/bash

echo "Building Docker Image"

docker build -t app .

docker push app

kubectl apply -f deployment.yaml

echo "Deployment Successful"
```

---

# 1.11 Summary

- Arithmetic expressions perform mathematical calculations.
- Logical conditions compare values.
- `if`, `else`, and `elif` help make decisions.
- Loops repeat tasks automatically.
- `case` is an alternative to multiple `if-else` statements.
- Shell programming is a fundamental skill for Linux administration and DevOps automation.