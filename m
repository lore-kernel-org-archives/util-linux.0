Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: losesetup -f, broken error handling
Date: Tue, 13 May 2014 23:11:40 +0200
Cc: util-linux@vger.kernel.org
References: <201405121510.46066.sweet_f_a@gmx.de> <20140513092016.GN8951@x2.net.home>
In-Reply-To: <20140513092016.GN8951@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405132311.40706.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 13 May 2014, Karel Zak wrote:
> On Mon, May 12, 2014 at 03:10:45PM +0200, Ruediger Meier wrote:
> > Hi,
> >
> > When having a kernel without loop device support
> > $ losetup -f
> > returns 0 and no warning on stderr
>
>  The return code is mistake, but there is:
>
>      warn(_("cannot find an unused loop device"));
>
>  in the code. Please, try
>
>     # LOOPDEV_DEBUG=yes losetup -f
>
>  or (and) strace would be also nice.
>
>     Karel

Below the otput of following commands. For comparison the first losetupfrom PATH
is the installed one util-linux 2.20.1. Full build log here
https://s3.amazonaws.com/archive.travis-ci.org/jobs/25104283/log.txt

I've run them as non-root but could repeat as root if needed.

echo "######## losetup -V"
losetup -V; true
echo "######## losetup -f"
losetup -f; echo $?
echo "######## LOOPDEV_DEBUG=yes strace losetup -f"
LOOPDEV_DEBUG=yes strace losetup -f; echo $?
echo "######## ./losetup -V"
./losetup -V; true
echo "######## ./losetup -f"
./losetup -f; echo $?
echo "######## LOOPDEV_DEBUG=yes ./losetup -f"
LOOPDEV_DEBUG=yes ./losetup -f; echo $?
echo "######## LOOPDEV_DEBUG=yes strace ./losetup -f"
LOOPDEV_DEBUG=yes strace ./losetup -f; echo $?


