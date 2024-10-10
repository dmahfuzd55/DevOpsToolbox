<h2 align="center">
Git Command
</h2>

GitLab

Git Initialization
```bash
git init
```
File Staging
```bash
git add .
```
Git Commit
```bash
git commit -m "Initial"
```
Local Repository connect with Remote Repository

Git Branch
----------
Check git branch
```bash
git branch
```
Create new branch
```bash
git branch main
```
Switch new branch
```bash
git checkout -b develop
```
Git Repositories Check
----------------------
```bash
git remote -v
```
```bash
git remote get-url origin
```
```bash
git remote set-url origin https://github.com/dmahfuzd55/DevOpsToolbox.git
```


Git Repositiories Remove
------------------------
```bash
git remote remove origin
```

How files transfer to repository
--------------------------------
```bash
git remote add origin http://172.8.9.41:8090/dmahfuzd/goaml_bai.git
```
```bash
git fetch origin main
```
```bash
git rebase origin/main
```
```bash
git merge origin/main
```
```bash
git push -u origin main
```

Git clone repository
--------------------
```bash
git clone http://172.8.9.41:8090/dmahfuzd/goaml_bai.git
```


Git File change check
---------------------
```bash
git diff index.js # This command show which line or content change in file
```
