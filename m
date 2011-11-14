Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:8226 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab1KNIsm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 03:48:42 -0500
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0LUN00ASD74ECU40@damascus.uab.es> for
 util-linux@vger.kernel.org; Mon, 14 Nov 2011 09:48:14 +0100 (CET)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0LUN006L274E3870@damascus.uab.es>
 forutil-linux@vger.kernel.org; Mon, 14 Nov 2011 09:48:14 +0100 (CET)
Date: Mon, 14 Nov 2011 11:50:54 +0100
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 13/15] prlimit: enhance examples section of the man page
In-reply-to: <4EC07381.6050608@bernhard-voelker.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Message-id: <1321267854.8015.2.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <4EC07381.6050608@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2011-11-14 at 02:48 +0100, Bernhard Voelker wrote:
> [PATCH 13/15] prlimit: enhance examples section of the man page
> 
> Add various examples to the man page, e.g. demonstrating setting
> limits using short options, showing that the --pid option can be
> used in random positions, how to use the "-1" notation for the
> "unlimited" value, and that prlimit takes the values from the arguments
> last set.

Just a few examples are more than enough to illustrate the point;
manpages have always been this way. I think this is unnecessary and
clogs the document.

> Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> ---
>   sys-utils/prlimit.1 |   13 ++++++++++---
>   1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
> index fa45aca..ece6c05 100644
> --- a/sys-utils/prlimit.1
> +++ b/sys-utils/prlimit.1
> @@ -88,13 +88,20 @@ Timeout for real-time tasks.
>   .SH EXAMPLES
>   .IP "\fBprlimit \-\-pid 13134\fP"
>   Display limit values for all current resources.
> -.IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
> +.IP "\fBprlimit \--rss \-\-pid 13134 --nofile=1024:4095\fP"
>   Display the limits of the RSS and set the soft and hard limits for the 
> amount
>   of open files to 1024 and 4095, respectively.
> -.IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
> +.IP "\fBprlimit \-\-pid 13134 -n512:\fP"
>   Modify only the soft limit for the amount of processes.
> -.IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
> +.IP "\fBprlimit \-\-pid=$$ --nproc=unlimited\fP"
>   Set the amount of processes for both soft and ceiling values to unlimited.
> +.IP "\fBprlimit \-p$$ -n-1:\fP"
> +Likewise, but only for the soft limit and using the "-1" notation.
> +.IP "\fBprlimit \-p$$ -n:1000 -n\fP"
> +Set the hard NPROC limit to 1000 and display its value.
> +.IP "\fBprlimit \-p$$ -n100:200 -n300 -n400: -n:500\fP"
> +Example to demonstrate that prlimit uses the values of the options last 
> set.
> +Here it will set the soft NPROC limit to 400 and the hard limit to 500.
> 
>   .SH "SEE ALSO"
>   .BR prlimit (2),
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


