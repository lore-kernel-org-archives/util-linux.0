Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51235 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbaETSk1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 14:40:27 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] lscpu: improve vmware detection
Date: Tue, 20 May 2014 20:40:23 +0200
Cc: Stanislav Brabec <sbrabec@suse.cz>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <1400600551-7227-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-5-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405202040.23526.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I guess this part of the patch set will be the most controversial one.

1. This inline assembler code breaks some compilers, e.g. clang on our
   travis build machine. Though this seems to be a bug of this
   particular old clang version.

2. The VMWARE_BDOOR function seems to be imported from kernel
   arch/x86/kernel/cpu/vmware.c
   I wonder if we couldn't just ask the kernel about vmware!? At least
   we should pull existing fixes from kernel.

BTW I've re-organized this patch a bit regarding ifdefs to let it look 
like this
https://github.com/rudimeier/util-linux/commit/8ff73842a1a552354272a954659983ff3caeb45c
(The ifdef __GNUC__ should actually be something which tells us whether 
that inline asm would work.)


On Tuesday 20 May 2014, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> This patch comes from openSUSE / SLE. Original author was probably
> Petr Uzel.
> Internal SUSE references: fate310255, sr226509
>
> CC: Stanislav Brabec <sbrabec@suse.cz>
> CC: Petr Uzel <petr.uzel@suse.cz>
> Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> ---
>  sys-utils/lscpu.c | 68
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file
> changed, 68 insertions(+)
>
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index b9e07e6..ee3ad19 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -32,6 +32,15 @@
>  #include <stdarg.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <stdint.h>
> +#include <signal.h>
> +#include <strings.h>
> +#include <setjmp.h>
> +#if defined(__x86_64__) || defined(__i386__)
> +#ifdef HAVE_sys_io_h
> +#include <sys/io.h>
> +#endif
> +#endif
>
>  #include <libsmartcols.h>
>
> @@ -573,6 +582,57 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
>  		desc->hyper = HYPER_VMWARE;
>  }
>
> +#define VMWARE_BDOOR_MAGIC          0x564D5868
> +#define VMWARE_BDOOR_PORT           0x5658
> +#define VMWARE_BDOOR_CMD_GETVERSION 10
> +
> +#define VMWARE_BDOOR(eax, ebx, ecx, edx)                            
>      \ +        __asm__("inl (%%dx)" :                               
>             \ +               "=a"(eax), "=c"(ecx), "=d"(edx),
> "=b"(ebx) :               \ +               "0"(VMWARE_BDOOR_MAGIC),
> "1"(VMWARE_BDOOR_CMD_GETVERSION), \ +              
> "2"(VMWARE_BDOOR_PORT), "3"(0) :                           \ +       
>        "memory");
> +
> +static jmp_buf segv_handler_env;
> +
> +static void
> +segv_handler(int sig, siginfo_t *info, void *ignored)
> +{
> +	siglongjmp(segv_handler_env, 1);
> +}
> +
> +static int
> +is_vmware_platform(void)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +	struct sigaction act, oact;
> +
> +	/*
> +	 * The assembly routine for vmware detection works
> +	 * fine under vmware, even if ran as regular user. But
> +	 * on real HW or under other hypervisors, it segfaults (which is
> +	 * expected). So we temporarily install SIGSEGV handler to catch
> +	 * the signal. All this magic is needed because lscpu
> +	 * isn't supposed to require root privileges.
> +	 */
> +	if (sigsetjmp(segv_handler_env, 1))
> +		return 0;
> +
> +	bzero(&act, sizeof(act));
> +	act.sa_sigaction = segv_handler;
> +	act.sa_flags = SA_SIGINFO;
> +
> +	if (sigaction(SIGSEGV, &act, &oact))
> +		err(EXIT_FAILURE, _("error: can not set signal handler"));
> +
> +	VMWARE_BDOOR(eax, ebx, ecx, edx);
> +
> +	if (sigaction(SIGSEGV, &oact, NULL))
> +		err(EXIT_FAILURE, _("error: can not restore signal handler"));
> +
> +	return eax != (uint32_t)-1 && ebx == VMWARE_BDOOR_MAGIC;
> +}
> +
>  #else	/* ! __x86_64__ */
>  static void
>  read_hypervisor_cpuid(struct lscpu_desc *desc
> __attribute__((__unused__))) @@ -623,6 +683,11 @@
> read_hypervisor_cpuid(struct lscpu_desc *desc
> __attribute__((__unused__))) }
>  #endif
>  }
> +
> +static int is_vmware_platform(void)
> +{
> +	return 0;
> +}
>  #endif
>
>  static void
> @@ -659,6 +724,9 @@ read_hypervisor(struct lscpu_desc *desc, struct
> lscpu_modifier *mod) } else if (has_pci_device(
> hv_vendor_pci[HYPER_XEN], hv_graphics_pci[HYPER_XEN])) { desc->hyper
> = HYPER_XEN;
>  		desc->virtype = VIRT_FULL;
> +	} else if (is_vmware_platform()) {
> +		desc->hyper = HYPER_VMWARE;
> +		desc->virtype = VIRT_FULL;
>  	} else if (has_pci_device( hv_vendor_pci[HYPER_VMWARE],
> hv_graphics_pci[HYPER_VMWARE])) { desc->hyper = HYPER_VMWARE;
>  		desc->virtype = VIRT_FULL;
