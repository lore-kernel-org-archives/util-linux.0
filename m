Return-Path: <SRS0=zmxI=DP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22539C43467
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CCC120B1F
	for <util-linux@archiver.kernel.org>; Thu,  8 Oct 2020 12:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQeaTW5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJHMKR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 8 Oct 2020 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHMKR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 8 Oct 2020 08:10:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49830C061755
        for <util-linux@vger.kernel.org>; Thu,  8 Oct 2020 05:10:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so6590625qkk.12
        for <util-linux@vger.kernel.org>; Thu, 08 Oct 2020 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngETFXtj4AbiiZ/+8a4uvzr835beItTIX58WlOnnisc=;
        b=gQeaTW5gmSGDxE+q4PKDbz5IspxvO8M5PY75gyxa0T+JvhJlxX5WDlM2aI0la3qW7r
         CMVsxBW+/Qk9Q/2mQ58NqYeQNUvE2/0kMAJEe9Y2aWjjCaDGxZ4t4KgnDctzkUKSZ9jj
         Ku4U+HUW1BD8nL5wvkfqwpJtjYIGOAX64u28gk3083MEBqX/eR+VVzKuBfReeDbCz/Nk
         haAEBQSz+HovkJdXydkcd7yE4DEDVDYZNnoZrRjlNfJp9Jrn7jiVEpimz39mKRaeZRMc
         JJmaxGiTpwKONtGOmgmzTjccIasqM9d0roqC0Tv+Eygau9oTIo1AIKI2zkbrn6CuttgO
         HSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngETFXtj4AbiiZ/+8a4uvzr835beItTIX58WlOnnisc=;
        b=A90UwnCCT/srX6DdtTXL3ijRHyFujEf7alpVDlEff/GOqf9DZbZV1GjvL7NoOCL169
         lw7jWSSjv1l/jangjO6OxGYgPPAN36i8X/5gejd1PRCK4Y/rlrtwpaiTy5QvreeWYZ5s
         /IjyaUsJeUt0eH7t2t46MpM6Oiq175k4nyx8Maths6B4RUaCplYD+iYJurqywUxSHi1y
         L6yI79IoISSzepJJl9uAE1mWa9PoX6UyvpYD9LwDVSCMBWgXuWVeJ4mSmBHkEz0GYchI
         DkTY4HDKwntju1Av7PZPGWmXfyKjw6D3JrRFejQw6Tk+GWxPHe22K8Tssc8fT9xiD2JW
         Khiw==
X-Gm-Message-State: AOAM530MDCrK0BsQhnFUiHRDqCyMzQ2MqVtTTI3IK21RV7PS5VxI3H7O
        9d7pHwTUeHAVqgiaimyZTg==
X-Google-Smtp-Source: ABdhPJxp32ecTYc//HHs9uzeQFzKCTJvNBMxbW9UtMr/avBoN3yUcaIt+ui20ZXn4Wdy3nzCXg/1CA==
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr8057015qke.250.1602159016489;
        Thu, 08 Oct 2020 05:10:16 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k21sm3847360qtq.4.2020.10.08.05.10.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 05:10:14 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:10:12 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Jeffrey Bastian <jbastian@redhat.com>
Cc:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>,
        Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20201008121012.nfeemhwih5dxnwjh@gabell>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
 <20201001030519.6d65sqhd54oxmlic@gabell>
 <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <20201005133550.e5zvvtdfv44r64o2@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005133550.e5zvvtdfv44r64o2@tarantula.users.ipa.redhat.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 05, 2020 at 08:35:50AM -0500, Jeffrey Bastian wrote:
