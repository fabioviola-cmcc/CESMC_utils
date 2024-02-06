# CESMC utils

This repository hosts a set of utilities to quickly check the status of the disk, the cluster nodes, the queues etc. This repository is highly work in progress, so please be sure to often pull the news and read the doc!

## 1. Disk usage

To check the disk usage, you can simply run (either on Juno or Zeus):

```bash
$ ./diskUsage.sh 
```

You will see the **your** disk occupation on home, work, or data filesets. If you want to check for another user, please add its username as a parameter:

```bash
$ ./diskUsage.sh <username>
```
