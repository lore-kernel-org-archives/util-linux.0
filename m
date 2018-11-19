Return-Path: <SRS0=5EDY=N6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF173C43441
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C07020831
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoalCIn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C07020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeKTEW1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:22:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41519 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbeKTDCR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 19 Nov 2018 22:02:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so21791539lfj.8;
        Mon, 19 Nov 2018 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lZ8l+WwOS3+Uxro0QNBAanAwdRleFaUV9KMYErdP950=;
        b=CoalCIn1SKdtzBB3c5a/0FTfqbN00wb3wrTkKhRmmBAEYSGwGtOplfK6jnv4TJr/KR
         5F4A5F+SoeKs3cK2wlsQTCbbrzuYWIsB4JH4PoVZGLoEx7jatw5/W4b15Q24/SQ3Benv
         zajTWcNWWxeNRVGn6adzFuZNq1tCM2OryLPM1k00S1CuD7jYDH9b5cSa4AyeEFAq/0rg
         U4HkwjIMqlD0qtep9l8OaTY6Who37Ie/f39yPCbRbjiTBuf+DAdZmVoBmibjxRQdNru3
         1+P6Zhnx6LhaKF71Fod7PdT3BUd4iXhpq5Ntss4Y/fZ6xnk+8yzeP0xSqF2RTu+kL4zi
         nKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lZ8l+WwOS3+Uxro0QNBAanAwdRleFaUV9KMYErdP950=;
        b=CUGDy269r2AUo+vOsTlA2tOKcAnGv8nFSq4wPnxnavdAkPoY3nNHXBKmyFredOX56k
         W+3pdZqh56XMzD2iaiGXddTg+8LXRmknAGgrCReIPcBHK5V1fl5YoCsG3q8W3sIMNaS6
         6ebc+7o+DpZvA/VU18i7vSPDRAnF8BcYjsV4wbvSE/Zf+LVSXt4tpQrhByRDIEdRc8ya
         O4zFRds7a4cqsH2OcpZO51qNSQYsfwzLNt1MMj1lknJ2mVlN0Lu7UB1Zxnx2VDagqQYj
         9IK+yDLLftzWKVXJ4vUi1iQ2If5oti0QqiaR6n5MnFyvRpAtYpXkZIRPtHGHWFOiYRhJ
         6bvg==
X-Gm-Message-State: AGRZ1gImqzJCvdpL7ouAeGruWlvPCuWfV+4f8ioQzNqEGuK1ZUKHp2nw
        EJtu1PQvb6PVTn4WACpiDWEC4GwtmBQjENX54AA=
X-Google-Smtp-Source: AJdET5fxw9oeDZb/AAuN0tDmT3/+X8gWIGptMpCs42ZcE2ihCZWdgshVie6yCLzKqSKbHgYSizu+6+kd6XaWECH/YO4=
X-Received: by 2002:a19:7d42:: with SMTP id y63mr10541801lfc.47.1542645485912;
 Mon, 19 Nov 2018 08:38:05 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic> <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
In-Reply-To: <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Mon, 19 Nov 2018 10:37:51 -0600
Message-ID: <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
Subject: Re: edac driver initialization, interrupt, & debug
To:     steve@theinkpens.com
Cc:     bp@alien8.de, york.sun@nxp.com, linux-edac@vger.kernel.org,
        backports@vger.kernel.org, linux-newbie@vger.kernel.org,
        util-linux@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Steve, you were correct, there wasn't a device tree entry for the
qoriq memory controller in
arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi.  I added it making it
identical to the fsl-ls1046s.dtsi, which should have the same memory
controller and entry as the ls1043a.  I added this but it didn't make
a difference as far as being able to call the probe function. I'm now
checking the mpc85xx_edac.c dtsi entry for comparison since York used
the mpc85xx as the basis for the layerscape, but there is something
else missing preventing the probe function from being called.

@York
What is your entry for
/proc/device-tree/soc/ifc@1530000/board-control@1,0/compatible

