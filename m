Return-Path: util-linux-owner@vger.kernel.org
Received: from nm20.bullet.mail.sp2.yahoo.com ([98.139.91.90]:48913 "HELO
	nm20.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752243Ab2APWaq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jan 2012 17:30:46 -0500
Message-ID: <4F14A512.2030904@yahoo.com.ar>
Date: Mon, 16 Jan 2012 19:30:42 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: fdisk: off-by-one issue in (n)new command
References: <4F0E167A.9090205@yahoo.com.ar> <CAMFXF50uHCU4yhwe3byAsTKvPpi8F63mR9O4TfKhuANiEL_v0Q@mail.gmail.com> <4F149CA0.6040100@yahoo.com.ar>
In-Reply-To: <4F149CA0.6040100@yahoo.com.ar>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 01/16/2012 06:54 PM, Gerardo Exequiel Pozzi wrote:
> On 01/16/2012 06:38 PM, Francesco Cosoleto wrote:
>> 2012/1/12 Gerardo Exequiel Pozzi<vmlinuz386@yahoo.com.ar>:
>>> I think I found two related bugs, steps to reproduce will be more 
>>> clear than
>>> a description:
>>> It is present in stable 2.20.1 and using latest git snapshot, and 
>>> using any
>>> device/file as disk, using here a loop dev with a backing file of 
>>> 256MiB
>>> just for example.
>> Fixed. Thank you for the report.
>>
>> http://git.kernel.org/?p=utils/util-linux/util-linux.git;a=commit;h=0c381880282b9365aaf9e8457c69750c12c4d9b2 
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> Thank you!
>
> I will test it in few hours ;)
>
Works fine (default value after out-of-range) :)

Still remains the other bug that does not allow to specify "last sector" 
that just fits the size in +sectors/+N(K|M|G).

Example:

Command (m for help): n
Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
Select (default p):
Using default response p
Partition number (1-4, default 1):
Using default value 1
First sector (2048-524287, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): +255M
Value out of range.
Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): 
+261120K
Value out of range.
Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): +522240
Value out of range.
Last sector, +sectors or +size{K,M,G} (2048-524287, default 524287): +522239
Partition 1 of type Linux and of size 255 MiB is set

Command (m for help): p

Disk /dev/vdb: 268 MB, 268435456 bytes
16 heads, 63 sectors/track, 520 cylinders, total 524288 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xbfd7539b

    Device Boot      Start         End      Blocks   Id  System
/dev/vdb1            2048      524287      261120   83  Linux


-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

