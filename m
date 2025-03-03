Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CFD1F0E2F
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994799; cv=none; b=qVSIPiD/CkkagpmOadtd1YpwGkKO0wGoh3HyS9Nkse3cPtZpaMHXFKE+msS4g7CNRdFLBx36qNmb59zf9yR5h70NCHyD1KMceH6iDcr/38wQeWLm/STMfXeMaBgT1ibXW9qfq3gFEVSu4pnUHtxldzOfd3F/pC7RBR8kouO75Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994799; c=relaxed/simple;
	bh=p96Sr7PZt+p39aKW+9B7OtYUcukLrAWik3CdFwV/6/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5FlyTN0MiIzEe40BNFdlii7lpcn5q0j3eW1EvnlDaB3otKrw3o2TPW1WR21GbOXCQcUoP7/iLWLVmN/X8SeWzKoClr93VxWy8CfsH01LoqMEkzX3YJ/4IWN6G8FkuC8XPCIkzmJkoiiJp7EAeos6iGrLm5oOCtsj+HZ94oAaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cRF+Fd5F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cRF+Fd5F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22339936bbfso60204295ad.1
        for <util-linux@vger.kernel.org>; Mon, 03 Mar 2025 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740994796; x=1741599596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hhSGpR7MRvt2BzEjF+DBLHzQE5J3wR0fFFyjhgpfcE=;
        b=cRF+Fd5F8JGT7PddKDBBoy66RaS6Lr8yOCf4pMYynTrQG8dPzsKLOz4mRfEweL9RWe
         9Hwjrg+qHndeIumURww9Cs0C4lBToUTUnJ7RsxPSGZtPYeZr1UC0IgjeRNBKIt1jj3s0
         EKZuf/hf0+sFo0StrzqHhM398ncTNcQTQBWSB2rcMBsGyEPUZU6ghSsvX79OPN0Bjupp
         m5XjIiAR2dWlAma7Q7gwDSN2a9L6KvjkMI13wcM8hMVBy/U3dBEXKYibrsIw0r2Yo+3f
         F9qPCxp8BpGXsKlzPApP3gEXymwMQBjI/Vj1GRnsToVZEJ364g0G9K8MwO/s18922EI9
         7UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994797; x=1741599597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hhSGpR7MRvt2BzEjF+DBLHzQE5J3wR0fFFyjhgpfcE=;
        b=cZvWwN9LQeuwfOIUo3/dg4qauo1NQVUyh4ED9cfa/PDgILCZUW0zJ7+RGDbeEXDzhr
         1fxHNPcJ8eAqJARVLYiqvd3PIv2sU3l6SxIjAxumsiuPEcBtpQppXW+Ow2Pi3xEZPz//
         Oh+k6+n2ar51A+Pos2p/tmmPRXpgr6R2ZFmng2vLL5/aKOYCWlzz/sSekKGE7kvQgQNA
         +bjvxzRkJQp7VwAzEDUdrxGytOJhnkMmmqjAvV5delsEG6N/+w8oNgj0O4Zc7LPzQmiO
         AzVH7OXacb9xu+450pJiyTO3NBM7lKTYbaNrRK/+cRXFGW6y/BZlt7gPNqo1+pveZDmC
         94cQ==
X-Gm-Message-State: AOJu0YyZ5afx8T5rg+oV5bq6+RDqQjXdCYEBTZLuaDRS5tYzACPyU/HN
	/84J8ybLp3BRs3urk4X+Zjq/+3J26f8kdLLoskFUuIEpZknRbUZ8gIkVo1XDXH8=
X-Gm-Gg: ASbGnctlzRDJd9lFY+pr0uRNk8m0zIV1P83tCDz6h9a3ugHVr0qvWgjwRH5UvkacHvJ
	GGVKdt1LD8BQMs63+EXCuzqYpjvBcQI2lwa96iAPZK3HjqGZLpve0iF5hwd26i8CRj++XRX+J9t
	fmSV4gAxShpzElDI/gLNTQH9Bftv6yc7joY8U+JnFPTDUfNJ6SUouPklVaqws3wjuBoQM61elG2
	WF8/xKKVlssc51OLa7GOKWd6maxm0JgzrSr8NsEr3OUqdfWXXpPrHhGUGqoD/wqGR216V2fPIrw
	/1ocUe60mVinUJfE1XW9xSVRG35N+cZ/p3A5s8YnpgT+1NecsbA=
X-Google-Smtp-Source: AGHT+IHbSSAUhe73PZYPD5AdpXhPVJOBtrwQvqgLHuTUR9PavTq9FgYM1j6fqtdJRFEzbqMu5/EY1g==
X-Received: by 2002:a17:902:d4cb:b0:21f:b6f:3f34 with SMTP id d9443c01a7336-22368f9d88fmr178819765ad.15.1740994796577;
        Mon, 03 Mar 2025 01:39:56 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a64bsm8699060b3a.11.2025.03.03.01.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:39:56 -0800 (PST)
