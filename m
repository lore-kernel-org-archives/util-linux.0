Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcCUJQb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 05:16:31 -0400
Date: Mon, 21 Mar 2016 10:16:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: util-linux@vger.kernel.org, qcai@redhat.com
Subject: Re: [PATCH 1/1] lscpu: correct the Virtualization type on Xen DomU
 PV guest
Message-ID: <20160321091628.g6qdefltmyl3biiv@ws.net.home>
References: <de0b877e-622c-4cd8-887b-38713224c01c@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de0b877e-622c-4cd8-887b-38713224c01c@default>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 19, 2016 at 05:03:41AM -0700, Dongli Zhang wrote:
> 
> > + Is the file always available (including old XEN versions)? 
> 
> This file (/sys/hypervisor/properties/features) has been available since Linux 2.6.31 
> (drivers/xen/sys-hypervisor.c)
> 
> > + There is also path_read_u64() to avoid path_fopen() & fscanf().
> 
> I will change to path_read_u64.
> 
> 
> I also made a new flow to detect the Xen virtualization type according to
> the features on this path to maximize the number of versions of existing
> Xen and Linux to support. Xen versions from Xen 3.3.0 to the current Xen
> unstable would be able to help detect PV based on
> XENFEAT_mmu_pt_update_preserve_ad. Xen versions from Xen 4.4.0 to the
> newest would be able to help detect PVH (which has been introduced since
> Xen 4.4.0).
> 
> if cpuid returns XenVMMXenVMM
> 	virtype = full
> 	if _PATH_SYS_HYP_FEATURES (the file) exists
> 		if XENFEAT_mmu_pt_update_preserve_ad is set (supported since Xen 3.3.0)
> 			virtype = para
> 		else if XENFEAT_supervisor_mode_kernel is set and
> 				XENFEAT_hvm_callback_vector is set (supported since Xen 4.4.0)
> 			virtype = para
> 		end if
> 	end if
> end if
> 
> Please let me know your feedback and suggestion so that I would send the
> new patch soon.

Looks good, go ahead ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
