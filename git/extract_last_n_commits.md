```shell
git rebase --onto bak_master bak_work~7 bak_work
```

1、bak_work branch will be updated, bak_master branch will not be update.
2、this command will rearrange bak_work last 7 commits as last 7 commits and also absorb bak_master all commits.
