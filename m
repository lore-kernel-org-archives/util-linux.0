Return-Path: <SRS0=+DDw=DB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D7C4363D
	for <util-linux@archiver.kernel.org>; Thu, 24 Sep 2020 01:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 146D02137B
	for <util-linux@archiver.kernel.org>; Thu, 24 Sep 2020 01:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725273AbgIXBgs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Sep 2020 21:36:48 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39927 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXBgr (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Sep 2020 21:36:47 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 21:36:47 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 521B0E11;
        Wed, 23 Sep 2020 21:26:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 23 Sep 2020 21:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        yQev0nZMKbAjX2H9B8s1XVPp+Wly6tHkdNB2FFmVtwA=; b=YquiabsOKfONou6h
        vOVBAbSzjvOS2pLsn7gsTrqNxOur+0OGLJ98uSV79vQ6zbscuenhECm2zzmpKppq
        eLUK02GRqfkiL3MFNiNIIQa4awoD06zFDaAw+a5KW0MK2/T2w70fhhsmdSItnQ70
        J8Mu2OE3OFEDU+F8YrJBnPAtXD081nRIaS1bLdRsLg/Pl2O9m6/Owy38CYH0uylj
        W7qf8r2CQ4Q1g5IA4DBIAQgd84oz8tQpxLfEX5w6z4T6VuFCivshzI9z40/yTnJ6
        QkqOh8COh2PS9YlEpCuJJW6ItAbZEnXtHolrQ7rVZkTlsrvAUaB0A/lrEdEnZoup
        kQSdAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=yQev0nZMKbAjX2H9B8s1XVPp+Wly6tHkdNB2FFmVt
        wA=; b=P/UrCQ951Aa/R0xkVQnYw3WxzfBiYnye5HtREiVb9PC9jewWadripkH3o
        2s9DtiGQnp9J86FZ/mgXoN0OL79sJi8Z2Cb4Aj7BiiXMkXXu+8mtIulm0VinHrM9
        LwgNSM7X/RIEYN5eKnBgJ/wmHbloOT2p4Ms5+764l//K0pPFL34xUqsvLlIdK9NU
        4W8aRJKul7MEMZcfpbqqwlX/MNQQPyiksHbKPX6EgodNSIWo9O3VKmYaHCjBeUMX
        DHrJfuvyfO9fiRTWNKlPSHuLTot9ttxbF/h2D4G4fz0L6M19MLypUY0mYOmdSMOb
        E5aUpYf57gfe5PLAA3s+3LIWwNNZA==
X-ME-Sender: <xms:0_VrXyk3iQ8gIUY3XiYeShzv8i2kWL_vTqfNFv1iDP0Z_-BiRjAzgg>
    <xme:0_VrX51uvZQ6RQVtqJ3QvwluHVG_5aF7ToC6Rg3Ft689cl86hEBaesqiXZo6dqdUA
    VRRxAg8BloO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepke
    ekjeeiieeigeevvddvjeejgeefffelkedukeegvddugeegvefgkedvhfdvleefnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddtiedrieelrddvheegrdduhedtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgv
    nhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:0_VrXwp_JZwKj6jjQcw0TAkaJcyFIWHCFg_zAq630VOyLMnKxnxv-w>
    <xmx:0_VrX2l_NTqOMiIUZc0b3kJUvucATEgP0TouLjUmxnW7TnUthuCTZA>
    <xmx:0_VrXw1aT5iZlDU8kBVl_mq_aiyOVmWwRR8hdk5wQ_dyzGSk7ge2Zw>
    <xmx:0_VrXxj4k8MNATeuB5IfRyg8y2AjrYtgoLAGxnVxfG_6jXIR5_unbA>
Received: from mickey.themaw.net (106-69-254-150.dyn.iinet.net.au [106.69.254.150])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37F833064685;
        Wed, 23 Sep 2020 21:26:41 -0400 (EDT)
Message-ID: <598289c5e236bca151f673bc4846459ce71ac430.camel@themaw.net>
Subject: Re: mountbomber -- generate mount load
From:   Ian Kent <raven@themaw.net>
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc:     Michal Sekletar <msekleta@redhat.com>
Date:   Thu, 24 Sep 2020 09:26:37 +0800
In-Reply-To: <20200923110554.agy6xevx3ll6uqh7@ws.net.home>
References: <20200923110554.agy6xevx3ll6uqh7@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2020-09-23 at 13:05 +0200, Karel Zak wrote:
>  Hi,
> 
> I have created an experimental testing tool to generate a large
> number of
> mount/umount operations on a large number of mount points. The
> important feature
> is that it does not use standard mount(8) command and it does not
> parse
> anything in /proc. 

This sounds great for testing large mount table and high notification
rates.

I'll certainly give a a spin as soon as I can get back to that systemd
change for high notification rate handling, I've had trouble with
various distractions lately unfortunately.

Thanks Karel.

> 
> The goal is to have a standard tool to easily reproduce mount load
> without
> writing a custom shell scripts.
> 
> The number of features is pretty basic and it supports only tmpfs
> now. Maybe
> later it will support other filesystems, regular block devices (or
> loopdevs)
> and more operations (like remount, execute scripts, etc.). We will
> see ...
> 
> The tool creates and cleanup all stuff, you do not have create
> mountpoints, etc.
> 
> It's maintained in separate branch in util-linux repository:
> 
>   git clone https://github.com/karelzak/util-linux.git --branch
> topic/mountbomber --single-branch
>   cd util-linux
>   ./autogen.sh
>   ./configure
>   make mountbomber
> 
> 
> Examples:
> 
> 
>   # mountbomber --parallel 1 --verbose \
>                 --oper "mount:all,@A,umount:rand,mount:last,-
> >A(loops=2),umount:all"
> 
>   - one process, 100 mountpoints (default), random umount and mount
> two times
> 
> 
>   # mountbomber --verbose --pool 10 \
>                 --oper
> "mount:all,@A,umount:next,mount:last,delay(500000),-
> >A(loops=200),umount:all"
> 
>   - 200 times umount and mount in order
> 
> 
>   # mountbomber --pool 10000 \
>                 --oper
> "mount:all,@A,umount:rand,mount:last,delay(1000),-
> >A(seconds=60),umount:all"
> 
> 
>    - 10 processes (default) repeating random umount/mount for 1
> minute on 10000 mountpoints
>    - your udisks will be pretty busy :-)
> 
> For more details:
> 
>   $ mountbomber --help 
> 
> there is no man page yet.
> 
> 
>     Karel
> 

