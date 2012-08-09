Return-Path: faizanh@linux.vnet.ibm.com
Message-ID: <50235651.6030409@linux.vnet.ibm.com>
Date: Thu, 09 Aug 2012 11:48:57 +0530
From: faizan husain <faizanh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: limit options --all, --online, --offline to parsable
 and extended output
References: <20120808085911.GA3441@osiris.de.ibm.com>
In-Reply-To: <20120808085911.GA3441@osiris.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Wednesday 08 August 2012 02:29 PM, Heiko Carstens wrote:
> So, how about the patch below in order to fix the issue Faisan
> brought up for lspcu?
>
>  From 0f0f80b71e90b6ab58d9f6009b8356bb42235916 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 8 Aug 2012 10:52:47 +0200
> Subject: [PATCH] lscpu: limit options --all, --online, --offline to parsable
>   and extended output
>
> Passing the --all, --online or --offline options for the output summary
> doesn't make much sense. It should be limited to the two list output options.
>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>   sys-utils/lscpu.1 |    9 ++++++---
>   sys-utils/lscpu.c |   12 ++++++++++++
>   2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
> index 41dae83..f7e34b9 100644
> --- a/sys-utils/lscpu.1
> +++ b/sys-utils/lscpu.1
> @@ -81,13 +81,16 @@ and hypervisor support CPU polarization.
>   .SH OPTIONS
>   .TP
>   .BR \-a , " \-\-all"
> -Include online and offline CPUs in the output (default for -e).
> +Include lines for online and offline CPUs in the output (default for -e). This
> +option may only specified together with option -e or -p.
>   .TP
>   .BR \-b , " \-\-online"
> -Limit the output to online CPUs (default for -p).
> +Limit the output to online CPUs (default for -p). This option may only
> +be specified together with option -e or -p.
>   .TP
>   .BR \-c , " \-\-offline"
> -Limit the output to offline CPUs.
> +Limit the output to offline CPUs. This option may only be specified together
> +with option -e or -p.
>   .TP
>   .BR \-e , " \-\-extended " \fI[=list]\fP
>   Display the CPU information in human readable format.
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index b93998a..25a0273 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -1243,6 +1243,7 @@ int main(int argc, char *argv[])
>   	struct lscpu_desc _desc = { .flags = 0 }, *desc = &_desc;
>   	int c, i;
>   	int columns[ARRAY_SIZE(coldescs)], ncolumns = 0;
> +	int cpu_modifier_specified = 0;
>
>   	static const struct option longopts[] = {
>   		{ "all",        no_argument,       0, 'a' },
> @@ -1276,12 +1277,15 @@ int main(int argc, char *argv[])
>   		switch (c) {
>   		case 'a':
>   			mod->online = mod->offline = 1;
> +			cpu_modifier_specified = 1;
>   			break;
>   		case 'b':
>   			mod->online = 1;
> +			cpu_modifier_specified = 1;
>   			break;
>   		case 'c':
>   			mod->offline = 1;
> +			cpu_modifier_specified = 1;
>   			break;
>   		case 'h':
>   			usage(stdout);
> @@ -1316,6 +1320,14 @@ int main(int argc, char *argv[])
>   		}
>   	}
>
> +	if (cpu_modifier_specified && mod->mode == OUTPUT_SUMMARY) {
> +		fprintf(stderr,
> +			_("%s: options --all, --online and --offline may only "
> +			  "be used with options --extended or --parsable.\n"),
> +			program_invocation_short_name);
> +		return EXIT_FAILURE;
> +	}
> +
>   	if (argc != optind)
>   		usage(stderr);
>
but...

don't you think we are missing on other column information

  [root@mx3650m2 ~]# lscpu -a
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                16
On-line CPU(s) list:   0-5,7-13,15
Off-line CPU(s) list:  6,14
Thread(s) per core:    2
Core(s) per socket:    3
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 26
Stepping:              5
CPU MHz:               1596.000
BogoMIPS:              5865.80
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              8192K
NUMA node0 CPU(s):     0-3,8-11
NUMA node1 CPU(s):     4,5,7,12,13,15


Thanks
Faizan
