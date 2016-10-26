Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753852AbcJZIRl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 04:17:41 -0400
Date: Wed, 26 Oct 2016 10:17:39 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libfdisk show stopper on i586?
Message-ID: <20161026081739.sz7i2kgyleqkzvi3@ws.net.home>
References: <201610260000.12844.sweet_f_a@gmx.de>
 <m3oa289cr7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3oa289cr7.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 26, 2016 at 03:26:20AM +0300, Yuriy M. Kaminskiy wrote:
> I doubt it is related, but while looking at this diff I noticed some
> pretty broken (even if accedintally working) code:
> 
> === cut libfdisk/src/gpt.c ===
> 	const char *p = str;
> ...
>                 } else if (isdigit((unsigned int) *p)
> === cut ===

Fixed, I found it on another places too (probably my mistakes, sorry).

> There either should be no explict cast here, or it should've been
> `(unsigned char)*p` instead.

We usually use (unsigned char), so to be consistent I have replaced
the "unsigned int" with "unsigned char".

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
