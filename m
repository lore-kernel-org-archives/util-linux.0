Return-Path: util-linux-owner@vger.kernel.org
Received: from tango.0pointer.de ([85.214.72.216]:34638 "EHLO
	tango.0pointer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2KTQ74 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 20 Nov 2012 11:59:56 -0500
Date: Tue, 20 Nov 2012 17:59:54 +0100
From: Lennart Poettering <lennart@poettering.net>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty and special chars @ and #
Message-ID: <20121120165954.GA18664@tango.0pointer.de>
References: <20121107165859.GD4383@x2.net.home>
 <20121112100410.GA1887@boole.suse.de>
 <20121112132926.GD26857@x2.net.home>
 <20121114142720.GA23414@boole.suse.de>
 <20121116101419.GC20338@x2.net.home>
 <20121116124729.GA4773@tango.0pointer.de>
 <20121116130544.GE20338@x2.net.home>
 <20121120004723.GH5922@tango.0pointer.de>
 <20121120092654.GA4345@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121120092654.GA4345@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 20.11.12 10:26, Dr. Werner Fink (werner@suse.de) wrote:

> > But the getty is actually not thaaaat special, it's actually just a unit
> > like any other with no special semantics.
> > 
> > This general approach is actually well documented, for example most
> > recently here:
> > 
> > http://0pointer.de/blog/projects/serial-console.html
> > 
> > Indirectly this all is also listed in the FAQ:
> > 
> > http://www.freedesktop.org/wiki/Software/systemd/FrequentlyAskedQuestions
> 
> Hi Lennart,
> 
> you and also I know how to do this, nevertheless just one remark: for most
> other users this is black magic (and most users are aliterate at the first
> moment).  This because they are not aware how the systemd-getty-generator
> nor how the getty services have to be read.  It is not at first glance
> obviously from getty@.service nor serial-getty@.service how to get an other
> getty for a special serial console nor how to have a getty with a special
> option for e.g. for tty1.
>
> The complexity level is to high due to the fact that there are to many
> locations and set screws to influence the numbers, devices, and options
> of the gettys.

Well, I am not really sure I buy into the complexity thing so much. We
use the same concepts for making changes to any service here, really. So
if an admin grokked this once he should be able to apply this to any
service he likes.

> If you like to avoid such simply approaches for agetty you may consider to
> help normal users which do not work daily as system administrators to help
> them by providing all infomations in a more comprehensible and user friendly
> form in *one* file.  That could be that the getty-generator my use informations
> from getty@.service and serial-getty@.service them self.
> 
> In other words: usability by striking simplicity :)

I really don't agree that adding multiple levels of configuration really
would be such a good idea. Adding redundancy by implementing several
different ways to configure the same thing just adds confusion and
complexity in my eyes.

Note that systemd-getty-generator actually comes with a man page. Of
course, it's a problem to get people to actually find it, or even know
about it.

I have now updated the Documentation= field of the getty services to
point to the aforementioned blog story (this will then show up in
systemctl status), and added similar links to all man pages in any way
related to getty configuration. I think this is the best we can do:
keeping things uniform and not redundant, while beefing up docs and
making them easier to find.

Hope this settles this,

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
