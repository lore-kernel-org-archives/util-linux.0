Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A7276D11
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706897; cv=none; b=UGgvUSDHY1+TIRSK2JuCUdAw0zm+2CWgPdItAsN6snIcUGIEBNDvcPRSlIInxLEVo1pQcnAL0w8w3FnBH+HVcP+Agz44yrU7izwvWpQfctfOmPWUQ+Kr2AiatyiURUXoxgXtfeBvWvZCzjn8kc7ivVWyWQXnsWTeJvkPQG3Ic2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706897; c=relaxed/simple;
	bh=woPad1lv8sJRQHcoeXHWy77vozY6JBdw3L9fID9lP3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rhjd28ItmJVW2r4kZdFcs4Wmmv3jz34F9qPvRV+mNiIFwDFJjlKHfSDD+KqhgDgK7jUf+OmbZJF17UAYjnBfTRibXN4S6JVAIhRmW73capDrb/3mhILr/dlqyuticTtXpTIZi3kBHGbBSi+2G6HrmV8j3ctxpXCb4ABSkF4rgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H3GA5ibI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H3GA5ibI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso2920846a91.1
        for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 17:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740706894; x=1741311694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BA3nAKjWGFDKtm47ShrJ0Yfv50ykuwfeTjLmliGI7h8=;
        b=H3GA5ibI8h6L56cT50e/rcVa/d4Dxjz4SMcmmMs5FjRbBFd/7IyNivjwdxvrsusAQ2
         vQBA1wc3wT2GJRQJ5+ysXMiFoxsBiJmytSTzB2jYtFm/w9HuM9i+mES/T9szqao4kPgO
         PvIk3SF5Spr2b2cf7Ig2rQuHtMEVlXNhElDGcQv413r4curBFQRCzzNJchmA59Ry8Kal
         tvzq8PvU8kEwk7E4O29dKaSK2b42/ozga8ZUndQ+Ha2hLligL84NPIweh8mQ6IFjgOjJ
         9M3rP/jSZeGqXZUdt2PJ0h+8pmT+IS6Txt1m4bJ7UkaKcaf/nIxS9YsI2NqMO1OlPCp4
         n34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740706894; x=1741311694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BA3nAKjWGFDKtm47ShrJ0Yfv50ykuwfeTjLmliGI7h8=;
        b=Dlswzh/H6nbzi6VD9NUhct04+ZsOYuoqqDwKVBeeP8ygOwwNmHCe2cvO+vjGfeVXqO
         Kg784ESMPS37Obg+aQBvqj45V4ntlob8yudnodVDjt81H2t7HzlXLq3rpEh4m+mDFfZO
         l4JaLJ2heF1GzzLklwrgfTIYQrS+Oajx9mbTfGHpVngbD2QbFRcYvktt18r1hY/wfhXK
         belTOruOpvt25Nl7U6DblXLN4UbQduoW1dDv4y7WWJ8UFotCKZd1i2Ee9dVclZHwaUHD
         F55VaScpp0nHLfa1LSJLPf47hjZnb7Ro8TaYPnxAM3jDIpf6y/Vm8zNU5mCpkrzwb/8+
         7VaA==
X-Gm-Message-State: AOJu0YyUgSWtqw3wFX5e9SS1jMevcVJXJZl680zYaRCJMvNGyaSz8ahU
	RLBXQEFf2oYjtQKMjNr7alCWu2sclDhhkuPXBvCxIT7gWeejFmllE+y8IMFqGy7UkGMZU7omaMQ
	Q
X-Gm-Gg: ASbGnctecjdyY9xZPcxdAY4OeYXtBzx/KgOmCujaP7nQd/kr1wqNEsCmHTYtS01JQHI
	QFOmW4pkWta/wpJEFKEYt/D0KKKXRLT833EBhn06ocQ9+Cv0Zwg1eZ0WhnZd/EBgJ1tyAQbYRDv
	3s4fLfymBx79dVNQEaYp4S+2/CTUzOjJgclz6ix3e67K4SCdPeOftmA84mvTFgrQ0tqURrdYQMi
	Qw359Zf/YZuVoOR1WxuFFjyZcFZnwjn+G7QZ4t4LfuwfJDZvItU9geKSYCQ0yrxi5NyGz4le954
	Yw/MU0cLq4h3GOh5pv5A2gUXTik1sF0=
X-Google-Smtp-Source: AGHT+IFMPyehex94CJ8SgNB8Q4nzULMJW2EUlCNH/D5E3o4pxAkIRunv/ZuOrUzoZPoBuBJ+uUWvWA==
X-Received: by 2002:a17:90b:380e:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-2feba5ce632mr2837341a91.2.1740706894209;
        Thu, 27 Feb 2025 17:41:34 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de37f6asm2199463a12.36.2025.02.27.17.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 17:41:33 -0800 (PST)
