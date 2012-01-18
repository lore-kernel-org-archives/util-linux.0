Return-Path: util-linux-owner@vger.kernel.org
Received: from nm9.bullet.mail.sp2.yahoo.com ([98.139.91.79]:36097 "HELO
	nm9.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752228Ab2ARPdz (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Jan 2012 10:33:55 -0500
Message-ID: <4F16E65E.2090208@yahoo.com.ar>
Date: Wed, 18 Jan 2012 12:33:50 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Kay Sievers <kay.sievers@vrfy.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Buffer I/O error, with latest losetup on first run
References: <4F16279F.3040100@yahoo.com.ar> <20120118121301.GA2371@x2.net.home>
In-Reply-To: <20120118121301.GA2371@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/18/2012 09:13 AM, Karel Zak wrote:
> On Tue, Jan 17, 2012 at 10:59:59PM -0300, Gerardo Exequiel Pozzi wrote:
>> Using (losetup from util-linux 2.20.620-4360-dirty) and Linux-3.2.1.
>>
>> Using losetup as first time, if loop module is not loaded, losetup -f
>> file-equal-or-below-1MiB I get: "Buffer I/O error on device loop0, logical
>> block 0" (sometimes get one message, or two or three, ...)
> It does not sound like userspace problem, I guess that the message comes
> from kernel (dmesg). It would be also nice to have strace output.
Yes, message is from kernel. Remember that sometimes works without any 
error, its random.

# strace losetup -f 1M
execve("/sbin/losetup", ["losetup", "-f", "1M"], [/* 13 vars */]) = 0
brk(0)                                  = 0x8ede000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7845000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=26081, ...}) = 0
mmap2(NULL, 26081, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb783e000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, 
"\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\225\1\0004\0\0\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1954497, ...}) = 0
mmap2(NULL, 1710788, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0xb769c000
mmap2(0xb7838000, 12288, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19c) = 0xb7838000
mmap2(0xb783b000, 10948, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb783b000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb769b000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb769b6c0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7838000, 8192, PROT_READ)   = 0
mprotect(0x8052000, 4096, PROT_READ)    = 0
mprotect(0xb7867000, 4096, PROT_READ)   = 0
munmap(0xb783e000, 26081)               = 0
brk(0)                                  = 0x8ede000
brk(0x8eff000)                          = 0x8eff000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=3111552, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb749b000
close(3)                                = 0
close(0)                                = 0
close(0)                                = -1 EBADF (Bad file descriptor)
uname({sys="Linux", node="archsrv", ...}) = 0
stat64("/dev/loop-control", {st_mode=S_IFCHR, st_rdev=makedev(10, 237), 
...}) = 0
open("/dev/loop-control", O_RDWR|O_LARGEFILE) = 0
ioctl(0, 0x4c82, 0xb783bda0)            = 0
close(0)                                = 0
getcwd("/root", 4095)                   = 6
readlink("/root/1M", 0xbf9859ab, 4096)  = -1 EINVAL (Invalid argument)
open("/root/1M", O_RDWR|O_LARGEFILE)    = 0
open("/dev/loop0", O_RDWR|O_LARGEFILE)  = 3
ioctl(3, LOOP_SET_FD[   32.948747] Buffer I/O error on device loop0, 
logical block 0
[   32.949764] Buffer I/O error on device loop0, logical block 0
, 0)                = 0
close(0)                                = 0
ioctl(3, LOOP_SET_STATUS64, 0xbf986b64) = 0
close(3)                                = 0
exit_group(0)                           = ?


>> Can be reproducible again if loop module is unloaded then execute losetup.
>> Does not happen if module is loaded previously to losetup.
>> Happens independently if /dev/loop0 exists or not.
>>
>> Does not happen with losetup from 2.20 under the same conditions.
> The new losetup uses /dev/loop-control to get the new free loop device.

Yes, I know, I expected something like this for a long time. Many thanks :)

I more info is needed please let me know.

-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

