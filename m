Return-Path: <SRS0=rELb=OH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CBC43441
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579D520832
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4MTVTf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579D520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeK2GOS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:14:18 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:35776 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeK2GOS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 29 Nov 2018 01:14:18 -0500
Received: by mail-lj1-f169.google.com with SMTP id x85-v6so24476360ljb.2;
        Wed, 28 Nov 2018 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKk06mc6ZRtoJ3+ldiTsxfShxbrECSVDGiCRThBMY14=;
        b=Q4MTVTf3Kqv+OopCM8qLoBn0SPLwFzM+ohF6H/qkF72Nltfeg3F4023XaI0dKaEmQr
         CAF2FAj6KaBn46s+hhkwTJBt3eLeNOWA9nao+jchW5BU7cs2DzgESnIF+zgxW6qFY08A
         Zpb4Z85FDd2D5tLBjj4R3KrDrDUb14pVYzsTzXgVmRxgKkoMRmsVjlkmuJRLeugzDk4/
         u5zWObjmR6TtTwD+zPC0I86bJNnXP7BGpgt661hI1F7BKjKVuTyR51HxHYUldtjDqUhA
         BCLqGY8m4ZSws7HXMkyxKbtvlJAmVRDWqyE35W9ayKDtAYojEbvBfRx78SPg3O7yz0Sq
         94+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKk06mc6ZRtoJ3+ldiTsxfShxbrECSVDGiCRThBMY14=;
        b=kNd8FsaE1Bfi16ACWHrkP2OEpNg2Wh0TvLnrnalzjRW4V4P2UUSK07n8X/JwFIRlfn
         6gr+0U69oHhkU8hI55wlW+WSER8mhelrRbdso12gtfx2wMkOY2j1PNo8vWkhD4HI0XGh
         6SapCS6oEhJCCrGNcdR+1V84IsOmv8ErgJC7tvrmNml9Jr7xhjH+oXHXIw3fiBAbu18x
         2jTJwZtMn5jDMd6KUECbv989fyrCjRLvFjIFwKIngNF/BQlkeTEdvG/Z2YT1WF/c9tT8
         NHbMfAfecMJLaSCon5+flHPXkedDK1ZoIjcizyHiBTIc6cpbbui9w4p0LkWF1v8dK1Qn
         NIcA==
X-Gm-Message-State: AA+aEWaDqBHZvhqQXPqP5kHJNsCaF0+WpYemE3gD/kKxbl4pejI929PY
        ur4aIrtCDO2969awYH3+8JK8Y5w9DQ/9Bj3ZD2c=
X-Google-Smtp-Source: AFSGD/WYoTTX+xtq6Z8Sp2v2M/sWHF3wPwroBVPu01xUaOYbchRpCgoyQF3MtlfKTtFR20ZuhzFcRGKaG6rRrDQ0yFo=
X-Received: by 2002:a2e:89d7:: with SMTP id c23-v6mr25585835ljk.0.1543432296268;
 Wed, 28 Nov 2018 11:11:36 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic> <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com> <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 28 Nov 2018 13:11:23 -0600
Message-ID: <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
Subject: Re: edac driver injection of uncorrected errors & utils
To:     york.sun@nxp.com
Cc:     linux-edac@vger.kernel.org, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thanks York. Why will injecting multi-bit errors crash linux?  Is this
the case only for layerscape?  Is there a way to harden against this?

On Wed, Nov 28, 2018 at 1:06 PM York Sun <york.sun@nxp.com> wrote:
>
> Tracy,
>
> You can inject multiple-bit errors. You will crash the system for doing
> that. I can't comment on edac-util.
>
> York
>
>
> On 11/28/18 12:49 PM, Tracy Smith wrote:
> > Can I inject a uncorrected error or only corrected errors using the
> > layerscape edac driver injection via sysfs?
> >
> > Is this the expected output for the edac-util on layerscape when
> > injecting errors?
> >
> > root@ls1043ardb:~# edac-util -v
> > mc0: 0 Uncorrected Errors with no DIMM info
> > mc0: 0 Corrected Errors with no DIMM info
> > mc0: csrow0: 0 Uncorrected Errors
> > mc0: csrow0: mc#0csrow#0channel#0: 643 Corrected Errors
> >
> > root@ls1043ardb:~# edac-util -vs
> > edac-util: EDAC drivers are loaded. 1 MC detected:
> > mc0:fsl_mc_err
> >
> > root@ls1043ardb:~# edac-util
> > mc0: csrow0: mc#0csrow#0channel#0: 2700 Corrected Errors
> >
> > Does edac-ctl function on ARM based platforms or only on x86 and why
> > might it show 0MB for the memory layout for DDR4 as below?
> >
> > /run/media/nvme0n1p1/tls/neo_mcu-kernel/drivers/edac-utils# edac-ctl
> > --layoutreadline() on closed filehandle IN at /usr/sbin/edac-ctl line
> > 514.
> > Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> > Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> > Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> > Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 533.
> >           +-----------------------------------------------+
> >           |                      mc0                      |
> >           |  csrow0   |  csrow1   |  csrow2   |  csrow3   |
> > ----------+-----------------------------------------------+
> > channel0: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |
> > ----------+-----------------------------------------------+
> >
>


--
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
