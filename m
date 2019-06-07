Return-Path: <SRS0=EPkY=UG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A3FC2BCA1
	for <util-linux@archiver.kernel.org>; Fri,  7 Jun 2019 10:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB39206BB
	for <util-linux@archiver.kernel.org>; Fri,  7 Jun 2019 10:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjaqeO/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfFGKai (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 7 Jun 2019 06:30:38 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35754 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfFGKah (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 7 Jun 2019 06:30:37 -0400
Received: by mail-io1-f50.google.com with SMTP id m24so1021798ioo.2
        for <util-linux@vger.kernel.org>; Fri, 07 Jun 2019 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gortq56mf/clj+0klwKYAs2FTTVYRaJsK3MTEdoJAw=;
        b=KjaqeO/4T2icXMWmi8f4DO6eJhJRIFgn5YX9F9SWYF+JmlESazGYxm1AmDpfoMdglJ
         DqgjKNAYxlU6X/tnq3xjBEICvbr7x/Q0mHCL2e3unAHz+9IMEAqw1StSlrpUM+1Jd59w
         oYrpkjW4DeLuYTDqxiBbjUXg4bNOGJzJB1tLDI9b5p4a9BTLa2zZZyytyCg3SEkMPRAm
         AwqEUTGY3RApoq3w5Jn60U9kIDsNvgGsCEleI7Etn5FLqS1mHYQV14R7BGezshiHc8/J
         wsMNq7iGLUsE8LOFVFEUiwXHY6hhxVfO8hagH6dWM/lAhnAsJWvy2EtgKbnvHOXmpV2p
         FsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gortq56mf/clj+0klwKYAs2FTTVYRaJsK3MTEdoJAw=;
        b=M3QK9FSD92KKbD3Tnkxpq7CAwEkT9UMrSyTb5zcWyFMGp5911UY8DjN8p0/jef5Xe9
         gcLCIUjP2hLS3D9rYZ8bPkjuRCbSCQMzlBMMpj8gh+im1zzhtY9HZmOpeKLln4Rrk2Pa
         ZtWOPlIcOwFFjfD2rNmCjgkuX3xsoZ5YEH17M0wviU/tUBd43XUF7XDACNi2dKJrxuio
         VMwbS4X5USrz+KapBaQvntxZ+6yXKOvaLTOwu5Nl5eDLFPR+jPguOzC96G2zckqPeg6Z
         YT9IweYdOOzbGfrcyjFyQlxhwhdU6mBIO2u5We4pxzIgsEcIyywpsclj9it2rJnOhxOE
         PPcg==
X-Gm-Message-State: APjAAAV/5VVd4iaDzBLzag61yW265OnQZjl3GdaV2QlYKJcTGXFFwKaG
        A6Y2g4qwFfqX/G1djoOWAtXtNkHRdXDyJkQdycFZ7TQ+
X-Google-Smtp-Source: APXvYqwNb7XY4ScdaZQiZmAjPwUITM9vbjtYuovnf/YtL/mEI+c77Iye9p7uk+Ta+bncH+NSD3m8HY1GO/vaeQ1l2kA=
X-Received: by 2002:a5e:c605:: with SMTP id f5mr4439131iok.78.1559903436939;
 Fri, 07 Jun 2019 03:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANOoOjvoz4q32tphKo-HwCmNLpugb8DvfSkzkToXRqpwVkve2Q@mail.gmail.com>
 <20190607071749.kf2ucex6b7y3btcx@ws.net.home>
In-Reply-To: <20190607071749.kf2ucex6b7y3btcx@ws.net.home>
From:   Dan MacDonald <allcoms@gmail.com>
Date:   Fri, 7 Jun 2019 10:30:26 +0000
Message-ID: <CANOoOjs4qwNSfVvAGkPk5nW43Ae6oyUOqH9s_ZfEPPkiR4brag@mail.gmail.com>
Subject: Re: lsblk full disk id output column
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel

On Fri, Jun 7, 2019 at 7:17 AM Karel Zak <kzak@redhat.com> wrote:
> Not sure what you mean with ID in this case.
>
> Try
>     lsblk -o+MODEL,WWN
> or
>     lsblk -o+MODEL,SERIAL
>
> maybe we can add SERIAL-LONG, because udev differentiate between
> SERIAL and SERIAL_SHORT (used by lsblk), and it's MODEL+SERIAL.

Neither of those commands provide the output I want.

>
> See also
>
>     udevadm info /dev/sda

That command does though, on my current laptop it prints

S: disk/by-id/ata-Samsung_SSD_840_EVO_250GB_S1DBNSBD945982B

As part of its output and that's exactly the sort of ZFS-friendly
device name I require and was hoping to get from lsblk.

I had never heard of or used udevadm until you mentioned it but it
serves the purpose of translating "regular" Linux disk device names
into their ID equivalents.

Thanks!
