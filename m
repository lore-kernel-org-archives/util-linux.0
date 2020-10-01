Return-Path: <SRS0=Tjs2=DI=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C2C4363D
	for <util-linux@archiver.kernel.org>; Thu,  1 Oct 2020 03:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66E821D7F
	for <util-linux@archiver.kernel.org>; Thu,  1 Oct 2020 03:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYdRLHye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgJADFX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Sep 2020 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJADFX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 30 Sep 2020 23:05:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C8C061755
        for <util-linux@vger.kernel.org>; Wed, 30 Sep 2020 20:05:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so3202310qtv.12
        for <util-linux@vger.kernel.org>; Wed, 30 Sep 2020 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pl5yE7ziKklcb5men9lED6/hby59IrXFT8oehi+CYbo=;
        b=oYdRLHyewRzGQpVWycwR7fAEA2LSl+MFJCBFZ5TZhPbnVmj8hXg8g2VX9MPaZxhUnA
         XbsqDrYP42X0mVg4E+RUceQVC1VXZK6hJA4S1aU7l/w6SNJ3OWxAqxRBC2gH4loIyXDT
         5kS6Z5AHTo2RS6D9r6IqkE0JjNQ6TR6qTq3N3TQUAkgNVbTou855WsHfLt1eDRaGREEu
         p/ZMqQPBJlbtROfw23f0DRTO5dtggBHL+AcLs5jO0xVebEffFoIvVkn5n6QRENMi2xZ0
         jP0MVJkZIiDCKJmw464t4D+8srGDo2AA32fCTG8pVP8Q1esRzOUZ5Fj+52b468HjwINP
         0h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pl5yE7ziKklcb5men9lED6/hby59IrXFT8oehi+CYbo=;
        b=S9BVu4KqvoC0S0mxRbN9wBwxUCYL3hxEoeBnMK9PZTd2clWrO4L5SIEZDgpt4ufBDe
         lvRgRVr5F51z/oFz/3Ogq9+S6CIsIrHvYk5wRaHfMGqJ6qNtYdgfqTyQh4NPo2etrPmW
         u+yiZ4gpSXabkeTdLY9wSJvaCdQfNb+rgbeyoFYGP69bnyLI2I76tyD+3ex1PFZh15Ew
         J5R3tSD8bPCXk3+j9CA64ISyoMY286qcj66qDx+GjkGQC35ix7mY+R8euESa5ihdcS82
         FfOXO61pMq3X043yWmF4kGbLhAAXUBejMmHTHCeo+MJms8CcqQG/dCZs/JqT34axAGu0
         AYiA==
X-Gm-Message-State: AOAM532nrHEPESaoJn9kMASYaF8uORisHH5PbBrRt1mAnjcBn8ywMyv3
        99CQuUWxHBQYY6RJTkBy6dC8jrqEbw==
X-Google-Smtp-Source: ABdhPJz4FsymB5QR6J52KqsCZ0dqFRpGMGYAdx8I8CCJfEaKHx8cX0nseIMzjtUH2zAnDsTMPYZrcg==
X-Received: by 2002:ac8:4998:: with SMTP id f24mr5764785qtq.276.1601521522230;
        Wed, 30 Sep 2020 20:05:22 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id e58sm5051480qtc.92.2020.09.30.20.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 20:05:21 -0700 (PDT)
