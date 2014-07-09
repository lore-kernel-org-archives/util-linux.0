Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55688 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752301AbaGIN3Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 09:29:16 -0400
Message-Id: <1404912546.1512.139736225.71C7CA63@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAG27Bk3niwrfc1oW9DfSvxZ2tV3Y=ZXEi1Wb+61AXOBYS_jmWw@mail.gmail.com>
References: <1404765295.16902.139036593.3B689FEB@webmail.messagingengine.com>
 <CAG27Bk3niwrfc1oW9DfSvxZ2tV3Y=ZXEi1Wb+61AXOBYS_jmWw@mail.gmail.com>
Subject: Re: small problem with kill --queue
Date: Wed, 09 Jul 2014 15:29:06 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi Sami,

On Tue, Jul 8, 2014, at 00:39, Sami Kerola wrote:
> Right. I am not sure did I mess up or someone else earlier when
> --queue was introduced.

It looks like you made the mistaken change four months ago,
in commit 9e8dffd5cd29f03029b1ac99eecb129532ca5c0f.

> Which way ever that was now when I look
> sigqueue(3) manual page your change proposal makes sense. Please have
> a look of the change below, that I hope to get reviewed before the
> final v2.25 is out. [...]
>
> +The
> +.B \-\-queue
> +should be combined with
> +.BI \-\-signal " signal"
> +when other than a SIGTERM is wanted to accompanied with
> +.IR sigval .

I don't think it's necessary to explain again that wanting to send any
other signal than TERM requires the --signal option; this is already at
the top of the page.

Also, thinking again, this word "sigval" looks far too similar to "signal",
it would be much clearer to use the plain word "value" instead.  So my
upcoming patches for the usage text and man page use that instead.

> + ctl->sigdata.sival_int = strtos32_or_err(arg, _("argument error"));

Maybe "argument of --queue must be an integer" instead?

My patch to kill.c also improves the error message when the
signal name or number cannot be interpreted.  Currently:

./kill --sigmal HUP foobar
kill: invalid sigval argument

Huh?

New:

./kill --sigmal HUP foobar
kill: invalid signal name or number: -sigmal

Ah, typo.

Benno

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are

