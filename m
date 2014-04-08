Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308AbaDHKZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Apr 2014 06:25:27 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Tue, 8 Apr 2014 12:25:21 +0200
Cc: Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <20140407104304.GJ22126@x2.net.home>
In-Reply-To: <20140407104304.GJ22126@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404081225.21563.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 07 April 2014, Karel Zak wrote:
> On Thu, Apr 03, 2014 at 11:41:51PM +0200, Thomas Bächler wrote:
> >  sys-utils/.gitignore        |  1 +
> >  sys-utils/Makemodule.am     |  6 ++++++
> >  sys-utils/fstrim.service.in |  6 ++++++
> >  sys-utils/fstrim.timer      | 10 ++++++++++
> >  4 files changed, 23 insertions(+)
> >  create mode 100644 sys-utils/fstrim.service.in
> >  create mode 100644 sys-utils/fstrim.timer
>
>  Applied, thanks.

Hm, isn't this a bit over the top? Adding a script just to 
call "fstrim -a" automatically?
Should we also add scripts for "mount -a" or "fsck -a" or "swapon -a"?

And wouldn't we also need to add "example crontab" lines for non-systemd 
systems! Sounds a bit ridiculous, right?

I think it's the distro's or admin's job to write and add the scripts 
for filesystems maintenance etc.

BTW fstrim.timer is missing in "make dist" tar ball.

cu,
Rudi
