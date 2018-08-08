Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39121 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHHQMr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Aug 2018 12:12:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so2859185wmq.4
        for <util-linux@vger.kernel.org>; Wed, 08 Aug 2018 06:53:00 -0700 (PDT)
Date: Wed, 8 Aug 2018 15:52:58 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: "Michael Kerrisk (man-opages)" <mtk.manpages@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>,
        Steve Kenton <skenton@ou.edu>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180808135258.ttcw5bmesiwuihvr@pali>
References: <20180227184407.5945-1-skenton@ou.edu>
 <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
 <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
 <20180228220319.ccosidfzrdlowwqu@pali>
 <b550e4cc-4a5e-72c3-a4db-85913769e97f@gmail.com>
 <20180506111527.xfzvxf2d4chajgyt@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180506111527.xfzvxf2d4chajgyt@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 06 May 2018 13:15:27 Pali Rohár wrote:
> On Sunday 06 May 2018 12:35:02 Michael Kerrisk (man-opages) wrote:
> > On 02/28/2018 11:03 PM, Pali Rohár wrote:
> > > On Wednesday 28 February 2018 14:32:20 Jan Kara wrote:
> > > > On Wed 28-02-18 14:08:28, Karel Zak wrote:
> > > > > On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> > > > > > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > > > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > >   sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++--------------
> > > > > >   1 file changed, 67 insertions(+), 22 deletions(-)
> > > > > 
> > > > > Applied, thanks.
> > > > > 
> > > > > Jan, what about to create udf(5) man page? We already have fs-specific
> > > > > man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maintained
> > > > > within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
> > > > > standard man-pages (CC: to Michael).
> > > > 
> > > > I'm fine with that. Pali is actually the maintainer of udf-tools so if he
> > > > is willing to take the manpage there, it's probably the best place.
> > > 
> > > Is udftools the best place for kernel udf mount options? Because
> > > userspace udftools are not needed for kernel udf driver, nor for
> > > mounting existing udf filesystem.
> > > 
> > > For me it looks like that kernel drivers should have its documentation
> > > in kernel itself...
> > 
> > [way late to the party...]
> > 
> > Or, better, in a man page that describes the kernel interface :-).
> > Many other filesystems have by now Section 5 pages in the man-pages package
> > that I maintain. A udf(5) page that describes the mount options that the
> > kernel supports for UDF would be best, and I think best lives inside
> > "man-pages" because it is kernel interface stuff.
> 
> Ok, that sounds good.
> 
> > Or, did such a page already land in udf-tools?
> 
> No, there is no such manpage.

Karel, Michael, has something happened here?

-- 
Pali Rohár
pali.rohar@gmail.com
