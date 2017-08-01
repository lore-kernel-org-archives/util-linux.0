Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdHAHUW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 1 Aug 2017 03:20:22 -0400
Date: Tue, 1 Aug 2017 09:20:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> > From: "Carlos Santos" <casantos@datacom.ind.br>
> > To: util-linux@vger.kernel.org
> > Sent: Monday, July 31, 2017 9:12:03 PM
> > Subject: Problem building util-linux without a separate ncursesw include dir
> 
> > of util-linux. Would it be possible to make the location of ncursesw
> > headers configurable, instead?

We test for alone ncurses.h and term.h in the for non-wide ncurses.
Can you send output from your configure from the current master
branch (or v2.30.1)?

> I was thinking on something simple, like https://pastebin.com/VqM9G9yu

Hmm, but you don't distinguish between wide and non-wide ncurses.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
