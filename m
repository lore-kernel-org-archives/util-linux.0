Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbaE3JPH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 May 2014 05:15:07 -0400
Date: Fri, 30 May 2014 11:15:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Csaba Kos <csaba.kos@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] deadlock in script
Message-ID: <20140530091503.GE9000@x2.net.home>
References: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADhtO=98eyzuDjbNgSzfdq17wxwWnuWp5H7-Go-Ut4SvMAQ7hw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 30, 2014 at 03:30:45PM +0900, Csaba Kos wrote:
> diff --git a/term-utils/script.c b/term-utils/script.c
> index e5d239c..32906d0 100644
> --- a/term-utils/script.c
> +++ b/term-utils/script.c
> @@ -36,6 +36,9 @@
>   * - added Native Language Support
>   *
>   * 2000-07-30 Per Andreas Buer <per@linpro.no> - added "q"-option
> + *
> + * 2014-05-30 Csaba Kos <csaba.kos@gmail.com>
> + * - fixed a rare deadlock after child termination
>   */
>  
>  /*
> @@ -114,6 +117,8 @@ int	tflg = 0;
>  int	forceflg = 0;
>  int	isterm;
>  
> +sigset_t block_mask, unblock_mask;

 This declaration shadows declaration in main() where is also block_mask and 
 unblock_mask -- I guess it's not expected.

> +	/* block SIGCHLD */
> +	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);

 the initialization is where? in main()?

> +		/* wait for input or signal (including SIGCHLD) */
> +		if ((cc = pselect(STDIN_FILENO + 1, &readfds, NULL, NULL, NULL,
> +			&unblock_mask)) > 0) {

 probably good idea, I have thought about something like this (or
 signalfd()), but I have never found time to try it... thanks!

> +			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
> +				if (write_all(master, ibuf, cc)) {
> +					warn (_("write failed"));
> +					fail();
> +				}

  Karel  


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
