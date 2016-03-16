Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52500 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933203AbcCPH5f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 03:57:35 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] lscpu: use cpu and revision tag if available
Date: Wed, 16 Mar 2016 08:57:26 +0100
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
References: <1458055880-18766-1-git-send-email-sweet_f_a@gmx.de> <1458055880-18766-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458055880-18766-2-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603160857.27047.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 15 March 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Avoid ifdef which does not work with --sysroot. Our existing test
> dumps produce even better output now for ppc and sparc.
>
> CC: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  sys-utils/lscpu.c                             | 18
> +++++++++++++----- tests/expected/lscpu/lscpu-ppc-qemu           |  3
> ++-
>  tests/expected/lscpu/lscpu-ppc64-POWER7       |  3 ++-
>  tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu |  3 ++-
>  tests/expected/lscpu/lscpu-sparc64            |  1 +
>  5 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index 423bc56..498234f 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -453,6 +453,8 @@ read_basicinfo(struct lscpu_desc *desc, struct
> lscpu_modifier *mod) char buf[BUFSIZ];
>  	struct utsname utsbuf;
>  	size_t setsize;
> +	char *cpu = 0;
> +	char *revision = 0;
>
>  	/* architecture */
>  	if (uname(&utsbuf) == -1)
> @@ -465,13 +467,8 @@ read_basicinfo(struct lscpu_desc *desc, struct
> lscpu_modifier *mod) else if (lookup(buf, "vendor_id",
> &desc->vendor)) ;
>  		else if (lookup(buf, "family", &desc->family)) ;
>  		else if (lookup(buf, "cpu family", &desc->family)) ;
> -#if defined(__powerpc__) || defined(__powerpc64__)
> -		else if (lookup(buf, "revision", &desc->model)) ;
> -		else if (lookup(buf, "cpu", &desc->modelname)) ;
> -#else
>  		else if (lookup(buf, "model", &desc->model)) ;
>  		else if (lookup(buf, "model name", &desc->modelname)) ;
> -#endif
>  		else if (lookup(buf, "stepping", &desc->stepping)) ;
>  		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
>  		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
> @@ -479,10 +476,21 @@ read_basicinfo(struct lscpu_desc *desc, struct
> lscpu_modifier *mod) else if (lookup(buf, "type", &desc->flags))
> ;		/* sparc64 */ else if (lookup(buf, "bogomips", &desc->bogomips)) ;
>  		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ; /*
> s390 */ +		else if (lookup(buf, "cpu", &cpu)) ;          /*
> modelname, ppc, sparc*/ +		else if (lookup(buf, "revision",
> &revision)) ;/* model, ppc */ else
>  			continue;
>  	}
>
> +	if (cpu) {
> +		free(desc->modelname);
> +		desc->modelname = cpu;
> +	}
> +	if (revision) {
> +		free(desc->model);
> +		desc->model = revision;
> +	}
> +

Watching this again today I think it could be even better to add cpu and 
revision members to the struct and move both if conditions to the 
printing code section.

It would avoid the small risk to break other logic like this one:
  if (desc->modelname && strstr(desc->modelname, "UML")) { ...

>  	desc->mode = init_mode(mod);
>
>  	if (desc->flags) {
> diff --git a/tests/expected/lscpu/lscpu-ppc-qemu
> b/tests/expected/lscpu/lscpu-ppc-qemu index b3ea4a7..78b0b29 100644
> --- a/tests/expected/lscpu/lscpu-ppc-qemu
> +++ b/tests/expected/lscpu/lscpu-ppc-qemu
> @@ -3,7 +3,8 @@ On-line CPU(s) list:   0
>  Thread(s) per core:    1
>  Core(s) per socket:    1
>  Socket(s):             1
> -Model:                 Power Macintosh
> +Model:                 3.1 (pvr 0008 0301)
> +Model name:            740/750
>  BogoMIPS:              33.25
>  L1d cache:             unknown size
>  L1i cache:             unknown size
> diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7
> b/tests/expected/lscpu/lscpu-ppc64-POWER7 index 0d6c5ba..9a3c0c9
> 100644
> --- a/tests/expected/lscpu/lscpu-ppc64-POWER7
> +++ b/tests/expected/lscpu/lscpu-ppc64-POWER7
> @@ -4,7 +4,8 @@ Thread(s) per core:    4
>  Core(s) per socket:    1
>  Socket(s):             4
>  NUMA node(s):          1
> -Model:                 IBM,8233-E8B
> +Model:                 2.1 (pvr 003f 0201)
> +Model name:            POWER7 (architected), altivec supported
>  L1d cache:             32K
>  L1i cache:             32K
>  NUMA node0 CPU(s):     0-15
> diff --git a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
> b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu index
> e48735e..0aed12a 100644
> --- a/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
> +++ b/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu
> @@ -4,7 +4,8 @@ Thread(s) per core:    4
>  Core(s) per socket:    1
>  Socket(s):             16
>  NUMA node(s):          2
> -Model:                 IBM,8231-E2B
> +Model:                 2.1 (pvr 003f 0201)
> +Model name:            POWER7 (architected), altivec supported
>  Hypervisor vendor:     pHyp
>  Virtualization type:   para
>  L1d cache:             32K
> diff --git a/tests/expected/lscpu/lscpu-sparc64
> b/tests/expected/lscpu/lscpu-sparc64 index 629b399..aacaf11 100644
> --- a/tests/expected/lscpu/lscpu-sparc64
> +++ b/tests/expected/lscpu/lscpu-sparc64
> @@ -4,6 +4,7 @@ On-line CPU(s) list:   6,7,10,11,14,15
>  Thread(s) per core:    1
>  Core(s) per socket:    1
>  Socket(s):             6
> +Model name:            TI UltraSparc II  (BlackBird)
>  Flags:                 sun4u
>
>  # The following is the parsable format, which can be fed to other


