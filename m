Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D881EB64DA
	for <util-linux@archiver.kernel.org>; Fri, 23 Jun 2023 01:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjFWBbh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Jun 2023 21:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjFWBbg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Jun 2023 21:31:36 -0400
Received: from mail-io1-xd61.google.com (mail-io1-xd61.google.com [IPv6:2607:f8b0:4864:20::d61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C51FE9
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2023 18:31:34 -0700 (PDT)
Received: by mail-io1-xd61.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso1877239f.3
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2023 18:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687483894; x=1690075894;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1GJ6hwl5gHH1vlvS8kchNSUHKV3NgTpbea6L2CnbQw=;
        b=aYkRmVbeKtlJlx8rw0UXNYNRr/CJE9cPhdpLYXvMNDiyG7EYNTW2G6NhqhamwUPI7U
         1RZz9JnMQYgNObcfcX3XiKQHMHTaUdidsvFpvjn7vPcpCrx+PEgkpAPs0OOjWTbUouPd
         x4fmGfqHWsmcv8HtA/+wMuBX2Tc8QqRE912aWEl36Lm6Sw5fq89MlrBe1vuIkAJfSpiE
         8PR+I+HYeyQgGPr0341luIzJBIDDZyFKmN3S2B1enIHXHnk/DS25zuROFSzVvYeyOo/Y
         bIpdC+8mX60hHihsQnQYJq4GkGJtfEVsnCVffcLqAuU6RY8XciYPUn4a+sT+aiY4Z3Ia
         mQ3Q==
X-Gm-Message-State: AC+VfDxPKZu5osFZ4+TlXoHGddnYWVZw1ukyBlKoq56q16yiAHKinYYR
        3UmPN/dk/waWda6n7dv63oOdZPQLfnW6ll/oPdUrTjSYg7pmZp0Mrnj3
X-Google-Smtp-Source: ACHHUZ4H/dLTdBXw67+u0mdtoHibpudWOgZUH0QpxfnryDtSb5g63vCSBo0neyu6fEQXzeZ++1dxfeHM0nxo
X-Received: by 2002:a05:6602:20da:b0:77a:d2d3:fbe0 with SMTP id 26-20020a05660220da00b0077ad2d3fbe0mr17232780ioz.3.1687483893791;
        Thu, 22 Jun 2023 18:31:33 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id n13-20020a02a90d000000b00424e5092297sm647438jam.23.2023.06.22.18.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2023 18:31:33 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
        by smtp.aristanetworks.com (Postfix) with ESMTP id E6D2A402044;
        Thu, 22 Jun 2023 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1687483892;
        bh=r1GJ6hwl5gHH1vlvS8kchNSUHKV3NgTpbea6L2CnbQw=;
        h=From:To:Cc:Subject:Date:From;
        b=rSn95amwZbeMvdqLa4ypbTQR8+UnVy7fW0yu5onKsXrffuQ+SqXjrWqXxnaOUoTPE
         qpbXoFXMmqI1zBSAo6cixlnyF7kA+PutZMrbhTLxVXw1Q1gZ9vVQJIdaNhCMefkZLV
         Q7rLiIpIbaHkrV0TSUvzBKGk7CxFxPzxwRPZ70gWjUa2Pj4ZGmPwQzPWeGB4pGzFTH
         1T7OSvXvqfTcJdFFHAm3ZPwAf7EVus+wwHQV1+Navwzl8vFhDRSjXYaGLsID+lJ8Uu
         nQO8/MjSeNtpTgNAdYyqY++5P7YvAXvW1RF7u1TKt0ANTvhY3VJI9Ch/07Nz5Z0daG
         oJh11X5C16Nog==
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
        id D8327B840B06; Thu, 22 Jun 2023 18:31:32 -0700 (PDT)
From:   echron@arista.com
To:     util-linux@vger.kernel.org
Cc:     echron@yahoo.com, colona@arista.com,
        Edward Chron <echron@arista.com>
Subject: [PATCH] util-linux/sys-utils dmesg -r LOG_MAKEPRI needs fac << 3
Date:   Thu, 22 Jun 2023 18:31:31 -0700
Message-ID: <20230623013131.4802-1-echron@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Edward Chron <echron@yahoo.com>

Submission to Project: util-linux
Open Incident: #2325 at github.com/util-linux/util-linux/issues/2325
Component: util-linux/sys-utils
File: dmesg.c
Code level patch applied against: 2.39 - latest code pulled from
           git.github.com:util-linux/util-linux.git

BUG: The facility field passed to macro from /usr/include/sys/syslog.h
     LOG_MAKEPRI(fac, pri) by dmesg -r needs to have fac argument
     shifted 3 bit to the left to return a valid raw valid. The lower
     3 bits for a raw value are used by the loglevel priority (pri)
     field, so the facility bits can only occupy the bits above the
     bits used to hold the pri field value.

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

