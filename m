Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Date: Wed, 21 May 2014 11:43:46 +0200
Cc: util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de> <20140521073753.GA2898@x2.net.home>
In-Reply-To: <20140521073753.GA2898@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405210943.47004.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 21 May 2014, Karel Zak wrote:
> On Tue, May 20, 2014 at 03:42:29PM +0000, Ruediger Meier wrote:
> >  const int hv_vendor_pci[] = {
> > @@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
> >  static void
> >  read_hypervisor_cpuid(struct lscpu_desc *desc
> > __attribute__((__unused__))) {
> > +#ifdef __powerpc__
> > +	/* powerpc:
> > +	 * IBM iSeries: legacy, if /proc/iSeries exists, its
> > para-virtualized on top of OS/400 +	 * IBM pSeries: always has a
> > hypervisor
> > +	 *              if partition-name is "full", its kind of
> > "bare-metal": full-system-partition +	 *              otherwise its
> > some partition created by Hardware Management Console +	 *         
> >     in any case, its always some sort of HVM +	 * KVM: "linux,kvm"
> > in /hypervisor/compatible indicates a KVM guest +	 * Xen: not in
> > use, not detected
> > +	 */
>
>  I don't see relation between this code and CPU ID. Why this  codes
> is with in read_hypervisor_cpuid() ?
>
>  Wouldn't be better to add  read_powerpc_hypervisor() and call it
> from read_hypervisor()?

Yes, I would call it like this, ok?
--------
static void
read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
{
	FILE *fd;

	if (mod->system != SYSTEM_SNAPSHOT) {
		read_hypervisor_cpuid(desc);
		if (!desc->hyper)
			desc->hyper = read_hypervisor_dmi();
	}
	if (desc->hyper)
		desc->virtype = VIRT_FULL;

	else if (read_hypervisor_powerpc(desc) > 0) {}

	/* Xen para-virt or dom0 */
	else if (path_exist(_PATH_PROC_XEN)) {
        ....
----------

BTW this is also better calling this code in case SYSTEM_SNAPSHOT too 
and it was a mistake anway that it could set desc->virtype = VIRT_NONE 
which was overwritten afterwards.


>     Karel
>
> > +	if (path_exist("/proc/iSeries")) {
> > +		desc->hyper = HYPER_OS400;
> > +		desc->virtype = VIRT_FULL;
> > +	} else if (path_exist(_PATH_PROC_DEVICETREE
> > "/ibm,partition-name")) { +		FILE *fd;
> > +		desc->hyper = HYPER_PHYP;
> > +		desc->virtype = VIRT_FULL;
> > +		fd = fopen(_PATH_PROC_DEVICETREE "/ibm,partition-name", "r");
> > +		if (fd) {
> > +			char buf[256];
> > +			if (fscanf(fd, "%s", buf) == 1 && !strcmp(buf, "full"))
> > +				desc->virtype = VIRT_NONE;
> > +			fclose(fd);
> > +		}
> > +	} else if (path_exist(_PATH_PROC_DEVICETREE
> > "/hypervisor/compatible")) { +		FILE *fd;
> > +		fd = fopen(_PATH_PROC_DEVICETREE "/hypervisor/compatible", "r");
> > +		if (fd) {
> > +			char buf[256];
> > +			int i;
> > +			memset(buf, 0, sizeof(buf));
> > +			fread(buf, sizeof(buf) - 1, 1, fd);
> > +			fclose(fd);
> > +			for (i = 0; i < sizeof(buf);) {
> > +				if (!strcmp(&buf[i], "linux,kvm")) {
> > +					desc->hyper = HYPER_KVM;
> > +					desc->virtype = VIRT_FULL;
> > +					break;
> > +				}
> > +				i += strlen(&buf[i]);
> > +				i++;
> > +			}
> > +		}
> > +	}
> > +#endif
> >  }
> >  #endif
> >
> > diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
> > index 7bb538d..6c25c4f 100644
> > --- a/sys-utils/lscpu.h
> > +++ b/sys-utils/lscpu.h
> > @@ -14,7 +14,9 @@ enum {
> >  	HYPER_INNOTEK,		/* VBOX */
> >  	HYPER_HITACHI,
> >  	HYPER_PARALLELS,	/* OpenVZ/VIrtuozzo */
> > -	HYPER_VBOX
> > +	HYPER_VBOX,
> > +	HYPER_OS400,
> > +	HYPER_PHYP
> >  };
> >
> >  extern int read_hypervisor_dmi(void);
> > --
> > 1.8.4.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > util-linux" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
