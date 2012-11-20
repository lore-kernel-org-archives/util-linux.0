Return-Path: util-linux-owner@vger.kernel.org
Received: from tango.0pointer.de ([85.214.72.216]:59072 "EHLO
	tango.0pointer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2KTArY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 Nov 2012 19:47:24 -0500
Date: Tue, 20 Nov 2012 01:47:23 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty and special chars @ and #
Message-ID: <20121120004723.GH5922@tango.0pointer.de>
References: <20121107165859.GD4383@x2.net.home>
 <20121112100410.GA1887@boole.suse.de>
 <20121112132926.GD26857@x2.net.home>
 <20121114142720.GA23414@boole.suse.de>
 <20121116101419.GC20338@x2.net.home>
 <20121116124729.GA4773@tango.0pointer.de>
 <20121116130544.GE20338@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121116130544.GE20338@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 16.11.12 14:05, Karel Zak (kzak@redhat.com) wrote:

> 
> On Fri, Nov 16, 2012 at 01:47:29PM +0100, Lennart Poettering wrote:
> > On Fri, 16.11.12 11:14, Karel Zak (kzak@redhat.com) wrote:
> > 
> > > 
> > > On Wed, Nov 14, 2012 at 03:27:20PM +0100, Dr. Werner Fink wrote:
> > > > Indeed this is a good solution ... but in the case of systemd and its
> > > > getty generator we may think about a /etc/agettytab with a similar
> > > > syntax scheme as the old /etc/inittab to be able to provide agetty
> > > > options based on the used tty line.  Clearly this /etc/agettytab should
> > > > be parsed by agetty and options for the specified tty are found:
> > > > 
> > > >   1:tty1:--noclear %p
> > > >   2:tty2:%p
> > > >   3:tty3:%p
> > > >   4:tty4:%p
> > > >   5:tty5:%p
> > > >   6:tty6:%p
> > > >   S0:ttyS0:--erase-chars # --kill-chars @ -mt 60 %p 9600,2400,1200
> > > >   S1:ttyS0:-L 9600 %p 9600 vt102
> > > 
> > >  Hmm, I guess it's still possible to create tty line specific config
> > >  file on systems with systemd. I'd like to avoid another place where
> > >  will be configuration.
> > 
> > Please do not add such a configuration file.
> > 
> > In systemd, if people want to configure line-specific getty
> > configuration they should just copy
> > /usr/lib/systemd/system/getty@.service to
> > /etc/systemd/system/getty@ttyS0.service and edit it there. Since systemd
> > will first look for instantiated unit files, and only then fall back to
> > generic template this should do the right thing.
> 
> It would be nice to make it more obvious in systemd.special man page.

But the getty is actually not thaaaat special, it's actually just a unit
like any other with no special semantics.

This general approach is actually well documented, for example most
recently here:

http://0pointer.de/blog/projects/serial-console.html

Indirectly this all is also listed in the FAQ:

http://www.freedesktop.org/wiki/Software/systemd/FrequentlyAskedQuestions

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
