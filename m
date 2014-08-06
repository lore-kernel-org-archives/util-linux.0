Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:45563 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbaHFOhk convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 10:37:40 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH] Fix re-enabling of cursor with slang also after pressing Ctrl-C
Date: Wed, 06 Aug 2014 16:37:38 +0200
Message-ID: <3075069.kQdDlpn9sU@merkaba>
In-Reply-To: <20140806134912.GK19820@x2.net.home>
References: <1419379.tzkKhjxti9@merkaba> <1469621.AbYYNxNq4q@merkaba> <20140806134912.GK19820@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Mittwoch, 6. August 2014, 15:49:12 schrieb Karel Zak:
> On Mon, Aug 04, 2014 at 02:01:42PM +0200, Martin Steigerwald wrote:
> > > Scratch that.
> > > 
> > > Fix doesn´t work.
> > > 
> > > Cursor is displayed on regular end, but not on Ctrl-C.
> > > 
> > > Don´t get why tough.
> > 
> > Patch may still be correct, but SIGINT handler is broke:
> hmm...
> 
> I have moved curs_set() to ui_end(), because you're right that the patch
> seems correct (although it's unnecessary for ncurses).
> 
> BTW, does it mean that Debian uses slang by default? Why? IMHO ncurses
> is better :-)

Yes, it does. Why? I don´t know. Maybe Andreas who maintained the util-linux 
2.25 update into Debian´s before highly outdated util-linux package knows 
more. Andreas?

Any hint about the SIGINT handler issue? It doesn´t appear to get called at 
all.

-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
