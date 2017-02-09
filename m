Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbdBIMmR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Feb 2017 07:42:17 -0500
Date: Thu, 9 Feb 2017 13:36:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Shaun Tancheff <shaun@tancheff.com>
Cc: util-linux@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v3] Add blkzonecmd and blkreport ZAC/ZBC drives
Message-ID: <20170209123603.oi763dhsfvxhsv6m@ws.net.home>
References: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485178362-25327-1-git-send-email-shaun@tancheff.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2017 at 08:32:42PM +0700, Shaun Tancheff wrote:
>  .gitignore              |   2 +
>  configure.ac            |  11 +++
>  include/strutils.h      |   2 +
>  lib/strutils.c          |   7 +-
>  sys-utils/Makemodule.am |  17 ++++
>  sys-utils/blkreport.8   |  68 ++++++++++++++
>  sys-utils/blkreport.c   | 245 ++++++++++++++++++++++++++++++++++++++++++++++++
>  sys-utils/blkreset.8    |  61 ++++++++++++
>  sys-utils/blkreset.c    | 190 +++++++++++++++++++++++++++++++++++++

Applied with some changes (see below), thanks.

Please, please "git pull" and test it!

I have no HW to do any tests (but I have free space for a new disk in
my workstation -- you know Seagate, right? :-)) Or is it possible to
test for example by scsi_debug?

> +blkreset_LDADD += -ludev

Fixed, unnecessary.

> +.BR \-z , " \-\-zone \fIoffset", " \-\-offset \fIoffset"
> +.BR \-c , " \-\-count \fIcount", " \-\-length \fIcount"

Fixed. I don't think we want to use aliases for the options (and one
of the utils had the aliases only in man page). I have modified man
pages and code to support

  --zone <offset>
  --count <length>

only.

> +#include "monotonic.h"

Copy & past I guess ;-) Unnecessary. Fixed.

> +	fputs(USAGE_OPTIONS, out);
> +	fputs(_(" -z, --zone <num>    zone lba in 512 byte sectors\n"
> +		"     --offset <num>  zone lba in 512 byte sectors\n"
> +		" -c, --count <num>   maximum number of zones in report\n"
> +		"     --length <num>  maximum number of zones in report\n"
> +		" -v, --verbose       print aligned length and offset"),
> +		out);

Fixed.

> +		case 'c':
> +			length = _strtou32_or_err(optarg,
> +					_("failed to parse report count"), 0);
> +			break;
> +		case 'z':
> +			offset = _strtou64_or_err(optarg,
> +					_("failed to parse zone offset"), 0);
> +			break;

The function strtou64_or_err() does not support size suffixes. Fixed
and replaced with strtosize_or_err().

> +
> +	if (ioctl(fd, BLKGETSIZE64, &blksize))
> +		err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path);
> +	if (ioctl(fd, BLKSSZGET, &secsize))
> +		err(EXIT_FAILURE, _("%s: BLKSSZGET ioctl failed"), path);

replaced with blkdev.h functions (like you did in blkreset.c).

> +	/* check offset alignment to the chunk size */
> +	if (zsector & (zsize - 1))
> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is not aligned "
> +			 "to zone size %" PRIu64), path, zsector, zsize);
> +	if (zsector > blksectors)
> +		errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is too large "
> +			 "for device %" PRIu64), path, zsector, blksectors);

It seems nowhere (blkreset and blkreport) we check if 
 
    offset + length <= blksectors

 it means we don't check the end of the area, I guess the end has to
 be within the block device.

 Maybe we can add this if() to the code, objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
