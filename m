Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab1F3Kdb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jun 2011 06:33:31 -0400
Date: Thu, 30 Jun 2011 12:33:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't try to chgrp write or wall if they are not built
Message-ID: <20110630103325.GN6418@nb.net.home>
References: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com> <20110630085327.GA8274@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110630085327.GA8274@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 30, 2011 at 10:53:27AM +0200, Olaf Hering wrote:
> On Thu, Jun 30, Marc-Antoine Perennou wrote:
> 
> > Fix regression from commit 4aa9d65bfa76afd0d886ca410ae83428a490d4ea
> > 
> > Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> > ---
> >  term-utils/Makefile.am |   10 ++++++++--
> 
> > -       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
> > $(DESTDIR)$(usrbin_execdir)/write
> > -       chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
> > $(DESTDIR)$(usrbin_execdir)/write
> > +if BUILD_WALL
> > +       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
> 
> This is wrong and should part of the packaging system, not part of make
> install. The userid building util-linux is not neccessary part of the
> tty group.

 Why do you expect that everyone uses any packaging system? The "make
 install" result should be usable. Note that this all is controlled by
 --disable-makeinstall-chown and --disable-makeinstall-setuid options.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
