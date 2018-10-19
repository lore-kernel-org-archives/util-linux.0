Return-Path: <SRS0=K1B8=M7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F090ECDE43
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 13:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE4F21479
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE4F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeJSVzC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:55:02 -0400
Received: from shell.v3.sk ([90.176.6.54]:39348 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbeJSVzB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Oct 2018 17:55:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1166FBDCC0;
        Fri, 19 Oct 2018 15:48:46 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bz_thkxvjB63; Fri, 19 Oct 2018 15:48:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 391E7BDDC5;
        Fri, 19 Oct 2018 15:48:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGe3OggP2cxT; Fri, 19 Oct 2018 15:48:42 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id DA5A2BDCC0;
        Fri, 19 Oct 2018 15:48:41 +0200 (CEST)
Message-ID: <0d9d07b6b3f45e069fefa4e9e008822a3aa7a135.camel@v3.sk>
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stanislav Brabec <sbrabec@suse.cz>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Fri, 19 Oct 2018 15:48:40 +0200
In-Reply-To: <cc6f95bb-6dc6-cb34-fb7e-505da29e61f1@suse.cz>
References: <20181016064149.2698-1-lkundrak@v3.sk>
         <20181016074053.dea6ydle26y37uva@ws.net.home>
         <52ebddaca50ed8d5f498bdf56b02ae4640af369a.camel@v3.sk>
         <cc6f95bb-6dc6-cb34-fb7e-505da29e61f1@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, 2018-10-19 at 15:08 +0200, Stanislav Brabec wrote:
> Dne 19. 10. 18 v 8:09 Lubomir Rintel napsal(a):
> > On Tue, 2018-10-16 at 09:40 +0200, Karel Zak wrote:
> > > On Tue, Oct 16, 2018 at 08:41:49AM +0200, Lubomir Rintel wrote:
> > > > Seems like zero lflags do the job just fine on a Linux VT. Reset it
> > > > to
> > > > canonical mode before running login.
> > > 
> > > What about Del/Backspace keys when user is typing login name? :-)
> > 
> > They seem to work the same as they used to?
> > 
> > From Stanislav's message I notice that there's supposed to be some
> > problem with them -- I'm not seeing that. Either the patch does
> > something different or I'm not looking at the right thing.
> > 
> > (I haven't looked at Stanislav's patch -- but I surely intend to give
> > it a try.)
> I am writing about non-canonical mode.

Yes, so am I.

> It was partially used in past.
> 
> Now agetty uses canonical mode. It handles Backspace by itself, but it
> makes impossible to implement "stop reloads when at least one character
> is entered". So we will have to switch to a non-canonical mode.

I've submitted a patch that does that, and my understanding is that so
did you (I didn't yet take a look -- sorry. I definitely intend to).

I just remarked that I haven't noticed a problem with character erase.
I have no idea why.

Lubo

