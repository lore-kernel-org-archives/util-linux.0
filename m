Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:10183 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3JHP4Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Oct 2013 11:56:25 -0400
Message-ID: <52542B27.4050901@draigBrady.com>
Date: Tue, 08 Oct 2013 16:56:23 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: "Richard W.M. Jones" <rjones@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: Remove the --setbsz (set blocksize) option
 which has never worked.
References: <1381222450-30380-1-git-send-email-rjones@redhat.com> <5254113A.2010709@draigBrady.com> <20131008140940.GW1887@redhat.com>
In-Reply-To: <20131008140940.GW1887@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/08/2013 03:09 PM, Richard W.M. Jones wrote:
> On Tue, Oct 08, 2013 at 03:05:46PM +0100, Pádraig Brady wrote:
>> On 10/08/2013 09:54 AM, Richard W.M. Jones wrote:
>>> From: "Richard W.M. Jones" <rjones@redhat.com>
>>>
>>> This option has never worked.  If you try setting the block size on a
>>> block device, and then read it using --getbsz, you will see that the
>>> block size never changes.
>>>
>>> The reason for this is because the block size is specific to the
>>> current file descriptor opening the block device, so the change of
>>> block size only persists for as long as blockdev has the device open,
>>> and is lost once blockdev exits.
>>>
>>> Also the block size is not really used anywhere.  Filesystems, for
>>> example, have their own idea of block size and ignore this setting
>>> completely.
>>>
>>> (Thanks Masayoshi Mizuma for diagnosing the problem)
>>>
>>> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>>> ---
>>>  bash-completion/blockdev | 7 +------
>>>  disk-utils/blockdev.8    | 2 --
>>>  disk-utils/blockdev.c    | 7 -------
>>>  3 files changed, 1 insertion(+), 15 deletions(-)
>>>
>>> diff --git a/bash-completion/blockdev b/bash-completion/blockdev
>>> index ce986cb..5889955 100644
>>> --- a/bash-completion/blockdev
>>> +++ b/bash-completion/blockdev
>>> @@ -19,7 +19,6 @@ _blockdev_module()
>>>  		--getalignoff
>>>  		--getmaxsect
>>>  		--getbsz
>>> -		--setbsz
>>>  		--getsize64
>>>  		--setra
>>>  		--getra
>>> @@ -29,11 +28,7 @@ _blockdev_module()
>>>  		--rereadpt
>>>  		$DEVS"
>>>  	case $prev in
>>> -		'--setbsz')
>>> -			COMPREPLY=( $(compgen -W "bytes" -- $cur) )
>>> -			return 0
>>> -			;;
>>> -		'--setbsz'|'--setfra')
>>> +		'--setfra')
>>>  			COMPREPLY=( $(compgen -W "sectors" -- $cur) )
>>>  			return 0
>>>  			;;
>>> diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
>>> index 2b3d64c..6ab4324 100644
>>> --- a/disk-utils/blockdev.8
>>> +++ b/disk-utils/blockdev.8
>>> @@ -67,8 +67,6 @@ Print sectorsize in bytes - usually 512.
>>>  Get size in 512-byte sectors.
>>>  .IP "\fB\-\-rereadpt\fP"
>>>  Reread partition table
>>> -.IP "\fB\-\-setbsz\fP \fIbytes\fP"
>>> -Set blocksize.
>>>  .IP "\fB\-\-setfra\fP \fIsectors\fP"
>>>  Set filesystem readahead (same like --setra on 2.6 kernels).
>>>  .IP "\fB\-\-setra\fP \fIsectors\fP"
>>> diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
>>> index 4543818..dc02d48 100644
>>> --- a/disk-utils/blockdev.c
>>> +++ b/disk-utils/blockdev.c
>>> @@ -122,13 +122,6 @@ static const struct bdc bdcms[] =
>>>  		.argval = -1,
>>>  		.help = N_("get blocksize")
>>>  	},{
>>> -		IOCTL_ENTRY(BLKBSZSET),
>>> -		.name = "--setbsz",
>>> -		.argname = "<bytes>",
>>> -		.argtype = ARG_INT,
>>> -		.flags = FL_NORESULT,
>>> -	        .help = N_("set blocksize")
>>> -	},{
>>>  		IOCTL_ENTRY(BLKGETSIZE),
>>>  		.name = "--getsize",
>>>  		.argtype = ARG_ULONG,
>>>
>>
>> Might one process the adjusted block device in a subshell?
>>
>> $ (blockdev --setbsz 2048 /dev/stdin; blockdev --getbsz /dev/stdin) < /dev/loop0
>> 2048
> 
> Yes .. if that was documented anywhere, if it wasn't so obscure, and
> if it was useful for anything except changing a handle property that
> nothing uses.
> 
> There's an informative but unfortunately private exchange on the
> subject in this bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=1002825
> 
> I have asked if we can make the contents of this bug public.
> 
> Rich.

For my own reference, the way I see it,
when accessing block devices Linux uses these block sizes:

physical	defined by the hardware device
logical		the smallest addressable unit used for the device
file system	ditto for the file system

--[gs]etbsz refers the _logical_ block size for the device.
Traditionally one had a physical of 512, but a larger logical size
of say 4096, with the size determining the standard I/O operations Vs
fragmentation tradeoff.

So why might one want to --setbsz?
I agree that would be fairly specialized.
I'm guessing that the logical size default is determined using
the device size, maxing out at the page size.
One might want to reduce that (temporarily), for odd sized devices,
where you might want to read/write slop at the end of the device?

But for low level access like this, one would probably use direct IO
to avoid the page cache (sized) reads/writes anyway.

I searched for uses of --setbz and noticed a couple:
Perf testing:
  https://lkml.org/lkml/2003/12/30/81
Functionality testing:
  http://www.linux-archive.org/device-mapper-development/699549-blockdev-fix-crash-when-block-size-changed-i-o-issued-simultaneously.html

So I'm not against removing it. If others wanted to leave it in,
then it would have to be documented that it was a transient setting.

thanks,
Pádraig.

