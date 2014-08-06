Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:38442 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbaHFRQM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 13:16:12 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id C45A4C22F
	for <util-linux@vger.kernel.org>; Wed,  6 Aug 2014 19:15:39 +0200 (CEST)
Date: Wed, 6 Aug 2014 19:15:37 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix re-enabling of cursor with slang also after pressing
 Ctrl-C
Message-ID: <20140806171537.GA10686@fatal.se>
References: <1419379.tzkKhjxti9@merkaba>
 <1469621.AbYYNxNq4q@merkaba>
 <20140806134912.GK19820@x2.net.home>
 <3075069.kQdDlpn9sU@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3075069.kQdDlpn9sU@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel Zak, Martin Steigerwald!

On Wed, Aug 06, 2014 at 04:37:38PM +0200, Martin Steigerwald wrote:
> Am Mittwoch, 6. August 2014, 15:49:12 schrieb Karel Zak:
[...]
> > BTW, does it mean that Debian uses slang by default? Why? IMHO ncurses
> > is better :-)
> 
> Yes, it does. Why? I don´t know. Maybe Andreas who maintained the util-linux 
> 2.25 update into Debian´s before highly outdated util-linux package knows 
> more. Andreas?
[...]

As Martin already mentioned and you might already be aware of, Debian
ships a really old version of util-linux. On top of this there seems
to have been basically no bug triaging done for the past decade.

As I see it one of the main reasons for this is that the Debian maintainers
backed themselves into a corner with how they worked and the main person
losing interest.

I've been working since a while to try to eliminate the gigantic hurdle
built up over a long time so we can (continuously) update the package
again in Debian. (The update from 2.20.1 -> 2.24.2 alone solved ~ 100 bugs
reported to the debian bug tracking system.)
(My updated package is currently sitting in Debian Experimental, so is only
available to those that explicitly add that repository and explicitly
install the new util-linux package from there as Martin have done.)

Over to slang, yes the Debian package of util-linux uses slang by default.
This is mostly for historic reasons and it's on the TODO list to change
to ncurses (which has been attempted once before prior to my involvement,
but then switched back).
Special considerations are needed to investigate the impact this has on
the debian-installer.
Because of these special considerations, I've punted the slang/ncurses
switch for now and hope to resolve the first part (continuous updates)
first.

If anyone is interested in more background info, please feel free to ask.

Finally, while we're talking about Debian I'll take the chance to mention
that it would be very appreciated if anyone wants to help me out with
some of the remaining bugs!
(There are still > 100 bugs open in the Debian bug tracking system.)

For the complete list:
http://bugs.debian.org/src:util-linux

For a filtered list with only the ones I've tagged "upstream":
http://bugs.debian.org/src:util-linux;include=tags:upstream

(For those unfamiliar with Debian BTS, please note that the webpages
are "read-only". Compare with eg. a mailing list archive. All interactions
are done via email.)


Regards,
Andreas Henriksson
