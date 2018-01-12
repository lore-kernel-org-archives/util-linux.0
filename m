Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754583AbeALKQD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 Jan 2018 05:16:03 -0500
Date: Fri, 12 Jan 2018 11:15:59 +0100
From: Karel Zak <kzak@redhat.com>
To: halfdog <me@halfdog.net>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux mount/unmount ASLR bypass via environment variable
Message-ID: <20180112101559.rm2k4qbhi7kyufma@ws.net.home>
References: <820-1515696719.436169@jYEA.ctRK.4WZD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <820-1515696719.436169@jYEA.ctRK.4WZD>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 11, 2018 at 06:51:59PM +0000, halfdog wrote:
> Cleaning up another issue, I noticed that I haven't reported this
> one yet. Debugging of libmount can be activated, also in SUID binaries,

This is expected and wanted ;-)

> thus spilling out the heap addresses.

Good point. Fixed, now for SUIDs it's without the addresses:

$ LIBMOUNT_DEBUG=all mount
18622: libmount:      CXT: ----> allocate [RESTRICTED]
18622: libmount:      TAB: alloc
18622: libmount:    CACHE: alloc
18622: libmount:      TAB: mtab parse: #1 read mountinfo
18622: libmount:      TAB: /proc/self/mountinfo: start parsing [entries=0, filter=not]
18622: libmount:      TAB: add entry: sysfs /sys
18622: libmount:    CACHE: canonicalize path /proc/self/mountinfo
...

Thanks!

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
