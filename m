Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbdFMKY1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 06:24:27 -0400
Date: Tue, 13 Jun 2017 12:24:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: util-linux@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Graf <agraf@suse.de>, sbrabec@suse.com
Subject: Re: [PATCH] lscpu: dmi: return HYPER_NONE when detection fails
Message-ID: <20170613102418.l6uhgpmqabacih3g@ws.net.home>
References: <20170612153228.2766-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170612153228.2766-1-msuchanek@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 12, 2017 at 05:32:28PM +0200, Michal Suchanek wrote:
> There is weird mix of logic in lscpu-dmi.c which sometimes returns 0 and
> sometimes -1 on error. Since most checks are if (rc) goto done; this
> bails out early on error skipping some detection methods. Further, in
> lscpu.c all following detections are guarder by if(hyper) so returnning
> -1 causes all following methods to be skipped. The hyper value is used
> as array index so -1 is out of bounds.

Yes, that's bug.

> Some users observe that they are running under hypervisor and this is
> not detected so it is probably good idea to just try everything.
> 
> On the other hand, on some versions of Linux on arm64 reading /dev/mem
> causes kernel oops killing lscpu. If it is desirable for lscpu to work
> on these broken kernels an additional ifdef is required.

We read /sys if possible, and it should be good enough for the current
arm64 kernel (I guess).

> @@ -200,7 +200,7 @@ static int hypervisor_decode_sysfw(void)
>  	struct stat st;
>  
>  	if (stat(sys_fw_dmi_tables, &st))
> -		return -1;
> +		return HYPER_NONE;
>  
>  	return hypervisor_from_dmi_table(0, st.st_size, st.st_size / 4,
>  					 sys_fw_dmi_tables);

Not applied.

I don't think this is correct. We need to differentiate between

 1/ DMI not in /sys   (rc == -1)
 2/ DMI available, but nothing detected (rc == HYPER_NONE)

For the 1/ we need to try /dev/mem.

I did some changes to the code to make it more robust. Now
read_hypervisor_dmi() does not return -1 at all.

Please, test it. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
