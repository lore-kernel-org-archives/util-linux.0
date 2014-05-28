Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Date: Wed, 28 May 2014 23:54:21 +0200
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Karel Zak <kzak@redhat.com>,
        Paul Mackerras <paulus@au1.ibm.com>, util-linux@vger.kernel.org,
        Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>,
        Ben Herrenschmidt <benh@kernel.crashing.org>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <20140522090824.GC4430@osiris> <537DC3A1.6000401@suse.de>
In-Reply-To: <537DC3A1.6000401@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405282354.22353.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

Thank you all for your comments!

Patch set updated here:
https://github.com/karelzak/util-linux/pull/87


On Thursday 22 May 2014, Alexander Graf wrote:
> >>>> +	if (path_exist("/proc/iSeries")) {
> >>>> +		desc->hyper = HYPER_OS400;
> >>>> +		desc->virtype = VIRT_FULL;
> >>> ... shouldn't this be VIRT_PARA? Somebody who knows this may correct this.
> 
> iSeries is PV, yes. Among others it's also dead :). But I'll let Ben 
> comment.

We set VIRT_PARA now for iSeries and (real) pSeries. 
 
> >>>
> >>>> +	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
> >>>> +		FILE *fd;
> >>>> +		desc->hyper = HYPER_PHYP;
> >>>> +		desc->virtype = VIRT_FULL;
> >>> Maybe more obvious here for pSeries where p seems to stand for para
> >>> http://www.ibm.com/developerworks/aix/library/au-syspvirtualization/index.html?S_TACT=105AGX99&S_CMP=CP
> 
> This is slightly more complicated. The ibm,partition-name device tree 
> property is defined in sPAPR which is a specification that both pHyp and 
> QEMU implement. Right now QEMU does not expose the ibm,partition-name 
> property, but there's no reason it will stay that way.
> 
> There are a few ways we could try to distinguish QEMU's implementation 
> of the pSeries machine and pHyp's implementation of it.
> 
>    /proc/device-tree/hmc-managed?
> 
> I don't think QEMU will ever implement this property, but at least my 
> pHyp reference VM does. If it's there we can use it as a definite marker 
> that we are in fact running on pHyp.
> 
>    /proc/device-tree/chosen/qemu,graphic-width

OK, we do it like this for now
  if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")
      && path_exist(_PATH_PROC_DEVICETREE "/hmc-managed?")
      && !path_exist(_PATH_PROC_DEVICETREE "/chosen/qemu,graphic-width")) {
  desc->hyper = HYPER_PHYP;
  desc->virtype = VIRT_PARA;
  ....  

Haven't yet done something about the "pSeries on QEMU/KVM" detection
according to the comments below. Could be that our existing KVM detection
would catch it already.

IMO we should add a script to easily make correct (and complete) /sys, /proc
dumps. So users who own exotic machines could send us test data.

> Only QEMU puts qemu, properties in the chosen directory. At least the 
> current code always sets the graphic-* properties, so if we find one we 
> can safely assume we're running on QEMU. We do not know whether we're 
> running on KVM yet.
> 
> Checking on KVM is slightly more tricky. I think we have 2 options:
> 
>    1) Check if /proc/device-tree/cpus/*@0/timebase-frequency is 1000000000.
> 
>       If it is, we're emulated (no KVM). If it's not, we're running with 
> a native CPU (KVM).
> 
>    2) Check whether /proc/device-tree/hypervisor/compatible == "linux,kvm"
> 
>      I have a patch in my queue to make the sPAPR compliant pSeries 
> machine type in QEMU also ePAPR compliant and expose a /hypervisor node. 
> Current versions of QEMU don't do this though, so this would not catch 
> QEMU versions < 2.1.
> 
>      The nice thing about the ePAPR compliant check is that we'd catch 
> non-pSeries machine types as well. We expose this node on all emulated 
> Mac machines and on FSL e500 style machines.
> 
> 
> Alex
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
