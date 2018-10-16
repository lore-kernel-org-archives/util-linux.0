Return-Path: <SRS0=SH8e=M4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18A4C04EBF
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A902208B3
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A902208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJPOSj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:18:39 -0400
Received: from shell.v3.sk ([90.176.6.54]:50683 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbeJPOSj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Oct 2018 10:18:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 43E81BD751;
        Tue, 16 Oct 2018 08:29:43 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bPZmsiZkvj7h; Tue, 16 Oct 2018 08:29:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 02526BD755;
        Tue, 16 Oct 2018 08:29:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id apfsX1ox-6TP; Tue, 16 Oct 2018 08:29:39 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 40757BD751;
        Tue, 16 Oct 2018 08:29:39 +0200 (CEST)
Message-ID: <fc48ac33ea6a2babeb4a322af4881b8fa8761bba.camel@v3.sk>
Subject: Re: [PATCH] agetty: don't put the VC into canonical mode
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Tue, 16 Oct 2018 08:29:37 +0200
In-Reply-To: <20180925112223.jbxhydzmjsdovdsv@ws.net.home>
References: <20180924101535.511758-1-lkundrak@v3.sk>
         <20180925112223.jbxhydzmjsdovdsv@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 2018-09-25 at 13:22 +0200, Karel Zak wrote:
> On Mon, Sep 24, 2018 at 12:15:35PM +0200, Lubomir Rintel wrote:
> > -	if ((options.flags & F_VCONSOLE) == 0) {
> > -		/* Finalize the termios settings. */
> > +	/* Finalize the termios settings. */
> > +	if ((options.flags & F_VCONSOLE) == 0)
> > +		reset_vc(&options, &termios, 1);
> > +	else
> >  		termio_final(&options, &termios, &chardata);
> 
> This completely changes logic of the code and removes termio_final()
> from serial-line code path. Is it expected change? I don't think so.

Of course, you're right -- the conditional is reversed. I'll follow up
with a v2.

> 
> > -		/* Now the newline character should be properly written. */
> > -		write_all(STDOUT_FILENO, "\r\n", 2);
> > -	}
> > +	/* Now the newline character should be properly written. */
> > +	write_all(STDOUT_FILENO, "\r\n", 2);
> 
> Why we need to always write \r\n ?

I honestly have no idea. By switching to the vconsole to non-canonical
mode as well, I just stopped getting a newline after typing a login:

  xo login: lkundrakPassword:

I just thought it was sort of expected to get the same behavior as on
serial lines and removed the special case.

> Maybe all you need is
> 
>     if ((options.flags & F_VCONSOLE) == 0) {
>         termio_final(&options, &termios, &chardata);
>         write_all(STDOUT_FILENO, "\r\n", 2);
>     } else
>         reset_vc(&options, &termios, 1);

Yes (but with the write_all(\r\n) common for both serial and vc).

> 
> 
>   Karel

Thanks,
Lubo

