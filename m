Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbaEUMlo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 May 2014 08:41:44 -0400
Date: Wed, 21 May 2014 14:41:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Message-ID: <20140521124134.GD2898@x2.net.home>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
 <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de>
 <20140521073753.GA2898@x2.net.home>
 <201405210943.47004.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405210943.47004.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 21, 2014 at 11:43:46AM +0200, Ruediger Meier wrote:
> On Wednesday 21 May 2014, Karel Zak wrote:
> > On Tue, May 20, 2014 at 03:42:29PM +0000, Ruediger Meier wrote:
> > >  const int hv_vendor_pci[] = {
> > > @@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
> > >  static void
> > >  read_hypervisor_cpuid(struct lscpu_desc *desc
> > > __attribute__((__unused__))) {
> > > +#ifdef __powerpc__
> > > +	/* powerpc:
> > > +	 * IBM iSeries: legacy, if /proc/iSeries exists, its
> > > para-virtualized on top of OS/400 +	 * IBM pSeries: always has a
> > > hypervisor
> > > +	 *              if partition-name is "full", its kind of
> > > "bare-metal": full-system-partition +	 *              otherwise its
> > > some partition created by Hardware Management Console +	 *         
> > >     in any case, its always some sort of HVM +	 * KVM: "linux,kvm"
> > > in /hypervisor/compatible indicates a KVM guest +	 * Xen: not in
> > > use, not detected
> > > +	 */
> >
> >  I don't see relation between this code and CPU ID. Why this  codes
> > is with in read_hypervisor_cpuid() ?
> >
> >  Wouldn't be better to add  read_powerpc_hypervisor() and call it
> > from read_hypervisor()?
> 
> Yes, I would call it like this, ok?

 OK.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
