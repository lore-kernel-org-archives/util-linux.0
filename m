Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:61851 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaETSNO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 14:13:14 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH 0/5] lscpu: improve hypervisor detection
Date: Tue, 20 May 2014 20:13:11 +0200
Cc: util-linux@vger.kernel.org
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de> <1400603662.5497.86.camel@oct.suse.cz>
In-Reply-To: <1400603662.5497.86.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201405202013.11625.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 20 May 2014, Stanislav Brabec wrote:
> Ruediger Meierwrote:
> > I've splitted the original patch into smaller pieces, removed some
> > incompatible output format changes and added some test data.
>
> There was a controversial part of this patch, that causes test
> failure.
>
> There should be a way how to output result of the virtual machine
> detection without breaking test cases (and possibly existing
> scripts).

We already output it per default "lscpu" without options. As you can see 
in the newly added test output:

$ grep -A1 "Hypervisor"   tests/expected/lscpu/lscpu-vbox-win
Hypervisor vendor:     Oracle
Virtualization type:   full

The other part of the original patch below only affected "-p" which was 
IMO useless and bad because incompatible.


> Index: util-linux-2.24.1/sys-utils/lscpu.c
> ===================================================================
> --- util-linux-2.24.1.orig/sys-utils/lscpu.c
> +++ util-linux-2.24.1/sys-utils/lscpu.c
> @@ -1181,6 +1322,7 @@ print_parsable(struct lscpu_desc *desc,
>  		}
>  		fputs(data && *data ? data : "", stdout);
>  	}
> +	printf(",HvVendor,VirtType");
>  	putchar('\n');
>
>  	/*
> @@ -1210,7 +1352,9 @@ print_parsable(struct lscpu_desc *desc,
>  					     buf, sizeof(buf));
>  			fputs(data && *data ? data : "", stdout);
>  		}
> -		putchar('\n');
> +		printf(",%s,%s\n",
> +		       hv_vendors[desc->hyper] ? hv_vendors[desc->hyper] : "none",
> +		       virt_types[desc->virtype]);
>  	}
>  }


