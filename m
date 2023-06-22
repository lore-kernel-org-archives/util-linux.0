Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074DCEB64D8
	for <util-linux@archiver.kernel.org>; Thu, 22 Jun 2023 19:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjFVTWq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjFVTWp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Jun 2023 15:22:45 -0400
Received: from mail-qt1-x864.google.com (mail-qt1-x864.google.com [IPv6:2607:f8b0:4864:20::864])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6922A1BC
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2023 12:22:43 -0700 (PDT)
Received: by mail-qt1-x864.google.com with SMTP id d75a77b69052e-3fde82c8ca7so59830881cf.3
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2023 12:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687461762; x=1690053762;
        h=user-agent:in-reply-to:content-disposition:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V6DypAYTCDSf8rMioyBk46B55doygswyUKKpNL1pwUI=;
        b=QvXuEAf5RykOx8NYWr8g3497WXJ+gYvMg8mzLdV5p5WU2I34Y91A3Ce6L0n9RZrEFr
         NavBr68+ecgQboI6nTG/QSLE9ys3nwfyb2j7/oi/MMKDkNd+VZpRUQc/rMCi/xVLbUjh
         r79B+2lqmTYCri9IzbeWjdRfGjvla/7QVEQ4zQrppYxJVWCs0A+JkY+xPJR5112pIzUK
         G1urzmCT+SqNDCto20MQ1bo7uxI/0kQQFm2AzQuUO5xA35U+vaff6C/AJxsM5/krdWBb
         Yg7yFcia6Mw3OjqKY6YbKfi+tVJlO9PN+mIlSEgAng+sLCM5u5IJtPHopPLta64Yiouu
         kmdw==
X-Gm-Message-State: AC+VfDzLkX/NamQ6dmyZKchmUBUa4v0oPIvQHJyCInnMJjRn6yxLnUgJ
        /gH2b5+UwlTIRi7dAOxpTWSiQIDiZWLb79x2CojpP0PSJ+QiOd89xrEr
X-Google-Smtp-Source: ACHHUZ4N+/j+PBKKqZgQUtHiKgdX4/C7JhMwHM6d0Zlt+j2Qzt+9unU/G7BEnxib94UrlxYT1Nq5Hvss++kB
X-Received: by 2002:ad4:5b87:0:b0:62b:4590:78e4 with SMTP id 7-20020ad45b87000000b0062b459078e4mr12209087qvp.28.1687461762133;
        Thu, 22 Jun 2023 12:22:42 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id h28-20020a0cab1c000000b0062df4a2f73bsm832057qvb.20.2023.06.22.12.22.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2023 12:22:42 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from visor (unknown [172.22.75.75])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id 471544FEF30;
        Thu, 22 Jun 2023 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1687461761;
        bh=V6DypAYTCDSf8rMioyBk46B55doygswyUKKpNL1pwUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsN2edd/4SP4Ex0pJ/1BXQtQR0asZGvzWVm69Rsz1LkYCuqMO7i8lH7u2ThJLYqFv
         UAnjVr/A/ne+TYBdvOnbr1fy5E2nconh8LH/YXP1PoeJzJA4PjzzxSLzUJO2uLjb7k
         CQ3gzvwI3LvenvQnzeCoF4qE2AviTiuTh5amMAaX4Q8lRmExY7+b/JymPIvxG2Lul+
         zsfxfEfVY1JtdlNRjiBtjJ+naL+u4hcw1K8jfyvZfzP2PdIWlDQV/ieqNuxL2uVg5s
         vBrpcqwfb+4Z59lalruFlmZ8SW+IaZKupVYpN/ALl3r0u4hSxGRU77qj35rixrt6yx
         bg9BGdnxzuG9A==
Date:   Thu, 22 Jun 2023 12:22:35 -0700
From:   Ivan Delalande <colona@arista.com>
To:     util-linux@vger.kernel.org
Cc:     echron@arista.com, echron@yahoo.com
Subject: [PATCH] util-linux/sys-utils dmesg -r LOG_MAKEPRI needs fac << 3
Message-ID: <20230622192235.GA8252@visor>
References: <CAM3twVT7+P5rnJQsdOXhD==orO1CFV1RBPmvzQZ6-JRspg=H9Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVT7+P5rnJQsdOXhD==orO1CFV1RBPmvzQZ6-JRspg=H9Q@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Edward Chron <echron@arista.com>

The dmesg -r command produces the incorrect output for the raw value
for the or'ed combination of the facility | loglevel priority that gets
produced by the LOG_MAKEPRI macro. That macro is defined as:

    #define LOG_MAKEPRI(fac, pri) ((fac) | (pri))

which is defined in the current glibc code in /usr/include/sys/syslog.h
and is used only in the dmesg -r (raw output option) command to form the
raw value for facility or'ed with loglevel priority and displayed as:

    <#>[#######.######] ...

where the # in <#> contains the output from the LOG_MAKEPRI macro.

The lower 3 bits are reserved for the loglevel priority 0-7
and the bits above that are for the facility value, so the facility
index should be shifted to the left three bits and or'ed with the
loglevel priority.

In the glibc file: /usr/include/sys/syslog.h the macro LOG_MAKEPRI is
defined as:

        #define LOG_MAKEPRI(fac, pri) ((fac) | (pri)

and returns the wrong facility and loglevel priority values, ideally it
should be defined as:

        #define LOG_MAKEPRI(fac, pri) ((fac << 3) | (pri))

to return the correct raw value.

