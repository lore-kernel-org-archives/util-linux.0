Return-Path: ingenit@zoho.com
Message-ID: <50DD9695.4080507@zoho.com>
Date: Fri, 28 Dec 2012 13:54:45 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: util-linux@vger.kernel.org, kerolasa@gmail.com, grawity@gmail.com,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] sys-tools: Enhance unshare command to support the
 switching of namespaces
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com> <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com>
In-Reply-To: <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 20/12/12 19:22, Neil Horman wrote:
>  		case 'm':
> -			unshare_flags |= CLONE_NEWNS;
> +			ns = "mount";
> +			if (!optarg)
> +				unshare_flags |= CLONE_NEWNS;
>  			break;

Is this right? I don't have a /proc/<task>/ns/mount locally nor is it
documented in
http://git.kernel.org/?p=docs/man-pages/man-pages.git;a=blob;f=man5/proc.5

However looking at
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=fs/proc/namespaces.c
there is a reference to mntns_operations, which is defined in
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=fs/proc/namespaces.c

but seems to be called "mnt", not "mount"

There are also pid and user namespaces there, but support for those are
better handled in a different patch IMHO.


> +				sprintf(path, "/proc/%d/ns/%s", (int)pid, ns); 
> +				ns_pids[nscount] = open(path, O_RDONLY);
> +				if (ns_pids[nscount] < 0)
> +					err(EXIT_FAILURE, _("could not open %s"), path);
> +				nscount++;

What about err(EXIT_FAILURE, _("The kernel doesn't seem to support %s
migrations: could not open %s"), ns, path); ?

Mention in the man page the kernel version from which each namespace can
be migrated.
