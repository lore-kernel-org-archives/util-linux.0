Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33018 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab2KOJsg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Nov 2012 04:48:36 -0500
Date: Thu, 15 Nov 2012 10:48:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: Petr Pisar <ppisar@redhat.com>, util-linux@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: vlock command
Message-ID: <20121115094830.GB26255@x2.net.home>
References: <20121114103509.GD1835@x2.net.home>
 <50A37AD8.6060601@gmail.com>
 <20121114122610.GF1835@x2.net.home>
 <20121114233117.GD20303@altlinux.org>
 <50A48F5F.3090404@gmail.com>
 <20121115075253.GA26255@x2.net.home>
 <20121115084821.GB1877@dhcp-0-146.brq.redhat.com>
 <50A4B774.4010005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50A4B774.4010005@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 15, 2012 at 01:35:48PM +0400, Alexey Gladkov wrote:
> 15.11.2012 12:48, Petr Pisar wrote:
> > It's similar but insufficient. The difference between your clear_str[]
> > = "\33[H\33[J" and my string is my way clears scroll-back buffer of Linux
> > virtual terminal too. This prevents from reading history using Shift-PgUp
> > while the terminal is locked. Read current console_codes(4) page, especially
> > search for word "buffer".
> > 
> > So what I ask is to prepend "\33[3J" to your clear_str[]. This even users with
> > older kernel not implementing this code get console cleared.
> 
> Sounds reasonable.
> 
> > If I understand the code correctly, you clear screen only if it's a virtual
> > terminal. I have no idea how usefull is vlock on other terminals (I use
> > "screen" there), so I do not request any change in this matter.
> 
> Ok. This is what I wanted to find out.
> 
> Guys, I want to release the new version of kbd next month. This will
> be the first kbd release with the vlock. Do you have any more
> suggestions on vlock?

 Rename --enable-vlock to --disable-vlock and enable it by default :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
