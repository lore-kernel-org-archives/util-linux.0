Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbcCPJhC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 05:37:02 -0400
Date: Wed, 16 Mar 2016 10:37:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] lscpu: use cpu and revision tag if available
Message-ID: <20160316093700.dekdnjyx6c2mfs4h@ws.net.home>
References: <1458055880-18766-1-git-send-email-sweet_f_a@gmx.de>
 <1458055880-18766-2-git-send-email-sweet_f_a@gmx.de>
 <201603160857.27047.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603160857.27047.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 16, 2016 at 08:57:26AM +0100, Ruediger Meier wrote:
> > +	if (cpu) {
> > +		free(desc->modelname);
> > +		desc->modelname = cpu;
> > +	}
> > +	if (revision) {
> > +		free(desc->model);
> > +		desc->model = revision;
> > +	}
> > +

The problem I see is that Linux kernel does not provide any unified
abstraction for /proc/cpuinfo, the file is generated individually by
architecture specific code, so the field names are very arch specific.
(use "git grep show_cpuinfo" in kernel tree to see more)

For example "revision" is no PPC specific, it's also used by ia64.
Alpha uses "cpu revision" and "cpu model", etc.

The ideal solution (for v2.29) would be to have more read_cpuinfo_<arch>()
functions to hide the differences. 

> Watching this again today I think it could be even better to add cpu and 
> revision members to the struct and move both if conditions to the 
> printing code section.

Do you want to send a new version of the patch?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
