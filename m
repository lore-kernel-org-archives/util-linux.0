Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3301 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab2ARMNE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Jan 2012 07:13:04 -0500
Date: Wed, 18 Jan 2012 13:13:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
        Kay Sievers <kay.sievers@vrfy.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: Buffer I/O error, with latest losetup on first run
Message-ID: <20120118121301.GA2371@x2.net.home>
References: <4F16279F.3040100@yahoo.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F16279F.3040100@yahoo.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 17, 2012 at 10:59:59PM -0300, Gerardo Exequiel Pozzi wrote:
> Using (losetup from util-linux 2.20.620-4360-dirty) and Linux-3.2.1.
> 
> Using losetup as first time, if loop module is not loaded, losetup -f
> file-equal-or-below-1MiB I get: "Buffer I/O error on device loop0, logical
> block 0" (sometimes get one message, or two or three, ...)

It does not sound like userspace problem, I guess that the message comes
from kernel (dmesg). It would be also nice to have strace output.

> 
> Can be reproducible again if loop module is unloaded then execute losetup.
> Does not happen if module is loaded previously to losetup.
> Happens independently if /dev/loop0 exists or not.
> 
> Does not happen with losetup from 2.20 under the same conditions.

The new losetup uses /dev/loop-control to get the new free loop device.

Kay, any idea?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
