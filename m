Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933806AbcCONtn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 09:49:43 -0400
Date: Tue, 15 Mar 2016 14:49:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
Message-ID: <20160315134941.atrpxt45iua6bq7b@ws.net.home>
References: <20160314144804.415.11481.stgit@hegdevasant>
 <201603150933.31562.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603150933.31562.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 15, 2016 at 09:33:31AM +0100, Ruediger Meier wrote:
> > diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> > index fc32762..423bc56 100644
> > --- a/sys-utils/lscpu.c
> > +++ b/sys-utils/lscpu.c
> > @@ -465,8 +465,13 @@ read_basicinfo(struct lscpu_desc *desc, struct
> > lscpu_modifier *mod) else if (lookup(buf, "vendor_id",
> > &desc->vendor)) ;
> >  		else if (lookup(buf, "family", &desc->family)) ;
> >  		else if (lookup(buf, "cpu family", &desc->family)) ;
> > +#if defined(__powerpc__) || defined(__powerpc64__)
> > +		else if (lookup(buf, "revision", &desc->model)) ;
> > +		else if (lookup(buf, "cpu", &desc->modelname)) ;
> > +#else
> >  		else if (lookup(buf, "model", &desc->model)) ;
> >  		else if (lookup(buf, "model name", &desc->modelname)) ;
> > +#endif
> >  		else if (lookup(buf, "stepping", &desc->stepping)) ;
> >  		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
> >  		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
> 
> Would it be possible to decide on runtime what to do, ideally looking 
> into /proc or /sys to see whether it's a powerpc? This ifdef does not 
> work with lscpu --sysroot.

 I have reverted the patch for --sysroot, so the #ifdef is applied to
 live systems only (please, test it). Not elegant, but better than
 nothing.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
