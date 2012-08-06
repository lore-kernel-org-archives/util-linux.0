Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:44391 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab2HFFJd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 01:09:33 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <faizanh@linux.vnet.ibm.com>;
	Mon, 6 Aug 2012 10:39:28 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7658r8T28049634
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 10:38:53 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7658r7L015571
	for <util-linux@vger.kernel.org>; Mon, 6 Aug 2012 15:08:53 +1000
Message-ID: <501F5165.6080007@linux.vnet.ibm.com>
Date: Mon, 06 Aug 2012 10:38:53 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Faizan husain <faizanh@linux.vnet.ibm.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu : -b and -c option does not give expected output.
References: <1344163028-30238-1-git-send-email-faizanh@linux.vnet.ibm.com>
In-Reply-To: <1344163028-30238-1-git-send-email-faizanh@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 05 August 2012 04:07 PM, Faizan husain wrote:
> From: faizan husain <faizanh@linux.vnet.ibm.com>
>
> Options for lscpu command are giving incorrect output.
> As per the man page or help, '-b' option should limit the output to online CPUs
> and '-c' option should limit the output to offline CPUs.
> But we could see the output is same for '-a','-b' and '-c' options.
>
> Signed-off-by: faizan husain <faizanh@linux.vnet.ibm.com>
> ---
>   sys-utils/lscpu.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index b93998a..648f51e 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -1101,12 +1101,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
>   #endif
>   	print_n(_("CPU(s):"), desc->ncpus);
>
> -	if (desc->online)
> +	if (desc->online && mod->online)
>   		print_cpuset(mod->hex ? _("On-line CPU(s) mask:") :
>   					_("On-line CPU(s) list:"),
>   				desc->online, mod->hex);
>
> -	if (desc->online && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
> +	if (desc->online && mod->online && CPU_COUNT_S(setsize, desc->online) != desc->ncpus) {
>   		cpu_set_t *set;
>
>   		/* Linux kernel provides cpuset of off-line CPUs that contains

please discard this patch as wrong patch has been sent, I will resend the patch again..

Thanks

Faizan

