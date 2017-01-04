Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbdADLcH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Jan 2017 06:32:07 -0500
Date: Wed, 4 Jan 2017 12:32:03 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Adam Borowski <kilobyte@angband.pl>,
        util-linux <util-linux@vger.kernel.org>,
        Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH 1/1] setterm: add --resize option
Message-ID: <20170104113203.ni5xdrcllu6ikjfl@ws.net.home>
References: <20161228220211.5634-1-kerolasa@iki.fi>
 <20161229003327.oeavblvtsem4e6ge@angband.pl>
 <CAG27Bk32Qb0V2g6HFXdPRakrRhjG9fhZbPSFtA8cTjDKpLWu4w@mail.gmail.com>
 <CAG27Bk1PbU1T=7cisG7kcO1txOXz9wap9xvZVs=0iEj7thzqNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1PbU1T=7cisG7kcO1txOXz9wap9xvZVs=0iEj7thzqNw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 29, 2016 at 11:01:45AM +0000, Sami Kerola wrote:
> On 29 December 2016 at 10:58, Sami Kerola <kerolasa@iki.fi> wrote:
> > On 29 December 2016 at 00:33, Adam Borowski <kilobyte@angband.pl> wrote:
> >> On Wed, Dec 28, 2016 at 10:02:11PM +0000, Sami Kerola wrote:
> >>> Reset terminal size by assessing maximum row and column.  This is useful
> >>> when actual geometry and kernel terminal driver are not in sync.
> >>>
> >>> Addresses: http://bugs.debian.org/835636
> >>> Based-on-work-by: Adam Borowski <kilobyte@angband.pl>
> >>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> >>
> >> Awesome, thanks for taking a look at it!
> >> Alas, at least the delay length makes your version not work for me.
> >
> > Fair enough, updates are available in the git repository at:
> >
> >   git://github.com/kerolasa/lelux-utiliteetit.git setterm
> >
> > https://github.com/kerolasa/lelux-utiliteetit/commit/9e0d5c6b0f8294ceabf38212f6ec14f148e5e642
> 
> Correction. The 9e0d5c... got amend. More recent commit is:
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/5d795999511adc455d223be8281948796bd7d087

Merged. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
