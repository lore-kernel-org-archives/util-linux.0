Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:34005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753285AbdDLJO5 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
        Wed, 12 Apr 2017 05:14:57 -0400
Subject: Re: [PATCH] lspcu: use sysfs for table access if available
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        util-linux-ng@vger.kernel.org
References: <20170412091129.27283-1-ard.biesheuvel@linaro.org>
Cc: leif.lindholm@linaro.org, kzak@redhat.com
From: Alexander Graf <agraf@suse.de>
Message-ID: <ca8730a8-c200-3f93-4997-ae20322265c8@suse.de>
Date: Wed, 12 Apr 2017 11:14:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170412091129.27283-1-ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 12.04.17 11:11, Ard Biesheuvel wrote:
> On ARM systems, accessing SMBIOS tables via /dev/mem using read()
> calls is not supported. The reason is that such tables are usually
> located in EFI_RUNTIME_SERVICE_DATA memory, which is not covered
> by the linear mapping on those systems, and so read() calls will
> fail.
>
> So instead, use the /sys/firmware/dmi/tables/DMI sysfs file, which
> contains the entire structure table array, and will be available
> on any recent Linux system, even on ones that only export the rev3
> SMBIOS entry point, which is currently ignored by lscpu.
>
> Note that the max 'num' value is inferred from the size. This is not
> a limitation of the sysfs interface, but a limitation of the rev3
> entry point, which no longer carries a number of array elements.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Alexander Graf <agraf@suse.de>

Thanks :)


Alex
