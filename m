Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47373 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455AbbCOP1d (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Mar 2015 11:27:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 3F4922063D
	for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 11:20:50 -0400 (EDT)
Message-Id: <1426432851.3224427.240608565.1C0BF744@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5503364E.6010302@gmx.com>
References: <5503364E.6010302@gmx.com>
Subject: Re: [PATCH 1/5] hwclock: add TZDIR
Date: Sun, 15 Mar 2015 16:20:51 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Mar 13, 2015, at 20:11, J William Piggott wrote:
>  sys-utils/hwclock.8.in | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

These patches only touch the man page of hwclock.  For changes
to documentation only, the normal marker is "docs:".  So I think
your subject line should be something like:

  docs: add TZDIR to the man page of hwclock

> +.TP
> +.B TZ
> +If this variable is set its value takes precedence over the system
> +configured timezone.

s/set its/set, its/
s/system/system's/

Same in the next item

> +.TP
> +.B TZDIR
> +If this variable is set its value takes precedence over the system
> +configured timezone database directory path.

Benno

-- 
http://www.fastmail.com - The way an email service should be