Message-ID: <da045963-e7d3-4edf-b3b9-783483a8920d@bytedance.com>
Date: Fri, 28 Feb 2025 09:41:30 +0800
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] lsirq,irqtop: add support for reading data from given
 file
To: Joe Jin <joe.jin@oracle.com>, Karel Zak <kzak@redhat.com>,
 Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-4-joe.jin@oracle.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20250227044916.89925-4-joe.jin@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Does the '--input IRQFILE' change?

irqtop reads 'IRQFILE' and uses the current one to calculate the 
increment from the previous one, I'm curious about this case ...

But I guess lsirq would work fine.

On 2/27/25 12:49, Joe Jin wrote:
> This is helpful for analyzng data saved from other system.
> 
> Signed-off-by: Joe Jin <joe.jin@oracle.com>
> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
> Cc: Sami Kerola <kerolasa@iki.fi>
> ---
>   bash-completion/irqtop  |  4 ++++
>   bash-completion/lsirq   |  4 ++++
>   sys-utils/irq-common.c  | 19 +++++++++----------
>   sys-utils/irq-common.h  |  3 ++-
>   sys-utils/irqtop.1.adoc |  3 +++
>   sys-utils/irqtop.c      | 28 +++++++++++++++++++++++++---
>   sys-utils/lsirq.1.adoc  |  3 +++
>   sys-utils/lsirq.c       | 28 ++++++++++++++++++++++++----
>   8 files changed, 74 insertions(+), 18 deletions(-)
> 
> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
> index 47b7b0af6..3bea5fc0e 100644
> --- a/bash-completion/irqtop
> +++ b/bash-completion/irqtop
> @@ -15,6 +15,9 @@ _irqtop_module()
>   		'-C'|'--cpu-list')
>   			return 0
>   			;;
> +		'-i'|'--input')
> +			COMPREPLY=( $(compgen -W "input file" -- $cur) )
> +			;;
>   		'-t'|'--threshold')
>   			return 0
>   			;;
> @@ -51,6 +54,7 @@ _irqtop_module()
>   		--cpu-stat
>   		--cpu-list
>   		--delay
> +		--input
>   		--number
>   		--sort
>   		--output
> diff --git a/bash-completion/lsirq b/bash-completion/lsirq
> index 4c3c9f04f..b913eecd0 100644
> --- a/bash-completion/lsirq
> +++ b/bash-completion/lsirq
> @@ -5,6 +5,9 @@ _lsirq_module()
>   	cur="${COMP_WORDS[COMP_CWORD]}"
>   	prev="${COMP_WORDS[COMP_CWORD-1]}"
>   	case $prev in
> +		'-i'|'--input')
> +			COMPREPLY=( $(compgen -W "input file" -- $cur) )
> +			;;
>   		'-o'|'--output')
>   			local prefix realcur OUTPUT
>   			realcur="${cur##*,}"
> @@ -35,6 +38,7 @@ _lsirq_module()
>   	OPTS="	--json
>   		--pairs
>   		--noheadings
> +		--input
>   		--output
>   		--softirq
>   		--sort
> diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
> index f069d8a63..560dd4b82 100644
> --- a/sys-utils/irq-common.c
> +++ b/sys-utils/irq-common.c
> @@ -233,7 +233,8 @@ static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
>   /*
>    * irqinfo - parse the system's interrupts
>    */
> -static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpuset)
> +static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
> +				    size_t setsize, cpu_set_t *cpuset)
>   {
>   	FILE *irqfile;
>   	char *line = NULL, *tmp;
> @@ -247,18 +248,15 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
>   	stat->irq_info = xmalloc(sizeof(*stat->irq_info) * IRQ_INFO_LEN);
>   	stat->nr_irq_info = IRQ_INFO_LEN;
>   
> -	if (softirq)
> -		irqfile = fopen(_PATH_PROC_SOFTIRQS, "r");
> -	else
> -		irqfile = fopen(_PATH_PROC_INTERRUPTS, "r");
> +	irqfile = fopen(input_file, "r");
>   	if (!irqfile) {
> -		warn(_("cannot open %s"), _PATH_PROC_INTERRUPTS);
> +		warn(_("cannot open %s"), input_file);
>   		goto free_stat;
>   	}
>   
>   	/* read header firstly */
>   	if (getline(&line, &len, irqfile) < 0) {
> -		warn(_("cannot read %s"), _PATH_PROC_INTERRUPTS);
> +		warn(_("cannot read %s"), input_file);
>   		goto close_file;
>   	}
>   
> @@ -270,7 +268,7 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
>   
>   	stat->cpus =  xcalloc(stat->nr_active_cpu, sizeof(struct irq_cpu));
>   
> -	/* parse each line of _PATH_PROC_INTERRUPTS */
> +	/* parse each line of input file */
>   	while (getline(&line, &len, irqfile) >= 0) {
>   		unsigned long count;
>   		size_t index;
> @@ -527,7 +525,8 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
>   	return NULL;
>   }
>   
> -struct libscols_table *get_scols_table(struct irq_output *out,
> +struct libscols_table *get_scols_table(const char *input_file,
> +					      struct irq_output *out,
>   					      struct irq_stat *prev,
>   					      struct irq_stat **xstat,
>   					      int softirq,
> @@ -542,7 +541,7 @@ struct libscols_table *get_scols_table(struct irq_output *out,
>   	size_t i;
>   
>   	/* the stats */
> -	stat = get_irqinfo(softirq, setsize, cpuset);
> +	stat = get_irqinfo(input_file, softirq, setsize, cpuset);
>   	if (!stat)
>   		return NULL;
>   
> diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
> index 02b72d752..b9cf72d2a 100644
> --- a/sys-utils/irq-common.h
> +++ b/sys-utils/irq-common.h
> @@ -73,7 +73,8 @@ void irq_print_columns(FILE *f, int nodelta);
>   void set_sort_func_by_name(struct irq_output *out, const char *name);
>   void set_sort_func_by_key(struct irq_output *out, const char c);
>   
> -struct libscols_table *get_scols_table(struct irq_output *out,
> +struct libscols_table *get_scols_table(const char *input_file,
> +                                              struct irq_output *out,
>                                                 struct irq_stat *prev,
>                                                 struct irq_stat **xstat,
>                                                 int softirq,
> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
> index 75cfe2e41..715008d07 100644
> --- a/sys-utils/irqtop.1.adoc
> +++ b/sys-utils/irqtop.1.adoc
> @@ -37,6 +37,9 @@ Specify cpus in list format to show.
>   *-d*, *--delay* _seconds_::
>   Update interrupt output every _seconds_ intervals.
>   
> +*-i*, *--input* _file_::
> +Read data from _file_ (Which was created by other tools, e.g. sosreport).
> +
>   *-n*, *--number* _number_::
>   Specifies the maximum _number_ of iterations before quitting.
>   
> diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
> index ba5680671..4cf1dc79a 100644
> --- a/sys-utils/irqtop.c
> +++ b/sys-utils/irqtop.c
> @@ -87,6 +87,8 @@ struct irqtop_ctl {
>   	bool	batch;
>   	bool	request_exit,
>   		softirq;
> +
> +	char	*input;
>   };
>   
>   #define irqtop_batch_mode(ctl) ((ctl)->batch == true)
> @@ -122,8 +124,9 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>   	char timestr[64], *data, *data0, *p;
>   
>   	/* make irqs table */
> -	table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq,
> -				ctl->threshold, ctl->setsize, ctl->cpuset);
> +	table = get_scols_table(ctl->input, out, ctl->prev_stat, &stat,
> +				ctl->softirq, ctl->threshold, ctl->setsize,
> +				ctl->cpuset);
>   	if (!table) {
>   		ctl->request_exit = 1;
>   		return 1;
> @@ -292,6 +295,7 @@ static void __attribute__((__noreturn__)) usage(void)
>   	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>   	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>   	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
> +	fputs(_(" -i, --input <file>   read data from file\n"), stdout);
>   	fputs(_(" -n, --number <number> the maximum number of iterations\n"), stdout);
>   	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>   	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
> @@ -325,6 +329,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   		{"cpu-stat", required_argument, NULL, 'c'},
>   		{"cpu-list", required_argument, NULL, 'C'},
>   		{"delay", required_argument, NULL, 'd'},
> +		{"input", required_argument, NULL, 'i'},
>   		{"number", required_argument, NULL, 'n'},
>   		{"sort", required_argument, NULL, 's'},
>   		{"output", required_argument, NULL, 'o'},
> @@ -336,7 +341,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   	};
>   	int o;
>   
> -	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
> +	while ((o = getopt_long(argc, argv, "bc:C:d:i:n:o:s:St:hV", longopts, NULL)) != -1) {
>   		switch (o) {
>   		case 'b':
>   			ctl->batch = true;
> @@ -376,6 +381,13 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   				ctl->timer.it_value = ctl->timer.it_interval;
>   			}
>   			break;
> +		case 'i':
> +			ctl->input = strdup(optarg);
> +			if (!ctl->input)
> +				err_oom();
> +			ctl->number = 1;
> +			ctl->batch = true;
> +			break;
>   		case 'n':
>   			ctl->number = str2num_or_err(optarg, 10,
>   					_("failed to parse number argument"),
> @@ -402,6 +414,15 @@ static void parse_args(	struct irqtop_ctl *ctl,
>   		}
>   	}
>   
> +	if (ctl->input == NULL) {
> +		if (ctl->softirq == 1)
> +			ctl->input = strdup(_PATH_PROC_SOFTIRQS);
> +		else
> +			ctl->input = strdup(_PATH_PROC_INTERRUPTS);
> +		if (!ctl->input)
> +			err_oom();
> +	}
> +
>   	/* default */
>   	if (!out->ncolumns) {
>   		out->columns[out->ncolumns++] = COL_IRQ;
> @@ -453,6 +474,7 @@ int main(int argc, char **argv)
>   
>   	free_irqstat(ctl.prev_stat);
>   	free(ctl.hostname);
> +	free(ctl.input);
>   	cpuset_free(ctl.cpuset);
>   
>   	if (ctl.batch == false) {
> diff --git a/sys-utils/lsirq.1.adoc b/sys-utils/lsirq.1.adoc
> index 02aea16b3..dd265710c 100644
> --- a/sys-utils/lsirq.1.adoc
> +++ b/sys-utils/lsirq.1.adoc
> @@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
>   *-n*, *--noheadings*::
>   Don't print headings.
>   
> +*-i*, *--input* _file_::
> +Read data from _file_ (Which was created by other tools, e.g. sosreport).
> +
>   *-o*, *--output* _list_::
>   Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
>   
> diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
> index e31addaf5..45d542919 100644
> --- a/sys-utils/lsirq.c
> +++ b/sys-utils/lsirq.c
> @@ -29,16 +29,17 @@
>   #include "optutils.h"
>   #include "strutils.h"
>   #include "xalloc.h"
> +#include "pathnames.h"
>   
>   #include "irq-common.h"
>   
> -static int print_irq_data(struct irq_output *out,
> +static int print_irq_data(const char *input_file, struct irq_output *out,
>   			  int softirq, unsigned long threshold,
>   			  size_t setsize, cpu_set_t *cpuset)
>   {
>   	struct libscols_table *table;
>   
> -	table = get_scols_table(out, NULL, NULL, softirq, threshold, setsize, cpuset);
> +	table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset);
>   	if (!table)
>   		return -1;
>   
> @@ -58,6 +59,7 @@ static void __attribute__((__noreturn__)) usage(void)
>   	fputs(USAGE_OPTIONS, stdout);
>   	fputs(_(" -J, --json           use JSON output format\n"), stdout);
>   	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), stdout);
> +	fputs(_(" -i, --input          read data from input file\n"), stdout);
>   	fputs(_(" -n, --noheadings     don't print headings\n"), stdout);
>   	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>   	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
> @@ -82,6 +84,7 @@ int main(int argc, char **argv)
>   	static const struct option longopts[] = {
>   		{"sort", required_argument, NULL, 's'},
>   		{"noheadings", no_argument, NULL, 'n'},
> +		{"input", required_argument, NULL, 'i'},
>   		{"output", required_argument, NULL, 'o'},
>   		{"threshold", required_argument, NULL, 't'},
>   		{"cpu-list", required_argument, NULL, 'C'},
> @@ -103,10 +106,11 @@ int main(int argc, char **argv)
>   	cpu_set_t *cpuset = NULL;
>   	size_t setsize = 0;
>   	int softirq = 0;
> +	char *input = NULL;
>   
>   	setlocale(LC_ALL, "");
>   
> -	while ((c = getopt_long(argc, argv, "no:s:t:C:ShJPV", longopts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "i:no:s:t:C:ShJPV", longopts, NULL)) != -1) {
>   		err_exclusive_options(c, longopts, excl, excl_st);
>   
>   		switch (c) {
> @@ -116,6 +120,11 @@ int main(int argc, char **argv)
>   		case 'P':
>   			out.pairs = 1;
>   			break;
> +		case 'i':
> +			input = strdup(optarg);
> +			if (!input)
> +				err_oom();
> +			break;
>   		case 'n':
>   			out.no_headings = 1;
>   			break;
> @@ -157,6 +166,15 @@ int main(int argc, char **argv)
>   		}
>   	}
>   
> +	if (input == NULL) {
> +		if (softirq == 1)
> +			input = strdup(_PATH_PROC_SOFTIRQS);
> +		else
> +			input = strdup(_PATH_PROC_INTERRUPTS);
> +		if (!input)
> +			err_oom();
> +	}
> +
>   	/* default */
>   	if (!out.ncolumns) {
>   		out.columns[out.ncolumns++] = COL_IRQ;
> @@ -171,8 +189,10 @@ int main(int argc, char **argv)
>   				irq_column_name_to_id) < 0)
>   		exit(EXIT_FAILURE);
>   
> -	if (print_irq_data(&out, softirq, threshold, setsize, cpuset) < 0)
> +	if (print_irq_data(input, &out, softirq, threshold, setsize, cpuset) < 0)
>   		return EXIT_FAILURE;
>   
> +	free(input);
> +
>   	return EXIT_SUCCESS;
>   }

