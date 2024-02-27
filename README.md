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

## 2. Jobs monitor

This script helps you check the memory efficiency of your jobs. It analyses the last n jobs (n specified by the users) where a memory requirement was set. Then, it compares the requested memory with the memory that was effectively used by the job. The average percentage of memory usage is shown.

```bash
$ ./jobsMon.sh <n>
```

If you want to check the memory usage of other users (why!?), add the username as a second parameter.
