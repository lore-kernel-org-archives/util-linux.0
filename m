Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbcDNMn0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Apr 2016 08:43:26 -0400
Date: Thu, 14 Apr 2016 14:43:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.29 plan: kill mtab
Message-ID: <20160414124323.u4efqhl6mwkvbk3c@ws.net.home>
References: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
 <201604132258.28216.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604132258.28216.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 13, 2016 at 10:58:28PM +0200, Ruediger Meier wrote:
> On Thursday 07 April 2016, Karel Zak wrote:
> > libmount supports three scenarios:
> >
> >  1) regular classic /etc/mtab
> >
> >  2) /etc/mtab symlink to /proc/self/mount -- in this case libmount
> > uses /proc/self/mountinfo and /run/mount/utab
> >
> >  The current default is to detect symlink and on-the-fly switch
> >  between 1) and 2).
> >
> >  3) --enable-libmount-force-mountinfo -- don't care about the symlink
> > and always use /proc/self/mountinfo. This is robust solution required
> > for example by systemd, because unfortunately sometimes people use
> > broken stuff (init scripts, tools, etc.) which removes the symlink.
> >
> >
> >  I'd like to make 3) default, the question is what with mtab code:
> >
> >     a) #ifdef all mtab code (and add --enable-libmount-support-mtab)
> >
> >     b) remove mtab support at all (because it's evil and horrible
> > code)
> >
> >  Comments?
> >
> >     Karel
> 
> 
> What about this first step:

I have applied another patch to disable mtab by default, a new 
configure option

    --enable-libmount-support-mtab 
    
is necessary to enable the original behavior.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
