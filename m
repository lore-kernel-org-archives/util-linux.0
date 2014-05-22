Return-Path: agraf@suse.de
Message-ID: <537DC3A1.6000401@suse.de>
Date: Thu, 22 May 2014 11:30:09 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Karel Zak <kzak@redhat.com>,
        Paul Mackerras <paulus@au1.ibm.com>
CC: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>,
        Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de> <201405220103.43871.sweet_f_a@gmx.de> <20140522084820.GE2898@x2.net.home> <20140522090824.GC4430@osiris>
In-Reply-To: <20140522090824.GC4430@osiris>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>


On 22.05.14 11:08, Heiko Carstens wrote:
> Hi Karel,
>
> I think Alexander Graf (who is kvm on powerpc maintainer) should answer
> how he would like to have it classified.
>
> [full quote below]
>
> On Thu, May 22, 2014 at 10:48:20AM +0200, Karel Zak wrote:
>>   Heiko, can you help us to classify pSeries and iSeries virtualization?
>>   See below. Is it FULL or PARA virtualization? Thanks!
>>
>>      Karel
>>
>> On Thu, May 22, 2014 at 01:03:43AM +0200, Ruediger Meier wrote:
>>>> +	[HYPER_OS400]	= "OS/400",
>>>> +	[HYPER_PHYP]	= "pHyp"
>>>>   };
>>>>   
>>>>   const int hv_vendor_pci[] = {
>>>> @@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
>>>>   static void
>>>>   read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
>>>>   {
>>>> +#ifdef __powerpc__
>>>> +	/* powerpc:
>>>> +	 * IBM iSeries: legacy, if /proc/iSeries exists, its para-virtualized on top of OS/400
>>> According to this comment ...
>>>
>>>> +	 * IBM pSeries: always has a hypervisor
>>>> +	 *              if partition-name is "full", its kind of "bare-metal": full-system-partition
>>>> +	 *              otherwise its some partition created by Hardware Management Console
>>>> +	 *              in any case, its always some sort of HVM
>>>> +	 * KVM: "linux,kvm" in /hypervisor/compatible indicates a KVM guest
>>>> +	 * Xen: not in use, not detected
>>>> +	 */
>>>> +	if (path_exist("/proc/iSeries")) {
>>>> +		desc->hyper = HYPER_OS400;
>>>> +		desc->virtype = VIRT_FULL;
>>> ... shouldn't this be VIRT_PARA? Somebody who knows this may correct this.

iSeries is PV, yes. Among others it's also dead :). But I'll let Ben 
comment.

>>>
>>>> +	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
>>>> +		FILE *fd;
>>>> +		desc->hyper = HYPER_PHYP;
>>>> +		desc->virtype = VIRT_FULL;
>>> Maybe more obvious here for pSeries where p seems to stand for para
>>> http://www.ibm.com/developerworks/aix/library/au-syspvirtualization/index.html?S_TACT=105AGX99&S_CMP=CP

This is slightly more complicated. The ibm,partition-name device tree 
property is defined in sPAPR which is a specification that both pHyp and 
QEMU implement. Right now QEMU does not expose the ibm,partition-name 
property, but there's no reason it will stay that way.

There are a few ways we could try to distinguish QEMU's implementation 
of the pSeries machine and pHyp's implementation of it.

   /proc/device-tree/hmc-managed?

I don't think QEMU will ever implement this property, but at least my 
pHyp reference VM does. If it's there we can use it as a definite marker 
that we are in fact running on pHyp.

   /proc/device-tree/chosen/qemu,graphic-width

Only QEMU puts qemu, properties in the chosen directory. At least the 
current code always sets the graphic-* properties, so if we find one we 
can safely assume we're running on QEMU. We do not know whether we're 
running on KVM yet.

Checking on KVM is slightly more tricky. I think we have 2 options:

   1) Check if /proc/device-tree/cpus/*@0/timebase-frequency is 1000000000.

      If it is, we're emulated (no KVM). If it's not, we're running with 
a native CPU (KVM).

   2) Check whether /proc/device-tree/hypervisor/compatible == "linux,kvm"

     I have a patch in my queue to make the sPAPR compliant pSeries 
machine type in QEMU also ePAPR compliant and expose a /hypervisor node. 
Current versions of QEMU don't do this though, so this would not catch 
QEMU versions < 2.1.

     The nice thing about the ePAPR compliant check is that we'd catch 
non-pSeries machine types as well. We expose this node on all emulated 
Mac machines and on FSL e500 style machines.


Alex
