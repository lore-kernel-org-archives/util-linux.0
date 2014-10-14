Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbaJNK1r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 06:27:47 -0400
Date: Tue, 14 Oct 2014 12:27:37 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: JWP <elseifthen@gmx.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
Message-ID: <20141014102737.GT8057@x2.net.home>
References: <5426D4C2.4060403@gmx.com>
 <5426D7C0.50108@gmx.com>
 <alpine.LNX.2.03.1409281829450.8884@iki.fi>
 <54298D46.6010101@gmx.com>
 <20141014090311.GM8057@x2.net.home>
 <CAG27Bk3x9YsB0sK+3ftPG4P_i8mK-en4BB=WoTjvPfpLvOLmOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3x9YsB0sK+3ftPG4P_i8mK-en4BB=WoTjvPfpLvOLmOA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 14, 2014 at 10:51:30AM +0100, Sami Kerola wrote:
> On 14 October 2014 10:03, Karel Zak <kzak@redhat.com> wrote:
> > Maybe it would be better to think about whole code refactoring as it's
> > horrible code. It's probably last so horrible code in util-linux.
> 
> Along with more(1). I started to look this refactoring task, and it
> seems reimplementation would be best option. Does someone fancy a
> programming challenge?

I prefer refactoring if possible than write things from scratch. And
for hwclock it's really critical to do the changes in small testable
steps.

Note that sfdisk and cfdisk are completely new because we have libfdisk that
replaces all the original cfdisk and sfdisk partitioning code. The
library itself is refactored and incrementally changed fdisk code.

> Few disk utils, cramfs, bfs, and minix related, could also be improved
> or marked deprecated. I am hoping for later.

Well, I don't think we can deprecated these tools and I don't think
that cramfs, minix and bfs code is so bad. For example mkfs.minix
has been clean upped by Davidlohr Bueso years ago. A few global
variables don't not mean that the code is bad...

Compare to hwclock it's like apples and oranges ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
