Return-Path: <SRS0=ZB3I=DH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90CEC4727C
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999B120708
	for <util-linux@archiver.kernel.org>; Wed, 30 Sep 2020 18:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaPHQeo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgI3StV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Sep 2020 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3StV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 30 Sep 2020 14:49:21 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EFCC061755
        for <util-linux@vger.kernel.org>; Wed, 30 Sep 2020 11:49:21 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so1477452qvb.0
        for <util-linux@vger.kernel.org>; Wed, 30 Sep 2020 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LYJRb37ZsvLGpkRZz1gmpxDvxYInjaIw2My3BRtyRNQ=;
        b=oaPHQeo4kbC+LkljuEitruYR1V0ty47jInRExNRdQPxgR5K10UimQEwotmIOxHLX0p
         ddMVLkMmMEU22ygEv60n76uM+iiddJ+2W1y0psb4iQccdiXIq4FwDLjzYyxUG3AiZrGA
         71d/l8XrIJUaqS2UsJg1Jyf/yiUUh32LVQ7QRg+Ip9zqZL648bKeTgtgCqEXm5sXILpu
         nS+wIfdu4Ll4Lmh/HBr8QjITy+fGGKYh4KNSF2t9umNM3qMtg/Zcd+svd3qHbEsMZ5Qn
         m/My/RHwAWwFUcRGE3dtA72pbHsoeMbgfWVRejrgll17bRgVPYQIyLsZiMJj1KsRBaSS
         HG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LYJRb37ZsvLGpkRZz1gmpxDvxYInjaIw2My3BRtyRNQ=;
        b=FPBU8UVVRBXqSSBVMNPI9ScS/1tYyCsPN31sE/jdpo96ByhdEPX0htwoPPW01P8w7Y
         SQ+1+huA9nQzZ2dTOqR1lMoTTwXIvDb83NGjX+Css/vCs1e6Vz/rpmeoZzzzHKeYQhVp
         bUtbxcWBs340PqpG/KanDpaJh5xcb3MFxDVZds/qswftijlLLslY/y0rHymXTGJz0xgz
         0xdcqrdYlDAI4PJ1pheEsYOJrJxhR51/ZiQrKeT6BACXWNVEP3HV849kP1Msfa1M3WGQ
         Q/6+xjMDSXUvWt4XQAqGj0P89w5t/LMYC5PHPBAkyhjibRa5gncDxfWRLgJ8hRNn4psg
         EU/g==
X-Gm-Message-State: AOAM532JQ+UyERDs8xdk2fYDsZtGx12naoiVkI4QSkzg1tjqzQiiJZ/U
        L+viIHQ026oek6LnCZercQ==
X-Google-Smtp-Source: ABdhPJyD9GRQOKbjHZ2MwooOMDE92jy/GGm/UpzoUna5GsSNIdnIabKFcWmTzeE5KLUuXozYuK2yCw==
X-Received: by 2002:a0c:b2ce:: with SMTP id d14mr3868487qvf.40.1601491760212;
        Wed, 30 Sep 2020 11:49:20 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id l26sm3076151qki.62.2020.09.30.11.49.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 11:49:19 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:49:17 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Jeffrey Bastian <jbastian@redhat.com>,
        Shunsuke Nakamura <nakamura.shun@jp.fujitsu.com>,
        util-linux@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20200930184917.z7sx7xxazhdkumvy@gabell>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930174027.rohdyp2kubitbs24@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Jeffrey and Karel,

On Wed, Sep 30, 2020 at 07:40:27PM +0200, Karel Zak wrote:
> On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
> > On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
> > > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura wrote:
> > > >  sys-utils/lscpu-arm.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > 
> > > Applied, thanks.
> > 
> > 
> > With the other ARM patch applied ("use SMBIOS tables on ARM for lscpu"),
> > the output changes on an FX700 system:
> > 
> > [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> > Vendor ID:                       FUJITSU
> > Model:                           0
> > Model name:                      461F0010
> > Stepping:                        0x1
> > 
> > 
> > The values here come from the SMBIOS Type 4 record:
> > 
> > [root@fujitsu-fx700 ~]# strings /sys/firmware/dmi/entries/4-0/raw
> > CPU1
> > FUJITSU
> > 461F0010
> > 8K083MH14
> > 
> > 
> > This FX700 system has firmware revision 1.4.0 (Jun 17 2020).
> 
> hmm... 461F0010 does not seem user-friendly, "A64FX" seems better. 
> 
> Shunsuke, what about to update the firmware strings? ;-) (as Jeffrey
> suggested in RH bugzilla)
> 
> The another possibility is to exclude some vendors and do not use
> SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
> SMBIOS based solution is more elegant and ready for new CPU types than
> in-lscpu hard coded tables.

According to SMBIOS specification, the description of Processor Version (Type4)
is "String number describing the Processor". It shows the version number of
the processor, not a model, like as A64FX and Cortex-A72 and so on.
So I think we should not use the Processor Version as the modelname...

As far as I can see, there's no useful information in SMBIOS to show the
modelname, so I suppose we should continue to use id_part structures in lscpu-arm.c.

As for Processor Version, how about using lscpu_desc.rversion or adding a new
member to lscpu_desc to show the version?

Thanks,
Masa
