Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40308 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbcHCJwl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Aug 2016 05:52:41 -0400
Date: Wed, 3 Aug 2016 11:52:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/8] losetup: Re-use loop device with matching parameters
Message-ID: <20160803095239.oczsfcpu7pcozyeq@ws.net.home>
References: <0a522a2f-71ff-ceb1-357b-d1298d418fbc@suse.cz>
 <20160803093334.3jtuejgboulpqe4o@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160803093334.3jtuejgboulpqe4o@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 03, 2016 at 11:33:34AM +0200, Karel Zak wrote:
> On Tue, Aug 02, 2016 at 07:55:58PM +0200, Stanislav Brabec wrote:
> > If losetup --find is called with parameters matching to an existing loop device,
> > re-use this loop device instead of allocating new one.
> > 
> > If --force is used, fall back to the old behavior.
> > 
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> > ---
> >  sys-utils/losetup.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> > index 0a323a9..ef6f52b 100644
> > --- a/sys-utils/losetup.c
> > +++ b/sys-utils/losetup.c
> > @@ -682,6 +682,51 @@ int main(int argc, char **argv)
> >  	{
> >  		int hasdev = loopcxt_has_device(&lc);
> >  
> > +		if (!hasdev && !force) {
> > +			res = loopcxt_find_by_backing_file(&lc,
> > +				file, offset, sizelimit,
> > +				LOOPDEV_FL_OFFSET | LOOPDEV_FL_SIZELIMIT);
> 
> Is it valid to set always the flags? If I do not specify --sizelimit
> then this code will use 0 as wanted size, right?

Ah... but /sys/.../sizelimit also uses 0 if not specified for the
original loop. So, seems correct.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
