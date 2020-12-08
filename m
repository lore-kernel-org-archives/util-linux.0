Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC7C433FE
	for <util-linux@archiver.kernel.org>; Tue,  8 Dec 2020 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A46F23A9B
	for <util-linux@archiver.kernel.org>; Tue,  8 Dec 2020 10:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgLHKVd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:21:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728050AbgLHKVc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 8 Dec 2020 05:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607422806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvgrtJBKUZd1rNfq7NNZJNu2wS4s2XR419bDn9+sPiU=;
        b=gzyU+uBhlNZFPCENYR6gCq536laiwtFcQSANyficskKWWmFoeLv80KL/8aztHyR9RTCivk
        Foh4C+SuoZRyKbibbX3bg5i4vbmIwQWBCdr4e5Ji6CbsvauT7rt0htV21B3RsFIqyY8M0j
        B8R+sRFebcjlyGtqkhlyUV/kC8zNFnM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-bL8wUzmGPlCQx9M146fepg-1; Tue, 08 Dec 2020 05:20:04 -0500
X-MC-Unique: bL8wUzmGPlCQx9M146fepg-1
Received: by mail-pf1-f200.google.com with SMTP id k17so7625502pfu.21
        for <util-linux@vger.kernel.org>; Tue, 08 Dec 2020 02:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvgrtJBKUZd1rNfq7NNZJNu2wS4s2XR419bDn9+sPiU=;
        b=EF/+xMYdZ3cCCiAoprM6v+upPQv1axDxFfAS/FIQea0nf+JGSpxqdoZksXzl0h97EA
         SG2i9Ej7BCrNK+JZp7ix/u2x5r5Fijtv6EI4mxvm5Gf9kxqpGOIK2yfOeAzJC8GnWAA/
         NUPQ3aAqO+joP5qpJgE1hUihRDXicD/QXyHnjg5JldwqOy9TcyMPFFe9v+YwcBvrsSgo
         QjEnhLDHXPpHG8vbOxGt+OoKdYKSRgz0XCtn0BHuGKB0jmz5EFGiKr3qqH1N1W8+tGEu
         tkwzeBxPr62F2O3QJtkzmuAx4NHH1pu4yXCIx33Kfi8l+jIWKjJddI8VlD7eSfspx69H
         lz/w==
X-Gm-Message-State: AOAM531uRIgOqOABlT3lkKt/SKU1OzKL22hmoP5t8PIt1JOsaUS5nGBJ
        MYT6DURWewMrcbGrODiUy8wDU/UDjdwM7aeN9p+OJM3srH0XQZuHIn6cb6iDt+pUkSEFX0cLK/H
        eUF2x196gBok4VNL8IZiiSA==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr3602472pjb.236.1607422800462;
        Tue, 08 Dec 2020 02:20:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEk33OVd0GQcnVTb+BU7uJ+A4K0SzetnAO7eFXE7hsLkXXur+N5IyY+4lrCQqPP34mKo353Q==
X-Received: by 2002:a17:90b:1882:: with SMTP id mn2mr3602456pjb.236.1607422800201;
        Tue, 08 Dec 2020 02:20:00 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q70sm2812220pja.39.2020.12.08.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 02:19:59 -0800 (PST)
Date:   Tue, 8 Dec 2020 18:19:50 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add erofs filesystem support
Message-ID: <20201208101950.GA3067897@xiangao.remote.csb>
References: <20201205074410.2317033-1-hsiangkao@redhat.com>
 <20201208100910.dqqh5cqihewkyetc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208100910.dqqh5cqihewkyetc@ws.net.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,

On Tue, Dec 08, 2020 at 11:09:10AM +0100, Karel Zak wrote:
> On Sat, Dec 05, 2020 at 03:44:10PM +0800, Gao Xiang wrote:
> > This patch adds support for detecting EROFS filesystem to libblkid.
> 
> Applied, thanks!

Thanks for taking time on this and the image/testcase!

> 
> I have also added simple regression test to tests/ts/blkid/images-fs/erofs.img.xz. 
> 
> Note that it seems the current mkfs.erofs cannot set volume_name (aka LABEL)
> although the filesystem superblock support it.

Yeah, since it has little use-case for now (but leave such field for later use),
I will add this feature if needed later :) Thanks for kind reminder!

>  
> 
> A small nitpick to mkfs.erofs, see https://github.com/hsiangkao/erofs-utils/blob/dev/mkfs/main.c#L27
> 
> The subdirectory in 
> 
>     #include <uuid/uuid.h> 
> 
> is unnecessary (or wrong), if you use 
> 
>     PKG_CHECK_MODULES([libuuid], [uuid])
> 
> than it returns the subdirectory as -I, see
> 
>     $ pkg-config --cflags uuid
>     -I/usr/include/uuid 
> 
> so the correct way is
> 
>      #include <uuid.h>
> 
> with the proper PKG_CHECK_MODULES(), btw you have it without
> subdirectory in configure.ac test.
> 
> The problem is that your code reads the default include file from
> /usr/include/uuid/ rather the one specified by your build system.

Yay, many thanks for catching this! will fix it soon!

Thanks,
Gao Xiang

> 
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

