Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:64262 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547AbcCOP3m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 11:29:42 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
Date: Tue, 15 Mar 2016 16:29:29 +0100
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, util-linux@vger.kernel.org
References: <20160314144804.415.11481.stgit@hegdevasant> <201603150933.31562.sweet_f_a@gmx.de> <20160315134941.atrpxt45iua6bq7b@ws.net.home>
In-Reply-To: <20160315134941.atrpxt45iua6bq7b@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603151629.30154.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 15 March 2016, Karel Zak wrote:
> On Tue, Mar 15, 2016 at 09:33:31AM +0100, Ruediger Meier wrote:
> > > diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> > > index fc32762..423bc56 100644
> > > --- a/sys-utils/lscpu.c
> > > +++ b/sys-utils/lscpu.c
> > > @@ -465,8 +465,13 @@ read_basicinfo(struct lscpu_desc *desc,
> > > struct lscpu_modifier *mod) else if (lookup(buf, "vendor_id",
> > > &desc->vendor)) ;
> > >  		else if (lookup(buf, "family", &desc->family)) ;
> > >  		else if (lookup(buf, "cpu family", &desc->family)) ;
> > > +#if defined(__powerpc__) || defined(__powerpc64__)
> > > +		else if (lookup(buf, "revision", &desc->model)) ;
> > > +		else if (lookup(buf, "cpu", &desc->modelname)) ;
> > > +#else
> > >  		else if (lookup(buf, "model", &desc->model)) ;
> > >  		else if (lookup(buf, "model name", &desc->modelname)) ;
> > > +#endif
> > >  		else if (lookup(buf, "stepping", &desc->stepping)) ;
> > >  		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
> > >  		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
> >
> > Would it be possible to decide on runtime what to do, ideally
> > looking into /proc or /sys to see whether it's a powerpc? This
> > ifdef does not work with lscpu --sysroot.
>
>  I have reverted the patch for --sysroot, so the #ifdef is applied to
>  live systems only (please, test it). Not elegant, but better than
>  nothing.

I have another idea, just use revision and cpu if available. I'll send a 
patch.

