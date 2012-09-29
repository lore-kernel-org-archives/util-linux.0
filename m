Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210Ab2I2KYH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 29 Sep 2012 06:24:07 -0400
Message-ID: <5066CC39.20408@draigBrady.com>
Date: Sat, 29 Sep 2012 11:23:53 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: column.1 describe change of separator behavior
 in bugs section
References: <50636D1D.3080007@draigBrady.com> <1348910519-10684-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1348910519-10684-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 09/29/2012 10:21 AM, Sami Kerola wrote:
> Add to manual page how to achieve old behavior, just in case someone
> relies on buggy behavior of the command.
>
> Reported-by: P�draig Brady<P@draigbrady.com>
> Signed-off-by: Sami Kerola<kerolasa@iki.fi>
> ---
>   text-utils/column.1 | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/text-utils/column.1 b/text-utils/column.1
> index 2050666..775c73b 100644
> --- a/text-utils/column.1
> +++ b/text-utils/column.1
> @@ -65,6 +65,35 @@ the screen if no other information is available.
>   .nf
>   sed 's/#.*//' /etc/fstab | column -t
>   .nf
> +.SH BUGS
> +The util-linux version 2.23 changed
> +.B \-s
> +option to be non-greedy.  The change made the following output
> +.PP
> +.EX
> +$ printf "a:b:c\n1::3\n" | column  -t -s ':'
> +a  b  c
> +1  3
> +.EE
> +.PP
> +to be
> +.PP
> +.EX
> +$ printf "a:b:c\n1::3\n" | column  -t -s ':'
> +a  b  c
> +1     3
> +.EE
> +.PP
> +If there is need to use greedy separator the old behavior can be achieved
> +by filtering with
> +.BR sed (1).
> +.PP
> +.EX
> +$ printf "xzcatxzdog\\ndonkeyxzzxkong\\n" |
> +>  sed 's/^[xz]*//
> +>  s/[xz]\\+/x/g' |
> +>  column -t -s xz
> +.EE

Too much info for a man page IMHO.

cheers,
Pádraig.
