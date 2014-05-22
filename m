Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaEVIsc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 22 May 2014 04:48:32 -0400
Date: Thu, 22 May 2014 10:48:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Message-ID: <20140522084820.GE2898@x2.net.home>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
 <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de>
 <201405220103.43871.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405220103.43871.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Heiko, can you help us to classify pSeries and iSeries virtualization?
 See below. Is it FULL or PARA virtualization? Thanks!

    Karel

On Thu, May 22, 2014 at 01:03:43AM +0200, Ruediger Meier wrote:
> > +	[HYPER_OS400]	= "OS/400",
> > +	[HYPER_PHYP]	= "pHyp"
> >  };
> >  
> >  const int hv_vendor_pci[] = {
> > @@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
> >  static void
> >  read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
> >  {
> > +#ifdef __powerpc__
> > +	/* powerpc:
> > +	 * IBM iSeries: legacy, if /proc/iSeries exists, its para-virtualized on top of OS/400
> 
> According to this comment ...
> 
> > +	 * IBM pSeries: always has a hypervisor
> > +	 *              if partition-name is "full", its kind of "bare-metal": full-system-partition
> > +	 *              otherwise its some partition created by Hardware Management Console
> > +	 *              in any case, its always some sort of HVM
> > +	 * KVM: "linux,kvm" in /hypervisor/compatible indicates a KVM guest
> > +	 * Xen: not in use, not detected
> > +	 */
> > +	if (path_exist("/proc/iSeries")) {
> > +		desc->hyper = HYPER_OS400;
> > +		desc->virtype = VIRT_FULL;
> 
> ... shouldn't this be VIRT_PARA? Somebody who knows this may correct this.
> 
> > +	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
> > +		FILE *fd;
> > +		desc->hyper = HYPER_PHYP;
> > +		desc->virtype = VIRT_FULL;
> 
> Maybe more obvious here for pSeries where p seems to stand for para
> http://www.ibm.com/developerworks/aix/library/au-syspvirtualization/index.html?S_TACT=105AGX99&S_CMP=CP

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
