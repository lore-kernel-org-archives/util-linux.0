Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37688 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab2KTJ06 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Nov 2012 04:26:58 -0500
Date: Tue, 20 Nov 2012 10:26:54 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Lennart Poettering <lennart@poettering.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty and special chars @ and #
Message-ID: <20121120092654.GA4345@boole.suse.de>
References: <20121107165859.GD4383@x2.net.home>
 <20121112100410.GA1887@boole.suse.de>
 <20121112132926.GD26857@x2.net.home>
 <20121114142720.GA23414@boole.suse.de>
 <20121116101419.GC20338@x2.net.home>
 <20121116124729.GA4773@tango.0pointer.de>
 <20121116130544.GE20338@x2.net.home>
 <20121120004723.GH5922@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121120004723.GH5922@tango.0pointer.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 20, 2012 at 01:47:23AM +0100, Lennart Poettering wrote:
> On Fri, 16.11.12 14:05, Karel Zak (kzak@redhat.com) wrote:
> 
> > 
> > On Fri, Nov 16, 2012 at 01:47:29PM +0100, Lennart Poettering wrote:
> > > On Fri, 16.11.12 11:14, Karel Zak (kzak@redhat.com) wrote:
> > > 
> > > > 
> > > > On Wed, Nov 14, 2012 at 03:27:20PM +0100, Dr. Werner Fink wrote:
> > > > > Indeed this is a good solution ... but in the case of systemd and its
> > > > > getty generator we may think about a /etc/agettytab with a similar
> > > > > syntax scheme as the old /etc/inittab to be able to provide agetty
> > > > > options based on the used tty line.  Clearly this /etc/agettytab should
> > > > > be parsed by agetty and options for the specified tty are found:
> > > > > 
> > > > >   1:tty1:--noclear %p
> > > > >   2:tty2:%p
> > > > >   3:tty3:%p
> > > > >   4:tty4:%p
> > > > >   5:tty5:%p
> > > > >   6:tty6:%p
> > > > >   S0:ttyS0:--erase-chars # --kill-chars @ -mt 60 %p 9600,2400,1200
> > > > >   S1:ttyS0:-L 9600 %p 9600 vt102
> > > > 
> > > >  Hmm, I guess it's still possible to create tty line specific config
> > > >  file on systems with systemd. I'd like to avoid another place where
> > > >  will be configuration.
> > > 
> > > Please do not add such a configuration file.
> > > 
> > > In systemd, if people want to configure line-specific getty
> > > configuration they should just copy
> > > /usr/lib/systemd/system/getty@.service to
> > > /etc/systemd/system/getty@ttyS0.service and edit it there. Since systemd
> > > will first look for instantiated unit files, and only then fall back to
> > > generic template this should do the right thing.
> > 
> > It would be nice to make it more obvious in systemd.special man page.
> 
> But the getty is actually not thaaaat special, it's actually just a unit
> like any other with no special semantics.
> 
> This general approach is actually well documented, for example most
> recently here:
> 
> http://0pointer.de/blog/projects/serial-console.html
> 
> Indirectly this all is also listed in the FAQ:
> 
> http://www.freedesktop.org/wiki/Software/systemd/FrequentlyAskedQuestions

Hi Lennart,

you and also I know how to do this, nevertheless just one remark: for most
other users this is black magic (and most users are aliterate at the first
moment).  This because they are not aware how the systemd-getty-generator
nor how the getty services have to be read.  It is not at first glance
obviously from getty@.service nor serial-getty@.service how to get an other
getty for a special serial console nor how to have a getty with a special
option for e.g. for tty1.

The complexity level is to high due to the fact that there are to many
locations and set screws to influence the numbers, devices, and options
of the gettys.

If you like to avoid such simply approaches for agetty you may consider to
help normal users which do not work daily as system administrators to help
them by providing all infomations in a more comprehensible and user friendly
form in *one* file.  That could be that the getty-generator my use informations
from getty@.service and serial-getty@.service them self.

In other words: usability by striking simplicity :)

   Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
