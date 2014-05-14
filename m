Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55798 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbaENM4j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 May 2014 08:56:39 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: losesetup -f, broken error handling
Date: Wed, 14 May 2014 14:56:35 +0200
Cc: util-linux@vger.kernel.org
References: <201405121510.46066.sweet_f_a@gmx.de> <201405132311.40706.sweet_f_a@gmx.de> <20140514110450.GC26357@x2.net.home>
In-Reply-To: <20140514110450.GC26357@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405141456.36138.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 14 May 2014, Karel Zak wrote:
> On Tue, May 13, 2014 at 11:11:40PM +0200, Ruediger Meier wrote:
> > Below the otput of following commands. For comparison the first
> > losetupfrom PATH is the installed one util-linux 2.20.1. Full build
> > log here
> > https://s3.amazonaws.com/archive.travis-ci.org/jobs/25104283/log.tx
> >t
>
>  The comparison is unnecessary as the code and semantic is very
> different.
>
>  Anyway, it's real issue, because on systems without
> /dev/loop-control it might incorrectly returns loop0 although the
> device does not exist.
>
> > lt-losetup from util-linux 2.24.749-4bbea
> > ######## ./losetup -f
> > /dev/loop0
> > 0
>
>  I hope it's fixed now. Please, try it again.
>
>     Karel

Thanks! This looks good now, see build log at the end.

Just for the record. Now we have a little different behavior of -f if 
you run as root or non-root.

$ sudo modprobe -r loop
$ ./losetup -f
losetup: cannot find an unused loop device: No such file or directory
$ sudo ./losetup -f
/dev/loop0
## now loop module is loaded and it works for the user as well
$ ./losetup -f
/dev/loop0

That's IMO ok, allthough it could be also nice to
  1. not have side-effects (modprobe loop)
  2. let it work as user when loop is not loaded (just to find out if
     system has loop support)
If that would be possible to implement at all.

An argument against 1. and 2. is that the returned device should 
probably always exist already. Maybe we could add another
option "--check-loop-support" which works without modprobe and equally 
for root and non-root.

cu,
Rudi

##########################
build log of fixed losetup

https://s3.amazonaws.com/archive.travis-ci.org/jobs/25149161/log.txt

