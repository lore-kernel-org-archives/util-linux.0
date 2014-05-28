Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37912 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755805AbaE1W3w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 May 2014 18:29:52 -0400
Message-ID: <5386635D.2070708@suse.de>
Date: Thu, 29 May 2014 00:29:49 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>, Karel Zak <kzak@redhat.com>,
        Paul Mackerras <paulus@au1.ibm.com>, util-linux@vger.kernel.org,
        Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>,
        Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <20140522090824.GC4430@osiris> <537DC3A1.6000401@suse.de> <201405282354.22353.sweet_f_a@gmx.de>
In-Reply-To: <201405282354.22353.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 28.05.14 23:54, Ruediger Meier wrote:
> Thank you all for your comments!
>
> Patch set updated here:
> https://github.com/karelzak/util-linux/pull/87
>
>
> On Thursday 22 May 2014, Alexander Graf wrote:
>>>>>> +	if (path_exist("/proc/iSeries")) {
>>>>>> +		desc->hyper = HYPER_OS400;
>>>>>> +		desc->virtype = VIRT_FULL;
>>>>> ... shouldn't this be VIRT_PARA? Somebody who knows this may correct this.
>> iSeries is PV, yes. Among others it's also dead :). But I'll let Ben
>> comment.
> We set VIRT_PARA now for iSeries and (real) pSeries.
>   
>>>>>> +	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
>>>>>> +		FILE *fd;
>>>>>> +		desc->hyper = HYPER_PHYP;
>>>>>> +		desc->virtype = VIRT_FULL;
>>>>> Maybe more obvious here for pSeries where p seems to stand for para
>>>>> http://www.ibm.com/developerworks/aix/library/au-syspvirtualization/index.html?S_TACT=105AGX99&S_CMP=CP
>> This is slightly more complicated. The ibm,partition-name device tree
>> property is defined in sPAPR which is a specification that both pHyp and
>> QEMU implement. Right now QEMU does not expose the ibm,partition-name
>> property, but there's no reason it will stay that way.
>>
>> There are a few ways we could try to distinguish QEMU's implementation
>> of the pSeries machine and pHyp's implementation of it.
>>
>>     /proc/device-tree/hmc-managed?
>>
>> I don't think QEMU will ever implement this property, but at least my
>> pHyp reference VM does. If it's there we can use it as a definite marker
>> that we are in fact running on pHyp.
>>
>>     /proc/device-tree/chosen/qemu,graphic-width
> OK, we do it like this for now
>    if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")
>        && path_exist(_PATH_PROC_DEVICETREE "/hmc-managed?")
>        && !path_exist(_PATH_PROC_DEVICETREE "/chosen/qemu,graphic-width")) {
>    desc->hyper = HYPER_PHYP;
>    desc->virtype = VIRT_PARA;
>    ....
>
> Haven't yet done something about the "pSeries on QEMU/KVM" detection
> according to the comments below. Could be that our existing KVM detection
> would catch it already.

I very much doubt it would, but if you give me a quick pointer I could 
verify.

I'll comment on more things inline on the github request.


Alex

