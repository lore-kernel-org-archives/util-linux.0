Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbeASJkz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Jan 2018 04:40:55 -0500
Date: Fri, 19 Jan 2018 10:40:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>, util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20180119094051.g3qztrrqf5guife5@ws.net.home>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
 <20180119024717.GJ7217@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119024717.GJ7217@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
> On 01 Aug 2017 09:20, Karel Zak wrote:
> > On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> > > > From: "Carlos Santos" <casantos@datacom.ind.br>
> > > > To: util-linux@vger.kernel.org
> > > > Sent: Monday, July 31, 2017 9:12:03 PM
> > > > Subject: Problem building util-linux without a separate ncursesw include dir
> > > 
> > > > of util-linux. Would it be possible to make the location of ncursesw
> > > > headers configurable, instead?
> > 
> > We test for alone ncurses.h and term.h in the for non-wide ncurses.
> > Can you send output from your configure from the current master
> > branch (or v2.30.1)?
> > 
> > > I was thinking on something simple, like https://pastebin.com/VqM9G9yu
> > 
> > Hmm, but you don't distinguish between wide and non-wide ncurses.
> 
> why don't we just support ncurses's pkg-config files as the default ?
> $ pkg-config --cflags ncurses
> -D_GNU_SOURCE
> $ pkg-config --cflags ncursesw
> -D_GNU_SOURCE -I/usr/include/ncursesw
> -mike

because pkg-config is not supported by ncurses upstream by default and
it's not always the best solution. See commit
4c12a334dc4104d16dc06edf51904b08b08fcdfa.

The ncurses detection and variability in distros is horrible. We
already tried all possible combinations and always someone complains
about the way how we detect ncurses. See mailing list archive for more
information.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
