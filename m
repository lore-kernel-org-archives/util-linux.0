Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD0C43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2348F206B2
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 22:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC26rVjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2348F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeKVIjX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:39:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35287 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbeKVIjX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Nov 2018 03:39:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so6210105ljb.2;
        Wed, 21 Nov 2018 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCnAwqUH5/VsT3Fd3eW5kjcZq5T0nLIglr2AzdbwH5g=;
        b=qC26rVjyF4cCY/Y5ZlWCvTy3FmbDqcqtieubSoBqbdmJXeF1RDps3hmCb3VbjrM8xv
         2TxRbp+EbJiEl1tUr9yuUsFEceZs2j/VyHZ29biEfJ17y2E0nVGyJjwD+P7Yh+/aiB9d
         4iZ7zUtRTpl5oXNDgyjVjCr/chvlwRDD9F3jFu5BeZHRqP2bnXGNWLX5XKByY8Y6gN6P
         tEvxHHxa9ZmRwZxuMzJyYfdD1wpxWitwqDOOHuyMzAd6fKk/iWkAvNn0fcyPRqCsngE9
         SU38xqGr56uRua6i9V/lPStNwhEatfdLzo7TLFp1ZnI97xHxxyPj9IQc+R2V7nlSQayy
         QpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCnAwqUH5/VsT3Fd3eW5kjcZq5T0nLIglr2AzdbwH5g=;
        b=lB7dhTKhIMZWsxHWeTjn+YQFr4D5VcxGTX3oXkerLL5Hn7Y757tiwbBuRryuKGv+qd
         7+5mKS5H4T0Ou4yUqA0lHNYLBSqMD8fpxoYpqHjb95OvyIjpJ6c8N8+uhMZUsRf+OKOJ
         G8aJB1pVGYn4iDm+bQ2o4yveBxjRcPhBsZxTrvADsrRUI7ubg6zS9L3ZMAELGIMLZCoX
         9Jd2ZiOSYForj6T31CkNj9I7YK4U9XHorAoXmGfsHhNLYsSPmNOSoaaJVSoVhiPMK4k2
         zBK2deZt3ouOGAQ4ReB765vWLi7iMsISp3Jou9PEimJZeQdUtFdrMh0xqsJ10JeChJet
         jjLQ==
X-Gm-Message-State: AA+aEWYTt3z7a78BVogxATuZn0dwSjzwubsIULBmU9KaV5+6K75PALlc
        /CsjGvzmFmyX2p2IzVtr2AOh0uZPVOW0MaLFQOk=
X-Google-Smtp-Source: AFSGD/W/uy6qNILEr3PwnURKmLQQzuLNKxKc7y+6XqTc+GagUCs/1t1Jw3ZyJxi8cefxhV2/BV6BGTuTUnnAylnMvjI=
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr5061470lja.81.1542837788376;
 Wed, 21 Nov 2018 14:03:08 -0800 (PST)
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
Date:   Wed, 21 Nov 2018 16:02:55 -0600
Message-ID: <CAChUvXMWp1Pou9koFP7QMz4CxJ-OrH2qiGTn6nrYZsDyHdoeyA@mail.gmail.com>
Subject: Re: edac driver initialization, interrupt, & debug
To:     york.sun@nxp.com
Cc:     steve@theinkpens.com, bp@alien8.de, linux-edac@vger.kernel.org,
        backports@vger.kernel.org, linux-newbie@vger.kernel.org,
        util-linux@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Please ignore the first question. I now see the expected EDAC message
in the kernel log:

EDAC MC0: 1 CE fsl_mc_err on mc#0csrow#0channel#0 (csrow:0 channel:0
page:0x5df1f offset:0xe40 grain:8 syndrome:0xe0e0)

1)  Is there anything similar to the edac-utils but for ARM instead of
x86, or does
sysfs replace the edac-utils, or is there something else for ARM?

2)  What is currently used for collecting and reporting ECC errors for
ARM/EDAC beyond the kernel log and messages?

https://github.com/grondo/edac-utils

3) How is RAS/rasdaemon reporting integrated into EDAC for error
collection and reporting?