@York
cat /proc/device-tree/compatible entry is this, is this correct?
fsl,ls1043a-rdbfsl,ls1043a

                ddr: memory-controller@1080000 {
                         compatible =3D "fsl,qoriq-memory-controller";
                         reg =3D <0x0 0x1080000 0x0 0x1000>;
                         interrupts =3D <0 144 0x4>;
                         big-endian;
                 };

                 ifc: ifc@1530000 {
                         compatible =3D "fsl,ifc", "simple-bus";
                         reg =3D <0x0 0x1530000 0x0 0x10000>;
                         interrupts =3D <0 43 0x4>;
                 };

I haven't had to change the edac code to compile it, so it is what is
in drivers/edac. The ECC is enabled in uboot and supported by the
memory controller DDR4. I have attached the layerscape_edac_mod.mod.c
file after compiling at the end.

I see the fsl_ddr_mc_err_of_match[] for the memory controller and it
is associated with the .of_match_table =3D fsl_ddr_mc_err_of_match

 static const struct of_device_id fsl_ddr_mc_err_of_match[] =3D {
         { .compatible =3D "fsl,qoriq-memory-controller", },
         {},
 };
 MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);

 static struct platform_driver fsl_ddr_mc_err_driver =3D {
         .probe =3D fsl_mc_err_probe,
         .remove =3D fsl_mc_err_remove,
         .driver =3D {
                 .name =3D "fsl_ddr_mc_err",
                 .of_match_table =3D fsl_ddr_mc_err_of_match,
         },
 };

Beyond this, I only see a "of_match_device" in the altera_edac.c
driver and the highbanks below, but not in any other drivers.

cd drivers/edac
grep of_match_device * | more
altera_edac.c:  id =3D of_match_device(altr_sdram_ctrl_of_match, &pdev->dev=
);
highbank_l2_edac.c:     id =3D of_match_device(hb_l2_err_of_match, &pdev->d=
ev);
highbank_mc_edac.c:     id =3D of_match_device(hb_ddr_ctrl_of_match, &pdev-=
>dev);

The .of_match_table entry appears correct for the layerscape_edac.c.
York took this entry from the mpc85xx_edac.c.

 layerscape_edac.c:              .of_match_table =3D fsl_ddr_mc_err_of_matc=
h,
 mpc85xx_edac.c:         .of_match_table =3D mpc85xx_l2_err_of_match,
 mpc85xx_edac.c:         .of_match_table =3D mpc85xx_mc_err_of_match,
 ppc4xx_edac.c:          .of_match_table =3D ppc4xx_edac_match,
 synopsys_edac.c:                   .of_match_table =3D synps_edac_match,
 xgene_edac.c:           .of_match_table =3D xgene_edac_of_match,

--=20
 layerscape_edac_mod.mod.c
 #include <linux/vermagic.h>
 #include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

