# 1. Shell Functions

Functions are used to organize code into reusable blocks. Instead of writing the same commands multiple times, we write them once inside a function and call the function whenever needed.

Functions improve:
- Code readability
- Reusability
- Maintainability
- Modularity

---

# 1.1 Why do we need Functions?

Suppose we need to greet three users.

Without functions:

```bash
echo "Hello Viral"

echo "Hello Rahul"

echo "Hello Priya"
```

This works, but if the greeting changes, every occurrence must be updated.

Using a function:

```bash
greet(){
    echo "Hello"
}

greet
greet
greet
```

The same block of code can now be reused multiple times.

---

# 1.2 Declaring a Function

There are two common ways to declare a function.

Method 1

```bash
greet(){

    echo "Hello World"

}
```

Method 2

```bash
function greet {

    echo "Hello World"

}
```

Both are valid, but the first method is more commonly used.

---

# 1.3 Calling a Function

Functions are called simply by writing their name.

Example

```bash
#!/bin/bash

greet(){

    echo "Welcome to Shell Scripting"

}

greet
```

Output

```text
Welcome to Shell Scripting
```

A function can be called multiple times.

```bash
greet
greet
greet
```

Output

```text
Welcome to Shell Scripting
Welcome to Shell Scripting
Welcome to Shell Scripting
```

---

# 1.4 Passing Arguments to Functions

Functions can accept values called **arguments**.

Example

```bash
greet(){

    echo "Hello $1"

}

greet Viral
```

Output

```text
Hello Viral
```

Here:

```text
$1 → First Argument
```

More arguments:

```bash
details(){

    echo "Name : $1"
    echo "City : $2"

}

details Viral Junagadh
```

Output

```text
Name : Viral
City : Junagadh
```

Argument variables:

| Variable | Meaning |
|----------|---------|
| $1 | First Argument |
| $2 | Second Argument |
| $3 | Third Argument |
| $@ | All Arguments |
| $# | Number of Arguments |

Example

```bash
show(){

    echo "Total Arguments : $#"

    echo "All Arguments : $@"

}

show Java AWS Linux
```

Output

```text
Total Arguments : 3

All Arguments : Java AWS Linux
```

---

# 1.5 Returning Values

Unlike Java, shell functions usually display output using `echo`.

Example

```bash
sum(){

    result=$((10+20))

    echo $result

}

sum
```

Output

```text
30
```

Functions can also return an exit status using `return`.

Example

```bash
check(){

    return 0

}

check

echo $?
```

Output

```text
0
```

Here:

- `0` means Success.
- Any non-zero value usually indicates an error.

---

# 1.6 Local and Global Variables

## Global Variable

Variables declared outside functions are available everywhere.

Example

```bash
name="Viral"

show(){

    echo $name

}

show
```

Output

```text
Viral
```

---

## Local Variable

Local variables exist only inside a function.

Example

```bash
show(){

    local city="Junagadh"

    echo $city

}

show
```

Outside the function:

```bash
echo $city
```

Nothing is printed because the variable no longer exists outside the function.

---

# 1.7 Function Exit Status

Every Linux command returns an exit status.

```text
0 → Success

Non-zero → Failure
```

Example

```bash
mkdir project

echo $?
```

If the directory is created successfully:

```text
0
```

If an error occurs:

```text
1
```

The same concept applies to functions.

---

# 1.8 Practical Examples

## Example 1 - Addition Function

```bash
add(){

    echo $(( $1+$2 ))

}

add 20 10
```

Output

```text
30
```

---

## Example 2 - Check Even or Odd

```bash
check(){

    if [ $(($1%2)) -eq 0 ]
    then

        echo "Even"

    else

        echo "Odd"

    fi

}

check 15
```

Output

```text
Odd
```

---

## Example 3 - Greeting Function

```bash
greet(){

    echo "Welcome $1"

}

greet Viral
```

Output

```text
Welcome Viral
```

---

# 1.9 Extra Topics

## Benefits of Functions

Functions help to:

- Reduce duplicate code.
- Improve readability.
- Simplify maintenance.
- Break large scripts into smaller reusable blocks.
- Make debugging easier.

---

## Local vs Global Variables

| Local Variable | Global Variable |
|----------------|-----------------|
| Exists only inside a function | Accessible throughout the script |
| Declared using `local` | Declared outside functions |

---

## Exit Status

Every function and Linux command returns an exit status.

```text
0 → Success

1 → Error

2 → Invalid Usage
```

The exit status can be checked using:

```bash
echo $?
```

---

# 1.10 Functions in DevOps

Functions are commonly used to organize deployment scripts.

Example

```bash
#!/bin/bash

build(){

    echo "Building Docker Image"

    docker build -t app .

}

deploy(){

    echo "Deploying Application"

    kubectl apply -f deployment.yaml

}

cleanup(){

    echo "Cleaning Temporary Files"

    rm -rf temp/

}

build

deploy

cleanup
```

This makes deployment scripts easier to understand and maintain.

---

# 1.11 Summary

- Functions group related commands into reusable blocks.
- Functions are declared once and can be called multiple times.
- Arguments are passed using `$1`, `$2`, `$3`, etc.
- `echo` is commonly used to produce output.
- `return` is used to indicate success or failure through an exit status.
- Local variables exist only within a function, while global variables are accessible throughout the script.
- Functions improve the structure, readability, and maintainability of shell scripts.