Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbbCPKaw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:30:52 -0400
Date: Mon, 16 Mar 2015 11:30:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: J William Piggott <elseifthen@gmx.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] hwclock: add TZDIR
Message-ID: <20150316103045.GC28925@ws.net.home>
References: <5503364E.6010302@gmx.com>
 <1426432851.3224427.240608565.1C0BF744@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426432851.3224427.240608565.1C0BF744@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 04:20:51PM +0100, Benno Schulenberg wrote:
> 
> On Fri, Mar 13, 2015, at 20:11, J William Piggott wrote:
> >  sys-utils/hwclock.8.in | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> These patches only touch the man page of hwclock.  For changes
> to documentation only, the normal marker is "docs:".  So I think
> your subject line should be something like:
> 
>   docs: add TZDIR to the man page of hwclock

Frankly, I prefer "<utilname>: ...." for patches. The "docs:" is
better only for some generic and global cleanups.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
