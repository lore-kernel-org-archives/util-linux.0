Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4AC43331
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF8220714
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 01:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCZBAX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:00:23 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:35899 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgCZBAX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2020 21:00:23 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 21:00:22 EDT
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D381B5612D2
        for <util-linux@vger.kernel.org>; Thu, 26 Mar 2020 01:55:06 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id b22so2018756pgb.6
        for <util-linux@vger.kernel.org>; Wed, 25 Mar 2020 17:55:06 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3DzxWgpampvuQnrOWI9Di9L3BHpUhY6ky5h60lgdoqK54ZA3Ij
        8dHmxU2nj76DyByDhyX3xTxY1Gg3OrhDG8fXyVg=
X-Google-Smtp-Source: ADFU+vtJtCX/ZsgRcKKcMNjiHJW/u6wdCI8Bk0+0+yX++SQIk0zNcQ2pLmGNAHgYx3nUbWVCyNk4sn8fbU6jEjiBW/0=
X-Received: by 2002:a62:18cf:: with SMTP id 198mr6370579pfy.277.1585184105025;
 Wed, 25 Mar 2020 17:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212625.6934-1-orel@melix.net> <20200325111049.jypz2csy2hqxoegr@ws.net.home>
In-Reply-To: <20200325111049.jypz2csy2hqxoegr@ws.net.home>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Thu, 26 Mar 2020 01:54:53 +0100
X-Gmail-Original-Message-ID: <CAA0A08Vj3Kdfa2ny9hiknosSZ-Auzz7zeCCcchiH5_EHRLNN-Q@mail.gmail.com>
Message-ID: <CAA0A08Vj3Kdfa2ny9hiknosSZ-Auzz7zeCCcchiH5_EHRLNN-Q@mail.gmail.com>
Subject: Re: [PATCH] libuuid: improve uuid_unparse() performance
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Mar 26 01:55:07 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 25, 2020 at 12:11 PM Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Mar 24, 2020 at 10:26:25PM +0100, Aurelien LAJOIE wrote:
> > There is 2 improvements:
> >
> >  * remove useless uuid_unpack,
> >  * directly print the hexa format from memory without using printf
> >    we can do this as the bytes order is the network byte order
>
> I'm not sure, but are you sure that whole UUID is in big-endian order?
> I think that last part (aka "node", 6 bytes) is not subject to swapping.
> It seems uuid_unpack() does nothing with the last part of the UUID.
>
> But your patch works on LE as well as on BE, so I probably miss
> something :-)
The RFC is quite clear on this "with each field encoded with the Most
Significant Byte first"
https://tools.ietf.org/html/rfc4122#section-4.1.2

I agree this is not clear for the node part
>From the RFC node should be an unsigned 48 bit integer

The parsing is done byte per byte
        for (i=0; i < 6; i++) {
                buf[0] = *cp++;
                buf[1] = *cp++;
                uuid.node[i] = strtoul(buf, NULL, 16);
        }
Then the sprintf is also done byte per byte.
So Big Endian and the swapping are hidden by the manipulation byte per byte
I cannot find any usage of the node field to set specific value only random.
As long the node is handled byte per byte it will work.

>
> > before took 382623 us
> > after  took  36740 us
> >
> > Big Endian OpenBSD:
> > before took 3138172 us
> > after  took  180116 us
>
> I guess all this is about sprintf(), another way would be to use
> uuid_unpack() but avoid sprintf().

Using uuid_unpack to fill a struct uuid, will trigger to handle the
endianness to print it
whereas uuid_t is matching the order needed to print it.
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

