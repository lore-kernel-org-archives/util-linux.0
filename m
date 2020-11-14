Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC0C56202
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BF42225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hajx0KDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKNENa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKNENa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:30 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53607C0613D2
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:30 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so11592147qkc.12
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+DHxi7Lh+Di0zKdKlH9sI5M59N/tNDknr2ChsUCD/Y=;
        b=Hajx0KDR6sBi+Eli4/ZWV48u01sik+Vujef+dXYxsMljDNwp/NOGj/QuToABP8vY5S
         ayEptH7WEPCkhdUatLbEsYZ60I6lfoAyVQxBu76blzHODbw5fnP5q+3DgPoqI65LV+0+
         Gl+EcVJ6ieXSaVQFW6NHt4qDdUVU7IQsvpn/AYZeICThE2Cehs+Bx5I5nHoDD2qVikOk
         03kkGwE1qm447KQdutzxN120/48+8AC1yw+Oj0TVhAUu/f2fkW2NS1AcxtIVuyMVJCy2
         Qz7h8OaXnX9SY5z+sYjkWvFkxZaRYICrc3aVhDwLyCDh1VdA/Qzs7vK7UMlPG78jbD5N
         kvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j+DHxi7Lh+Di0zKdKlH9sI5M59N/tNDknr2ChsUCD/Y=;
        b=XGxqt9Zg8kleL41G2zfHdeOT+vGCZd9ngnLzWaxnsVA5qRfvu1P6jvIb8S3n3u0Qvc
         6o2UK+SXCoW1U3BjR9DbTfJluckQoENnu1CfKi04iKepbcAeCAODmMAYD9l22VIgAzBk
         bBlB6lsBZ/rguyQNjh/zxFS0eAVxKdh0GrBC2BokQ3Jd1A/bmLW912zY0XrN9Go+mKMX
         iHIfXitqt4VxaN6rJTsWYHNKpv82CtfEC/Q+GE1yqYCFV9afGzNhhQvb+K5bY/H7+NmS
         3kKgQRFOfHBci6FQOi+CdOlZHCVxT8sHxzmzUVNdsA4gPBTpJGXyz+NRYR+Rn57YOVBn
         jVHA==
X-Gm-Message-State: AOAM5330iUxYf7bUjpEl0w0j2BqlVbkJp9KqerATjlgExLal6rD6juDE
        GlOkWvUdDoo8Gns33yDOkzVWGxPkoQ==
X-Google-Smtp-Source: ABdhPJwflSnahyKJxN9+LrKMGFzr/NXVOzV2WkPWVI6yyitH0eSZ/V8KWSu90tH+FhFRIfvTBxoveg==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr5183072qka.387.1605327209345;
        Fri, 13 Nov 2020 20:13:29 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id o5sm8010338qtt.60.2020.11.13.20.13.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:28 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 4/5] lscpu: add helper to get physical sockets
Date:   Fri, 13 Nov 2020 23:12:28 -0500
Message-Id: <20201114041229.26417-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114041229.26417-1-msys.mizuma@gmail.com>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add a helper function, get_number_of_physical_sockets_from_dmi(),
to get physical sockets from DMI table in case of the sysfs for
cpu topology doesn't have the physical socket information.

get_number_of_physical_sockets_from_dmi() parse the DMI table
and counts the number of SMBIOS Processor Information (Type04)
structure.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu-dmi.c | 29 +++++++++++++++++++++++++++++
 sys-utils/lscpu.h     |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 00d4439f8..e7ffa88d3 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -66,6 +66,9 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 			di->manufacturer = dmi_string(&h, data[0x04]);
 			di->product = dmi_string(&h, data[0x05]);
 			break;
+		case 4:
+			di->sockets++;
+			break;
 		default:
 			break;
 		}
@@ -77,3 +80,29 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 done:
 	return rc;
 }
+
+size_t get_number_of_physical_sockets_from_dmi(void)
+{
+	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
+	struct dmi_info di;
+	struct stat st;
+	uint8_t *data;
+	int rc = 0;
+
+	if (stat(sys_fw_dmi_tables, &st))
+		return rc;
+
+	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
+	if (!data)
+		return rc;
+
+	memset(&di, 0, sizeof(struct dmi_info));
+	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
+
+	free(data);
+
+	if ((rc < 0) || !di.sockets)
+		return 0;
+	else
+		return di.sockets;
+}
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 565f6aee5..d137b94b1 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -312,10 +312,12 @@ struct dmi_info {
 	char *vendor;
 	char *product;
 	char *manufacturer;
+	int sockets;
 };
 
 
 void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data);
 char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s);
 int parse_dmi_table(uint16_t len, uint16_t num, uint8_t *data, struct dmi_info *di);
+size_t get_number_of_physical_sockets_from_dmi(void);
 #endif /* LSCPU_H */
-- 
2.27.0

