Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21246 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab3CNKWV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Mar 2013 06:22:21 -0400
Date: Thu, 14 Mar 2013 11:22:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Jeff Epler <jepler@unpythonic.net>
Cc: LaMont Jones <lamont@debian.org>, Roger Leigh <rleigh@codelibre.net>,
        util-linux@vger.kernel.org
Subject: Re: Enable findmnt on kfreebsd
Message-ID: <20130314102209.GB7700@x2.net.home>
References: <20130314003946.GB4068@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130314003946.GB4068@unpythonic.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 13, 2013 at 07:39:47PM -0500, Jeff Epler wrote:
> In a recent discussion on #debian-kbsd, rleigh brought up the fact that
> findmnt isn't available on kfreebsd; he feels it would be useful in
> initscripts.

 Do you mean for fstab/mtab parsing? ... because I cannot imagine
 anything else without Linux kernel.

> I had a look at what it would take to enable findmnt, which needs
> libmount.  It turns out that not much is required: mostly, make a few
> bits of code return (-)ENOSYS.  There were also a few more bits that
> needed tweaking before kfreebsd was happy (LIST_HEAD is also in some
> bsd-origin header, and of course <linux/posix_types.h> was not
> available).
> 
> I'm not sure I correctly intuited where it was proper to return +ENOSYS
> and where it was proper to return -ENOSYS, so this merits further study.

 Maybe you can #ifdef whole context{.c,_umount.c,mount.c} API. All you
 need is probably fs.c tab*.c files. Maybe you can modify libmount/src/Makemodule.am
 rather than code to create a minimalistic kernel independent libmount :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
