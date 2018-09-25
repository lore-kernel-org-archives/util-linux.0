Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbeIYR3a (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Sep 2018 13:29:30 -0400
Date: Tue, 25 Sep 2018 13:22:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: don't put the VC into canonical mode
Message-ID: <20180925112223.jbxhydzmjsdovdsv@ws.net.home>
References: <20180924101535.511758-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180924101535.511758-1-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 24, 2018 at 12:15:35PM +0200, Lubomir Rintel wrote:
> -	if ((options.flags & F_VCONSOLE) == 0) {
> -		/* Finalize the termios settings. */
> +	/* Finalize the termios settings. */
> +	if ((options.flags & F_VCONSOLE) == 0)
> +		reset_vc(&options, &termios, 1);
> +	else
>  		termio_final(&options, &termios, &chardata);

This completely changes logic of the code and removes termio_final()
from serial-line code path. Is it expected change? I don't think so.

> -		/* Now the newline character should be properly written. */
> -		write_all(STDOUT_FILENO, "\r\n", 2);
> -	}
> +	/* Now the newline character should be properly written. */
> +	write_all(STDOUT_FILENO, "\r\n", 2);

Why we need to always write \r\n ?

Maybe all you need is

    if ((options.flags & F_VCONSOLE) == 0) {
        termio_final(&options, &termios, &chardata);
        write_all(STDOUT_FILENO, "\r\n", 2);
    } else
        reset_vc(&options, &termios, 1);


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
