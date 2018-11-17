Return-Path: <SRS0=UGNN=N4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E8C43610
	for <util-linux@archiver.kernel.org>; Sat, 17 Nov 2018 14:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723182080D
	for <util-linux@archiver.kernel.org>; Sat, 17 Nov 2018 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FIDZX4eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723182080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeKRAWK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 17 Nov 2018 19:22:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeKRAWK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 17 Nov 2018 19:22:10 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542463522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bGk4d8qMAnVqxSDXNjeesm+gtksK+91RLX+MUvCasU=;
        b=FIDZX4eonzCUp2EGNftS0RBzc+509fYJmXVCDzLVU9GXazuC3C7D43Y837hp5M7ZX9cjPP
        g6NOOTNMIuiZNldHbSYu00vX5Col48u28zAjA6NsF+62hrUAXPZH6lIpVQ+7yrgyF6tlHB
        ZbhXe4jDsA5wjDu0M0UVLmoWJ+pd/aM=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YAGs-xsyM8Tn; Sat, 17 Nov 2018 15:05:22 +0100 (CET)
Received: from zn.tnic (p200300EC2BE2B7004D130AD2F34E6DE4.dip0.t-ipconnect.de [IPv6:2003:ec:2be2:b700:4d13:ad2:f34e:6de4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C9C01EC0291;
        Sat, 17 Nov 2018 15:05:22 +0100 (CET)
Date:   Sat, 17 Nov 2018 15:05:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tracy Smith <tlsmith3777@gmail.com>, York Sun <york.sun@nxp.com>
Cc:     linux-edac@vger.kernel.org, backports@vger.kernel.org,
        linux-newbie@vger.kernel.org, util-linux@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: FW: edac driver initialization, interrupt, & debug
Message-ID: <20181117140513.GA4944@zn.tnic>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

+ York.

On Fri, Nov 16, 2018 at 11:07:50AM -0600, Tracy Smith wrote:
> I’m attempting to insmod/modprobe the layerscape_edac_mod.ko driver.
> It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and
> completes successfully. But there is no EDAC boot messages and no
> /proc/interrupts entry for the EDAC. I’m backporting the EDAC from the
> LSDK to the SDK 2.0.
> 
> I have set CONFIG_EDAC_DEBUG and set edac_debug_level to 4, but I
> don’t see any debug messages other than printk()s that I add to
> fsl_ddr_mc_init() in layerscape_edac.c. No debug messages appear in
> any logs from fsl_ddr_edac.c.
> 
> 1. How can I enable debug information? Is debugfs required to print
> the debug messages for the edac_debug_level and CONFIG_EDAC_DEBUG in
> the 4.1.35-rt41 kernel for drivers/edac?

No, just slap printks before every return statement, like:

        if (!devres_open_group(&op->dev, fsl_mc_err_probe, GFP_KERNEL)) {
		pr_err("%s: Error devres_open_group()\n", __func__);
                return -ENOMEM;
	}

so that you can get closer to the place where it fails.

> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
> platform_driver_register() is successful. But I don’t see any printk()
> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear
> in any /var/log/*.

Yeah, see if it even gets called at all:

int fsl_mc_err_probe(struct platform_device *op)
{
        struct mem_ctl_info *mci;
        struct edac_mc_layer layers[2];
        struct fsl_mc_pdata *pdata;
        struct resource r;
        u32 sdram_ctl;
        int res;

	pr_err("%s: entry\n", __func__);


> 3. I don’t see any interrupts, so why would there not be an edac
> interrupt in /proc/inturrupts?

Probably because it doesn't reach the point where it registers an IRQ
handler...

> Do I need to inject an error before seeing an edac interrupt in
> /proc/interrupts?

You should, AFAICT, if it loads and registers stuff properly.

> lsmod
> module: layerscape_edac_mod    12594  0
> 
> 4. To inject an error I can use the fsl_mc_inject …. routines in
> fsl_ddr_edac.c and write to the registers. But is there a utility that
> already uses these routines that can be used to inject an error
> (FSL_MC_ECC_ERR_INJECT, FSL_MC_DATA_ERR_INJECT_LO,

You should be able to simply write to *sysfs*. Somewhere under
/sys/devices/system/edac/...

fsl_mc_inject_data_{lo,hi}_store simply writes the low and high inject
register.

Btw, looking at it, York, this whole injection functionality needs to
be behind CONFIG_EDAC_DEBUG because a production driver shouldn't have
injection capability.

Hmmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
