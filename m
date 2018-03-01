Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35827 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033238AbeCARYL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Mar 2018 12:24:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id x7so13623486wmc.0
        for <util-linux@vger.kernel.org>; Thu, 01 Mar 2018 09:24:10 -0800 (PST)
Date: Thu, 1 Mar 2018 18:24:08 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Steve Kenton <skenton@ou.edu>,
        util-linux@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180301172408.wsggwvmb33oogmex@pali>
References: <20180227184407.5945-1-skenton@ou.edu>
 <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
 <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
 <20180228220319.ccosidfzrdlowwqu@pali>
 <20180301110851.tc7erpwy3duhvzxw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180301110851.tc7erpwy3duhvzxw@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 March 2018 12:08:51 Karel Zak wrote:
> On Wed, Feb 28, 2018 at 11:03:19PM +0100, Pali Rohár wrote:
> > On Wednesday 28 February 2018 14:32:20 Jan Kara wrote:
> > > On Wed 28-02-18 14:08:28, Karel Zak wrote:
> > > > On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> > > > > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >  sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++--------------
> > > > >  1 file changed, 67 insertions(+), 22 deletions(-)
> > > > 
> > > > Applied, thanks.
> > > > 
> > > > Jan, what about to create udf(5) man page? We already have fs-specific
> > > > man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maintained
> > > > within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
> > > > standard man-pages (CC: to Michael).
> > > 
> > > I'm fine with that. Pali is actually the maintainer of udf-tools so if he
> > > is willing to take the manpage there, it's probably the best place.
> > 
> > Is udftools the best place for kernel udf mount options? Because
> > userspace udftools are not needed for kernel udf driver, nor for
> > mounting existing udf filesystem.
> 
> This is reason why Michael is in CC: :-)

Ok :-)

> > For me it looks like that kernel drivers should have its documentation
> > in kernel itself...
> > 
> > Anyway, I have not know yet that there is e.g. ext4 manpage which
> > describe mount options. I was always looking into mount.8 manpage for
> > filesystem mount parameters.
> 
> There is no extN stuff anymore in mount.8.

Ah, ok. I have Debian stable on servers which has older mount.8 with
ext* options.

> > The only missing filesystem in mount.8 is nfs, but that is probably
> > because mount uses mount.nfs helper.
> 
> Unfortunately, it's nothing unusual that mount.8 is ignored by FS
> devels and not up to date... so the idea is keep FS docs near to 
> the FS developers to improve things ;-) 
> 
> For example NFS developers have decided to maintain it in nfs-utils,
> extN in e2fsprogs, tmpfs and procfs in Michaels' man-pages, etc.
> 
> Anyway, I have no problem to maintain UDF (or another) mount options 
> in mount.8. It's your choice. Your patches for mount.8 are welcomed.

So wait for Michael answer...

-- 
Pali Rohár
pali.rohar@gmail.com
