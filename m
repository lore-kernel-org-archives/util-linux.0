Return-Path: util-linux-owner@vger.kernel.org
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20940 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdBJDHl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Feb 2017 22:07:41 -0500
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
To: Karel Zak <kzak@redhat.com>, Shaun Tancheff <shaun@tancheff.com>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
 <20170209123603.oi763dhsfvxhsv6m@ws.net.home>
Cc: util-linux@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <96cd8646-d971-4e25-f97c-a1c782016573@wdc.com>
Date: Fri, 10 Feb 2017 12:06:58 +0900
MIME-Version: 1.0
In-Reply-To: <20170209123603.oi763dhsfvxhsv6m@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel, Shaun,

Tested on SAS and SATA host-managed drive. No problems detected.
A few remarks though:

1) The term "lba" is being used throughout (command description and
error messages). This is confusing when using 4K drives. Since in fact
the unit used for the arguments and displayed results is the traditional
512B "sector", I think that "LBA" should be replaced by "sector" is all
messages, command argument descriptions and man pages.

2) In kernel, the offset passed to the zone reset ioctl is indeed
checked for alignment to the drive LBA size. So checking the offset
passed to blkreset makes sense. However, the same check for report is a
little too harsh since the kernel will accept an unaligned sector number
(it will be aligned down to the containing zone start sector before
issuing a report zones command to the drive). So we could get rid of
that check I think.

Otherwise, please feel free to add:
Tested-by: Damien Le Moal <damien.lemoal@wdc.com>

Best regards.

On 2/9/17 21:36, Karel Zak wrote:
> On Mon, Jan 23, 2017 at 08:32:42PM +0700, Shaun Tancheff wrote:
>>  .gitignore              |   2 +
>>  configure.ac            |  11 +++
>>  include/strutils.h      |   2 +
>>  lib/strutils.c          |   7 +-
>>  sys-utils/Makemodule.am |  17 ++++
>>  sys-utils/blkreport.8   |  68 ++++++++++++++
>>  sys-utils/blkreport.c   | 245 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  sys-utils/blkreset.8    |  61 ++++++++++++
>>  sys-utils/blkreset.c    | 190 +++++++++++++++++++++++++++++++++++++
> 
> Applied with some changes (see below), thanks.
> 
> Please, please "git pull" and test it!
> 
> I have no HW to do any tests (but I have free space for a new disk in
> my workstation -- you know Seagate, right? :-)) Or is it possible to
> test for example by scsi_debug?
> 
>> +blkreset_LDADD += -ludev
> 
> Fixed, unnecessary.
> 
>> +.BR \-z , " \-\-zone \fIoffset", " \-\-offset \fIoffset"
>> +.BR \-c , " \-\-count \fIcount", " \-\-length \fIcount"
> 
> Fixed. I don't think we want to use aliases for the options (and one
> of the utils had the aliases only in man page). I have modified man
> pages and code to support
> 
>   --zone <offset>
>   --count <length>
> 
> only.
> 
>> +#include "monotonic.h"
> 
> Copy & past I guess ;-) Unnecessary. Fixed.
> 
>> +	fputs(USAGE_OPTIONS, out);
>> +	fputs(_(" -z, --zone <num>    zone lba in 512 byte sectors\n"
>> +		"     --offset <num>  zone lba in 512 byte sectors\n"
>> +		" -c, --count <num>   maximum number of zones in report\n"
>> +		"     --length <num>  maximum number of zones in report\n"
>> +		" -v, --verbose       print aligned length and offset"),
>> +		out);
> 
> Fixed.
> 
>> +		case 'c':
>> +			length = _strtou32_or_err(optarg,
>> +					_("failed to parse report count"), 0);
>> +			break;
>> +		case 'z':
>> +			offset = _strtou64_or_err(optarg,
>> +					_("failed to parse zone offset"), 0);
>> +			break;
> 
> The function strtou64_or_err() does not support size suffixes. Fixed
> and replaced with strtosize_or_err().
> 
>> +
>> +	if (ioctl(fd, BLKGETSIZE64, &blksize))
>> +		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
>> +	if (ioctl(fd, BLKSSZGET, &secsize))
>> +		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);
> 
> replaced with blkdev.h functions (like you did in blkreset.c).
> 
>> +	/* check offset alignment to the chunk size */
>> +	if (zsector & (zsize - 1))
>> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is not aligned "
>> +			 "to zone size %" PRIu64), path, zsector, zsize);
>> +	if (zsector > blksectors)
>> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is too large "
>> +			 "for device %" PRIu64), path, zsector, blksectors);
> 
> It seems nowhere (blkreset and blkreport) we check if 
>  
>     offset + length <= blksectors
> 
>  it means we don't check the end of the area, I guess the end has to
>  be within the block device.
> 
>  Maybe we can add this if() to the code, objections?
> 
>     Karel
> 

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
