Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59893 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbDQIgm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 17 Apr 2015 04:36:42 -0400
Date: Fri, 17 Apr 2015 10:36:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Unknown <ben.kero@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: failure to write partition layout to loopback devices
Message-ID: <20150417083638.GF6757@ws.net.home>
References: <1429182391.15041.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429182391.15041.2.camel@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 16, 2015 at 04:06:31AM -0700, Unknown wrote:
> In util-linux 2.26 and onward a check is done to see if there are any
> open filehandles on the device that is being updated. Specifically,
> this check is being done in 'is_device_used': disk-utils/sfdisk.c:1055
> 
> For loopback devices the ioctl(fd, BLKRRPART) will always fail with
> return code -1. Checking errno will yield error '22'. This is
> "expected" and parted has considered making exceptions for this in the
> past [1]. I would propose that instead of having to iss ue a '--force'
> flag for basic loopback device operation, an exception should be
> included in the is_device_used function.
> 
> It could be as simple as:
> 
> +    // If we are dealing with a loopback device this will fail, but
> shouldn't
> +    if (!strncmp("/dev/loop", fdisk_get_devname(sf->cxt), 9)) {
> +        return 0;
> +    }

 Fixed (I have use major(st.st_rdev) == LOOPDEV_MAJOR).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
