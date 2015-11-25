Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbbKYJRR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Nov 2015 04:17:17 -0500
Date: Wed, 25 Nov 2015 10:17:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: nacc@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: Re: [RFC][PATCH 1/1] lscpu: Print physical cpu information
Message-ID: <20151125091715.GE4955@ws.net.home>
References: <1448402285-15621-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448402285-15621-1-git-send-email-sukadev@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 24, 2015 at 01:58:05PM -0800, Sukadev Bhattiprolu wrote:
> Appreciate comments on the proposal including following:
> 
> 	- Should we instead display the physical information unconditionally?

yes

> 	  Maybe add '--system' or '--no-physical' to suppress the physical
> 	  topology info?
> 
> 	- Should we ignore (as this patch does) or fail if '--physical'
> 	  is specified on yet unsupported architectures?

I have originally thought that --physical will overwrite the current
output (e.g. "Sockets:"). If we add information from librtas as
additional fields (e.g. "Physical sockets:") than maybe we don't need
the option --physical at all, and all we need is to describe all
(difference between system/physical) in docs.

> +static void read_physical_info_powerpc(struct lscpu_desc *desc)
> +{
> +	char buf[4096];

  buf[BUFSIZ]

...

>  static void
>  read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
>  {
> @@ -506,6 +555,9 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
>  		desc->dispatching = path_read_s32(_PATH_SYS_CPU "/dispatching");
>  	else
>  		desc->dispatching = -1;
>

you should not read information from rtas when lscpu is running in
shapshot mode ("snapshot" means that we read info from /sys and /proc
dump rather than from a real system; we use it for regression tests).

   if (mod->system == SYSTEM_ALIVE)
        read_physical_info_powerpc(desc);

and mod->physical will be  probably unnecessary if the physical information
will be printed unconditionally ;-)

> +	if (mod->physical)
> +		read_physical_info_powerpc(desc);
>  }


 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
