Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934579AbaEFK53 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:57:29 -0400
Date: Tue, 6 May 2014 12:57:22 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Stanislav Brabec <sbrabec@suse.cz>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: Warning typo fix
Message-ID: <20140506105722.GO5962@x2.net.home>
References: <1399317654.11780.43.camel@oct.suse.cz>
 <CAG27Bk3HocOszOVAXfzTeLUgr_6fhgpRt61_KuwVxCV4tKADYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3HocOszOVAXfzTeLUgr_6fhgpRt61_KuwVxCV4tKADYQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 05, 2014 at 08:35:17PM +0100, Sami Kerola wrote:
> On 5 May 2014 20:20, Stanislav Brabec <sbrabec@suse.cz> wrote:
> > Trailing '\n' is missing in:
> > "Not setting clock because last adjustment time is zero, so history is bad."
> >
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> > ---
> >  sys-utils/hwclock.c | 2 +-
> 
> Hi Stanislav,
> 
> The hwclock.c change is OK. The po files are not updated this way.
> 
> See also http://www.spinics.net/lists/util-linux-ng/msg09087.html

 Yep, fixed manually.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
