Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60692 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389AbaE3LxB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 May 2014 07:53:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: BUG: fdisk, gpt broken on 32bit big endian systems
Date: Fri, 30 May 2014 13:52:54 +0200
Cc: util-linux@vger.kernel.org
References: <201405300531.00403.sweet_f_a@gmx.de> <20140530085406.GD9000@x2.net.home>
In-Reply-To: <20140530085406.GD9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405301352.55198.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 30 May 2014, Karel Zak wrote:
> On Fri, May 30, 2014 at 05:31:00AM +0200, Ruediger Meier wrote:
> > $ rm -f xxx; truncate -s 10M xxx
> > $ echo -ne
> > "g\nx\ni\n26841E90-46E0-4205-B012-4B8AEC35C088\nr\nw\nq\n" | fdisk
> > xxx
> >
> > ... creates a broken gpt image on 32bit big endian systems.
> >
> > "hexdiff" xxx-broken xxx-good:
> >  00000260  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
> > |................| *
> >  009ffe00  45 46 49 20 50 41 52 54  00 00 01 00 00 02 00 00  |EFI
> > PART........| -009ffe10  68 a5 49 d1 00 00 00 00  ff ff ff ff ff ff
> > ff ff  |h.I.............| +009ffe10  15 b9 f3 7e 00 00 00 00  ff 4f
> > 00 00 00 00 00 00  |...~.....O......| 009ffe20  01 00 00 00 00 00
> > 00 00  00 08 00 00 00 00 00 00  |................| 009ffe30  de 4f
> > 00 00 00 00 00 00  90 1e 84 26 e0 46 05 42  |.O.........&.F.B|
> > 009ffe40  b0 12 4b 8a ec 35 c0 88  df 4f 00 00 00 00 00 00 
> > |..K..5...O......|
>
>  Fixed now, I hope (not tested on 32bit BE, but the code was so
>  stupid that it has to be the problem :-)

Thanks! This works.

cu,
Rudi

