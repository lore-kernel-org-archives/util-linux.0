Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.vodafone.ie ([213.233.128.43]:23626 "EHLO
	mail1.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbDBLgh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Apr 2015 07:36:37 -0400
Message-ID: <551D29C1.1010107@draigBrady.com>
Date: Thu, 02 Apr 2015 12:36:33 +0100
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Bernhard Voelker <mail@bernhard-voelker.de>, Coreutils <coreutils@gnu.org>,
        bug-gnulib <bug-gnulib@gnu.org>,
        util-linux <util-linux@vger.kernel.org>,
        Fridolin Pokorny <fpokorny@redhat.com>
Subject: Re: large overhead in libmount
References: <54A321DC.4020300@bernhard-voelker.de> <54BDB6E9.4070500@draigBrady.com> <20150402100546.GE2097@ws.net.home>
In-Reply-To: <20150402100546.GE2097@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/04/15 11:05, Karel Zak wrote:
> On Tue, Jan 20, 2015 at 02:01:13AM +0000, Pádraig Brady wrote:
>> On 30/12/14 22:06, Bernhard Voelker wrote:
>>> I just pulled the recent gnulib update, and now the above, expensive
>>> test fails:
>>>
>>>    + ulimit -v 40000
>>>    + du -sh d
>>>    du: fts_read failed: d: Cannot allocate memory
>>>    + fail=1
>>>
>>> I guess this due to the inclusion of libmount?
>>
>> Yes I get the same issue in that test:
>> http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=tests/rm/many-dir-entries-vs-OOM.sh
>>
>> Indeed there is significant overhead in using libmount as shown below.
>> This is a crazy amount of overhead just to read /proc/self/mountinfo,
>> and is the sort of creeping dependencies I hate.  The proposed solution
>> in the attached gnulib patch, is to require ./configure --with-libmount
>> to enable this feature. I.E. it's disabled by default.
>>
>> cheers,
>> Pádraig
>>
>> ======= without =========
>> $ (ulimit -v 5380; du -s .)
>>
>> $ ldd /usr/bin/du
>> linux-vdso.so.1 =>  (0x00007fff0d7fe000)
>> libc.so.6 => /lib64/libc.so.6 (0x00007fd414a32000)
>> /lib64/ld-linux-x86-64.so.2 (0x00007fd414e0b000)
>>
>> $ time du -s src/du.c >/dev/null
>> real    0m0.003s
>> user    0m0.000s
>> sys     0m0.003s
>>
>> ======= with =========
>> $ (ulimit -v 23250; src/du -s .)
>>
>> $ ldd src/du
>> linux-vdso.so.1 =>  (0x00007fff76ca8000)
>> libc.so.6 => /lib64/libc.so.6 (0x00007f2a1f742000)
>> /lib64/ld-linux-x86-64.so.2 (0x00007f2a1fd61000)
>>  libmount.so.1 => /lib64/libmount.so.1 (0x00007f2a1faff000)
>>   libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f2a1f501000)
>>   libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f2a1f2fc000)
>>   libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f2a1f0d7000)
>>   libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f2a1ee69000)
>>   liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f2a1ec44000)
>>   libdl.so.2 => /lib64/libdl.so.2 (0x00007f2a1ea40000)
>>   libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f2a1e823000)
> 
> The problem is libselinux, but on selinux based system you have all the
> libraries already in memory for many another tools...

Indeed.

I see libmount links with libselinux to use selinux_trans_to_raw_context()
for the context= mount options etc.  I suppose one could split libmount
to avoid that dependency, though it's probably not worth it for this case at least?

I still think it's worth avoiding the dependencies here though
with the little extra code.  I'll add a comment to the patch about libselinux
as the source of these deps.

thanks!
Pádraig
