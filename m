Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2DZHqh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 03:46:37 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q3Q7kb1I006073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 26 Apr 2012 03:46:37 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q3Q7kaEO025270
	for <util-linux@vger.kernel.org>; Thu, 26 Apr 2012 03:46:36 -0400
Date: Thu, 26 Apr 2012 09:46:35 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] findmnt: add match_by_file to do within-device
 matching
Message-ID: <20120426074635.GB28346@x2.net.home>
References: <1335400252-17929-1-git-send-email-dreisner@archlinux.org>
 <1335400252-17929-2-git-send-email-dreisner@archlinux.org>
 <20120426021651.GH938@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120426021651.GH938@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 25, 2012 at 10:16:51PM -0400, Dave Reisner wrote:
> On Wed, Apr 25, 2012 at 08:30:52PM -0400, Dave Reisner wrote:
> > Use the newly exported mnt_get_mountpoint to determine the device that a
> > given file resides on, in case the supplied source or target is not
> > explicitly a mount point.
> > 
> > http://www.spinics.net/lists/util-linux-ng/msg06081.html
> > 
> > Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> > ---
> 
> On second thought, this isn't good -- it'll return results even when
> you're searching with --fstab (which is completely undesirable, imo).

 I'll fix it, that's easy. Thanks.

> >  	m = get_match(COL_TARGET);
> > -	if (m && !mnt_fs_match_target(fs, m, cache))
> > +	if (m && !match_by_file(m, fs, mnt_fs_match_target))
> >  		return rc;
> >  
> >  	m = get_match(COL_SOURCE);
> > -	if (m && !mnt_fs_match_source(fs, m, cache))
> > +	if (m && !match_by_file(m, fs, mnt_fs_match_source))

 why we need this functionality for SOURCE too?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