Message-ID: <db814aa0-e91b-4a37-81fb-4c849c4a6c0d@bytedance.com>
Date: Mon, 3 Mar 2025 17:39:52 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] irqtop: add max iteration support
To: Joe Jin <joe.jin@oracle.com>, Karel Zak <kzak@redhat.com>,
 Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <20250228161334.82987-3-joe.jin@oracle.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250228161334.82987-3-joe.jin@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/1/25 00:13, Joe Jin wrote:
> Add support for setting the number of iterations. This is useful in
> non-interactive mode.
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
> Cc: Sami Kerola <kerolasa@iki.fi>
> Cc: Karel Zak <kzak@redhat.com>
> ---
>   bash-completion/irqtop  |  5 +++++
>   sys-utils/irqtop.1.adoc |  3 +++
>   sys-utils/irqtop.c      | 19 +++++++++++++++++--
>   3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
> index 215281ee8..d18ef99bb 100644
> --- a/bash-completion/irqtop
> +++ b/bash-completion/irqtop
> @@ -22,6 +22,10 @@ _irqtop_module()
>   			COMPREPLY=( $(compgen -W "secs" -- $cur) )
>   			return 0
>   			;;
> +		'-n'|'--iter')
> +			COMPREPLY=( $(compgen -W "the max iterations" -- $cur) )
> +			return 0
> +			;;
>   		'-s'|'--sort')
>   			COMPREPLY=( $(compgen -W "irq total delta name" -- $cur) )
>   			return 0
> @@ -47,6 +51,7 @@ _irqtop_module()
>   		--cpu-stat
>   		--cpu-list
>   		--delay
> +		--iter
>   		--sort
>   		--output
>   		--softirq
> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
> index e81f4fbb6..75930f5cf 100644
> --- a/sys-utils/irqtop.1.adoc
> +++ b/sys-utils/irqtop.1.adoc
> @@ -37,6 +37,9 @@ Specify cpus in list format to show.
>   *-d*, *--delay* _seconds_::
>   Update interrupt output every _seconds_ intervals.
>   
> +*-n*, *--iter* _number_::
> +Specifies the maximum iterations before quitting.
> +
>   *-s*, *--sort* _column_::
>   Specify sort criteria by column name. See *--help* output to get column names. The sort criteria may be changes in interactive mode.
>   
> diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
> index 81a137be0..17c7d72cb 100644
> --- a/sys-utils/irqtop.c
> +++ b/sys-utils/irqtop.c
> @@ -83,6 +83,7 @@ struct irqtop_ctl {
>   	cpu_set_t *cpuset;
>   
>   	enum irqtop_cpustat_mode cpustat_mode;
> +	int64_t	iter;
>   	bool	batch;
>   	bool	request_exit,
>   		softirq;
> @@ -190,6 +191,12 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>   	if (ctl->prev_stat)
>   		free_irqstat(ctl->prev_stat);
>   	ctl->prev_stat = stat;
> +
> +	if (ctl->iter > 0) {
> +		ctl->iter--;
> +		if (ctl->iter == 0)
> +			ctl->request_exit = 1;
> +	}
>   	return 0;
>   }

If ctl->iter is initialized as int64_max, then we have codes like:

if (--ctl->iter == 0) {
     ctl->request_exit = 1;
}

>   
> @@ -295,6 +302,7 @@ static void __attribute__((__noreturn__)) usage(void)
>   	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>   	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>   	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
> +	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
>   	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>   	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
>   	fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
> @@ -327,6 +335,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   		{"cpu-stat", required_argument, NULL, 'c'},
>   		{"cpu-list", required_argument, NULL, 'C'},
>   		{"delay", required_argument, NULL, 'd'},
> +		{"iter", required_argument, NULL, 'n'},
>   		{"sort", required_argument, NULL, 's'},
>   		{"output", required_argument, NULL, 'o'},
>   		{"softirq", no_argument, NULL, 'S'},
> @@ -337,7 +346,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   	};
>   	int o;
>   
> -	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
> +	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
>   		switch (o) {
>   		case 'b':
>   			ctl->batch = 1;
> @@ -377,6 +386,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   				ctl->timer.it_value = ctl->timer.it_interval;
>   			}
>   			break;
> +		case 'n':
> +			ctl->iter = str2num_or_err(optarg, 10,
> +					_("failed to parse iter argument"),
> +					0, INT_MAX);
> +			break;
>   		case 's':
>   			set_sort_func_by_name(out, optarg);
>   			break;
> @@ -423,7 +437,8 @@ int main(int argc, char **argv)
>   	};
>   	struct irqtop_ctl ctl = {
>   		.timer.it_interval = {3, 0},
> -		.timer.it_value = {3, 0}
> +		.timer.it_value = {3, 0},
> +		.iter = -1
>   	};
>   
>   	setlocale(LC_ALL, "");

