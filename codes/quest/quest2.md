# 연습문제 1: 기본 파일 시스템 탐색
## 1-1. 현재 위치 확인 및 이동
 - 현재 작업 디렉터pw리의 절대 경로를 출력하시오.
 - 홈 디렉터리로 이동하시오.
 - 루트 디렉터리(/)로 이동하시오.
 - 다시 홈 디렉터리로 돌아가시오.

```
[jeongho@localhost ~]$ pwd
/home/jeongho
[jeongho@localhost ~]$ cd /home
[jeongho@localhost home]$ cd /
[jeongho@localhost /]$ cd /home
```

## 1-2. 디렉터리 내용 확인
 - 현재 디렉터리의 파일과 폴더 목록을 출력하시오.ㄱㄷㅁ
 - 숨김 파일을 포함한 모든 파일의 상세 정보를 출력하시오.
 - /etc 디렉터리의 내용을 확인하시오.

```
[jeongho@localhost ~]$ ls
Desktop    Downloads  Pictures  Templates
Documents  Music      Public    Videos
[jeongho@localhost ~]$ ls -l
total 0
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Desktop
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Documents
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Downloads
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Music
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Pictures
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Public
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Templates
drwxr-xr-x. 2 jeongho jeongho 6 Jul 16 10:54 Videos
[jeongho@localhost ~]$ cd /etc
[jeongho@localhost etc]$ ls
accountsservice          makedumpfile.conf.sample
adjtime                  man_db.conf
aliases                  mcelog
alsa                     microcode_ctl
alternatives             mime.types
anacrontab               mke2fs.conf
appstream.conf           modprobe.d
asound.conf              modules-load.d
at.deny                  motd
audit                    motd.d
authselect               mtab
avahi                    multipath
bash_completion.d        nanorc
bashrc                   netconfig
bindresvport.blacklist   NetworkManager
binfmt.d                 networks
bluetooth                nftables
brlapi.key               nsswitch.conf
brltty                   nsswitch.conf.bak
brltty.conf              nvme
chromium                 openldap
chrony.conf              opt
chrony.keys              os-release
cifs-utils               ostree
cockpit                  PackageKit
containers               pam.d
cron.d                   papersize
cron.daily               passwd
cron.deny                passwd-
cron.hourly              pbm2ppa.conf
cron.monthly             pinforc
crontab                  pkcs11
cron.weekly              pkgconfig
crypto-policies          pki
crypttab                 plymouth
csh.cshrc                pm
csh.login                pnm2ppa.conf
cups                     polkit-1
cupshelpers              popt.d
dbus-1                   printcap
dconf                    profile
debuginfod               profile.d
default                  protocols
depmod.d                 pulse
dhcp                     qemu-ga
DIR_COLORS               ras
DIR_COLORS.lightbgcolor  rc.d
dnf                      rc.local
dnsmasq.conf             redhat-release
dnsmasq.d                request-key.conf
dracut.conf              request-key.d
dracut.conf.d            resolv.conf
egl                      rocky-release
enscript.cfg             rocky-release-upstream
environment              rpc
ethertypes               rpm
exports                  rsyncd.conf
favicon.png              rsyslog.conf
filesystems              rsyslog.d
firefox                  rwtab.d
firewalld                samba
flatpak                  sane.d
fonts                    sasl2
foomatic                 security
fprintd.conf             selinux
fstab                    services
fuse.conf                sestatus.conf
fwupd                    setroubleshoot
gcrypt                   sgml
gdm                      shadow
geoclue                  shadow-
glvnd                    shells
gnupg                    skel
GREP_COLORS              smartmontools
groff                    sos
group                    speech-dispatcher
group-                   ssh
grub2.cfg                ssl
grub.d                   sssd
gshadow                  statetab.d
gshadow-                 subgid
gss                      subgid-
host.conf                subuid
hostname                 subuid-
hosts                    sudo.conf
hp                       sudoers
inittab                  sudoers.d
inputrc                  sudo-ldap.conf
iscsi                    sysconfig
issue                    sysctl.conf
issue.d                  sysctl.d
issue.net                systemd
kdump                    system-release
kdump.conf               system-release-cpe
kernel                   terminfo
keys                     tmpfiles.d
keyutils                 tpm2-tss
krb5.conf                trusted-key.key
krb5.conf.d              tuned
ld.so.cache              udev
ld.so.conf               udisks2
ld.so.conf.d             updatedb.conf
libaudit.conf            UPower
libblockdev              usb_modeswitch.conf
libibverbs.d             vconsole.conf
libnl                    vimrc
libpaper.d               virc
libreport                vmware-tools
libssh                   vulkan
libuser.conf             wgetrc
locale.conf              wireplumber
localtime                wpa_supplicant
login.defs               X11
logrotate.conf           xattr.conf
logrotate.d              xdg
lsm                      xml
lvm                      yum
machine-id               yum.conf
magic                    yum.repos.d
```

