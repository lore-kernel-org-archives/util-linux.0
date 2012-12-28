Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:33280 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2L1QNH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 11:13:07 -0500
Date: Fri, 28 Dec 2012 11:12:18 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: util-linux@vger.kernel.org, kerolasa@gmail.com, grawity@gmail.com,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] sys-tools: Enhance unshare command to support the
 switching of namespaces
Message-ID: <20121228161217.GA5325@neilslaptop.think-freely.org>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
 <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com>
 <50DD9695.4080507@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50DD9695.4080507@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 28, 2012 at 01:54:45PM +0100, Ángel González wrote:
> On 20/12/12 19:22, Neil Horman wrote:
> >  		case 'm':
> > -			unshare_flags |= CLONE_NEWNS;
> > +			ns = "mount";
> > +			if (!optarg)
> > +				unshare_flags |= CLONE_NEWNS;
> >  			break;
> 
> Is this right? I don't have a /proc/<task>/ns/mount locally nor is it
> documented in
> http://git.kernel.org/?p=docs/man-pages/man-pages.git;a=blob;f=man5/proc.5
> 
> However looking at
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=fs/proc/namespaces.c
> there is a reference to mntns_operations, which is defined in
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=fs/proc/namespaces.c
> 
> but seems to be called "mnt", not "mount"
> 
Shoot, I thought Biederman was going to call it mount, not mnt, I'll fix that
shortly.

> There are also pid and user namespaces there, but support for those are
> better handled in a different patch IMHO.
> 
I'm not really sure what you mean by a different patch here.  Why would I add
support for setns for other pid/uts namespaces in a different patch?

> 
> > +				sprintf(path, "/proc/%d/ns/%s", (int)pid, ns); 
> > +				ns_pids[nscount] = open(path, O_RDONLY);
> > +				if (ns_pids[nscount] < 0)
> > +					err(EXIT_FAILURE, _("could not open %s"), path);
> > +				nscount++;
> 
> What about err(EXIT_FAILURE, _("The kernel doesn't seem to support %s
> migrations: could not open %s"), ns, path); ?
> 
Sure, I can do that.

> Mention in the man page the kernel version from which each namespace can
> be migrated.
> 
Yeah, ok
Neil

> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