__visible struct module __this_module
 __attribute__((section(".gnu.linkonce.this_module"))) =3D {
         .name =3D KBUILD_MODNAME,
         .init =3D init_module,

 #ifdef CONFIG_MODULE_UNLOAD
         .exit =3D cleanup_module,
 #endif

        .arch =3D MODULE_ARCH_INIT,
 };

 MODULE_INFO(intree, "Y");

 static const struct modversion_info ____versions[]
 __used
 __attribute__((section("__versions"))) =3D {
         { 0xf41fc8a9, __VMLINUX_SYMBOL_STR(module_layout) },
         { 0x8294e3fc, __VMLINUX_SYMBOL_STR(edac_mc_add_mc_with_groups) },
         { 0x1fdc7df2, __VMLINUX_SYMBOL_STR(_mcount) },
         { 0x51eafc8e, __VMLINUX_SYMBOL_STR(param_ops_int) },
         { 0x69a358a6, __VMLINUX_SYMBOL_STR(iomem_resource) },
         { 0x91715312, __VMLINUX_SYMBOL_STR(sprintf) },
         { 0x26d622f, __VMLINUX_SYMBOL_STR(__platform_driver_register) },
         { 0x60ea2d6, __VMLINUX_SYMBOL_STR(kstrtoull) },
         { 0x11089ac7, __VMLINUX_SYMBOL_STR(_ctype) },
         { 0xb51fbd64, __VMLINUX_SYMBOL_STR(edac_op_state) },
         { 0x27e1a049, __VMLINUX_SYMBOL_STR(printk) },
         { 0x1e614c08, __VMLINUX_SYMBOL_STR(of_find_property) },
         { 0x1215bb3b, __VMLINUX_SYMBOL_STR(devres_open_group) },
         { 0x91f27fc0, __VMLINUX_SYMBOL_STR(edac_mc_handle_error) },
         { 0x643ce492, __VMLINUX_SYMBOL_STR(edac_mc_free) },
         { 0x9b69ee39, __VMLINUX_SYMBOL_STR(edac_debug_level) },
         { 0x9c26e7ff, __VMLINUX_SYMBOL_STR(edac_mc_alloc) },
         { 0x3c5bfeaa, __VMLINUX_SYMBOL_STR(__devm_request_region) },
         { 0x8229211c, __VMLINUX_SYMBOL_STR(devm_ioremap) },
         { 0x159dd96a, __VMLINUX_SYMBOL_STR(edac_mc_del_mc) },
         { 0xb3d3cbde, __VMLINUX_SYMBOL_STR(devres_remove_group) },
         { 0x48fb5a26, __VMLINUX_SYMBOL_STR(of_address_to_resource) },
         { 0xb2904f0, __VMLINUX_SYMBOL_STR(platform_get_irq) },
         { 0xfb3ca8db, __VMLINUX_SYMBOL_STR(platform_driver_unregister) },
         { 0x69e0f942, __VMLINUX_SYMBOL_STR(devm_request_threaded_irq) },
         { 0xec4e8f9b, __VMLINUX_SYMBOL_STR(devres_release_group) },
 };

 static const char __module_depends[]
 __used
 __attribute__((section(".modinfo"))) =3D
 "depends=3D";

Question: is this MODULE_ALIAS "of:N*T*Cfsl" correct?

MODULE_ALIAS("of:N*T*Cfsl,qoriq-memory-controller*");
 - layerscape_edac_mod.mod.c 55/55 100%

thx,
Tracy


On Sat, Nov 17, 2018 at 7:05 PM Steve Inkpen <steve@theinkpens.com> wrote:
>
> Are you using a device tree? If yes, make sure there is an entry for this=
 device.
>
> From your snippet of code, there appears to be a match entry in of_match_=
table?
>
> Steve
>
> > On Nov 17, 2018, at 6:22 PM, Tracy Smith <tlsmith3777@gmail.com> wrote:
> >
> > Thank you Boris for the information.  It is helpful.
> >
> >>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
> >>> platform_driver_register() is successful. But I don=E2=80=99t see any=
 printk()