Date:   Wed, 30 Sep 2020 23:05:19 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Jeffrey Bastian <jbastian@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        util-linux@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20201001030519.6d65sqhd54oxmlic@gabell>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 30, 2020 at 04:53:34PM -0500, Jeffrey Bastian wrote:
> On Wed, Sep 30, 2020 at 02:49:17PM -0400, Masayoshi Mizuma wrote:
> > Hi Jeffrey and Karel,
> > 
> > On Wed, Sep 30, 2020 at 07:40:27PM +0200, Karel Zak wrote:
> > > On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
> > > > On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
> > > > > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura wrote:
> > > > > >  sys-utils/lscpu-arm.c | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > Applied, thanks.
> > > >
> > > >
> > > > With the other ARM patch applied ("use SMBIOS tables on ARM for lscpu"),
> > > > the output changes on an FX700 system:
> > > >
> > > > [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> > > > Vendor ID:                       FUJITSU
> > > > Model:                           0
> > > > Model name:                      461F0010
> > > > Stepping:                        0x1
> > > >
> > > >
> > > > The values here come from the SMBIOS Type 4 record:
> > > >
> > > > [root@fujitsu-fx700 ~]# strings /sys/firmware/dmi/entries/4-0/raw
> > > > CPU1
> > > > FUJITSU
> > > > 461F0010
> > > > 8K083MH14
> > > >
> > > >
> > > > This FX700 system has firmware revision 1.4.0 (Jun 17 2020).
> > > 
> > > hmm... 461F0010 does not seem user-friendly, "A64FX" seems better.
> > > 
> > > Shunsuke, what about to update the firmware strings? ;-) (as Jeffrey
> > > suggested in RH bugzilla)
> > > 
> > > The another possibility is to exclude some vendors and do not use
> > > SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
> > > SMBIOS based solution is more elegant and ready for new CPU types than
> > > in-lscpu hard coded tables.
> > 
> > According to SMBIOS specification, the description of Processor Version (Type4)
> > is "String number describing the Processor". It shows the version number of
> > the processor, not a model, like as A64FX and Cortex-A72 and so on.
> > So I think we should not use the Processor Version as the modelname...
> 
> Hello Masa,
> 
> I think I see your confusion because I was also confused by the wording
> of the SMBIOS spec.  In this case, "String number" means the number of
> the string appended to the Type 4 record, not a version number of the
> processor.
> 
> See section 6.1.3, "Text strings", of the SMBIOS spec (version 3.4.0).
> 
> For Type 4, there can be up to 6 strings appended to the table:
>   Offset 0x04: Socket Designation
>   Offset 0x07: Processor Manufacturer
>   Offset 0x10: Processor Version
>   Offset 0x20: Serial Number
>   Offset 0x21: Asset Tag
>   Offset 0x22: Part Number
> 
> Each string is optional.  If the byte at one of the above offsets is 0,
> that means the string is not included.  If the byte is non-0, it means
> refer to the first or second or third (or so on) string appended to the
> table.  It's this non-0 number that the spec calls "String number".

Ohh... thank you for pointing it out! I misunderstood about "String number".

> 
> Example:
> 
> A Type 4 record that only defined Processor Manufacturer and Processor
> Version would therefore look like:
>   Offset 0x04: 0x00
>   Offset 0x07: 0x01
>   Offset 0x10: 0x02
>   Offset 0x20: 0x00
>   Offset 0x21: 0x00
>   Offset 0x22: 0x00
> 
> The text of each string is free form.  Most vendors have chosen to use
> Processor Manufacturer as the CPU vendor, and Processor Version as a
> text description of the CPU.
> 
> Some examples from existing servers (copy/paste from the other thread):
> 
> [root@hp-m400 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> Vendor ID:                       AppliedMicro
> Model:                           1
> Model name:                      X-Gene
> Stepping:                        0x0
> 
> [root@lenovo-hr330a ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> Vendor ID:                       Ampere(TM)
> Model:                           2
> Model name:                      eMAG
> Stepping:                        0x3
> 
> [root@hpe-apollo-70 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> Vendor ID:                       Cavium Inc.
> Model:                           1
> Model name:                      Cavium ThunderX2(R) CPU CN9980 v2.1 @ 2.20GHz
> Stepping:                        0x1
> 
> 
> Therefore, I believe you are free to change the string "461F0010" to
> "A64FX" in the SMBIOS Type 4 record of the FX700 and FX1000 servers'
> firmware.

Thanks, I got the most vendors put their CPU model name to Processor Version,
however it depends on the vendor, right..? That's because the SMBIOS specification
says just "String number describing the Processor", so vendors can put any strings
to describe the own processor, like "461F0010"...

But I don't have strong opinion about the Processor Version of A64FX,
let's wait for Shunsuke's comment.

Thanks,
Masa