We checked with glibc developement and the LOG_MAKEPRI macro is correct
as is and can't be changed as it used by *BSD as is so the solution for
dmesg -r is to shift the facility index left by 3 bits as input to the
LOG_MAKEPRI macro. That is what glibc development recommended.
(For reference, see glibc bugzilla Bug 30563)

We can front end the LOG_MAKEPRI macro with a macro that shifts the
facility by the needed 3 bits which we've added to dmesg.c:

    #define LOG_RAW_FAC_PRI(fac, pri) LOG_MAKEPRI((fac << 3), (pri))

This has been tested and works correctly to produce the correct raw
mode value for Facility or'ed together with Loglevel priority.

You can verify that this fix works correctly.

We can test by adding several records to /dev/kmsg like this:

    echo "<14> Test Message Facility 8 Loglevel 6" >> /dev/kmsg
    echo "<15> Test Message Facility 8 Loglevel 7" >> /dev/kmsg
    echo "<30> Test Message Facility 24 Loglevel 6" >> /dev/kmsg
    echo "<31> Test Message Facility 24 Loglevel 7" >> /dev/kmsg

these commands add 4 records to the dmesg buffer. Then when we print the
records by cat'ing /dev/kmsg or using the dmesg command several ways:

    -bash-4.2# cat /dev/kmsg | grep "Test Message Facility"
    14,1114,495317239,-; Test Message Facility 8 Loglevel 6
    15,1115,503340779,-; Test Message Facility 8 Loglevel 7
    30,1116,643374764,-; Test Message Facility 24 Loglevel 6
    31,1117,657165117,-; Test Message Facility 24 Loglevel 7

    -bash-4.2# dmesg -x | grep "Test Message Facility"
    user  :info  : [  495.317239]  Test Message Facility 8 Loglevel 6
    user  :debug : [  503.340779]  Test Message Facility 8 Loglevel 7
    daemon:info  : [  643.374764]  Test Message Facility 24 Loglevel 6
    daemon:debug : [  657.165117]  Test Message Facility 24 Loglevel 7

    -bash-4.2# dmesg -S -x | grep "Test Message Facility"
    user  :info  : [  495.317239]  Test Message Facility 8 Loglevel 6
    user  :debug : [  503.340779]  Test Message Facility 8 Loglevel 7
    daemon:info  : [  643.374764]  Test Message Facility 24 Loglevel 6
    daemon:debug : [  657.165117]  Test Message Facility 24 Loglevel 7

   -bash-4.2# dmesg -S -r | grep "Test Message Facility"
   <14>[  495.317239]  Test Message Facility 8 Loglevel 6
   <15>[  503.340779]  Test Message Facility 8 Loglevel 7
   <30>[  643.374764]  Test Message Facility 24 Loglevel 6
   <31>[  657.165117]  Test Message Facility 24 Loglevel 7

All the above methods agree in their output as expected.
However, running dmesg -r does not agree.

dmesg -r erronously produces:
----------------------------

    -bash-4.2# dmesg -r | grep "Test Message Facility"
    <7>[  495.317239]  Test Message Facility 8 Loglevel 6
    <7>[  503.340779]  Test Message Facility 8 Loglevel 7
    <7>[  643.374764]  Test Message Facility 24 Loglevel 6
    <7>[  657.165117]  Test Message Facility 24 Loglevel 7


However, if we run the dmesg -r command using the new front end macro
LOG_RAW_FAC_PRI(fac, pri) we do get the correct output:

Here is the corrected dmesg -r output:
-------------------------------------

    -bash-4.2# dmesg -r | grep "Test Message Facility"
    <14>[  495.317239]  Test Message Facility 8 Loglevel 6
    <15>[  503.340779]  Test Message Facility 8 Loglevel 7
    <30>[  643.374764]  Test Message Facility 24 Loglevel 6
    <31>[  657.165117]  Test Message Facility 24 Loglevel 7

shifting the facility index value by 3 bits in the LOG_RAW_FAC_PRI macro
provides the correct ouput as shown. All the other commands produce the
same output so now they are all in agreement.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 sys-utils/dmesg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 717cc588b..02358e449 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -125,6 +125,7 @@ static const struct dmesg_name level_names[] =
  * shifted code :-)
  */
 #define FAC_BASE(f)	((f) >> 3)
+#define LOG_RAW_FAC_PRI(fac, pri)	LOG_MAKEPRI((fac << 3), (pri))
 
 static const struct dmesg_name facility_names[] =
 {
@@ -968,7 +969,7 @@ static void print_record(struct dmesg_control *ctl,
 	if (ctl->raw) {
 		ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
 				       "<%d>[%5ld.%06ld] ",
-				       LOG_MAKEPRI(rec->facility, rec->level),
+				       LOG_RAW_FAC_PRI(rec->facility, rec->level),
 				       (long) rec->tv.tv_sec,
 				       (long) rec->tv.tv_usec);
 		goto full_output;
@@ -1052,7 +1053,7 @@ full_output:
 			ul_jsonwrt_value_s(&ctl->jfmt, "fac", facility_names[rec->facility].name);
 			ul_jsonwrt_value_s(&ctl->jfmt, "pri", level_names[rec->level].name);
 		} else
-			ul_jsonwrt_value_u64(&ctl->jfmt, "pri", LOG_MAKEPRI(rec->facility, rec->level));
+			ul_jsonwrt_value_u64(&ctl->jfmt, "pri", LOG_RAW_FAC_PRI(rec->facility, rec->level));
 	}
 
 	/* Output the timestamp buffer */
-- 
2.41.0
