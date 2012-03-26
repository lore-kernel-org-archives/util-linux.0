Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:54519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab2CZHUe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Mar 2012 03:20:34 -0400
Date: Mon, 26 Mar 2012 09:20:26 +0200 (CEST)
From: "mail@bernhard-voelker.de" <mail@bernhard-voelker.de>
Reply-To: "mail@bernhard-voelker.de" <mail@bernhard-voelker.de>
To: Karel Zak <kzak@redhat.com>
Cc: Simon de Vlieger <simon@ikanobori.jp>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Message-ID: <917665944.185472.1332746426227.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <20120323171936.GH2040@x2.net.home>
References: <4F6B13F9.4020108@bernhard-voelker.de> <20120323171936.GH2040@x2.net.home>
Subject: Re: [PATCH] hexdump: adjust -s and -n option in the man page [was:
 hexsyntax.c using strtol on the offset parameter]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

 Karel Zak wrote:
> > From: Bernhard Voelker <mail@bernhard-voelker.de>
> > Date: Thu, 22 Mar 2012 12:53:06 +0100
> > Subject: [PATCH] hexdump: adjust -s and -n option in the man page
>
> Good point, I have copied the text we already have in the losetup man
> page.
>
> +The \fIlength\fR and \fIoffset\fR arguments may be followed by binary
(2^N)
> +suffixes KiB, MiB, GiB, TiB, PiB and EiB (the "iB" is optional, e.g. "K"
has the
> +same meaning as "KiB") or decimal (10^N) suffixes KB, MB, GB, PB and EB.

Thanks.

I have derived my patch proposal from the info pages of coreutils, as there
has recently been a discussion about the clearest wording.
I don't think all users are aware what's the difference between
"binary (2^N) suffixes KiB" and "decimal (10^N) suffixes KB".

BTW: why omitting the Z and the Y suffix in the man page?

Have a nice day, Berny
