Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31483 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2KIIit (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Nov 2012 03:38:49 -0500
Date: Fri, 9 Nov 2012 09:38:45 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Philipp Thomas <pth@suse.de>, Werner Fin <werner@suse.de>
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121109083845.GA26857@x2.net.home>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
 <20121012132336.GC23945@x2.net.home>
 <20121012140757.GA10101@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121012140757.GA10101@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 12, 2012 at 04:07:57PM +0200, Dr. Werner Fink wrote:
> +static
> +#ifdef __GNUC__
> +__attribute__((__nonnull__,__hot__))
> +#endif
> +void consalloc(char * name)
> +{
> +	struct console *restrict tail;
> +
> +	if (posix_memalign((void*)&tail, sizeof(void*), alignof(typeof(struct console))) != 0)
> +		perror("memory allocation");

 why not malloc() ?

> +
> +	tail->next = (struct console*)0;
> +	tail->tty = name;
> +
> +	tail->file = (FILE*)0;
> +	tail->flags = 0;
> +	tail->fd = -1;
> +	tail->id = concount++;
> +	tail->pid = 0;
> +	memset(&tail->tio, 0, sizeof(tail->tio));
> +	memcpy(&tail->cp, &initcp, sizeof(struct chardata));
> +
> +	if (!consoles)
> +		consoles = tail;
> +	else
> +		consoles->next = tail;
> +}

 It does not look like a list. It always update the same pointer
 consoles->next but not "consoles", so the result is list with only
 two items (first and the last item).

 If you want to create a list you have to always update two pointers
 (the "->next" and pointer to the first/last item).

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
