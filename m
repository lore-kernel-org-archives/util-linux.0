Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbcKIJQI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 Nov 2016 04:16:08 -0500
Date: Wed, 9 Nov 2016 10:16:06 +0100
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 2/4] lsmem: new tool
Message-ID: <20161109091606.6iunpd6p3cco4dpn@ws.net.home>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-3-heiko.carstens@de.ibm.com>
 <20161103120059.75nflzf5wvepafzu@ws.net.home>
 <20161103161948.GA12234@osiris>
 <20161104103931.dvhnyuyjhb4ykyw7@ws.net.home>
 <20161104121006.GA4088@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161104121006.GA4088@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 04, 2016 at 01:10:06PM +0100, Heiko Carstens wrote:
> - you changed the alignment of nearly all columns from left to right,
> except for STATE and RANGE. For RANGE it does make sense to keep it aligned
> to the left, however for STATE it looks a bit inconsistent. Not sure if you
> missed to make it also align to the right?

Fixed, STATE is aligned to the right too.

> - the updated man page now says that the default output is subject to
> change; but it should not change in order to be compatible with the old
> lsmem tool within s390-tools.

Well, I'd like to force users to use --output in scripts for our
ls-like tools, but you're right. We should be friendly to the current
s390-tools users.  I have a little bit changed the sentence, and now
it recommends --output and there is also note about compatibility with
s390-tools.

>  sys-utils/lsmem.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks. All merged to the master branch now. 


Thanks to IBM that you don't play on your own playground only and you
consolidate things in more generic way!

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