# 연습문제 2: 디렉터리 및 파일 생성
## 2-1. 디렉터리 구조 생성
### 다음과 같은 디렉터리 구조를 생성하시오:
```
practice/

├── documents/
│   ├── reports/ls
│   └── notes/
├── images/
└── backup/
```
```
[jeongho@localhost ~]$ mkdir practice
[jeongho@localhost ~]$ ls
Desktop    Downloads  Pictures  Public     Videos
Documents  Music      practice  Templates
[jeongho@localhost ~]$ cd /practice
bash: cd: /practice: No such file or directory
[jeongho@localhost ~]$ cd /home/jeongho/practice
[jeongho@localhost practice]$ mkdir documents
[jeongho@localhost practice]$ mkdir images
[jeongho@localhost practice]$ mkdir backup
[jeongho@localhost practice]$ ls
backup  documents  images
[jeongho@localhost practice]$ cd /home/jeongho/pracice/documents
bash: cd: /home/jeongho/pracice/documents: No such file or directory
[jeongho@localhost practice]$ cd /home/jeongho/practice/documents
[jeongho@localhost documents]$ mkdir reports
[jeongho@localhost documents]$ mkdir notes
[jeongho@localhost documents]$ cd /home/jeongho/practice/documents/reports
[jeongho@localhost reports]$ mkdir ls
[jeongho@localhost reports]$ cd ..
[jeongho@localhost documents]$ cd ..
[jeongho@localhost practice]$ tree
.
├── backup
├── documents
│   ├── notes
│   └── reports
│       └── ls
└── images
```


# 2-2. 파일 생성 및 내용 작성
- practice/documents/ 디렉터리에 readme.txt 파일을 생성하고 "Hello Linux!"라는 내용을 작성하시오.
-  practice/notes/ 디렉터리에 memo.txt 파일을 생성하고 "Linux 명령어 연습 중"이라는 내용을 작성하시오.

```
[jeongho@localhost practice]$ cd /documents
bash: cd: /documents: No such file or directory
[jeongho@localhost practice]$ cd /home/jeongho/practice/documents

[jeongho@localhost documents]$ cat >> readme.txt
"Hello Linux!"
[jeongho@localhost documents]$ ls
notes  readme.txt  reports
[jeongho@localhost documents]$ ls -
ls: cannot access '-': No such file or directory
[jeongho@localhost documents]$ ls -l
total 4
drwxr-xr-x. 2 jeongho jeongho  6 Jul 16 11:06 notes
-rw-r--r--. 1 jeongho jeongho 15 Jul 16 11:13 readme.txt
drwxr-xr-x. 3 jeongho jeongho 16 Jul 16 11:06 reports
[jeongho@localhost documents]$ cd ..
[jeongho@localhost practice]$ ls
backup  documents  images
[jeongho@localhost practice]$ cd /home/jeongho/practice/documents
[jeongho@localhost documents]$ cd /home/jeongho/practice/documents/notes
[jeongho@localhost notes]$ cat >> memo.txt
"Linux 명령어 연습중!"

[jeongho@localhost notes]$ ls
memo.txt

[jeongho@localhost documents]$ 
```

# 연습문제 3: 파일 내용 확인 및 조작
## 3-1. 파일 내용 출력
- 앞서 생성한 readme.txt 파일의 내용을 출력하시오.
- memo.txt 파일의 내용을 출력하시오.

```
[jeongho@localhost notes]$ cat  memo.txt
"Linux practice"

[jeongho@localhost documents]$ cat  readme.txt
"Hello Linux!"
```

## 3-2. 파일 복사
- readme.txt 파일을 backup/ 디렉터리에 복사하시오.
- documents/ 디렉터리 전체를 backup/ 디렉터리에 복사하시오.
```
[jeongho@localhost documents]$ cat >> readme.txt
[jeongho@localhost documents]$ cp readme.txt backup

[jeongho@localhost documents]$ cd ..
[jeongho@localhost practice]$ cp documents backup
cp: -r not specified; omitting directory 'documents'
[jeongho@localhost practice]$ ls
backup  documents  images
[jeongho@localhost practice]$ cp documents /backup
cp: -r not specified; omitting directory 'documents'
[jeongho@localhost practice]$ cp -r documents /backup
cp: cannot create directory '/backup': Permission denied
[jeongho@localhost practice]$ cp -r documents backup
[jeongho@localhost practice]$ cd /home/jeongho/practice/backup
[jeongho@localhost backup]$ ls
documents


```

# 연습문제 4: 파일 이동 및 이름 변경
## 4-1. 파일 이동
 - 파일을 documents/ 디렉터리로 이동하시오.
