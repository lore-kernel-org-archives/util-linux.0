Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:63480 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964927AbcCOIdl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 04:33:41 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] lscpu: Fix model and model name on Power Systems
Date: Tue, 15 Mar 2016 09:33:31 +0100
Cc: util-linux@vger.kernel.org, kzak@redhat.com
References: <20160314144804.415.11481.stgit@hegdevasant>
In-Reply-To: <20160314144804.415.11481.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603150933.31562.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 14 March 2016, Vasant Hegde wrote:
> On Power System, lspcu presently displays system model number instead
> of processor model name. 'model' tag in cpuinfo contains system model
> name, not processor model. Instead it uses 'cpu' tag for processor
> model name. Also it uses 'revision' tag for processor model.
>
> Fix lspcu so that it displays processor model number. Also display
> processor model name.
>
> cpuinfo output on Power System:
>   ...
>   ...
>
>   processor	: 127
>   cpu		: POWER8E (raw), altivec supported
>   clock		: 4322.000000MHz
>   revision	: 2.1 (pvr 004b 0201)
>
>   timebase	: 512000000
>   platform	: PowerNV
>   model		: 8286-42A
>   machine	: PowerNV 8286-42A
>   firmware	: OPAL
>
>
> Output without this patch:
>   Architecture:          ppc64le
>   Byte Order:            Little Endian
>   CPU(s):                128
>   On-line CPU(s) list:   0-127
>   Thread(s) per core:    8
>   Core(s) per socket:    4
>   Socket(s):             4
>   NUMA node(s):          4
>   Model:                 8286-42A
>   ...
>   ...
>
> Output with this patch:
>   Architecture:          ppc64le
>   Byte Order:            Little Endian
>   CPU(s):                128
>   On-line CPU(s) list:   0-127
>   Thread(s) per core:    8
>   Core(s) per socket:    4
>   Socket(s):             4
>   NUMA node(s):          4
>   Model:                 2.1 (pvr 004b 0201)
>   Model name:            POWER8E (raw), altivec supported
>   ...
>   ...
>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
> ---
>  sys-utils/lscpu.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index fc32762..423bc56 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -465,8 +465,13 @@ read_basicinfo(struct lscpu_desc *desc, struct
> lscpu_modifier *mod) else if (lookup(buf, "vendor_id",
> &desc->vendor)) ;
>  		else if (lookup(buf, "family", &desc->family)) ;
>  		else if (lookup(buf, "cpu family", &desc->family)) ;
> +#if defined(__powerpc__) || defined(__powerpc64__)
> +		else if (lookup(buf, "revision", &desc->model)) ;
> +		else if (lookup(buf, "cpu", &desc->modelname)) ;
> +#else
>  		else if (lookup(buf, "model", &desc->model)) ;
>  		else if (lookup(buf, "model name", &desc->modelname)) ;
> +#endif
>  		else if (lookup(buf, "stepping", &desc->stepping)) ;
>  		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
>  		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */

Would it be possible to decide on runtime what to do, ideally looking 
into /proc or /sys to see whether it's a powerpc? This ifdef does not 
work with lscpu --sysroot.

See below our test diffs. The power7 and sparc dumps look better, x86 is 
broken and ppc-qemu looks odd.


--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-ppc-qemu     
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-ppc-qemu       
2016-03-15 00:48:52.850000003 +0000
@@ -3,7 +3,8 @@
 Thread(s) per core:    1
 Core(s) per socket:    1
 Socket(s):             1
-Model:                 Power Macintosh
+Model:                 3.1 (pvr 0008 0301)
+Model name:            740/750
 BogoMIPS:              33.25
 L1d cache:             unknown size
 L1i cache:             unknown size
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-ppc64-POWER7 
2016-03-02 21:33:53.348702004 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-ppc64-POWER7   
2016-03-15 00:48:53.080000003 +0000
@@ -4,7 +4,8 @@
 Core(s) per socket:    1
 Socket(s):             4
 NUMA node(s):          1
-Model:                 IBM,8233-E8B
+Model:                 2.1 (pvr 003f 0201)
+Model name:            POWER7 (architected), altivec supported
 L1d cache:             32K
 L1i cache:             32K
 NUMA node0 CPU(s):     0-15
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu   
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-ppc64-POWER7-64cpu     
2016-03-15 00:48:53.010000003 +0000
@@ -4,7 +4,8 @@
 Core(s) per socket:    1
 Socket(s):             16
 NUMA node(s):          2
-Model:                 IBM,8231-E2B
+Model:                 2.1 (pvr 003f 0201)
+Model name:            POWER7 (architected), altivec supported
 Hypervisor vendor:     pHyp
 Virtualization type:   para
 L1d cache:             32K
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-sparc64      
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-sparc64        
2016-03-15 00:48:53.250000003 +0000
@@ -4,6 +4,7 @@
 Thread(s) per core:    1
 Core(s) per socket:    1
 Socket(s):             6
+Model name:            TI UltraSparc II  (BlackBird)
 Flags:                 sun4u

 # The following is the parsable format, which can be fed to other
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-vbox-win     
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-vbox-win       
2016-03-15 00:48:53.290000003 +0000
@@ -7,8 +7,6 @@
 NUMA node(s):          1
 Vendor ID:             GenuineIntel
 CPU family:            6
-Model:                 58
-Model name:            Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
 Stepping:              9
 CPU MHz:               1600.000
 CPU max MHz:           3800.0000
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-x86_64-64cpu 
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-x86_64-64cpu   
2016-03-15 00:48:53.710000003 +0000
@@ -7,8 +7,6 @@
 NUMA node(s):          3
 Vendor ID:             GenuineIntel
 CPU family:            6
-Model:                 46
-Model name:            Intel(R) Xeon(R) CPU           X7550  @ 2.00GHz
 Stepping:              6
 CPU MHz:               1064.000
 CPU max MHz:           1996.0000
--- /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/expected/lscpu/lscpu-x86_64-dell_e4310    
2016-03-13 15:08:02.457989796 +0000
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.28.rc1.git35.83a77/tests/output/lscpu/lscpu-x86_64-dell_e4310      
2016-03-15 00:48:53.760000003 +0000
@@ -7,8 +7,6 @@
 NUMA node(s):          1
 Vendor ID:             GenuineIntel
 CPU family:            6
-Model:                 37
-Model name:            Intel(R) Core(TM) i5 CPU       M 560  @ 2.67GHz
 Stepping:              5
 CPU MHz:               1199.000
 CPU max MHz:           2667.0000

