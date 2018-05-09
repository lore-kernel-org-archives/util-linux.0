Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:46491 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965260AbeEIQQF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 May 2018 12:16:05 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 87BFFAD11
        for <util-linux@vger.kernel.org>; Wed,  9 May 2018 16:16:04 +0000 (UTC)
Date: Wed, 9 May 2018 18:16:04 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Stanislav Brabec <sbrabec@suse.cz>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Avoid use of the old CPU macros
In-Reply-To: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
Message-ID: <alpine.LSU.2.21.1805091812050.12477@wotan.suse.de>
References: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

On Wed, 9 May 2018, Stanislav Brabec wrote:

> diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
> index 12e52d887..f32b7a6fc 100644
> --- a/sys-utils/chcpu.c
> +++ b/sys-utils/chcpu.c
> @@ -81,7 +81,7 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
>  	size_t fails = 0;
>  
>  	for (cpu = 0; cpu < setsize; cpu++) {
> -		if (!CPU_ISSET(cpu, cpu_set))
> +		if (!CPU_ISSET_S(cpu, setsize, cpu_set))

Careful, the _S macros count the size in _bytes_, the above loop iterates 
in nr-of-cpus (i.e. bits), or alternatively if the caller really gives a 
byte size then the loop iterations don't catch all CPUs.  More instances 
follow.

> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index 2132511a5..fd6d63bbf 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -478,7 +478,7 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
>  		desc->idx2cpunum = xcalloc(desc->ncpuspos, sizeof(int));
>  
>  		for (num = 0, idx = 0; num < maxcpus; num++) {
> -			if (CPU_ISSET(num, tmp))
> +			if (CPU_ISSET_S(num, setsize, tmp))
>  				desc->idx2cpunum[idx++] = num;
>  		}
>  		cpuset_free(tmp);
> @@ -1109,10 +1109,11 @@ cpu_max_mhz(struct lscpu_desc *desc, char *buf, size_t bufsz)
>  {
>  	int i;
>  	float cpu_freq = 0.0;
> +	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
>  
>  	if (desc->present) {
>  		for (i = 0; i < desc->ncpuspos; i++) {
> -			if (CPU_ISSET(real_cpu_num(desc, i), desc->present)
> +			if (CPU_ISSET_S(real_cpu_num(desc, i), setsize, desc->present)

This here is okay, though, CPU_ALLOC_SIZE also counts in bytes.


Ciao,
Michael.
