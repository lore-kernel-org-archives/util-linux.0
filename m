Return-Path: <SRS0=o02/=N5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A74C04EBF
	for <util-linux@archiver.kernel.org>; Sun, 18 Nov 2018 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D18C20817
	for <util-linux@archiver.kernel.org>; Sun, 18 Nov 2018 01:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=theinkpens-com.20150623.gappssmtp.com header.i=@theinkpens-com.20150623.gappssmtp.com header.b="LUBrMXEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D18C20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=theinkpens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeKRLX4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:23:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38575 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeKRLX4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Nov 2018 06:23:56 -0500
Received: by mail-it1-f196.google.com with SMTP id k141-v6so2943901itk.3
        for <util-linux@vger.kernel.org>; Sat, 17 Nov 2018 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theinkpens-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KEz6mYmXAjay/K8Ym4+P02I0hUahoNxKDM2rVKdU1U0=;
        b=LUBrMXEpFWRcBasPWZcUUqH9q/PVGQkwUA+svBe87BnOHMd6mRuYdk/udV43PPk5oU
         XGTm1TSGjFWE63DiYAr6fHO951YxkwE/vmnmLZ1EYowZy+20T3E+Ixr64V7xUV3YZMfS
         Aytha2D9UeUTqEMuUH/0OJO6L4fWdTDSo9UFdc7kDiMBNlcJuRxUs5McqXM+J2spyYlx
         iJdnA7HtdL1PTsz3vy3I23EHA/n1GpGOEHQKpBcYa+tJB8CcQSNlWzgxhjqceJilQTHY
         v9P87pgByK98o5GjKUXY36LkTOsOlt6JRa4DFgzSGGHQrqrcQtQcHbETE1rE0Qff/A6i
         TqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KEz6mYmXAjay/K8Ym4+P02I0hUahoNxKDM2rVKdU1U0=;
        b=PaFIghGCBJQQhkI7ZHazQeRIAy0E6kbjCFMAuPXxEHQN3KDHePWZQ8UMg5Wn/W7NNF
         PZC+lWmFWYKL9cafRRnOrPodz82LAMlwYBgeSx5kd56WkDzRUguL+z8ftUFPE5AQFOrn
         NVInq3imofmIC1IfA8qgRl+6uv952NakN2Coubbv5YirXdvJZFcpcYaI9ts4CgU3VPyE
         lEVY5S9yBvjmzkl8mMqJPz4/fGyI+a65xjhoLiowVvnj/+lrHQ4baX/TKi15MNRquSX0
         oA6qBmF0Pb2HjO8lu2JnlsfcdAN8GlASX0KuIoSR72UNGxxTQLx6klOAf85XGCHyMS2r
         h1LQ==
X-Gm-Message-State: AGRZ1gJII4SKDUFM0Ow2rLIenkyG8U1+HrNPDKGEKR4K66nJcL2HI8Lt
        76PiidPT1Uz2haNRzNm5u1zp8A==
X-Google-Smtp-Source: AJdET5e1ImiV6hKhkqLvLYvTFzb5cTjOPBvHZ6M9Gtfj4IEjk/OMBOaBoM2msAOP6Qj/SeLhAILPbw==
X-Received: by 2002:a02:12c5:: with SMTP id 66mr15490865jap.54.1542503121607;
        Sat, 17 Nov 2018 17:05:21 -0800 (PST)
Received: from [192.168.253.209] (CPE3c1e0447b630-CMa84e3f4980e0.cpe.net.cable.rogers.com. [174.116.204.66])
        by smtp.gmail.com with ESMTPSA id g3sm92161iom.10.2018.11.17.17.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:05:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: edac driver initialization, interrupt, & debug
From:   Steve Inkpen <steve@theinkpens.com>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
Date:   Sat, 17 Nov 2018 20:05:20 -0500
Cc:     bp@alien8.de, york.sun@nxp.com, linux-edac@vger.kernel.org,
        backports@vger.kernel.org, linux-newbie@vger.kernel.org,
        util-linux@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com> <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com> <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com> <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com> <20181117140513.GA4944@zn.tnic> <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
To:     Tracy Smith <tlsmith3777@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Are you using a device tree? If yes, make sure there is an entry for this de=
vice.

=46rom your snippet of code, there appears to be a match entry in of_match_t=
able?

Steve