> >>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appea=
r
> >>> in any /var/log/*.
> >
> >> Yeah, see if it even gets called at all:
> >
> > I did a grep on /var/log/* and don't see any printk's from
> > fsl_mc_err_probe(). So, it's not being called.
> >
> > 1) What would cause the probe function not to be called?
> >
> > 2) Were changes made in how .probe functions were called between
> > different kernel releases of the edac?
> >
> > 3) How should I go about root causing the reason for the .probe to
> > fail since I may have to backport any changes made?
> >
> > 4) Possibly a patch exists for .probe changes after 4.1.35-rt41?
> >
> > static struct platform_driver fsl_ddr_mc_err_driver =3D {
> >
> > .probe =3D fsl_mc_err_probe,
> > .remove =3D fsl_mc_err_remove,
> > .driver =3D {
> >              .name =3D "fsl_ddr_mc_err",
> >              .of_match_table =3D fsl_ddr_mc_err_of_match,
> >    },
> > }l;
> >
> > int fsl_mc_err_probe(struct platform_device *op)
> >
> > {
> > struct mem_ctl_info *mci;
> > struct edac_mc_layer layers[2];
> > struct fsl_mc_pdata *pdata;
> > struct resource r;
> > u32 sdram_ctl;
> > int res;
> >
> > pr_err("%s: entry\n", __func__);
> > printk("entered fsl_mc_err_probe!\n");
> >
> > Any assistance greatly appreciated.
> >
> >
> >> On Sat, Nov 17, 2018 at 8:05 AM Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> + York.
> >>
> >>> On Fri, Nov 16, 2018 at 11:07:50AM -0600, Tracy Smith wrote:
> >>> I=E2=80=99m attempting to insmod/modprobe the layerscape_edac_mod.ko =
driver.
> >>> It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and
> >>> completes successfully. But there is no EDAC boot messages and no
> >>> /proc/interrupts entry for the EDAC. I=E2=80=99m backporting the EDAC=
 from the
> >>> LSDK to the SDK 2.0.
> >>>
> >>> I have set CONFIG_EDAC_DEBUG and set edac_debug_level to 4, but I
> >>> don=E2=80=99t see any debug messages other than printk()s that I add =
to
> >>> fsl_ddr_mc_init() in layerscape_edac.c. No debug messages appear in
> >>> any logs from fsl_ddr_edac.c.
> >>>
> >>> 1. How can I enable debug information? Is debugfs required to print
> >>> the debug messages for the edac_debug_level and CONFIG_EDAC_DEBUG in
> >>> the 4.1.35-rt41 kernel for drivers/edac?
> >>
> >> No, just slap printks before every return statement, like:
> >>
> >>        if (!devres_open_group(&op->dev, fsl_mc_err_probe, GFP_KERNEL))=
 {
> >>                pr_err("%s: Error devres_open_group()\n", __func__);
> >>                return -ENOMEM;
> >>        }
> >>
> >> so that you can get closer to the place where it fails.
> >>
> >>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the
> >>> platform_driver_register() is successful. But I don=E2=80=99t see any=
 printk()
> >>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appea=
r
> >>> in any /var/log/*.
> >>
> >> Yeah, see if it even gets called at all:
> >>
> >> int fsl_mc_err_probe(struct platform_device *op)
> >> {
> >>        struct mem_ctl_info *mci;
> >>        struct edac_mc_layer layers[2];
> >>        struct fsl_mc_pdata *pdata;
> >>        struct resource r;
> >>        u32 sdram_ctl;
> >>        int res;
> >>
> >>        pr_err("%s: entry\n", __func__);
> >>
> >>
> >>> 3. I don=E2=80=99t see any interrupts, so why would there not be an e=
dac
> >>> interrupt in /proc/inturrupts?
> >>
> >> Probably because it doesn't reach the point where it registers an IRQ
> >> handler...
> >>
> >>> Do I need to inject an error before seeing an edac interrupt in
> >>> /proc/interrupts?
> >>
> >> You should, AFAICT, if it loads and registers stuff properly.
> >>
> >>> lsmod
> >>> module: layerscape_edac_mod    12594  0
> >>>
> >>> 4. To inject an error I can use the fsl_mc_inject =E2=80=A6. routines=
 in
> >>> fsl_ddr_edac.c and write to the registers. But is there a utility tha=
t
> >>> already uses these routines that can be used to inject an error
> >>> (FSL_MC_ECC_ERR_INJECT, FSL_MC_DATA_ERR_INJECT_LO,
> >>
> >> You should be able to simply write to *sysfs*. Somewhere under
> >> /sys/devices/system/edac/...
> >>
> >> fsl_mc_inject_data_{lo,hi}_store simply writes the low and high inject
> >> register.
> >>
> >> Btw, looking at it, York, this whole injection functionality needs to
> >> be behind CONFIG_EDAC_DEBUG because a production driver shouldn't have
> >> injection capability.
> >>
> >> Hmmm.
> >>
> >> --
> >> Regards/Gruss,
> >>    Boris.
> >>
> >> Good mailing practices for 400: avoid top-posting and trim the reply.
> >
> >
> >
> > --
> > Confidentiality notice: This e-mail message, including any
> > attachments, may contain legally privileged and/or confidential
> > information. If you are not the intended recipient(s), please
> > immediately notify the sender and delete this e-mail message.



--=20
Confidentiality notice: This e-mail message, including any
attachments, may contain legally privileged and/or confidential
information. If you are not the intended recipient(s), please
immediately notify the sender and delete this e-mail message.
