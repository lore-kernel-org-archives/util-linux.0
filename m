Return-Path: <SRS0=u4W5=N3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C20C43441
	for <util-linux@archiver.kernel.org>; Fri, 16 Nov 2018 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA98820811
	for <util-linux@archiver.kernel.org>; Fri, 16 Nov 2018 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ldLvqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA98820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbeKQDVU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:21:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33282 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQDVS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 16 Nov 2018 22:21:18 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so20943448ljd.0;
        Fri, 16 Nov 2018 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wfIx7PZ/WyQs5qSF44RrBUhRlSKzsYDHetoecxo+1IM=;
        b=g2ldLvqUYGndUmqaVVgBq294CQxn4oPYFUKx4Lj8j17esm/o3IgZ/7Tav9K+oSHszy
         7yTTy3xgGcrH6l/Uu1LloneTYiHxK7LT6M0tnax6aCvYoz7fDpQtMl38Qeq7gpgcpEcY
         FxySUKl2hhZvKhBOr7GKfAsFzpGusue+CKle8Y3mXVoPS1d1aphLMmRkSqEfUGUt51Op
         6yQe8qmr1hyFy6Cx3X6iYviUbuY2SPi6OobZs7YrgUB+SnLaHH6yGVM6BxFLd445ZWn3
         Gf2XIKvGAKROr88iPc90I/as5QgEn7NRQC6BvOfFKTxtCebtAePYlhGGRMg0kWbZsF9f
         WjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wfIx7PZ/WyQs5qSF44RrBUhRlSKzsYDHetoecxo+1IM=;
        b=fD0s4qEYrnLHYy/slzRfvdPFiLm++i3ZUd/me8NyPWBUmH+cfTA75BU2rKf016oSRb
         YSJ22WPz8pjRPCtqhgHBG1y2Rg4DRE43Qe9x/+GRkp/BSQ297kBkLTneX+BQRtCOvYYJ
         E3hF+Qp0NrBM2bLid+8NHS0SdidlZv9//HW15JGWBA+YtLcVfRnxPaQSxYuCq56XHK6D
         Jpa1AHO2QevzOHMVc9fTjxcVXcqQJuu8SJb/Hy3WwDpuNOcZ1eioMJaXVTpw8IoIAIkB
         pLqE3ZCDjOOuleKurg/mDnvhEFtbX3qBJeI3rJtR3EqAW9jZGk8QPa7X44LA5ImBuFkh
         sddw==
X-Gm-Message-State: AGRZ1gKVAe1yFEaFy8HpX97aY4sa2PYA/sZ/RxwuShfQ9ZcL+Dh0KsvN
        iREYsU33is/1A4MsdemHYplLi4uCOiYSVfFShk/+EkK1
X-Google-Smtp-Source: AJdET5e2DjZGG9T5FYSOxMLxu2gvBRCkPfbobZGqSwAlCRgeTGyLlzulDbBW2zFZ0v+C30beCse1NMTcbIlnqoO3670=
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr6533760ljc.83.1542388083408;
 Fri, 16 Nov 2018 09:08:03 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
In-Reply-To: <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Fri, 16 Nov 2018 11:07:50 -0600
Message-ID: <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
Subject: Re: FW: edac driver initialization, interrupt, & debug
To:     linux-edac@vger.kernel.org
Cc:     backports@vger.kernel.org, linux-newbie@vger.kernel.org,
        util-linux@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I=E2=80=99m attempting to insmod/modprobe the layerscape_edac_mod.ko driver=
.
It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and
completes successfully. But there is no EDAC boot messages and no
/proc/interrupts entry for the EDAC. I=E2=80=99m backporting the EDAC from =
the
LSDK to the SDK 2.0.

I have set CONFIG_EDAC_DEBUG and set edac_debug_level to 4, but I
don=E2=80=99t see any debug messages other than printk()s that I add to
fsl_ddr_mc_init() in layerscape_edac.c. No debug messages appear in
any logs from fsl_ddr_edac.c.

1. How can I enable debug information? Is debugfs required to print
the debug messages for the edac_debug_level and CONFIG_EDAC_DEBUG in
the 4.1.35-rt41 kernel for drivers/edac?

2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
platform_driver_register() is successful. But I don=E2=80=99t see any print=
k()
messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
in any /var/log/*.

3. I don=E2=80=99t see any interrupts, so why would there not be an edac
interrupt in /proc/inturrupts?  Do I need to inject an error before
seeing an edac interrupt in /proc/interrupts?

lsmod
module: layerscape_edac_mod    12594  0

4. To inject an error I can use the fsl_mc_inject =E2=80=A6. routines in
fsl_ddr_edac.c and write to the registers. But is there a utility that
already uses these routines that can be used to inject an error
(FSL_MC_ECC_ERR_INJECT, FSL_MC_DATA_ERR_INJECT_LO,

Thanks you for any assistance. Instrumenting throughout the driver now
to see if I can trace through the driver.

thx, Tracy Smith
