Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdHAMoJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 08:44:09 -0400
Date: Tue, 1 Aug 2017 14:44:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20170801124405.ikj44ulhisvfthnf@ws.net.home>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
 <1033867833.2726878.1501589362348.JavaMail.zimbra@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1033867833.2726878.1501589362348.JavaMail.zimbra@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 01, 2017 at 09:09:22AM -0300, Carlos Santos wrote:
> > From: "Karel Zak" <kzak@redhat.com>
> > To: "Carlos Santos" <casantos@datacom.ind.br>
> > Cc: util-linux@vger.kernel.org
> > Sent: Tuesday, August 1, 2017 4:20:17 AM
> > Subject: Re: Problem building util-linux without a separate ncursesw include dir
> 
> > On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> >> > From: "Carlos Santos" <casantos@datacom.ind.br>
> >> > To: util-linux@vger.kernel.org
> >> > Sent: Monday, July 31, 2017 9:12:03 PM
> >> > Subject: Problem building util-linux without a separate ncursesw include dir
> >> 
> >> > of util-linux. Would it be possible to make the location of ncursesw
> >> > headers configurable, instead?
> > 
> > We test for alone ncurses.h and term.h in the for non-wide ncurses.
> > Can you send output from your configure from the current master
> > branch (or v2.30.1)?
> 
> config.log: https://pastebin.com/DVAyx1Zb

I see --with-ncursesw, it means the configure.ac code where we check
for alone ncurses.h is not executed. Try it without this --with... I
guess it will work.

> defconfig for buildroot: https://pastebin.com/U3pz0hvm
> 
> >> I was thinking on something simple, like https://pastebin.com/VqM9G9yu
> > 
> > Hmm, but you don't distinguish between wide and non-wide ncurses.
> 
> That's because on Buildroot only one of the variants can exist.
> 
> BTW I noticed that on Fedora each /usr/include/ncurses/<foo> is a
> symlink to ../<foo>, so the situation is exactly the same.

Yes, but the symlink is good enough (f25):

        checking for ncursesw6-config... ncursesw6-config
        checking ncursesw/ncurses.h usability... yes
        checking ncursesw/ncurses.h presence... yes
        ...


Anyway, you're right with your suggested patch :-)

We don't have to distinguish between wide and non-wide ncurses when we
check for header files, because it's already done by
UL_NCURSES_CHECK() and AC_CHECK_HEADERS() is executed only if we
already have widechar lib.

Fixed... git-pull and try it. 

    Karel

> “The greatest triumph that modern PR can offer is the transcendent 
> success of having your words and actions judged by your reputation, 
> rather than the other way about.” — Christopher Hitchens

Nice ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
