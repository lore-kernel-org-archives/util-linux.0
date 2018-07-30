Return-Path: BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org
Date: Mon, 30 Jul 2018 00:29:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, Bernhard Voelker <mail@bernhard-voelker.de>,
	util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
Message-ID: <20180730072905.GA32653@infradead.org>
References: <20180626211343.4675-1-kerolasa@iki.fi>
 <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
 <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
 <20180724123052.szmsn3yguneebree@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180724123052.szmsn3yguneebree@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 24, 2018 at 02:30:52PM +0200, Karel Zak wrote:
> > >> -#if defined(__alpha__) || defined(__sparc__)
> > >> -             /*
> > >> -              * Not all alpha kernels reject RTC_UIE_ON, but probably
> > >> -              * they should.
> > >> -              */
> > >> -             rc = -1;
> > >> -             errno = EINVAL;
> > >> -#else
> > >>               rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
> > >> -#endif
> > >
> > > Are you sure you want to change the code path for SPARC?
> > 
> > Hi Berny,
> > 
> > After reading linux kernel code, and trying to find references where sparc
> > condition might be originating I could not find good reason why sparc should
> > hard code RTC_UIE_ON not to be supported.  There is message from 2005 about
> > chrony having issue with sparc RTC_UIE_ON, but later in that thread Dave
> > Miller tells there is no problem with rtc and sparc.  I am fairly confident
> > ioctl(rtc_fd, RTC_UIE_ON, 0) will either do the right thing or return -1.
> > 
> > Reference: https://lists.debian.org/debian-sparc/2005/04/msg00115.html
> 
> Maybe the best would be to postpone this to v2.34 and in v2.33 just
> inform about this plan. Frankly, I'm not sure where and what is
> supported for alpha...

Note that for modern kernel RTC support uses a lot more common code
so some of the old quirks should be dead.  It might be a better idea
to approach this as dropping support for long obsolete kernels on
not common architectures, although that might require a bit more
research and testing.
