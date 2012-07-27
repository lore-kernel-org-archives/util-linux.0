Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34579 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab2G0R7I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 13:59:08 -0400
Received: by obbuo13 with SMTP id uo13so4590132obb.19
        for <util-linux@vger.kernel.org>; Fri, 27 Jul 2012 10:59:08 -0700 (PDT)
Message-ID: <5012D6EA.5070405@gmail.com>
Date: Fri, 27 Jul 2012 12:59:06 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
References: <20120727081033.GA14019@x2.net.home> <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com> <20120727103132.GA28708@x2.net.home> <5012B7B4.8070001@gmail.com>
In-Reply-To: <5012B7B4.8070001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bruce Dubbs wrote:
> Karel Zak wrote:
>> On Fri, Jul 27, 2012 at 10:26:24AM +0200, Sami Kerola wrote:
>>> I think it might be good idea to try to get 'make check' to run
>>> './tests/run.sh'.
>>
>>   Maybe, but many of the tests requires root permissions and it's
>>   designed for developers only. I'd like to avoid situations when the
>>   tests are executed with root permissions by automatic distro build
>>   systems etc.
>>
>>   Maybe we can improve run.sh to be require .git/ in the top level
>>   sources directory if executed with root permissions.
>
> The nature of Linux From Scratch is to build inside chroot as the root
> user.  We encourage, but do not require, our users to run tests for
> mostly confidence reasons.  We discuss test issues on our mailing lists
> to determine if problems are due to user error, our procedures, or
> upstream.  We rarely need to mention issues here.
>
> I encourage you to *not* require .git to run tests as root.

I wish a standard 'reply-to' went to the list by default.  :(

Another item for the wishlist is that /etc/adjtime not be hard coded 
throughout the application.  A configure option would be nice so it is a 
little easier for us to put adjtime in a FHS recommended location 
(/var/lib/hwclock/adjtime).

http://www.pathname.com/fhs/pub/fhs-2.3.html#VARLIBHWCLOCKSTATEDIRECTORYFORHWCLO

Also, here is a report of a build in the LFS environment.

We will configure  v2.22 with --disable-login --disable-sulogin 
--disable-su because we use the applications from shadow for equivalent 
functionality.

Using gcc 4.7.0 on a P4.  All the following are warnings, but it 
certainly looks a lot more professional to have a clean build.

   -- Bruce

lib/md5.c: In function 'MD5Final':
lib/md5.c:142:5: warning: dereferencing type-punned pointer will break 
strict-aliasing rules [-Wstrict-aliasing]
lib/md5.c:143:5: warning: dereferencing type-punned pointer will break 
strict-aliasing rules [-Wstrict-aliasing]

text-utils/more.c: In function 'main':
text-utils/more.c:322:10: warning: variable 'left' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/more.c:323:10: warning: variable 'prnames' might be clobbered 
by 'longjmp' or 'vfork' [-Wclobbered]
text-utils/more.c:324:10: warning: variable 'initopt' might be clobbered 
by 'longjmp' or 'vfork' [-Wclobbered]
text-utils/more.c:325:10: warning: variable 'srchopt' might be clobbered 
by 'longjmp' or 'vfork' [-Wclobbered]
text-utils/more.c:328:11: warning: variable 'initbuf' might be clobbered 
by 'longjmp' or 'vfork' [-Wclobbered]

tests/helpers/test_sysinfo.c: In function 'hlp_wordsize':
tests/helpers/test_sysinfo.c:30:2: warning: format '%lu' expects 
argument of type 'long unsigned int', but argument 2 has type 'unsigned 
int' [-Wformat]

sys-utils/hwclock-cmos.c: In function 'i386_iopl':
sys-utils/hwclock-cmos.c:614:13: warning: redundant redeclaration of 
'iopl' [-Wredundant-decls]
In file included from sys-utils/hwclock-cmos.c:60:0:
/usr/include/sys/io.h:39:12: note: previous declaration of 'iopl' was here

disk-utils/fsck.minix.c: In function 'check_file2':
disk-utils/fsck.minix.c:1049:11: warning: format '%zd' expects argument 
of type 'signed size_t', but argument 2 has type 'long unsigned int' 
[-Wformat]

disk-utils/mkswap.c: In function 'check_blocks':
disk-utils/mkswap.c:322:28: warning: comparison between signed and 
unsigned integer expressions [-Wsign-compare]

fdisks/sfdisk.c: In function 'extended_partition':
fdisks/sfdisk.c:1428:7: warning: format '%ld' expects argument of type 
'long int', but argument 2 has type 'size_t' [-Wformat]
fdisks/sfdisk.c: In function 'bsd_partition':
fdisks/sfdisk.c:1504:6: warning: format '%ld' expects argument of type 
'long int', but argument 2 has type 'size_t' [-Wformat]
fdisks/sfdisk.c: In function 'msdos_partition':
fdisks/sfdisk.c:1554:5: warning: dereferencing type-punned pointer will 
break strict-aliasing rules [-Wstrict-aliasing]
fdisks/sfdisk.c:1556:2: warning: dereferencing type-punned pointer will 
break strict-aliasing rules [-Wstrict-aliasing]

text-utils/pg.c: In function 'pgfile':
text-utils/pg.c:964:21: warning: variable 'fpos' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:965:18: warning: variable 'fline' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:965:40: warning: variable 'oldline' might be clobbered 
by 'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:976:6: warning: variable 'search' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:977:11: warning: variable 'searchcount' might be 
clobbered by 'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:981:6: warning: variable 'seekeof' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:985:6: warning: variable 'eof' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:989:6: warning: variable 'nobuf' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]
text-utils/pg.c:1000:8: warning: variable 'fbuf' might be clobbered by 
'longjmp' or 'vfork' [-Wclobbered]

term-utils/setterm.c: In function 'screendump':
term-utils/setterm.c:1191:39: warning: comparison between signed and 
unsigned integer expressions [-Wsign-compare]

isc-utils/lslocks.c: In function 'get_dev_inode':
misc-utils/lslocks.c:221:2: warning: format '%lu' expects argument of 
type 'long unsigned int *', but argument 5 has type 'ino_t *' [-Wformat]
misc-utils/lslocks.c: In function 'add_tt_line':
misc-utils/lslocks.c:419:4: warning: format '%ld' expects argument of 
type 'long int', but argument 3 has type 'off_t' [-Wformat]
misc-utils/lslocks.c:422:4: warning: format '%ld' expects argument of 
type 'long int', but argument 3 has type 'off_t' [-Wformat]




