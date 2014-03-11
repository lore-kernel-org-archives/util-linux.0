Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.13]:53072 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbaCKHVS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Mar 2014 03:21:18 -0400
Message-ID: <531EB96C.4040500@bernhard-voelker.de>
Date: Tue, 11 Mar 2014 08:21:16 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 06/10] kill: leeway deprecation of --pid invocation as
 command name
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi> <1394397023-7050-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-6-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/09/2014 09:30 PM, Sami Kerola wrote:
> diff --git a/misc-utils/kill.c b/misc-utils/kill.c
> index 2fecda3..11c8cd2 100644
> --- a/misc-utils/kill.c
> +++ b/misc-utils/kill.c
> @@ -170,6 +170,8 @@ int main(int argc, char **argv)
>  
>  	numsig = SIGTERM;
>  	do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
> +	if (do_pid)
> +		warnx(_("use of 'kill --pid' option as command name will be deprecated in future"));

You deprecate now:
  s/will .* future/is deprecated/


Another minor note:
Shouldn't there be something like a

  +  /* FIXME: remove in March 2016.  */

together with deprecations like that?
It would be easier to find and fix then.

Have a nice day,
Berny
