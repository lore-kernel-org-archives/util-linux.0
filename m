Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbeHCNBL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Aug 2018 09:01:11 -0400
Date: Fri, 3 Aug 2018 13:05:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: kerolasa@gmail.com, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
Message-ID: <20180803110519.5phtzbuvwfytc3ht@ws.net.home>
References: <20180626211343.4675-1-kerolasa@iki.fi>
 <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
 <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
 <20180724123052.szmsn3yguneebree@ws.net.home>
 <20180730072905.GA32653@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730072905.GA32653@infradead.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 30, 2018 at 12:29:06AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018 at 02:30:52PM +0200, Karel Zak wrote:
> > > >> -#if defined(__alpha__) || defined(__sparc__)
> > > >> -             /*
> > > >> -              * Not all alpha kernels reject RTC_UIE_ON, but probably
> > > >> -              * they should.
> > > >> -              */
> > > >> -             rc = -1;
> > > >> -             errno = EINVAL;
> > > >> -#else
> > > >>               rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
> > > >> -#endif
> > > >
> > > > Are you sure you want to change the code path for SPARC?
> > > 
> > > Hi Berny,
> > > 
> > > After reading linux kernel code, and trying to find references where sparc
> > > condition might be originating I could not find good reason why sparc should
> > > hard code RTC_UIE_ON not to be supported.  There is message from 2005 about
> > > chrony having issue with sparc RTC_UIE_ON, but later in that thread Dave
> > > Miller tells there is no problem with rtc and sparc.  I am fairly confident
> > > ioctl(rtc_fd, RTC_UIE_ON, 0) will either do the right thing or return -1.
> > > 
> > > Reference: https://lists.debian.org/debian-sparc/2005/04/msg00115.html
> > 
> > Maybe the best would be to postpone this to v2.34 and in v2.33 just
> > inform about this plan. Frankly, I'm not sure where and what is
> > supported for alpha...
> 
> Note that for modern kernel RTC support uses a lot more common code
> so some of the old quirks should be dead.  It might be a better idea
> to approach this as dropping support for long obsolete kernels on
> not common architectures, although that might require a bit more
> research and testing.
 
 Yes. 
 
 Anyway, it seems the patch is wrong. The current kernel still
 supports RTC_EPOCH_* ioctls, so we need hwclock --{set,get,}epoch
 commands. 

 The question is RTC_UIE_ON. It seems hwclock tries to be more smart than
 kernel:

        #if defined(__alpha__) || defined(__sparc__)
               /*
                * Not all alpha kernels reject RTC_UIE_ON, but probably
                * they should.
                */
               rc = -1;
               errno = EINVAL;
        #else
               rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
        #endif

 I don't like such code in userspace. It's kernel business o make
 decisions about supported/unsupported features... 

 It would be probably better to remove this #ifdef and call the ioctl
 everywhere and assume EINVAL from kernel rather than play this ifdef
 userspace game.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