######## ./losetup -V
lt-losetup from util-linux 2.24.752-2c5e
######## ./losetup -f
lt-losetup: cannot find an unused loop device: No such file or directory
1
######## LOOPDEV_DEBUG=yes ./losetup -f
loopdev:  [0x7fff39e7bc70]: init: disable /sys usage
loopdev:  [0x7fff39e7bc70]: find_unused requested
loopdev:  [0x7fff39e7bc70]: iter: initialize
loopdev:  [0x7fff39e7bc70]: iter: next
loopdev:  [0x7fff39e7bc70]: iter: next: default check
loopdev:  [0x7fff39e7bc70]: loop0 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop0 does not exist
loopdev:  [0x7fff39e7bc70]: loop1 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop1 does not exist
loopdev:  [0x7fff39e7bc70]: loop2 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop2 does not exist
loopdev:  [0x7fff39e7bc70]: loop3 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop3 does not exist
loopdev:  [0x7fff39e7bc70]: loop4 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop4 does not exist
loopdev:  [0x7fff39e7bc70]: loop5 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop5 does not exist
loopdev:  [0x7fff39e7bc70]: loop6 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop6 does not exist
loopdev:  [0x7fff39e7bc70]: loop7 name assigned
loopdev:  [0x7fff39e7bc70]: iter: /dev/loop7 does not exist
loopdev:  [0x7fff39e7bc70]: iter: next: scan /dev
loopdev:  [0x7fff39e7bc70]: iter: de-initialize
loopdev:  [0x7fff39e7bc70]: iter: de-initialize
loopdev:  [0x7fff39e7bc70]: find_unused by scan [rc=1]
lt-losetup: cannot find an unused loop device: No such file or directory
loopdev:  [0x7fff39e7bc70]: de-initialize
loopdev:  [0x7fff39e7bc70]: iter: de-initialize
1
######## LOOPDEV_DEBUG=yes strace ./losetup -f
execve("./losetup", ["./losetup", "-f"], [/* 80 vars */]) = 0
brk(0)                                  = 0x706000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3ec1b35000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64/libtinfo.so.5", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64", 
0x7fffb8e1b890) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/libtinfo.so.5", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls", 
0x7fffb8e1b890) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64/libtinfo.so.5", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64", 
0x7fffb8e1b890) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libtinfo.so.5", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib", 
{st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("tls/x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No 
such file or directory)
open("tls/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
open("x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
open("libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=57866, ...}) = 0
mmap(NULL, 57866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f3ec1b20000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/x86_64-linux-gnu/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\301\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=159200, ...}) = 0
mmap(NULL, 2255936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7f3ec16e8000
mprotect(0x7f3ec170a000, 2097152, PROT_NONE) = 0
mmap(0x7f3ec190a000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x22000) = 0x7f3ec190a000
close(3)                                = 0
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libdl.so.2", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/x86_64/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
open("tls/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
open("x86_64/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
open("libdl.so.2", O_RDONLY|O_CLOEXEC)  = -1 ENOENT (No such file or 
directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/x86_64-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\r\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=14768, ...}) = 0
mmap(NULL, 2109704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7f3ec14e0000
mprotect(0x7f3ec14e2000, 2097152, PROT_NONE) = 0
mmap(0x7f3ec16e2000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x2000) = 0x7f3ec16e2000
close(3)                                = 0
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or 
directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\30\2\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1802936, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3ec1b31000
mmap(NULL, 3917016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7f3ec1120000
mprotect(0x7f3ec12d3000, 2093056, PROT_NONE) = 0
mmap(0x7f3ec14d2000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x1b2000) = 0x7f3ec14d2000
mmap(0x7f3ec14d8000, 17624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7f3ec14d8000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3ec1b30000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3ec1b2f000
arch_prctl(ARCH_SET_FS, 0x7f3ec1b30700) = 0
mprotect(0x7f3ec14d2000, 16384, PROT_READ) = 0
mprotect(0x7f3ec16e2000, 4096, PROT_READ) = 0
mprotect(0x7f3ec190a000, 16384, PROT_READ) = 0
mprotect(0x6df000, 4096, PROT_READ)     = 0
mprotect(0x7f3ec1b32000, 4096, PROT_READ) = 0
munmap(0x7f3ec1b20000, 57866)           = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK)     = 3
close(3)                                = 0
brk(0)                                  = 0x706000
brk(0x707000)                           = 0x707000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2919792, ...}) = 0
mmap(NULL, 2919792, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f3ec0e50000
close(3)                                = 0
brk(0x708000)                           = 0x708000
brk(0x709000)                           = 0x709000
getuid()                                = 1000
getgid()                                = 1000
geteuid()                               = 1000
getegid()                               = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x70a000)                           = 0x70a000
open("/proc/meminfo", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7f3ec1b2e000
read(3, "MemTotal:        3145728 kB\nMemF"..., 1024) = 560
close(3)                                = 0
munmap(0x7f3ec1b2e000, 4096)            = 0
brk(0x70b000)                           = 0x70b000
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f3ec11564c0}, 
8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
uname({sys="Linux", 
node="testing-worker-linux-4-1-25225-linux-3-25149161", ...}) = 0
brk(0x70c000)                           = 0x70c000
brk(0x70d000)                           = 0x70d000
brk(0x70e000)                           = 0x70e000
brk(0x70f000)                           = 0x70f000
brk(0x710000)                           = 0x710000
brk(0x711000)                           = 0x711000
brk(0x712000)                           = 0x712000
stat("/home/travis/build/rudimeier/util-linux", {st_mode=S_IFDIR|0775, 
st_size=4096, ...}) = 0
stat(".", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
getpid()                                = 25085
open("/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 
3
fstat(3, {st_mode=S_IFREG|0644, st_size=26258, ...}) = 0
mmap(NULL, 26258, PROT_READ, MAP_SHARED, 3, 0) = 0x7f3ec1b28000
close(3)                                = 0
getppid()                               = 25084
brk(0x713000)                           = 0x713000
brk(0x714000)                           = 0x714000
getpgrp()                               = 1189
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f3ec11564c0}, 
8) = 0
getrlimit(RLIMIT_NPROC, {rlim_cur=514040, rlim_max=514040}) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("./losetup", O_RDONLY)             = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fffb8e1bf78) = -1 ENOTTY 
(Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "#! /bin/bash\n\n# losetup - tempor"..., 80) = 80
lseek(3, 0, SEEK_SET)                   = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=64000, rlim_max=64000}) = 0
fcntl(255, F_GETFD)                     = -1 EBADF (Bad file descriptor)
dup2(3, 255)                            = 255
close(3)                                = 0
fcntl(255, F_SETFD, FD_CLOEXEC)         = 0
fcntl(255, F_GETFL)                     = 0x8000 (flags O_RDONLY|
O_LARGEFILE)
fstat(255, {st_mode=S_IFREG|0775, st_size=8653, ...}) = 0
lseek(255, 0, SEEK_CUR)                 = 0
brk(0x716000)                           = 0x716000
brk(0x717000)                           = 0x717000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "#! /bin/bash\n\n# losetup - tempor"..., 8176) = 8176
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x718000)                           = 0x718000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x719000)                           = 0x719000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x71a000)                           = 0x71a000
brk(0x71b000)                           = 0x71b000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
lseek(255, -7266, SEEK_CUR)             = 910
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25086
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
close(4)                                = 0
read(3, "allexport      \toff\nbraceexpand "..., 128) = 39
read(3, "emacs          \toff\nerrexit     "..., 128) = 128
read(3, "      \toff\nignoreeof      \toff\ni"..., 128) = 128
read(3, "  \toff\nnoglob         \toff\nnolog"..., 128) = 128
brk(0x71c000)                           = 0x71c000
read(3, "ipefail       \toff\nposix        "..., 128) = 119
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 
25086
wait4(-1, 0x7fffb8e1b458, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "BIN_SH=xpg4; export BIN_SH # for"..., 8176) = 7743
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
lseek(255, -7526, SEEK_CUR)             = 1127
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25088
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 25088
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, 0x7fffb8e1b598, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nrelink_command=\"(cd /home/travi"..., 8176) = 7526
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x71d000)                           = 0x71d000
brk(0x71e000)                           = 0x71e000
brk(0x71f000)                           = 0x71f000
brk(0x720000)                           = 0x720000
brk(0x721000)                           = 0x721000
brk(0x722000)                           = 0x722000
brk(0x723000)                           = 0x723000
brk(0x724000)                           = 0x724000
brk(0x725000)                           = 0x725000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x726000)                           = 0x726000
brk(0x727000)                           = 0x727000
brk(0x728000)                           = 0x728000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x729000)                           = 0x729000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x72a000)                           = 0x72a000
brk(0x72b000)                           = 0x72b000
brk(0x72c000)                           = 0x72c000
brk(0x72d000)                           = 0x72d000
brk(0x72e000)                           = 0x72e000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x72f000)                           = 0x72f000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25089
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
close(4)                                = 0
read(3, ".\n", 128)                     = 2
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 
25089
wait4(-1, 0x7fffb8e19e58, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25092
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
close(4)                                = 0
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 
25092
wait4(-1, 0x7fffb8e1a1d8, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25095
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
close(4)                                = 0
read(3, "/home/travis/build/rudimeier/uti"..., 128) = 40
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 
25095
wait4(-1, 0x7fffb8e1a8d8, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", 
{st_mode=S_IFREG|0775, st_size=220958, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
SIGCHLD, child_tidptr=0x7f3ec1b309d0) = 25096
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
close(4)                                = 0
read(3, "/home/travis/build/rudimeier/uti"..., 128) = 57
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 
25096
wait4(-1, 0x7fffb8e1a9d8, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{0x43f140, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", 
{st_mode=S_IFREG|0775, st_size=220958, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x730000)                           = 0x730000
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f3ec11564c0}, 
{SIG_IGN, [], SA_RESTORER, 0x7f3ec11564c0}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 
0x7f3ec11564c0}, 8) = 0
execve("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", 
["/home/travis/build/rudimeier/uti"..., "-f"], [/* 80 vars */]) = 0
brk(0)                                  = 0x90a000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fe74b506000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/home/travis/build/rudimeier/util-linux/.libs/tls/x86_64/libsmartcols.so.1", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/tls/x86_64", 
0x7fffed185d00) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/tls/libsmartcols.so.1", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/tls", 
0x7fffed185d00) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/x86_64/libsmartcols.so.1", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/x86_64", 
0x7fffed185d00) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/libsmartcols.so.1", 
O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`Y\0\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0775, st_size=484447, ...}) = 0
mmap(NULL, 2222032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fe74b0c0000
mprotect(0x7fe74b0dd000, 2093056, PROT_NONE) = 0
mmap(0x7fe74b2dc000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x1c000) = 0x7fe74b2dc000
mmap(0x7fe74b2de000, 2000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7fe74b2de000
close(3)                                = 0
open("/home/travis/build/rudimeier/util-linux/.libs/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64", 
0x7fffed185cd0) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls", 
0x7fffed185cd0) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64", 
0x7fffed185cd0) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libc.so.6", 
O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib", 
{st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such 
file or directory)
open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file 
or directory)
open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=57866, ...}) = 0
mmap(NULL, 57866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fe74b0b0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\30\2\0\0\0\0\0"..., 
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1802936, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fe74b508000
mmap(NULL, 3917016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x7fe74acf0000
mprotect(0x7fe74aea3000, 2093056, PROT_NONE) = 0
mmap(0x7fe74b0a2000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x1b2000) = 0x7fe74b0a2000
mmap(0x7fe74b0a8000, 17624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x7fe74b0a8000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fe74b505000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fe74b501000
arch_prctl(ARCH_SET_FS, 0x7fe74b505700) = 0
mprotect(0x7fe74b0a2000, 16384, PROT_READ) = 0
mprotect(0x7fe74b2dc000, 4096, PROT_READ) = 0
mprotect(0x60e000, 4096, PROT_READ)     = 0
mprotect(0x7fe74b502000, 4096, PROT_READ) = 0
munmap(0x7fe74b0b0000, 57866)           = 0
brk(0)                                  = 0x90a000
brk(0x92b000)                           = 0x92b000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2919792, ...}) = 0
mmap(NULL, 2919792, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fe74aa20000
close(3)                                = 0
stat("/sys/block", 0x7fffed186010)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "init: disable /sys usage", 24init: disable /sys usage) = 24
write(2, "\n", 1
)                       = 1
stat("/dev/loop-control", 0x7fffed186010) = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "find_unused requested", 21find_unused requested)   = 21
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: initialize", 16iter: initialize)        = 16
write(2, "\n", 1
)                       = 1
stat("/dev/loop", 0x7fffed1861d0)       = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: next", 10iter: next)              = 10
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: next: default check", 25iter: next: default check) = 25
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop0 name assigned", 19loop0 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop0", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop0 does not exist", 31iter: /dev/loop0 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop1 name assigned", 19loop1 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop1", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop1 does not exist", 31iter: /dev/loop1 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop2 name assigned", 19loop2 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop2", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop2 does not exist", 31iter: /dev/loop2 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop3 name assigned", 19loop3 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop3", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop3 does not exist", 31iter: /dev/loop3 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop4 name assigned", 19loop4 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop4", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop4 does not exist", 31iter: /dev/loop4 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop5 name assigned", 19loop5 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop5", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop5 does not exist", 31iter: /dev/loop5 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop6 name assigned", 19loop6 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop6", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop6 does not exist", 31iter: /dev/loop6 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "loop7 name assigned", 19loop7 name assigned)     = 19
write(2, "\n", 1
)                       = 1
stat("/dev/loop7", 0x7fffed186180)      = -1 ENOENT (No such file or 
directory)
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: /dev/loop7 does not exist", 31iter: /dev/loop7 does not 
exist) = 31
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: next: scan /dev", 21iter: next: scan /dev)   = 21
write(2, "\n", 1
)                       = 1
openat(AT_FDCWD, "/dev/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 33 entries */, 32768)    = 872
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: de-initialize", 19iter: de-initialize)     = 19
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: de-initialize", 19iter: de-initialize)     = 19
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "find_unused by scan [rc=1]", 26find_unused by scan [rc=1]) = 
26
write(2, "\n", 1
)                       = 1
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x7fe74b500000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2570
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7fe74b500000, 4096)            = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) 
= -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/util-linux.mo", O_RDONLY) 
= -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) 
= -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.utf8/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/util-linux.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "lt-losetup: ", 12lt-losetup: )            = 12
write(2, "cannot find an unused loop devic"..., 33cannot find an unused 
loop device) = 33
write(2, ": ", 2: )                       = 2
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT 
(No such file or directory)
open("/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/libc.mo", O_RDONLY) 
= -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) 
= -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 
ENOENT (No such file or directory)
write(2, "No such file or directory\n", 26No such file or directory
) = 26
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "de-initialize", 13de-initialize)           = 13
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fffed186390]: ", 28loopdev:  [0x7fffed186390]: ) 
= 28
write(2, "iter: de-initialize", 19iter: de-initialize)     = 19
write(2, "\n", 1
)                       = 1
close(1)                                = 0
close(2)                                = 0
exit_group(1)                           = ?
1