```
[jeongho@localhost practice]$ cd /home/jeongho/practice/notes
bash: cd: /home/jeongho/practice/notes: No such file or directory
[jeongho@localhost practice]$ cd /home/jeongho/practice
[jeongho@localhost practice]$ ls
backup  documents  images
[jeongho@localhost practice]$ cd /home/jeongho/practice/documents
[jeongho@localhost documents]$ cd /home/jeongho/practice/documents/notes
[jeongho@localhost notes]$ ls
memo.txt
[jeongho@localhost notes]$ mv memo.txt documents
[jeongho@localhost notes]$ ls
documents
[jeongho@localhost notes]$ cat documents
"Linux practice"[jeongho@localhost notes]$ mv documents memo.txt
[jeongho@localhost notes]$ mv  memo.txt /home/jeongho/practice/documents
[jeongho@localhost notes]$ cd ..
[jeongho@localhost documents]$ ls
backup  memo.txt  notes  readme.txt  reports
[jeongho@localhost documents]$ 
```
 - images/ 디렉터리를 practice/media/로 이름을 변경하시오.
 ```
[jeongho@localhost practice]$ ls
backup  documents  images
[jeongho@localhost practice]$ mv images media
[jeongho@localhost practice]$ ls
backup  documents  media
[jeongho@localhost practice]$

```

# 4-2. 파일 이름 변경
- readme.txt를 introduction.txt로 이름을 변경하시오.
- memo.txt를 study_notes.txt로 이름을 변경하시오.

```
[jeongho@localhost practice]$ cd /home/jeongho/practice/documents
[jeongho@localhost documents]$ ls
backup  memo.txt  notes  readme.txt  reports
[jeongho@localhost documents]$ mv readme.txt introduction.txt
[jeongho@localhost documents]$ mv memo.txt study_notes.txt
[jeongho@localhost documents]$ ls
backup  introduction.txt  notes  reports  study_notes.txt
[jeongho@localhost documents]$ 
```

# 연습문제 5: 종합 실습
- 5-1. 프로젝트 디렉터리 생성
- 다음 요구사항에 따라 프로젝트 디렉터리를 생성하시오:
```
[jeongho@localhost ~]$ mkdir my_project
[jeongho@localhost ~]$ cd /home/jeongho/my_project
[jeongho@localhost my_project]$ mkdir src
[jeongho@localhost my_project]$ mkdir docs
[jeongho@localhost my_project]$ mkdir tests
[jeongho@localhost my_project]$ mkdir config
[jeongho@localhost my_project]$ cd /home/jeongho/my_project/src
[jeongho@localhost src]$ cat >> main.py
"#Main Python File"[jeongho@localhost src]$ cat main.py 
"#Main Python File"[jeongho@localhost src]$ cat >> main.py
(#Main Python File")                    
[jeongho@localhost src]$ cat main.py
"#Main Python File"(#Main Python File")
[jeongho@localhost src]$ cd ..
[jeongho@localhost my_project]$ cd /home/jeongho/my_project/docs
[jeongho@localhost docs]$ cat >> README.md
"# My Project Documentation"      
[jeongho@localhost docs]$ ls
README.md
[jeongho@localhost docs]$ cd /home/jeongho/my_project/config
[jeongho@localhost config]$ cat >> settings.conf
"# Configuration File"
[jeongho@localhost config]$ ls
settings.conf

``` 
### 5-2. 백업 및 정리
- 전체 my_project/ 디렉터리를 my_project_backup/으로 복사하시오.
```
[jeongho@localhost ~]$ cp -r my_project my_project_backup
[jeongho@localhost ~]$ cd /home/jeongho/my_project_backup
[jeongho@localhost my_project_backup]$ ls
my_project
[jeongho@localhost my_project_backup]$ 
```
- my_project/src/main.py 파일을 my_project/src/app.py로 이름을 변경하시오.
```
[jeongho@localhost ~]$ cp -r my_project my_project_backup
[jeongho@localhost ~]$ cd /home/jeongho/my_project_backup
[jeongho@localhost my_project_backup]$ ls
my_project
[jeongho@localhost my_project_backup]$ cd /home/jeongho/my_project_backup/my_project
[jeongho@localhost my_project]$ cd /home/jeongho/my_project_backup/my_project/src
[jeongho@localhost src]$ ls
main.py
[jeongho@localhost src]$ mv main.py app.py
[jeongho@localhost src]$ ls
app.py


```
- my_project/docs/README.md 파일을 my_project/ 디렉터리로 이동하시오
```
[jeongho@localhost my_project]$ cd /home/jeongho/my_project_backup/my_project/docs
[jeongho@localhost docs]$ ls
README.md
[jeongho@localhost docs]$ mv README.md cd/home/jeongho/my_project_backup/my_project

[jeongho@localhost docs]$ ls
[jeongho@localhost docs]$ cd ..
[jeongho@localhost my_project]$ ls
config  docs  README.md  src  tests
[jeongho@localhost my_project]$ 

```