######## losetup -V
losetup: invalid option -- 'V'
######## losetup -f
losetup: Could not find any loop device. Maybe this kernel does not know
       about the loop device? (If so, recompile or `modprobe loop'.)
255
######## LOOPDEV_DEBUG=yes strace losetup -f
execve("/sbin/losetup", ["losetup", "-f"], [/* 80 vars */]) = 0
brk(0)                                  = 0x17df000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1db801f000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64", 0x7ffff0538d60) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls", 0x7ffff0538d60) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64", 0x7ffff0538d60) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=57866, ...}) = 0
mmap(NULL, 57866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f1db8008000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\30\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1802936, ...}) = 0
mmap(NULL, 3917016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f1db7a38000
mprotect(0x7f1db7beb000, 2093056, PROT_NONE) = 0
mmap(0x7f1db7dea000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b2000) = 0x7f1db7dea000
mmap(0x7f1db7df0000, 17624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f1db7df0000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1db801e000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1db801d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1db8019000
arch_prctl(ARCH_SET_FS, 0x7f1db801d700) = 0
mprotect(0x7f1db7dea000, 16384, PROT_READ) = 0
mprotect(0x609000, 4096, PROT_READ)     = 0
mprotect(0x7f1db801a000, 4096, PROT_READ) = 0
munmap(0x7f1db8008000, 57866)           = 0
brk(0)                                  = 0x17df000
brk(0x1800000)                          = 0x1800000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2919792, ...}) = 0
mmap(NULL, 2919792, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f1db7768000
close(3)                                = 0
stat("/dev/", {st_mode=S_IFDIR|0755, st_size=660, ...}) = 0
stat("/dev/loop", 0x7ffff0539330)       = -1 ENOENT (No such file or directory)
open("/dev/loop0", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop1", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop2", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop3", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop4", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop5", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop6", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/dev/loop7", O_RDONLY)            = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/dev/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 33 entries */, 32768)    = 872
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1db8018000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2570
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f1db8018000, 4096)            = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.utf8/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "losetup: Could not find any loop"..., 141losetup: Could not find any loop device. Maybe this kernel does not know
       about the loop device? (If so, recompile or `modprobe loop'.)) = 141
write(2, "\n", 1
)                       = 1
exit_group(-1)                          = ?
255
######## ./losetup -V
lt-losetup from util-linux 2.24.749-4bbea
######## ./losetup -f
/dev/loop0
0
######## LOOPDEV_DEBUG=yes ./losetup -f
loopdev:  [0x7fffc2164b50]: init: disable /sys usage
loopdev:  [0x7fffc2164b50]: find_unused requested
loopdev:  [0x7fffc2164b50]: iter: initialize
loopdev:  [0x7fffc2164b50]: iter: next
loopdev:  [0x7fffc2164b50]: iter: next: default check
loopdev:  [0x7fffc2164b50]: loop0 successfully assigned
loopdev:  [0x7fffc2164b50]: open /dev/loop0 [ro]: No such file or directory
loopdev:  [0x7fffc2164b50]: get_offset [rc=-22]
loopdev:  [0x7fffc2164b50]: iter: de-initialize
loopdev:  [0x7fffc2164b50]: find_unused by scan [rc=0]
/dev/loop0
loopdev:  [0x7fffc2164b50]: de-initialize
loopdev:  [0x7fffc2164b50]: iter: de-initialize
0
######## LOOPDEV_DEBUG=yes strace ./losetup -f
execve("./losetup", ["./losetup", "-f"], [/* 80 vars */]) = 0
brk(0)                                  = 0x1126000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f539e842000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64", 0x7fff1b437290) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls", 0x7fff1b437290) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64", 0x7fff1b437290) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("tls/x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("x86_64/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("libtinfo.so.5", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=57866, ...}) = 0
mmap(NULL, 57866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f539e828000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\301\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=159200, ...}) = 0
mmap(NULL, 2255936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f539e3f0000
mprotect(0x7f539e412000, 2097152, PROT_NONE) = 0
mmap(0x7f539e612000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7f539e612000
close(3)                                = 0
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/x86_64/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("x86_64/libdl.so.2", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("libdl.so.2", O_RDONLY|O_CLOEXEC)  = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\r\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=14768, ...}) = 0
mmap(NULL, 2109704, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f539e1e8000
mprotect(0x7f539e1ea000, 2097152, PROT_NONE) = 0
mmap(0x7f539e3ea000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x7f539e3ea000
close(3)                                = 0
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\30\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1802936, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f539e841000
mmap(NULL, 3917016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f539de28000
mprotect(0x7f539dfdb000, 2093056, PROT_NONE) = 0
mmap(0x7f539e1da000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b2000) = 0x7f539e1da000
mmap(0x7f539e1e0000, 17624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f539e1e0000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f539e840000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f539e83f000
arch_prctl(ARCH_SET_FS, 0x7f539e840700) = 0
mprotect(0x7f539e1da000, 16384, PROT_READ) = 0
mprotect(0x7f539e3ea000, 4096, PROT_READ) = 0
mprotect(0x7f539e612000, 16384, PROT_READ) = 0
mprotect(0x6df000, 4096, PROT_READ)     = 0
mprotect(0x7f539e83a000, 4096, PROT_READ) = 0
munmap(0x7f539e828000, 57866)           = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK)     = 3
close(3)                                = 0
brk(0)                                  = 0x1126000
brk(0x1127000)                          = 0x1127000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2919792, ...}) = 0
mmap(NULL, 2919792, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f539db58000
close(3)                                = 0
brk(0x1128000)                          = 0x1128000
brk(0x1129000)                          = 0x1129000
getuid()                                = 1000
getgid()                                = 1000
geteuid()                               = 1000
getegid()                               = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x112a000)                          = 0x112a000
open("/proc/meminfo", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f539e83e000
read(3, "MemTotal:        3145728 kB\nMemF"..., 1024) = 588
close(3)                                = 0
munmap(0x7f539e83e000, 4096)            = 0
brk(0x112b000)                          = 0x112b000
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
uname({sys="Linux", node="testing-worker-linux-6-1-30204-linux-19-25104283", ...}) = 0
brk(0x112c000)                          = 0x112c000
brk(0x112d000)                          = 0x112d000
brk(0x112e000)                          = 0x112e000
brk(0x112f000)                          = 0x112f000
brk(0x1130000)                          = 0x1130000
brk(0x1131000)                          = 0x1131000
brk(0x1132000)                          = 0x1132000
stat("/home/travis/build/rudimeier/util-linux", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
stat(".", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
getpid()                                = 25046
open("/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26258, ...}) = 0
mmap(NULL, 26258, PROT_READ, MAP_SHARED, 3, 0) = 0x7f539e830000
close(3)                                = 0
getppid()                               = 25045
brk(0x1133000)                          = 0x1133000
brk(0x1134000)                          = 0x1134000
getpgrp()                               = 1170
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
getrlimit(RLIMIT_NPROC, {rlim_cur=514038, rlim_max=514038}) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("./losetup", O_RDONLY)             = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0x7fff1b437978) = -1 ENOTTY (Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "#! /bin/bash\n\n# losetup - tempor"..., 80) = 80
lseek(3, 0, SEEK_SET)                   = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=64000, rlim_max=64000}) = 0
fcntl(255, F_GETFD)                     = -1 EBADF (Bad file descriptor)
dup2(3, 255)                            = 255
close(3)                                = 0
fcntl(255, F_SETFD, FD_CLOEXEC)         = 0
fcntl(255, F_GETFL)                     = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat(255, {st_mode=S_IFREG|0775, st_size=8653, ...}) = 0
lseek(255, 0, SEEK_CUR)                 = 0
brk(0x1136000)                          = 0x1136000
brk(0x1137000)                          = 0x1137000
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
brk(0x1138000)                          = 0x1138000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x1139000)                          = 0x1139000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x113a000)                          = 0x113a000
brk(0x113b000)                          = 0x113b000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
lseek(255, -7266, SEEK_CUR)             = 910
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25047
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
close(4)                                = 0
read(3, "allexport      \toff\n", 128)  = 20
read(3, "braceexpand    \ton\nemacs        "..., 128) = 128
read(3, "     \toff\nhistory        \toff\nig"..., 128) = 128
read(3, " \toff\nnoexec         \toff\nnoglob"..., 128) = 128
brk(0x113c000)                          = 0x113c000
read(3, "ysical       \toff\npipefail      "..., 128) = 128
read(3, "     \toff\n", 128)            = 10
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 25047
wait4(-1, 0x7fff1b436e58, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
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
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25049
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 25049
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, 0x7fff1b436f98, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nrelink_command=\"(cd /home/travi"..., 8176) = 7526
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x113d000)                          = 0x113d000
brk(0x113e000)                          = 0x113e000
brk(0x113f000)                          = 0x113f000
brk(0x1140000)                          = 0x1140000
brk(0x1141000)                          = 0x1141000
brk(0x1142000)                          = 0x1142000
brk(0x1143000)                          = 0x1143000
brk(0x1144000)                          = 0x1144000
brk(0x1145000)                          = 0x1145000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
brk(0x1146000)                          = 0x1146000
brk(0x1147000)                          = 0x1147000
brk(0x1148000)                          = 0x1148000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x1149000)                          = 0x1149000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x114a000)                          = 0x114a000
brk(0x114b000)                          = 0x114b000
brk(0x114c000)                          = 0x114c000
brk(0x114d000)                          = 0x114d000
brk(0x114e000)                          = 0x114e000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x114f000)                          = 0x114f000
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25050
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
close(4)                                = 0
read(3, ".\n", 128)                     = 2
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 25050
wait4(-1, 0x7fff1b435858, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25053
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
close(4)                                = 0
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 25053
wait4(-1, 0x7fff1b435bd8, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
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
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25056
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
close(4)                                = 0
read(3, "/home/travis/build/rudimeier/uti"..., 128) = 40
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 25056
wait4(-1, 0x7fff1b4362d8, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", {st_mode=S_IFREG|0775, st_size=220694, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f539e8409d0) = 25057
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
close(4)                                = 0
read(3, "/home/travis/build/rudimeier/uti"..., 128) = 57
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 25057
wait4(-1, 0x7fff1b4363d8, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {0x43f140, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", {st_mode=S_IFREG|0775, st_size=220694, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
brk(0x1150000)                          = 0x1150000
rt_sigaction(SIGINT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigaction(SIGQUIT, {SIG_DFL, [], SA_RESTORER, 0x7f539de5e4c0}, {SIG_IGN, [], SA_RESTORER, 0x7f539de5e4c0}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, {0x441a00, [], SA_RESTORER|SA_RESTART, 0x7f539de5e4c0}, 8) = 
0
execve("/home/travis/build/rudimeier/util-linux/.libs/lt-losetup", ["/home/travis/build/rudimeier/uti"..., "-f"], [/* 80 vars */]) = 0
brk(0)                                  = 0x10f4000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c65f98000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/tls/x86_64/libsmartcols.so.1", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/tls/x86_64", 0x7fff20b9f8b0) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/tls/libsmartcols.so.1", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/tls", 0x7fff20b9f8b0) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/x86_64/libsmartcols.so.1", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/build/rudimeier/util-linux/.libs/x86_64", 0x7fff20b9f8b0) = -1 ENOENT (No such file or directory)
open("/home/travis/build/rudimeier/util-linux/.libs/libsmartcols.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`Y\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0775, st_size=484191, ...}) = 0
mmap(NULL, 2222032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f4c65b50000
mprotect(0x7f4c65b6d000, 2093056, PROT_NONE) = 0
mmap(0x7f4c65d6c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1c000) = 0x7f4c65d6c000
mmap(0x7f4c65d6e000, 2000, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f4c65d6e000
close(3)                                = 0
open("/home/travis/build/rudimeier/util-linux/.libs/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or 
directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/x86_64", 0x7fff20b9f880) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/tls", 0x7fff20b9f880) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/x86_64", 0x7fff20b9f880) = -1 ENOENT (No such file or directory)
open("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat("/home/travis/.gvm/pkgsets/go1.2/global/overlay/lib", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
open("tls/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("tls/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT (No such file or directory)
open("libc.so.6", O_RDONLY|O_CLOEXEC)   = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=57866, ...}) = 0
mmap(NULL, 57866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f4c65f80000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\30\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1802936, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c65f97000
mmap(NULL, 3917016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f4c65790000
mprotect(0x7f4c65943000, 2093056, PROT_NONE) = 0
mmap(0x7f4c65b42000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b2000) = 0x7f4c65b42000
mmap(0x7f4c65b48000, 17624, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f4c65b48000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c65f96000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c65f95000
arch_prctl(ARCH_SET_FS, 0x7f4c65f96700) = 0
mprotect(0x7f4c65b42000, 16384, PROT_READ) = 0
mprotect(0x7f4c65d6c000, 4096, PROT_READ) = 0
mprotect(0x60e000, 4096, PROT_READ)     = 0
mprotect(0x7f4c65f92000, 4096, PROT_READ) = 0
munmap(0x7f4c65f80000, 57866)           = 0
brk(0)                                  = 0x10f4000
brk(0x1115000)                          = 0x1115000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2919792, ...}) = 0
mmap(NULL, 2919792, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f4c654c0000
close(3)                                = 0
stat("/sys/block", 0x7fff20b9fbc0)      = -1 ENOENT (No such file or directory)
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "init: disable /sys usage", 24init: disable /sys usage) = 24
write(2, "\n", 1
)                       = 1
stat("/dev/loop-control", 0x7fff20b9fbc0) = -1 ENOENT (No such file or directory)
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "find_unused requested", 21find_unused requested)   = 21
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "iter: initialize", 16iter: initialize)        = 16
write(2, "\n", 1
)                       = 1
stat("/dev/loop", 0x7fff20b9fd80)       = -1 ENOENT (No such file or directory)
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "iter: next", 10iter: next)              = 10
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "iter: next: default check", 25iter: next: default check) = 25
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "loop0 successfully assigned", 27loop0 successfully assigned) = 27
write(2, "\n", 1
)                       = 1
open("/dev/loop0", O_RDONLY|O_CLOEXEC)  = -1 ENOENT (No such file or directory)
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c654bf000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2570
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x7f4c654bf000, 4096)            = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "open /dev/loop0 [ro]: No such fi"..., 47open /dev/loop0 [ro]: No such file or directory) = 47
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "get_offset [rc=-22]", 19get_offset [rc=-22])     = 19
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "iter: de-initialize", 19iter: de-initialize)     = 19
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "find_unused by scan [rc=0]", 26find_unused by scan [rc=0]) = 26
write(2, "\n", 1
)                       = 1
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c654bf000
write(1, "/dev/loop0\n", 11/dev/loop0
)            = 11
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "de-initialize", 13de-initialize)           = 13
write(2, "\n", 1
)                       = 1
write(2, "loopdev:  [0x7fff20b9ff40]: ", 28loopdev:  [0x7fff20b9ff40]: ) = 28
write(2, "iter: de-initialize", 19iter: de-initialize)     = 19
write(2, "\n", 1
)                       = 1
close(1)                                = 0
munmap(0x7f4c654bf000, 4096)            = 0
close(2)                                = 0
exit_group(0)                           = ?
0


cu,
Rudi
