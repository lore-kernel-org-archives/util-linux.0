Return-Path: util-linux-owner@vger.kernel.org
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:57860 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbaEVJI3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 22 May 2014 05:08:29 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 22 May 2014 10:08:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 10C2017D8063
	for <util-linux@vger.kernel.org>; Thu, 22 May 2014 10:09:38 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4M98P7x55181414
	for <util-linux@vger.kernel.org>; Thu, 22 May 2014 09:08:25 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4M98OYc009518
	for <util-linux@vger.kernel.org>; Thu, 22 May 2014 03:08:25 -0600
Date: Thu, 22 May 2014 11:08:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>, Alexander Graf <agraf@suse.de>,
        Paul Mackerras <paulus@au1.ibm.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Message-ID: <20140522090824.GC4430@osiris>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
 <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de>
 <201405220103.43871.sweet_f_a@gmx.de>
 <20140522084820.GE2898@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140522084820.GE2898@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

I think Alexander Graf (who is kvm on powerpc maintainer) should answer
how he would like to have it classified.

[full quote below]

On Thu, May 22, 2014 at 10:48:20AM +0200, Karel Zak wrote:
> 
>  Heiko, can you help us to classify pSeries and iSeries virtualization?
>  See below. Is it FULL or PARA virtualization? Thanks!
> 
>     Karel
> 
> On Thu, May 22, 2014 at 01:03:43AM +0200, Ruediger Meier wrote:
> > > +	[HYPER_OS400]	= "OS/400",
> > > +	[HYPER_PHYP]	= "pHyp"
> > >  };
> > >  
> > >  const int hv_vendor_pci[] = {
> > > @@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
> > >  static void
> > >  read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
> > >  {
> > > +#ifdef __powerpc__
> > > +	/* powerpc:
> > > +	 * IBM iSeries: legacy, if /proc/iSeries exists, its para-virtualized on top of OS/400
> > 
> > According to this comment ...
> > 
> > > +	 * IBM pSeries: always has a hypervisor
> > > +	 *              if partition-name is "full", its kind of "bare-metal": full-system-partition
> > > +	 *              otherwise its some partition created by Hardware Management Console
> > > +	 *              in any case, its always some sort of HVM
> > > +	 * KVM: "linux,kvm" in /hypervisor/compatible indicates a KVM guest
> > > +	 * Xen: not in use, not detected
> > > +	 */
> > > +	if (path_exist("/proc/iSeries")) {
> > > +		desc->hyper = HYPER_OS400;
> > > +		desc->virtype = VIRT_FULL;
> > 
> > ... shouldn't this be VIRT_PARA? Somebody who knows this may correct this.
> > 
> > > +	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
> > > +		FILE *fd;
> > > +		desc->hyper = HYPER_PHYP;
> > > +		desc->virtype = VIRT_FULL;
> > 
> > Maybe more obvious here for pSeries where p seems to stand for para
> > http://www.ibm.com/developerworks/aix/library/au-syspvirtualization/index.html?S_TACT=105AGX99&S_CMP=CP
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

