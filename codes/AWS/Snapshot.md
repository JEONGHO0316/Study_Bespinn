```
[ec2-user@ip-10-0-0-7 ~]$ sudo lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0   8G  0 part /
├─nvme0n1p127 259:2    0   1M  0 part 
└─nvme0n1p128 259:3    0  10M  0 part /boot/efi

[ec2-user@ip-10-0-0-7 ~]$ sudo growpart /dev/nvme0n1 1
CHANGED: partition=1 start=24576 old: size=16752607 end=16777183 new: size=41918431 end=41943007
[ec2-user@ip-10-0-0-7 ~]$ sudo lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0  20G  0 part /
├─nvme0n1p127 259:2    0   1M  0 part 
└─nvme0n1p128 259:3    0  10M  0 part /boot/efi

[ec2-user@ip-10-0-0-7 ~]$ df -Th
Filesystem       Type      Size  Used Avail Use% Mounted on
devtmpfs         devtmpfs  4.0M     0  4.0M   0% /dev
tmpfs            tmpfs     453M     0  453M   0% /dev/shm
tmpfs            tmpfs     181M  432K  181M   1% /run
/dev/nvme0n1p1   xfs       8.0G  1.6G  6.5G  20% /
tmpfs            tmpfs     453M     0  453M   0% /tmp
/dev/nvme0n1p128 vfat       10M  1.3M  8.7M  13% /boot/efi
tmpfs            tmpfs      91M     0   91M   0% /run/user/1000

[ec2-user@ip-10-0-0-7 ~]$ ls
[ec2-user@ip-10-0-0-7 ~]$ sudo xfs_growfs -d /
meta-data=/dev/nvme0n1p1         isize=512    agcount=2, agsize=1047040 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1
data     =                       bsize=4096   blocks=2094075, imaxpct=25
         =                       sunit=128    swidth=128 blks
naming   =version 2              bsize=16384  ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=4096  sunit=4 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 2094075 to 5239803

[ec2-user@ip-10-0-0-7 ~]$ df -Th
Filesystem       Type      Size  Used Avail Use% Mounted on
devtmpfs         devtmpfs  4.0M     0  4.0M   0% /dev
tmpfs            tmpfs     453M     0  453M   0% /dev/shm
tmpfs            tmpfs     181M  432K  181M   1% /run
/dev/nvme0n1p1   xfs        20G  1.7G   19G   9% /
tmpfs            tmpfs     453M     0  453M   0% /tmp
/dev/nvme0n1p128 vfat       10M  1.3M  8.7M  13% /boot/efi
tmpfs            tmpfs      91M     0   91M   0% /run/user/1000

[ec2-user@ip-10-0-0-7 ~]$ sudo resize2fs /dev/xvda1 
resize2fs 1.46.5 (30-Dec-2021)
resize2fs: Bad magic number in super-block while trying to open /dev/xvda1
Couldn't find valid filesystem superblock.
[ec2-user@ip-10-0-0-7 ~]$ df -Th
Filesystem       Type      Size  Used Avail Use% Mounted on
devtmpfs         devtmpfs  4.0M     0  4.0M   0% /dev
tmpfs            tmpfs     453M     0  453M   0% /dev/shm
tmpfs            tmpfs     181M  432K  181M   1% /run
/dev/nvme0n1p1   xfs        20G  1.7G   19G   9% /
tmpfs            tmpfs     453M     0  453M   0% /tmp
/dev/nvme0n1p128 vfat       10M  1.3M  8.7M  13% /boot/efi
tmpfs            tmpfs      91M     0   91M   0% /run/user/1000
```

1. EBS 볼륨 하나 더 추가 후 
2. 파일 시스템 포맷 후 볼륨 연결할 폴더생성 
3. +마운트 하는 작업까지 

```
[ec2-user@ip-10-0-0-7 ~]$ lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0  20G  0 part /
├─nvme0n1p127 259:2    0   1M  0 part 
└─nvme0n1p128 259:3    0  10M  0 part /boot/efi
nvme1n1       259:4    0  10G  0 disk 

[ec2-user@ip-10-0-0-7 ~]$ sudo mkdir /data
[ec2-user@ip-10-0-0-7 ~]$ ls
[ec2-user@ip-10-0-0-7 ~]$ sudo mkfs.xfs /dev/nvme1n1
meta-data=/dev/nvme1n1           isize=512    agcount=16, agsize=163840 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1
data     =                       bsize=4096   blocks=2621440, imaxpct=25
         =                       sunit=1      swidth=1 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[ec2-user@ip-10-0-0-7 ~]$ sudo mount /dev/nvme1n1 /data

[ec2-user@ip-10-0-0-7 ~]$ lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0  20G  0 part /
├─nvme0n1p127 259:2    0   1M  0 part 
└─nvme0n1p128 259:3    0  10M  0 part /boot/efi
nvme1n1       259:4    0  10G  0 disk /data


복제 볼륨 서버
[ec2-user@ip-10-0-0-7 ~]$ lsblk
NAME          MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0  20G  0 disk 
├─nvme0n1p1   259:1    0  20G  0 part /
├─nvme0n1p127 259:2    0   1M  0 part 
└─nvme0n1p128 259:3    0  10M  0 part /boot/efi
nvme1n1       259:4    0  10G  0 disk /data
nvme2n1       259:5    0  20G  0 disk 
├─nvme2n1p1   259:6    0  20G  0 part 
├─nvme2n1p127 259:7    0   1M  0 part 
└─nvme2n1p128 259:8    0  10M  0 part 
```
