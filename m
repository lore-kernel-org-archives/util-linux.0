Return-Path: <SRS0=D5gH=DW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A70C433E7
	for <util-linux@archiver.kernel.org>; Thu, 15 Oct 2020 18:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E704A21527
	for <util-linux@archiver.kernel.org>; Thu, 15 Oct 2020 18:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCWck3IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbgJOSxg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391065AbgJOSx3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Oct 2020 14:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602788007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLhEbZ/yRGThwldl2Fj+FIBd7FQphRIWcirVggjsrVE=;
        b=aCWck3IUpA0JxPNvCbpmVcSRy3ZtSgyH3zMTVeLMUE07h98cRoZEV9qaZEY54K8ImTcTnw
        y6mVni9E1io4cJtSbpGdE0Ih+yTpRkvFMaB8Gu1fSluHUeGy/8Zcu7WmyQa39E0Vx8g7Zm
        ptMBv5lC+Yq5duJ5E/US+GRb6KDOf18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-_EKyvN7IPwGLtQFzhNDSlw-1; Thu, 15 Oct 2020 14:53:25 -0400
X-MC-Unique: _EKyvN7IPwGLtQFzhNDSlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A7918C89C3
        for <util-linux@vger.kernel.org>; Thu, 15 Oct 2020 18:53:24 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (ovpn-115-106.rdu2.redhat.com [10.10.115.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C489A60C07
        for <util-linux@vger.kernel.org>; Thu, 15 Oct 2020 18:53:23 +0000 (UTC)
Date:   Thu, 15 Oct 2020 13:53:21 -0500
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] lscpu: Add FUJITSU aarch64 A64FX cpupart
Message-ID: <20201015185321.i5ugnvlx5rq36yrl@tarantula.users.ipa.redhat.com>
Mail-Followup-To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <20200928094614.3648619-1-nakamura.shun@jp.fujitsu.com>
 <20200929104627.i4tivxi6kd4m24oh@ws.net.home>
 <20200930144409.e5agryctsfijrrrb@tarantula.users.ipa.redhat.com>
 <20200930174027.rohdyp2kubitbs24@ws.net.home>
 <20200930184917.z7sx7xxazhdkumvy@gabell>
 <20200930215334.k6vnsnpan32i43pj@tarantula.users.ipa.redhat.com>
 <20201001030519.6d65sqhd54oxmlic@gabell>
 <OSBPR01MB460011A4773B0250C55ED8E7F7310@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <20201005133550.e5zvvtdfv44r64o2@tarantula.users.ipa.redhat.com>
 <20201008121012.nfeemhwih5dxnwjh@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201008121012.nfeemhwih5dxnwjh@gabell>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 08, 2020 at 08:10:12AM -0400, Masayoshi Mizuma wrote:
>Hi Jeffrey,
>
>Could you try the following patch?

This patch works for X-Gene and eMAG, but unfortunately it broke the
output on the Altra.  The Altra is based on the Neoverse N1 design from
ARM and so it inherited the N1 values in the MIDR register (at least on
the prototype I'm using).

Before your patch:

[root@ampere-altra ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       Ampere(TM)
Model:                           1
Model name:                      Ampere(TM) Altra(TM) Processor
Stepping:                        0x3

After your patch:

[root@ampere-altra ~]# ./lscpu | grep -e Vendor -e Model -e Stepping
Vendor ID:                       ARM
Model:                           1
Model name:                      Neoverse-N1
Stepping:                        r3p1

Raw cpuinfo values:

[root@ampere-altra ~]# grep -m5 CPU /proc/cpuinfo
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x3
CPU part	: 0xd0c
CPU revision	: 1



>====================================================================
>From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>Subject: [PATCH] lscpu-arm: Set the order to search the model name
>
>After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
>Model name for A64FX shows like as:
>
>   Model name:       461F0010
>
>That's because 367c85c47 changes to get the modelname from Processor
>Version of SMBIOS.
>
>The SMBIOS info would be great if the system is based on SBBR v1.2E and
>BBR v1.0 because the specs require the Processor Version of SMBIOS
>as "This field must provide a human readable description of the processor
>part number".
>
>However, it's not good for the systems aren't based on the specs,
>like A64FX. Such systems need to have the model name to the hard
>corded table.
>
>Let's set the order; first, search the hard corded table, then SMBIOS.
>
>Note, some systems, like APM X-Gene, may not match the information
>between MIDR register (/proc/cpuinfo) and SMBIOS. To be consistency,
>use Processor Manufacturer of SMBIOS when Processor Version is used
>even if the hard corded table has the vendor id.
>
>Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>---
> sys-utils/lscpu-arm.c | 30 ++++++++++++++++--------------
> 1 file changed, 16 insertions(+), 14 deletions(-)
>
>diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
>index 20c7291e5..4e48f6d65 100644
>--- a/sys-utils/lscpu-arm.c
>+++ b/sys-utils/lscpu-arm.c
>@@ -110,7 +110,6 @@ static const struct id_part cavium_part[] = {
> };
>
> static const struct id_part apm_part[] = {
>-    { 0x000, "X-Gene" },
>     { -1, "unknown" },
> };
>
>@@ -288,6 +287,7 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
> 	struct lscpu_dmi_header h;
> 	int fd;
> 	ssize_t rs;
>+	int use_smbios = 0;
>
> 	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
> 	if (fd < 0)
>@@ -301,16 +301,21 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
>
> 	to_dmi_header(&h, data);
>
>-	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
>-	if (str) {
>-		xstrncpy(buf, str, 127);
>-		desc->vendor = xstrdup(buf);
>+	if (!desc->modelname) {
>+		str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
>+		if (str) {
>+			xstrncpy(buf, str, 127);
>+			desc->modelname = xstrdup(buf);
>+			use_smbios = 1;
>+		}
> 	}
>
>-	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
>-	if (str) {
>-		xstrncpy(buf, str, 127);
>-		desc->modelname = xstrdup(buf);
>+	if ((startswith(desc->vendor, "0x")) || use_smbios) {
>+		str = dmi_string(&h, data[PROC_MFR_OFFSET]);
>+		if (str) {
>+			xstrncpy(buf, str, 127);
>+			desc->vendor = xstrdup(buf);
>+		}
> 	}
>
> 	return 0;
>@@ -318,14 +323,11 @@ static int __arm_cpu_smbios(struct lscpu_desc *desc)
>
> void arm_cpu_decode(struct lscpu_desc *desc, struct lscpu_modifier *mod)
> {
>-	int rc = -1;
>+	__arm_cpu_decode(desc);
>
> 	/* use SMBIOS Type 4 data if available,
> 	 * else fall back to manual decoding using the tables above */
> 	if (mod->system == SYSTEM_LIVE &&
> 	    access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
>-		rc = __arm_cpu_smbios(desc);
>-
>-	if (rc)
>-		__arm_cpu_decode(desc);
>+		__arm_cpu_smbios(desc);
> }
>-- 
>2.27.0
>
>
>Thanks,
>Masa
>

-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat

