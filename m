Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab1ECMx0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 May 2011 08:53:26 -0400
Date: Tue, 3 May 2011 14:53:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Austen Dicken <cvpcsm@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] dmesg: adds the ability to "follow" the klog ring
	buffer
Message-ID: <20110503125322.GK29492@nb.net.home>
References: <BANLkTin=y5oaEU0913dOnjWhosiyXe3Zwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTin=y5oaEU0913dOnjWhosiyXe3Zwg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 29, 2011 at 11:42:00AM -0500, Austen Dicken wrote:
> adds the "-f" option to dmesg, which allows an underpriviledged
> user to "follow" the kernel ring buffer, outputting new messages as they

I like the "follow the kernel ring buffer" idea, but ...

> appear.  this is done non-destructively so that the current buffer remains
> after execution.
> 
> this also changes the log output to be by-line instead of by-character,
> and saves the last line printed on each read of the buffer.  if looping,
> it will then read the buffer again, but not output until it finds the last
> line that it printed.

... this seems like a problem to me.

 [...]

> -	for (i = 0; i < n; i++) {
> -		if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
> -			i++;
> -			while (isdigit(buf[i]))
> -				i++;
> -			if (buf[i] == '>')
> +		this_line = xmalloc(n * sizeof(char));
> +		for (i = 0, j = 0; i < n; i++) {
> +			if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
>  				i++;
> +				while (isdigit(buf[i]))
> +					i++;
> +				if (buf[i] == '>')
> +					i++;
> +			}
> +			this_line[j] = buf[i];
> +
> +			if (this_line[j] == '\n') {
> +				this_line[j] = '\0';
> +				if (last_line) {
> +					if (!strcmp(last_line, this_line)) {
> +						free(last_line);
> +						last_line = NULL;
> +					}
> +				} else
> +					printf("%s\n", this_line);

It expects that the kernel log does not contain duplicate messages.
Is it correct? I don't think so, I see:

   ata1.00: configured for UDMA/100
   ata1.00: configured for UDMA/100

You have to compile kernel with CONFIG_PRINTK_TIME, otherwise your
heuristic will not work properly.

> +		usleep(200);
> +
> +	} while (follow_loop);

Hmm... sleep() in code usually means a poor design or API.

What about to support -f (follow) for privileged users only?

Then you can use klogctl(2, ...). It waits until the kernel log buffer
is non-empty, so the last_line and usleep() will be unnecessary, and
the implementation will be pretty simple.

> +		if (prev_sighandler)
> +			signal(SIGINT, prev_sighandler);
> +		else
> +			signal(SIGINT, SIG_DFL);

Why do you need to restore the handler before return (exit)? It seems
unnecessary.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
