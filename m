Return-Path: systemd-devel-bounces@lists.freedesktop.org
Date: Tue, 24 Jun 2014 07:21:12 +0000
From: Minchan Kim <minchan@kernel.org>
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <20140624065816.GA11030@gmail.com>
References: <53953D5C.1080004@gmail.com> <i8pg6b-mg8.ln1@hurikhan77.spdns.de>
 <5395BE60.70309@gmail.com> <pd8h6b-ufa.ln1@hurikhan77.spdns.de>
 <5395FF3A.9050407@gmail.com> <20140624062209.GA10661@gmail.com>
 <53A91C0A.2020807@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53A91C0A.2020807@gmail.com>
Cc: util-linux@vger.kernel.org, Kai Krakow <hurikhan77@gmail.com>,
        systemd-devel@lists.freedesktop.org, kay@vrfy.org,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [systemd-devel] systemd-213: regression with zram
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 24, 2014 at 12:34:50PM +0600, Alexander E. Patrakov wrote:
> 24.06.2014 12:22, Minchan Kim wrote:
> >
> >Hello,
> >
> >Sorry for the late response.
> 
> Better late than never.
> 
> >If I parse your problem correctly, you meant that changing disksize is
> >failed while someone opens /dev/zram0?
> >
> >I tried test which opens "/dev/zram0" with O_RDWR and sleep forever
> >and then echo $((512<<20)) > /sys/block/zram0/disksize is successful.
> >IOW, it's okay with me.
> 
> No, this is only a part of the problem. A valid test would be:
> 
> 0. Reset the unused zram device.
> 1. Use a program that opens /dev/zram0 with O_RDWR and sleeps until killed.
> 2. While that program sleeps, echo the correct value to
> /sys/block/zram0/disksize.
> 3. Verify (e.g. in /proc/partitions) that the disk size is applied
> correctly. It is.
> 4. While that program still sleeps, attempt to mkswap /dev/zram0.
> This fails:
> 
> mkswap: error: swap area needs to be at least 40 KiB
> 
> There is nothing in dmesg.

Thanks. I could reproduce.
When I read strace result, fstat access closed fd which seem to be
a culprit.

Cced util-linux.

<snip>

open("/dev/zram0", O_RDONLY)            = 4
uname({sys="Linux", node="bboxv", ...}) = 0
ioctl(4, BLKGETSIZE64, 0x7fffa2384888)  = 0
close(4)                                = 0
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f8a058ea000
read(4, "# Locale name alias data base.\n#"..., 4096) = 2570
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x7f8a058ea000, 4096)            = 0
open("/usr/share/locale/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "mkswap: ", 8mkswap: )                 = 8
write(2, "error: swap area needs to be at "..., 44error: swap area needs to be at least 40 KiB) = 44
write(2, "\n", 1
)                       = 1
write(2, "\nUsage:\n mkswap [options] device"..., 40
Usage:
 mkswap [options] device [size]
) = 40
write(2, "\nOptions:\n -c, --check          "..., 479
Options:
 -c, --check               check bad blocks before creating the swap area
 -f, --force               allow swap size area be larger than device
 -p, --pagesize SIZE       specify page size in bytes
 -L, --label LABEL         specify label
 -v, --swapversion NUM     specify swap-space version number
 -U, --uuid UUID           specify the uuid to use
 -V, --version             output version information and exit
 -h, --help                display this help and exit

) = 479
exit_group(1)                           = ?

But when it was successful, it was as follows via stat("/dev/zram0").

<snip>

open("/dev/zram0", O_RDONLY)            = 4
uname({sys="Linux", node="bboxv", ...}) = 0
ioctl(4, BLKGETSIZE64, 0x7fff85926088)  = 0
close(4)                                = 0
stat("/dev/zram0", {st_mode=S_IFBLK|0660, st_rdev=makedev(252, 0), ...}) = 0
open("/dev/zram0", O_RDWR|O_EXCL)       = 4
open("/etc/mtab", O_RDONLY|O_CLOEXEC)   = 5
fstat(5, {st_mode=S_IFREG|0644, st_size=725, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f984f537000
read(5, "/dev/vda1 / ext4 rw,errors=remou"..., 4096) = 725
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x7f984f537000, 4096)            = 0
ioctl(4, BLKALIGNOFF, 0x7fff85925fcc)   = 0
lseek(4, 0, SEEK_SET)                   = 0
ioctl(4, 0x301, 0x7fff85925fc0)         = -1 ENOTTY (Inappropriate ioctl for device)
fadvise64(4, 0, 0, POSIX_FADV_RANDOM)   = 0
fstat(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(252, 0), ...}) = 0
uname({sys="Linux", node="bboxv", ...}) = 0
ioctl(4, BLKGETSIZE64, 0x15f72b0)       = 0
ioctl(4, CDROM_GET_CAPABILITY, 0)       = -1 ENOTTY (Inappropriate ioctl for device)
lseek(4, 0, SEEK_SET)                   = 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
ioctl(4, BLKSSZGET, 0x15f72c8)          = 0
lseek(4, 15872, SEEK_SET)               = 15872
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 512) = 512
lseek(4, 28672, SEEK_SET)               = 28672
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
lseek(4, 0, SEEK_SET)                   = 0
write(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1024) = 1024
open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) = 5
fstat(5, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f984f537000
read(5, "# Locale name alias data base.\n#"..., 4096) = 2570
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0x7f984f537000, 4096)            = 0
open("/usr/share/locale/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en_US/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale-langpack/en/LC_MESSAGES/util-linux.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
fstat(1, {st_mode=S_IFREG|0644, st_size=8472, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f984f537000
lseek(4, 1024, SEEK_SET)                = 1024
write(4, "\1\0\0\0\377\377\0\0\0\0\0\0\205\236:\36b\377N\324\255\224\5\341CH(\376\0\0\0\0"..., 3072) = 3072
fsync(4)                                = 0
write(1, "Setting up swapspace version 1, "..., 102Setting up swapspace version 1, size = 262140 KiB
no label, UUID=859e3a1e-62ff-4ed4-ad94-05e1434828fe
) = 102
exit_group(0)                           = ?

> 
> -- 
> Alexander E. Patrakov
_______________________________________________
systemd-devel mailing list
systemd-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/systemd-devel