4) Has there been a patch to prevent EDAC sysfs API from reporting bogus values?
See http://lkml.iu.edu/hypermail/linux/kernel/1205.3/02249.html
On Wed, Nov 21, 2018 at 11:01 AM Tracy Smith <tlsmith3777@gmail.com> wrote:
>
> Not probing the edac driver turned out to be a device tree issue as
> Steve suspected. Thanks to both Steve and York, this has been resolved
> and the backport is now logging ECC errors after injection. Added the
> ddr qoriq-memory-controller entry since we used a different .dtsi
> file.
>
> arch/arm64/boot/dts/freescale/...ls1043a.dtsi
>
> ddr: memory-controller@1080000
> { compatible = "fsl,qoriq-memory-controller"; reg = <0x0 0x1080000 0x0
> 0x1000>; interrupts = <0 144 0x4>; big-endian; };
>
> I now need to collect and report CE and UE ECC errors and extend the
> existing logging and reporting function that I currently see. After
> reviewing the following document, the system logging appears different
> from that given in the kernel EDAC document. I need the level of
> granularity described in the edac.txt file.
>
> https://www.mjmwired.net/kernel/Documentation/edac.txt#173 same as
> kernel/Documentation/edac.txt
>
> 1)  Can I gather the system logging described below in the edac.txt
> file for layerscape?
>
> 2)  Is there anything similar to the edac-utils but for ARM, or does
> sysfs replace the edac-utils, or something else?
>
> 3)  What is currently used for collecting and reporting ECC errors for
> ARM/EDAC beyond the kernel log and messages?
> https://github.com/grondo/edac-utils
>
> 4) How is RAS reporting integrated into EDAC for error collection and reporting?
>
> 5) Has there been a patch to prevent EDAC sysfs API from reporting bogus values?
> See http://lkml.iu.edu/hypermail/linux/kernel/1205.3/02249.html
>
> - The EDAC sysfs API will still report bogus values. So, userspace
> tools like edac-utils will still use the bogus data;
>
> - Add a new tracepoint-based way to get the binary information about
> the errors.
>
> This is the logging I currently see with layerscape EDAC. Need
> something explaining these fields.
>
> [ 407.612311] EDAC FSL_DDR MC0: Err Detect Register: 0x80000004 [
> 407.618182] EDAC FSL_DDR MC0: Faulty Data bit: 0
> [ 407.622793] EDAC FSL_DDR MC0: Expected Data / ECC:
> 0x40c50901_40c50900 / 0x800000f0
> [ 407.630443] EDAC FSL_DDR MC0: Captured Data / ECC: 0x40c50900_40c50901 / 0xf0
> [ 407.637571] EDAC FSL_DDR MC0: Err addr: 0x3e0bfff50
> [ 407.642440] EDAC FSL_DDR MC0: PFN: 0x003e0bff
>
> This is the level of detail I need:
>
> SYSTEM LOGGING
> --------------
>
> If logging for UEs and CEs is enabled, then system logs will contain
> information indicating that errors have been detected:
>
> EDAC MC0: CE page 0x283, offset 0xce0, grain 8, syndrome 0x6ec3, row 0,
> channel 1 "DIMM_B1": amd76x_edac
>
> EDAC MC0: CE page 0x1e5, offset 0xfb0, grain 8, syndrome 0xb741, row 0,
> channel 1 "DIMM_B1": amd76x_edac
>
> The structure of the message is:
>     the memory controller            (MC0)
>     Error type                               (CE)
>     memory page                         (0x283)
>     offset in the page                   (0xce0)
>     the byte granularity                (grain 8)
>         or resolution of the error
>     the error syndrome                 (0xb741)
>     memory row                            (row 0)
>     memory channel                     (channel 1)
>     DIMM label, if set prior            (DIMM B1
>     and then an optional, driver-specific message that may
>             have additional information.
>
> Both UEs and CEs with no info will lack all but memory controller, error
> type, a notice of "no info" and then an optional, driver-specific error
> message.
>
> On Mon, Nov 19, 2018 at 10:48 AM York Sun <york.sun@nxp.com> wrote:
> >
> > On 11/19/18 8:38 AM, Tracy Smith wrote:
> > > Steve, you were correct, there wasn't a device tree entry for the
> > > qoriq memory controller in
> > > arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi.  I added it making it
> > > identical to the fsl-ls1046s.dtsi, which should have the same memory
> > > controller and entry as the ls1043a.  I added this but it didn't make
> > > a difference as far as being able to call the probe function. I'm now
> > > checking the mpc85xx_edac.c dtsi entry for comparison since York used
> > > the mpc85xx as the basis for the layerscape, but there is something
> > > else missing preventing the probe function from being called.
> > >
> > > @York
> > > What is your entry for
> > > /proc/device-tree/soc/ifc@1530000/board-control@1,0/compatible
> >
> > EDAC driver doesn't check IFC. Are you debugging EDAC for memory controller?
> >
> > >
> > > @York
> > > cat /proc/device-tree/compatible entry is this, is this correct?
> > > fsl,ls1043a-rdbfsl,ls1043a
> >
> > Once again, you are using your modified code on your own board. So it is
> > not ls1043ardb. This compatible has nothing to do with EDAC driver.
> >
> > I cannot help you with ls1043ardb because the real ls1043ardb board
> > doesn't support ECC. The closest board I have is ls1046ardb.
> >
> > >
> > >                 ddr: memory-controller@1080000 {
> > >                          compatible = "fsl,qoriq-memory-controller";
> > >                          reg = <0x0 0x1080000 0x0 0x1000>;
> > >                          interrupts = <0 144 0x4>;
> > >                          big-endian;
> > >                  };
> >
> > This is your source code, not your final device tree. Please learn to
> > use "fdt" command under U-Boot to dump your device tree before booting
> > Linux, or check after Linux is up. For your reference, on my ls1046ardb,
> > I have
> >
> > # cat /proc/device-tree/soc/memory-controller@1080000/compatible
> > fsl,qoriq-memory-controller
> >
> > York
>
>
>
> --
> Confidentiality notice: This e-mail message, including any
> attachments, may contain legally privileged and/or confidential
> information. If you are not the intended recipient(s), please
> immediately notify the sender and delete this e-mail message.



-- 
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
