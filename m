Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcEKIiH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 May 2016 04:38:07 -0400
Date: Wed, 11 May 2016 10:38:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] write: add control structure to clarify what is
 going on
Message-ID: <20160511083804.4sia7k6wfetw4auo@ws.net.home>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
 <1462829248-6935-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462829248-6935-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 09, 2016 at 10:27:23PM +0100, Sami Kerola wrote:
> @@ -339,39 +347,42 @@ int main(int argc, char **argv)
>  		 * term_chk() will put "/dev/" in front, so remove that
>  		 * part.
>  		 */
> -		if (!strncmp(mytty, "/dev/", 5))
> -			mytty += 5;
> -		if (term_chk(mytty, &msgsok, NULL, 1))
> +		if (!strncmp(ctl.src_tty, "/dev/", 5))
> +			memmove(ctl.src_tty, ctl.src_tty + 5, strlen(ctl.src_tty + 5) + 1);
> +		if (term_chk(ctl.src_tty, &msgsok, NULL, 1))

The patch promises that it replaces variables with control struct, but
here it does something more. Don't do that. There is no memmove() in
the original code. 

Please, if you want to optimize the code than do it in another patch.

and btw: we have lib/ttyutils.c: get_terminal_name(), it seems usable
for this use-case, but...

> -		if (!strncmp(argv[2], "/dev/", 5))
> -			argv[2] += 5;
> -		if (utmp_chk(argv[1], argv[2]))
> +		ctl.dst_login = argv[1];
> +		xstrncpy(ctl.dst_tty, argv[2], sizeof(ctl.dst_tty));
> +		if (!strncmp(ctl.dst_tty, "/dev/", 5))
> +			memmove(ctl.dst_tty, ctl.dst_tty + 5, strlen(ctl.dst_tty + 5) + 1);

... maybe we need xttyname() to return a name (no path) and in
allocated string for programs where we call ttyname() more times.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
