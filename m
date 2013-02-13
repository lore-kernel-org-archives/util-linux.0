Return-Path: util-linux-owner@vger.kernel.org
Received: from [65.55.111.101] ([65.55.111.101]:50448 "EHLO
	blu0-omc2-s26.blu0.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S934139Ab3BMQfh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 11:35:37 -0500
Message-ID: <BLU0-SMTP28536229842C754116023F5D5080@phx.gbl>
Date: Thu, 14 Feb 2013 02:35:10 +1000
From: Luis Aranguren <pizzaman@hotmail.com>
MIME-Version: 1.0
To: kerolasa@iki.fi
CC: util-linux@vger.kernel.org
Subject: Re: Hypervisor & Virtualization lscpu test fail
References: <BLU0-SMTP36414270EB979DF67318E53D50B0@phx.gbl> <CAG27Bk2XQxWUFZPuQP8JWJaJ5OuCrxspk==9saGO-Xv6yk=7Sg@mail.gmail.com> <BLU0-SMTP144C815AE93C94E539C372CD50A0@phx.gbl> <CAG27Bk0ddxfVP98dxWiS+XjoGcM2gv1O78L3wBcVXDKNjMjMQg@mail.gmail.com>
In-Reply-To: <CAG27Bk0ddxfVP98dxWiS+XjoGcM2gv1O78L3wBcVXDKNjMjMQg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2/12/2013 8:56 AM, Sami Kerola wrote:
>  
> -	if (desc->hypervisor)
> +	if (desc->hypervisor && mod->system == SYSTEM_LIVE)
>  		print_s(_("Hypervisor:"), desc->hypervisor);
> -	if (desc->hyper) {
> +	if (desc->hyper && mod->system == SYSTEM_LIVE) {
>

Thanks for the fix. After applying it I got these results:

        lscpu:                                ... 
                : ppc64-POWER7                ... OK 
                : s390-kvm                    ... FAILED
(lscpu/lscpu-s390-kvm) 
                : s390-lpar                   ... FAILED
(lscpu/lscpu-s390-lpar) 
                : s390-zvm                    ... FAILED
(lscpu/lscpu-s390-zvm) 
                : x86_64-64cpu                ... OK 
                : x86_64-dell_e4310           ... OK 
           ... FAILED (3 from 6 sub-tests) 

---
/var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/util-linux-2.22.2/tests/expected/lscpu/lscpu-s390-kvm   
2012-10-15 10:09:42.000000000 +0000
+++
/var/tmp/paludis/build/sys-apps-util-linux-2.22.2/work/C/64/tests/output/lscpu/lscpu-s390-kvm   
2013-02-13 15:37:56.000000000 +0000
@@ -7,9 +7,6 @@
 Book(s):               3
 Vendor ID:             IBM/S390
 BogoMIPS:              14367.00
-Hypervisor:            KVM/Linux
-Hypervisor vendor:     KVM
-Virtualization type:   full
 Dispatching mode:      horizontal
 

Same for the other two s390's. Hope this helps.
Thanks!
