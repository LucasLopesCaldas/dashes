# Dashes
Dashes are shell scripts that do automated tasks.
These tasks will be performed by the node package [auto-dash](https://github.com/LucasLopesCaldas/auto-dash) and are called dash.

### To create or modify a dash:
1. Clone this repository: 
  <br>`git clone git@github.com:LucasLopesCaldas/dashes.git`
2. Create a new branch: 
  <br>`git checkout -b <branch name>`
3. Create a folder with the name of the task: 
  <br>`mkdir <task name>`
4. Create, modify and test a shell script inside the created folder: 
  <br>`touch index.sh`
5. Commit and push
6. Create a pull request
7. Wait for me to approve
8. **Be happy!**

# Auto Dash
[Auto dash](https://github.com/LucasLopesCaldas/auto-dash) is an online task automator.


### To list tasks:
```
npx auto-dash list
```

### To run a task:
```
npx auto-dash <task> [arguments]
```

### To run a local tasks:
```
npx auto-dash local <.sh or folder path>
```
