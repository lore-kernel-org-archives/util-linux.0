Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754019AbeFLMMs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Jun 2018 08:12:48 -0400
Date: Tue, 12 Jun 2018 14:12:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Alexey Gladkov <legion@altlinux.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: hardlink util -- files de-duplication
Message-ID: <20180612121244.ou2xusihgw4f6vlz@ws.net.home>
References: <20180601113807.ghf6dtcd5xa6qptu@ws.net.home>
 <20180601132930.GA5803@altlinux.org>
 <20180612105522.byg6agpta355f73x@ws.net.home>
 <201806121322.46190.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201806121322.46190.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 12, 2018 at 01:22:45PM +0200, Ruediger Meier wrote:
> On Tuesday 12 June 2018, Karel Zak wrote:
> > I won't have enough time in next two weeks to work on this task (fix
> > indention, reuse some lib/ stuff, etc.), so any volunteer(s)? ;-)
> 
> I would do this, maybe next week or so. Should it go to sys-utils or  
> misc-utils?

Thanks! I think misc-utils is better in this case. 

The sys-utils directory should be used for kernel API wrappers (ioctl,
syscalls, sysfs, etc) -- hmm... why we have kill.c in misc-utils? :-)

(But it's "color of the bikeshed" topic, so better not start this
discussion :-)

Note that the best way is to use "indent --linux" for the first patch.
And another changes to the code do by additional patches. So, we will
able to keep track about our local changes.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
