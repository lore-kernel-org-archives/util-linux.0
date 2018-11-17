Return-Path: <SRS0=UGNN=N4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98882C04EBF
	for <util-linux@archiver.kernel.org>; Sat, 17 Nov 2018 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600B120815
	for <util-linux@archiver.kernel.org>; Sat, 17 Nov 2018 23:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Shvf9qaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600B120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeKRJky (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Nov 2018 04:40:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35520 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKRJky (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Nov 2018 04:40:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so17091556lfc.2;
        Sat, 17 Nov 2018 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ulD9t4eOaITLeQiThcyOTqCMZdhIn11EWleWSNBZGS8=;
        b=Shvf9qaI/owMnZZKin4bFXSFSjVDzmEOioZdhHoiw5bloRL40ArlQdmZ68s7DKXSZP
         rdjcz1zUStT8DA82pX3Dmm2E+nBHmVLyHNOxs15SqiTdTrtdZiL1o+xSKrPdvjYOzrYk
         MGbhVzxcCoREteVeZ8jsg0bVHWYpIicd91P4uQh00rN8TbKpvHLz3K4xrxLbRDTSYgwZ
         HVttmlgX5k6c89sJZEKkl7My6JmwvdcWLT53TVPoL6U/AX2VBRsWeTjP4rvt1PfjHbKK
         rqaTktiukZKvz+TxBZCaUTOfACi/9vMzqIlkcrHQGh4D7Q4nGU56dnKFzlRLx2/iok1h
         cnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ulD9t4eOaITLeQiThcyOTqCMZdhIn11EWleWSNBZGS8=;
        b=A5qHPqJCBiDySS151UJEAahVfy6Wrve1RRhYxGUtfd2TRsPmfGJXwqOQstZI3c8pgZ
         z9GEjAELM1OUBXC9LGgQKR4g1Rqoal798BN58oSPGZiWr4bnk0ukNEp1QoqZ1dr7GaKf
         s2Dg20rMbUMSUSHmJQkvcNH3wber/5a0Oi6A6wPuwZ7vJQanleNvzT3el8pBsHL15iXC
         2tV5SU7KnQ67qyGLkL2b4/zxTRtcFrX5ZZUwXIaqbfXY+oo2T8R79Nef7V9goBohFKHf
         D6dyFkzEZK9H+0H7M8FxyVJ5AHGVuCWXL2wYOpCLba6ce1PeDP+izC4IOnG6AUmGkspD
         gC8Q==
X-Gm-Message-State: AGRZ1gIVvqA/Anku09mnXppWffHHoKekX//noyclCqe2moOWQCyoRVC7
        wNTN4q7/2R63OCbJDs4P7spE8wsqQ1AJwSs3LQY=
X-Google-Smtp-Source: AJdET5ebLiIXQJ9IEzOyoMQtmv3qPCKqCpAGT5ST4WQw6OajEcPs/LmaYX1oc3ZHMSBEKj1EooFf4KR2Ouw9wCVYc2Y=
X-Received: by 2002:a19:26ce:: with SMTP id m197mr7797743lfm.23.1542496950520;
 Sat, 17 Nov 2018 15:22:30 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com> <20181117140513.GA4944@zn.tnic>
In-Reply-To: <20181117140513.GA4944@zn.tnic>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Sat, 17 Nov 2018 17:22:17 -0600
Message-ID: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
Subject: Re: FW: edac driver initialization, interrupt, & debug
To:     bp@alien8.de
Cc:     york.sun@nxp.com, linux-edac@vger.kernel.org,
        backports@vger.kernel.org, linux-newbie@vger.kernel.org,
        util-linux@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thank you Boris for the information.  It is helpful.

>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
>> platform_driver_register() is successful. But I don=E2=80=99t see any pr=
intk()
>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
>> in any /var/log/*.

> Yeah, see if it even gets called at all:

I did a grep on /var/log/* and don't see any printk's from
fsl_mc_err_probe(). So, it's not being called.

1) What would cause the probe function not to be called?

2) Were changes made in how .probe functions were called between
different kernel releases of the edac?

3) How should I go about root causing the reason for the .probe to
fail since I may have to backport any changes made?

4) Possibly a patch exists for .probe changes after 4.1.35-rt41?

static struct platform_driver fsl_ddr_mc_err_driver =3D {

.probe =3D fsl_mc_err_probe,
.remove =3D fsl_mc_err_remove,
.driver =3D {
              .name =3D "fsl_ddr_mc_err",
              .of_match_table =3D fsl_ddr_mc_err_of_match,
    },
}l;

int fsl_mc_err_probe(struct platform_device *op)

{
 struct mem_ctl_info *mci;
 struct edac_mc_layer layers[2];
 struct fsl_mc_pdata *pdata;
 struct resource r;
 u32 sdram_ctl;
 int res;

pr_err("%s: entry\n", __func__);
printk("entered fsl_mc_err_probe!\n");

Any assistance greatly appreciated.


On Sat, Nov 17, 2018 at 8:05 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + York.
>
> On Fri, Nov 16, 2018 at 11:07:50AM -0600, Tracy Smith wrote:
> > I=E2=80=99m attempting to insmod/modprobe the layerscape_edac_mod.ko dr=
iver.
> > It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and
> > completes successfully. But there is no EDAC boot messages and no
> > /proc/interrupts entry for the EDAC. I=E2=80=99m backporting the EDAC f=
rom the
> > LSDK to the SDK 2.0.
> >
> > I have set CONFIG_EDAC_DEBUG and set edac_debug_level to 4, but I
> > don=E2=80=99t see any debug messages other than printk()s that I add to
> > fsl_ddr_mc_init() in layerscape_edac.c. No debug messages appear in
> > any logs from fsl_ddr_edac.c.
> >
> > 1. How can I enable debug information? Is debugfs required to print
> > the debug messages for the edac_debug_level and CONFIG_EDAC_DEBUG in
> > the 4.1.35-rt41 kernel for drivers/edac?
>
> No, just slap printks before every return statement, like:
>
>         if (!devres_open_group(&op->dev, fsl_mc_err_probe, GFP_KERNEL)) {
>                 pr_err("%s: Error devres_open_group()\n", __func__);
>                 return -ENOMEM;
>         }
>
> so that you can get closer to the place where it fails.
>
> > 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
> > platform_driver_register() is successful. But I don=E2=80=99t see any p=
rintk()
> > messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
> > in any /var/log/*.
>
> Yeah, see if it even gets called at all:
>
> int fsl_mc_err_probe(struct platform_device *op)
> {
>         struct mem_ctl_info *mci;
>         struct edac_mc_layer layers[2];
>         struct fsl_mc_pdata *pdata;
>         struct resource r;
>         u32 sdram_ctl;
>         int res;
>
>         pr_err("%s: entry\n", __func__);
>
>
> > 3. I don=E2=80=99t see any interrupts, so why would there not be an eda=
c
> > interrupt in /proc/inturrupts?
>
> Probably because it doesn't reach the point where it registers an IRQ
> handler...
>
> > Do I need to inject an error before seeing an edac interrupt in
> > /proc/interrupts?
>
> You should, AFAICT, if it loads and registers stuff properly.
>
> > lsmod
> > module: layerscape_edac_mod    12594  0
> >
> > 4. To inject an error I can use the fsl_mc_inject =E2=80=A6. routines i=
n
> > fsl_ddr_edac.c and write to the registers. But is there a utility that
> > already uses these routines that can be used to inject an error
> > (FSL_MC_ECC_ERR_INJECT, FSL_MC_DATA_ERR_INJECT_LO,
>
> You should be able to simply write to *sysfs*. Somewhere under
> /sys/devices/system/edac/...
>
> fsl_mc_inject_data_{lo,hi}_store simply writes the low and high inject
> register.
>
> Btw, looking at it, York, this whole injection functionality needs to
> be behind CONFIG_EDAC_DEBUG because a production driver shouldn't have
> injection capability.
>
> Hmmm.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



--=20
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
