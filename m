Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754737AbdL2Li2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 Dec 2017 06:38:28 -0500
Date: Fri, 29 Dec 2017 12:38:24 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
Message-ID: <20171229113824.72y6cgyqta42mt2y@ws.net.home>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 24, 2017 at 03:38:58PM -0500, J William Piggott wrote:
> 
> Undocumented at this time, because it is a skeleton
> implementation.  More debugging points are to be added after
> refactoring is complete, or ad hoc in the mean time.
> 
> When fully implemented, enough time may have passed that the
> deprecated --debug could be used to replace --ul-debug.

We use everywhere env.variables (e.g. HWCLOCK_DEBUG=). The macro
__UL_INIT_DEBUG() already provides all necessary functionality for
this purpose. 

It also allows to use human readable names for the masks or hex
numbers. See for example  sys-utils/lsns.c or libsmartcols/src/init.c
for more complex usage. The human readable masks are optional and now
used by shared libs only, see for example "LIBSMARTCOLS_DEBUG=help
lsns".

I'd like to keep things consistent and with no exceptions...

IMHO "hwclock --verbose" is good idea for ordinary users and
"HWCLOCK_DEBUG=all hwclock" for developers.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
