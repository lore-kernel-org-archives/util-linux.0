Return-Path: <SRS0=rELb=OH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E63C43441
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6969A206B6
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/GEL0fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6969A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeK2Fvr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:51:47 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40072 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2Fvr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 29 Nov 2018 00:51:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so24399386lji.7;
        Wed, 28 Nov 2018 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUTpSs9nAQW+ekmNPQNwf4ht774K6l0sTUWdIYA2zqk=;
        b=R/GEL0fvsfWkDo0zaDWL8WaQVaHx02hwFxFYVITOHl/Yrn6N4ptqyM1YffOgP2goNY
         Ltj+01hMfQK/Wib5sgDpP6EvjelQrw8tYOkFNBSv3GEivjcdPCa9kg+fVqot04MrbsF/
         gRq39YUkNDAIaYut1jWaP2Ah9ASTQAKBQl+jKStHh3o0ly2MFHY+dOCMh+H0ywnRfn1l
         yAWynI+QrCGhRNnRX5x95/T3iQaj0Et5gLaQ5W7anTFNRe/a/sytRvd7PAYnohtXPCF8
         +efJehNDQPTovPqVcy1flr6mhrYwkBZ0r6NBSp32l6SWCZThGrgrH9+eRqVS/Z0UZbfb
         i+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUTpSs9nAQW+ekmNPQNwf4ht774K6l0sTUWdIYA2zqk=;
        b=G1UOGaQNTzuWZpDxcFLQOTbjx5dhkOMdx1nUQy2e97wzJtt3zcybIiwDO3TYCE+d7X
         qlhepS32YPIooN690QdsBbj104BC151HT8i/a/X5csy0X5RcTlCNnUOE5CfTos7NlxFz
         puL0f2WxzMTZpZXTXDC6uM2gdEw6sCaITNuy02ODOEIciS5ypqbr8zP+X092jF1ILCva
         67j2s7H7EhFxhrzfcjONiqYWZ9gq18epoMd6r+C9ep8czG3TH/XWDUpQU6YsLfq52SWZ
         2qg110XfV6xLEQ2hTggp7u6aom3imJaQEWK26bbB2/D3XetSPYYfgZqbeO8MUWx/THHG
         qGLg==
X-Gm-Message-State: AA+aEWZpiLUnjZ88OlZC8q3iBWMoLckPjxoLAK+AM+UMNqXvB96BdPdz
        OpfEJbGQUeWZEpbZYKTpZLtHi2Vk+KBrMkyJJXnlhg==
X-Google-Smtp-Source: AFSGD/VFT9dNbhBZaSXI9CjFwPoouYn9LXiqtXq0xQXc7SDIe6rkfeDOt4fZypRtWvUyqko5hx8yTnMFJ2Je5MOg19M=
X-Received: by 2002:a2e:89d7:: with SMTP id c23-v6mr25535962ljk.0.1543430949165;
 Wed, 28 Nov 2018 10:49:09 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic> <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
In-Reply-To: <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 28 Nov 2018 12:48:57 -0600
Message-ID: <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
Subject: edac driver injection of uncorrected errors & utils
To:     linux-edac@vger.kernel.org, york.sun@nxp.com
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Can I inject a uncorrected error or only corrected errors using the
layerscape edac driver injection via sysfs?

Is this the expected output for the edac-util on layerscape when
injecting errors?

root@ls1043ardb:~# edac-util -v
mc0: 0 Uncorrected Errors with no DIMM info
mc0: 0 Corrected Errors with no DIMM info
mc0: csrow0: 0 Uncorrected Errors
mc0: csrow0: mc#0csrow#0channel#0: 643 Corrected Errors

root@ls1043ardb:~# edac-util -vs
edac-util: EDAC drivers are loaded. 1 MC detected:
mc0:fsl_mc_err

root@ls1043ardb:~# edac-util
mc0: csrow0: mc#0csrow#0channel#0: 2700 Corrected Errors

Does edac-ctl function on ARM based platforms or only on x86 and why
might it show 0MB for the memory layout for DDR4 as below?

/run/media/nvme0n1p1/tls/neo_mcu-kernel/drivers/edac-utils# edac-ctl
--layoutreadline() on closed filehandle IN at /usr/sbin/edac-ctl line
514.
Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
          +-----------------------------------------------+
          |                      mc0                      |
          |  csrow0   |  csrow1   |  csrow2   |  csrow3   |
----------+-----------------------------------------------+
channel0: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
----------+-----------------------------------------------+