> On Fri, Oct 02, 2020 at 12:15:39PM +0000, nakamura.shun@fujitsu.com wrote:
> > Hi Karel, Jeffrey, Mizuma-san
> > 
> > Sorry for the late reply.
> > 
> > > From: Masayoshi Mizuma <msys.mizuma@gmail.com>
> > > Sent: Thursday, October 1, 2020 12:05 PM
> > > To: Jeffrey Bastian <jbastian@redhat.com>
> > > Cc: Karel Zak <kzak@redhat.com>; Nakamura, Shunsuke
> > > <nakamura.shun@fujitsu.com>; util-linux@vger.kernel.org; Nakamura,
> > > Shunsuke <nakamura.shun@fujitsu.com>
> > > Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
> > > 
> > > On Wed, Sep 30, 2020 at 04:53:34PM -0500, Jeffrey Bastian wrote:
> > > > On Wed, Sep 30, 2020 at 02:49:17PM -0400, Masayoshi Mizuma wrote:
> > > > > Hi Jeffrey and Karel,
> > > > >
> > > > > On Wed, Sep 30, 2020 at 07:40:27PM +0200, Karel Zak wrote:
> > > > > > On Wed, Sep 30, 2020 at 09:44:09AM -0500, Jeffrey Bastian wrote:
> > > > > > > On Tue, Sep 29, 2020 at 12:46:27PM +0200, Karel Zak wrote:
> > > > > > > > On Mon, Sep 28, 2020 at 06:46:14PM +0900, Shunsuke Nakamura
> > > wrote:
> > > > > > > > >  sys-utils/lscpu-arm.c | 6 ++++++
> > > > > > > > >  1 file changed, 6 insertions(+)
> > > > > > > >
> > > > > > > > Applied, thanks.
> > > > > > >
> > > > > > >
> > > > > > > With the other ARM patch applied ("use SMBIOS tables on ARM for
> > > > > > > lscpu"), the output changes on an FX700 system:
> > > > > > >
> > > > > > > [root@fujitsu-fx700 ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
> > > > > > > Vendor ID:                       FUJITSU
> > > > > > > Model:                           0
> > > > > > > Model name:                      461F0010
> > > > > > > Stepping:                        0x1
> > > > > > >
> > > > > > >
> > > > > > > The values here come from the SMBIOS Type 4 record:
> > > > > > >
> > > > > > > [root@fujitsu-fx700 ~]# strings
> > > > > > > /sys/firmware/dmi/entries/4-0/raw
> > > > > > > CPU1
> > > > > > > FUJITSU
> > > > > > > 461F0010
> > > > > > > 8K083MH14
> > > > > > >
> > > > > > >
> > > > > > > This FX700 system has firmware revision 1.4.0 (Jun 17 2020).
> > > > > >
> > > > > > hmm... 461F0010 does not seem user-friendly, "A64FX" seems better.
> > > > > >
> > > > > > Shunsuke, what about to update the firmware strings? ;-) (as
> > > > > > Jeffrey suggested in RH bugzilla)
> > > > > >
> > > > > > The another possibility is to exclude some vendors and do not use
> > > > > > SMBIOS for them (e.g. 0x46 for Fujitsu), but from my point of view
> > > > > > SMBIOS based solution is more elegant and ready for new CPU types
> > > > > > than in-lscpu hard coded tables.
> > > > >
> > > > > According to SMBIOS specification, the description of Processor
> > > > > Version (Type4) is "String number describing the Processor". It
> > > > > shows the version number of the processor, not a model, like as A64FX and
> > > Cortex-A72 and so on.
> > > > > So I think we should not use the Processor Version as the modelname...
> > > >
> > > > Hello Masa,
> > > >
> > > > I think I see your confusion because I was also confused by the
> > > > wording of the SMBIOS spec.  In this case, "String number" means the
> > > > number of the string appended to the Type 4 record, not a version
> > > > number of the processor.
> > > >
> > > > See section 6.1.3, "Text strings", of the SMBIOS spec (version 3.4.0).
> > > >
> > > > For Type 4, there can be up to 6 strings appended to the table:
> > > >   Offset 0x04: Socket Designation
> > > >   Offset 0x07: Processor Manufacturer
> > > >   Offset 0x10: Processor Version
> > > >   Offset 0x20: Serial Number
> > > >   Offset 0x21: Asset Tag
> > > >   Offset 0x22: Part Number
> > > >
> > > > Each string is optional.  If the byte at one of the above offsets is
> > > > 0, that means the string is not included.  If the byte is non-0, it
> > > > means refer to the first or second or third (or so on) string appended
> > > > to the table.  It's this non-0 number that the spec calls "String number".
> > > 
> > > Ohh... thank you for pointing it out! I misunderstood about "String number".
> > > 
> > > >
> > > > Example:
> > > >
> > > > A Type 4 record that only defined Processor Manufacturer and Processor
> > > > Version would therefore look like:
> > > >   Offset 0x04: 0x00
> > > >   Offset 0x07: 0x01
> > > >   Offset 0x10: 0x02
> > > >   Offset 0x20: 0x00
> > > >   Offset 0x21: 0x00
> > > >   Offset 0x22: 0x00
> > > >
> > > > The text of each string is free form.  Most vendors have chosen to use
> > > > Processor Manufacturer as the CPU vendor, and Processor Version as a
> > > > text description of the CPU.
> > > >
> > > > Some examples from existing servers (copy/paste from the other thread):
> > > >
> > > > [root@hp-m400 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> > > > Vendor ID:                       AppliedMicro
> > > > Model:                           1
> > > > Model name:                      X-Gene
> > > > Stepping:                        0x0
> > > >
> > > > [root@lenovo-hr330a ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> > > > Vendor ID:                       Ampere(TM)
> > > > Model:                           2
> > > > Model name:                      eMAG
> > > > Stepping:                        0x3
> > > >
> > > > [root@hpe-apollo-70 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
> > > > Vendor ID:                       Cavium Inc.
> > > > Model:                           1
> > > > Model name:                      Cavium ThunderX2(R) CPU CN9980 v2.1
> > > @ 2.20GHz
> > > > Stepping:                        0x1
> > > >
> > > >
> > > > Therefore, I believe you are free to change the string "461F0010" to
> > > > "A64FX" in the SMBIOS Type 4 record of the FX700 and FX1000 servers'
> > > > firmware.
> > > 
> > > Thanks, I got the most vendors put their CPU model name to Processor Version,
> > > however it depends on the vendor, right..? That's because the SMBIOS
> > > specification says just "String number describing the Processor", so vendors can
> > > put any strings to describe the own processor, like "461F0010"...
> > > 
> > > But I don't have strong opinion about the Processor Version of A64FX, let's wait
> > > for Shunsuke's comment.
> > 
> > I checked with the person in charge.
> > 
> > When the A64FX was designed, there was ambiguity in the Processer Version specification.
> > Therefore we defined it as "461F0010".
> > Considering the maintenance cost to keep up with the latest CPU, I agree to get information
> > from the SMBIOS table rather than the hard code.
> > However, as Mizuma-san said, since "Processer Version" specs depends on the interpretation
> > of the vendor, the expected value is not output in the processor group existing in the current table
> > as in the case of the A64FX.
> > 
> > Given these, I propose referring to the SMBIOS table if the processor version does not exist in
> > the current table. Can you give me your opinion?
> 
> 
> My motivation for writing the SMBIOS patch was the exact opposite
> problem: the original AppliedMicro X-Gene and newer Ampere eMAG are both
> identified as X-Gene by lscpu when using the hard-coded tables.
> (AppliedMicro was acquired by Macom, then the server CPU team split out
> into a new company named Ampere and the X-Gene 3 was rebranded as eMAG.)
> The X-Gene output on an eMAG system is often confusing to people
> (including myself).
> 
> The "CPU implementer" and "CPU part" values are the same for X-Gene and
> eMAG.  The difference is in the "CPU variant" field, but lscpu does not
> use the variant number in its tables.
> 
> ## X-Gene
> ~]# grep -m5 CPU /proc/cpuinfo
> CPU implementer : 0x50
> CPU architecture: 8
> CPU variant     : 0x0
> CPU part        : 0x000
> CPU revision    : 1
> 
> ## eMAG
> ~]# grep -m5 CPU /proc/cpuinfo
> CPU implementer : 0x50
> CPU architecture: 8
> CPU variant     : 0x3
> CPU part        : 0x000
> CPU revision    : 2
> 
> 
> I thought about trying to extend lscpu to add the variant value to the
> tables, but then I realized the strings already exist in SMBIOS Type 4.
> Furthermore, using SMBIOS Type 4 reduces the maintenance costs for lscpu
> since it no longer needs the hard-coded tables (at least for servers).

Hi Jeffrey,

Could you try the following patch?

====================================================================
From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH] lscpu-arm: Set the order to search the model name

After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
Model name for A64FX shows like as:

   Model name:       461F0010

That's because 367c85c47 changes to get the modelname from Processor
Version of SMBIOS.

The SMBIOS info would be great if the system is based on SBBR v1.2E and
BBR v1.0 because the specs require the Processor Version of SMBIOS
as "This field must provide a human readable description of the processor
part number".

However, it's not good for the systems aren't based on the specs,
like A64FX. Such systems need to have the model name to the hard
corded table.

Let's set the order; first, search the hard corded table, then SMBIOS.

Note, some systems, like APM X-Gene, may not match the information
between MIDR register (/proc/cpuinfo) and SMBIOS. To be consistency,
use Processor Manufacturer of SMBIOS when Processor Version is used
even if the hard corded table has the vendor id.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-arm.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 20c7291e5..4e48f6d65 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -110,7 +110,6 @@ static const struct id_part cavium_part[] = {
 };
 
 static const struct id_part apm_part[] = {
-    { 0x000, "X-Gene" },
     { -1, "unknown" },
 };
 
@@ -288,6 +287,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 	struct lscpu_dmi_header h;
 	int fd;
 	ssize_t rs;
+	int use_smbios = 0;
 
 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
 	if (fd < 0)
@@ -301,16 +301,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
 	to_dmi_header(&h, data);
 
-	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		desc->vendor = xstrdup(buf);
+	if (!desc->modelname) {
+		str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
+		if (str) {
+			xstrncpy(buf, str, 127);
+			desc->modelname = xstrdup(buf);
+			use_smbios = 1;
+		}
 	}
 
-	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		desc->modelname = xstrdup(buf);
+	if ((startswith(desc->vendor, "0x")) || use_smbios) {
+		str = dmi_string(&h, data[PROC_MFR_OFFSET]);
+		if (str) {
+			xstrncpy(buf, str, 127);
+			desc->vendor = xstrdup(buf);
+		}
 	}
 
 	return 0;
@@ -318,14 +323,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
 
 void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
-	int rc = -1;
+	__arm_cpu_decode(desc);
 
 	/* use SMBIOS Type 4 data if available,
 	 * else fall back to manual decoding using the tables above */
 	if (mod->system == SYSTEM_LIVE &&
 	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
-		rc = __arm_cpu_smbios(desc);
-
-	if (rc)
-		__arm_cpu_decode(desc);
+		__arm_cpu_smbios(desc);
 }
-- 
2.27.0


Thanks,
Masa
