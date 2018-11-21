Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56EC43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA31B2146F
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="1xfUAwFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA31B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKUVWz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:22:55 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:32917 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeKUVWz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 21 Nov 2018 16:22:55 -0500
Received: by mail-wm1-f46.google.com with SMTP id 79so6999686wmo.0
        for <util-linux@vger.kernel.org>; Wed, 21 Nov 2018 02:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYPFK+wYRAmiJvaAcnJ0+S7/7rwY85l4BjKJyDGJSYM=;
        b=1xfUAwFmX8dSqm9ZdPmgidezloBgxRhAhOlPL0juVpPUerQXn+psDLLpKVvTr3NoYQ
         1vaM0nUOM9ReO3YqTibrpDCUj4l0RTaE6Sy3lKdab89TXT99XK7xo8Y7d2VJ2/7VJ+xA
         aIjBY0wS3AS1DWyFvQnE67AyMAhLHHNvdcPsWQcUGoQkFrjaesUOnhcnbK6CNoKnkg39
         lWwAwy1DKJK8YvJ4EK3j6SRQFCjUkxG+M97B3bc9Q9povc8tQWxup3BuLzUxamL81HV/
         UzgkkpgOTSf+bVAneFNlME5DprB/tVRXQVFSQtGgPlQi6IZ30ZTTvcJ4O2cYN/s0mmZx
         UPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYPFK+wYRAmiJvaAcnJ0+S7/7rwY85l4BjKJyDGJSYM=;
        b=VFnPbS56oVOs16QmAjo/hh535Pv+/oj+PBUvOeBeGCCkGnf92WfxdtPvgSeCmTWWWn
         BiFRPMG7tE5XPvk+EkGzgulhUl1No2A7UJ1PSPqvQRAo0Iw3Mx5um50wZjsyjmxecEyZ
         FKCAbR6jkdPLp4BbT3Bprk33ZzkzjKcYjilexX3j3y8rrN1gOFmUETKeyJ/Oy9xSq+my
         o8VOo11fUqZmWoSXw70GcNK1uSWtBHDh4QeiLouc4FaGkTzgyTN+lK9nDyF0zb01Mb6E
         9QkNhk0RWTuNV5TayIiT34yPyUo5LlHa3cu4av3G7z6e6mYy3Xxk6bWAqyeecPE4yAD3
         MVmw==
X-Gm-Message-State: AA+aEWawgHnf+H0nhvesBn4UpnxSaAK1vKALvToaEF4iKXsowQAB+6ls
        OkWYuw50iZTUN4JcBqgD7ZNcWpTSRnc=
X-Google-Smtp-Source: AJdET5d5g2KdwsaL/vH5b66iEOmMFIcsFXAxdRZO+yXzwG0JDzAJITqBKjXdTvtebNbaTb/QTxG62w==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr5807253wme.44.1542797338915;
        Wed, 21 Nov 2018 02:48:58 -0800 (PST)
Received: from localhost (213-47-144-126.static.upcbusiness.at. [213.47.144.126])
        by smtp.gmail.com with ESMTPSA id b16sm55928673wrm.41.2018.11.21.02.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 02:48:58 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:48:57 +0100
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] libblkid: add check for DRBD9
Message-ID: <20181121104857.3mj4z3oddlvx6vh5@rck.sh>
References: <20181120161049.5687-1-roland.kammerer@linbit.com>
 <20181121095630.2n4libom7nz3qh32@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121095630.2n4libom7nz3qh32@ws.net.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 21, 2018 at 10:56:30AM +0100, Karel Zak wrote:
> On Tue, Nov 20, 2018 at 05:10:49PM +0100, Roland Kammerer wrote:
> >  libblkid/src/superblocks/drbd.c | 111 ++++++++++++++++++++++++++++++--
> >  1 file changed, 107 insertions(+), 4 deletions(-)
> 
> Applied, thanks!
> 
> It would be nice to have DRBD test images in tests/ts/blkid/images-fs/, 
> so on 
> 
>     ./tests/run.sh blkid
> 
> we will see if DRBD probing code works as expected :-)

Sure thing, I will prepare one for "v08" and one for "v09". Expect them
early next week.

Regards, rck