> On Nov 17, 2018, at 6:22 PM, Tracy Smith <tlsmith3777@gmail.com> wrote:
>=20
> Thank you Boris for the information.  It is helpful.
>=20
>>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
>>> platform_driver_register() is successful. But I don=E2=80=99t see any pr=
intk()
>>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
>>> in any /var/log/*.
>=20
>> Yeah, see if it even gets called at all:
>=20
> I did a grep on /var/log/* and don't see any printk's from
> fsl_mc_err_probe(). So, it's not being called.
>=20
> 1) What would cause the probe function not to be called?
>=20
> 2) Were changes made in how .probe functions were called between
> different kernel releases of the edac?
>=20
> 3) How should I go about root causing the reason for the .probe to
> fail since I may have to backport any changes made?
>=20
> 4) Possibly a patch exists for .probe changes after 4.1.35-rt41?
>=20
> static struct platform_driver fsl_ddr_mc_err_driver =3D {
>=20
> .probe =3D fsl_mc_err_probe,
> .remove =3D fsl_mc_err_remove,
> .driver =3D {
>              .name =3D "fsl_ddr_mc_err",
>              .of_match_table =3D fsl_ddr_mc_err_of_match,
>    },
> }l;
>=20
> int fsl_mc_err_probe(struct platform_device *op)
>=20
> {
> struct mem_ctl_info *mci;
> struct edac_mc_layer layers[2];
> struct fsl_mc_pdata *pdata;
> struct resource r;
> u32 sdram_ctl;
> int res;
>=20
> pr_err("%s: entry\n", __func__);
> printk("entered fsl_mc_err_probe!\n");
>=20
> Any assistance greatly appreciated.
>=20
>=20
>> On Sat, Nov 17, 2018 at 8:05 AM Borislav Petkov <bp@alien8.de> wrote:
>>=20
>> + York.
>>=20
>>> On Fri, Nov 16, 2018 at 11:07:50AM -0600, Tracy Smith wrote:
>>> I=E2=80=99m attempting to insmod/modprobe the layerscape_edac_mod.ko dri=
ver.
>>> It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and
>>> completes successfully. But there is no EDAC boot messages and no
>>> /proc/interrupts entry for the EDAC. I=E2=80=99m backporting the EDAC fr=
om the
>>> LSDK to the SDK 2.0.
>>>=20
>>> I have set CONFIG_EDAC_DEBUG and set edac_debug_level to 4, but I
>>> don=E2=80=99t see any debug messages other than printk()s that I add to
>>> fsl_ddr_mc_init() in layerscape_edac.c. No debug messages appear in
>>> any logs from fsl_ddr_edac.c.
>>>=20
>>> 1. How can I enable debug information? Is debugfs required to print
>>> the debug messages for the edac_debug_level and CONFIG_EDAC_DEBUG in
>>> the 4.1.35-rt41 kernel for drivers/edac?
>>=20
>> No, just slap printks before every return statement, like:
>>=20
>>        if (!devres_open_group(&op->dev, fsl_mc_err_probe, GFP_KERNEL)) {
>>                pr_err("%s: Error devres_open_group()\n", __func__);
>>                return -ENOMEM;
>>        }
>>=20
>> so that you can get closer to the place where it fails.
>>=20
>>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
>>> platform_driver_register() is successful. But I don=E2=80=99t see any pr=
intk()
>>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
>>> in any /var/log/*.
>>=20
>> Yeah, see if it even gets called at all:
>>=20
>> int fsl_mc_err_probe(struct platform_device *op)
>> {
>>        struct mem_ctl_info *mci;
>>        struct edac_mc_layer layers[2];
>>        struct fsl_mc_pdata *pdata;
>>        struct resource r;
>>        u32 sdram_ctl;
>>        int res;
>>=20
>>        pr_err("%s: entry\n", __func__);
>>=20
>>=20
>>> 3. I don=E2=80=99t see any interrupts, so why would there not be an edac=

>>> interrupt in /proc/inturrupts?
>>=20
>> Probably because it doesn't reach the point where it registers an IRQ
>> handler...
>>=20
>>> Do I need to inject an error before seeing an edac interrupt in
>>> /proc/interrupts?
>>=20
>> You should, AFAICT, if it loads and registers stuff properly.
>>=20
>>> lsmod
>>> module: layerscape_edac_mod    12594  0
>>>=20
>>> 4. To inject an error I can use the fsl_mc_inject =E2=80=A6. routines in=

>>> fsl_ddr_edac.c and write to the registers. But is there a utility that
>>> already uses these routines that can be used to inject an error
>>> (FSL_MC_ECC_ERR_INJECT, FSL_MC_DATA_ERR_INJECT_LO,
>>=20
>> You should be able to simply write to *sysfs*. Somewhere under
>> /sys/devices/system/edac/...
>>=20
>> fsl_mc_inject_data_{lo,hi}_store simply writes the low and high inject
>> register.
>>=20
>> Btw, looking at it, York, this whole injection functionality needs to
>> be behind CONFIG_EDAC_DEBUG because a production driver shouldn't have
>> injection capability.
>>=20
>> Hmmm.
>>=20
>> --
>> Regards/Gruss,
>>    Boris.
>>=20
>> Good mailing practices for 400: avoid top-posting and trim the reply.
>=20
>=20
>=20
> --=20
> Confidentiality notice: This e-mail message, including any
> attachments, may contain legally privileged and/or confidential
> information. If you are not the intended recipient(s), please
> immediately notify the sender and delete this e-mail message.
