Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/2] build-sys: add --disable-logger and --disable-lslogins
Date: Wed, 6 Apr 2016 13:20:03 +0100
Cc: util-linux@vger.kernel.org
References: <1459939867-20719-1-git-send-email-sweet_f_a@gmx.de> <1459939867-20719-2-git-send-email-sweet_f_a@gmx.de> <20160406115712.fqmc4eaqsxza2ajr@ws.net.home>
In-Reply-To: <20160406115712.fqmc4eaqsxza2ajr@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604061420.04272.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 06 April 2016, Karel Zak wrote:
> On Wed, Apr 06, 2016 at 12:51:07PM +0200, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > Now we are able to disable all programs which have systemd/journald
> > support. This feature is needed by openSUSE packagers who are
> > building util-linux in 2 stages to avoid build cycles.
>
> Well, systemd support is optional, you can build all (including
> logger and lslogins) --without-systemd.

My commit message was a bit wrong. Actually they are already 
using --without-systemd to disable both progs. But in stage 2 they need 
to _enable_ them again like this:
  --with-systemd --disable-all-programs \
  --enable-logger --enable-lslogins --enable-uuidd

> But I have nothing against --disable-lslogins and --disable-logger.
>
> Applied, thanks.

Thanks!
