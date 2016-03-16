Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/2] lscpu: use cpu and revision tag if available
Date: Wed, 16 Mar 2016 11:23:58 +0100
Cc: util-linux@vger.kernel.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
References: <1458055880-18766-1-git-send-email-sweet_f_a@gmx.de> <201603160857.27047.sweet_f_a@gmx.de> <20160316093700.dekdnjyx6c2mfs4h@ws.net.home>
In-Reply-To: <20160316093700.dekdnjyx6c2mfs4h@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603161123.58299.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 16 March 2016, Karel Zak wrote:
> On Wed, Mar 16, 2016 at 08:57:26AM +0100, Ruediger Meier wrote:
> > > +	if (cpu) {
> > > +		free(desc->modelname);
> > > +		desc->modelname = cpu;
> > > +	}
> > > +	if (revision) {
> > > +		free(desc->model);
> > > +		desc->model = revision;
> > > +	}
> > > +
>
> The problem I see is that Linux kernel does not provide any unified
> abstraction for /proc/cpuinfo, the file is generated individually by
> architecture specific code, so the field names are very arch
> specific. (use "git grep show_cpuinfo" in kernel tree to see more)
>
> For example "revision" is no PPC specific, it's also used by ia64.
> Alpha uses "cpu revision" and "cpu model", etc.

Yes, but the probability is high that the new code will do it better. 
Like in sparc case.

> The ideal solution (for v2.29) would be to have more
> read_cpuinfo_<arch>() functions to hide the differences.
>
> > Watching this again today I think it could be even better to add
> > cpu and revision members to the struct and move both if conditions
> > to the printing code section.
>
> Do you want to send a new version of the patch?

Yep.
