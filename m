Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761E6C433DB
	for <util-linux@archiver.kernel.org>; Tue, 16 Mar 2021 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BDC65027
	for <util-linux@archiver.kernel.org>; Tue, 16 Mar 2021 11:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhCPLxi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Mar 2021 07:53:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37897 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCPLxc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Mar 2021 07:53:32 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210316115328euoutp02d97f0ffdada6726b5881e8484e39f93f~s0H6WiOmh3250932509euoutp02e
        for <util-linux@vger.kernel.org>; Tue, 16 Mar 2021 11:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210316115328euoutp02d97f0ffdada6726b5881e8484e39f93f~s0H6WiOmh3250932509euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615895608;
        bh=kddI9WfWbzDDJtx3EGxn8u/xneXrDjdmNTlH/T+vPIs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mzsJoh8HItc1l7O5QkSh5TSHr/uF8lDM1r4Jf6UHja5nrMq1Q4NcBBfXXUQriAQOu
         91Zjjs+m+4Um49B+9nmCp7U2pFsQ1Tw3FlerpxO6+tcn7yzdfNyKeqPdrY9FLoFTOq
         4/4BuJ6y1MB3QdofdT6bcmOg3mkGT77AHnu2m6Xc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210316115327eucas1p230cd36078b5d917eccdb5cab9caf7f32~s0H56t9pA2454824548eucas1p2h;
        Tue, 16 Mar 2021 11:53:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A0.D5.09444.73C90506; Tue, 16
        Mar 2021 11:53:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210316115327eucas1p1735dd1ce566ef851bad9560927198834~s0H5VoDVy0593905939eucas1p1u;
        Tue, 16 Mar 2021 11:53:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316115327eusmtrp22a5a4b175e7590562f65698249beb50a~s0H5U9FdE2078020780eusmtrp2K;
        Tue, 16 Mar 2021 11:53:27 +0000 (GMT)
X-AuditID: cbfec7f4-dbdff700000024e4-15-60509c377f00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 27.A7.08696.73C90506; Tue, 16
        Mar 2021 11:53:27 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210316115327eusmtip18549720c6bab47d903dbfe16144d10d6~s0H5IYOUH1257412574eusmtip1k;
        Tue, 16 Mar 2021 11:53:27 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     util-linux@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] hwclock: fix indentation
Date:   Tue, 16 Mar 2021 12:53:13 +0100
Message-Id: <20210316115313.20164-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87rmcwISDJb+MrPYOGM9q8XNQysY
        LdYeuctuMedKC7sDi0ffllWMHp83yQUwRXHZpKTmZJalFunbJXBlvD4yg7XgDUfFgcO9zA2M
        vexdjJwcEgImEtMmtbB0MXJxCAmsYJSYfm0OE4TzhVHi0MbbbBDOZ0aJGdM+MMO0bNg7Aapl
        OVDLj32sEM5zRomHLW1sIFVsAo4S/UtPsILYIgJyEku3PwHrYBbYxyix894UoFEcHMICmhIX
        biWB1LAIqErcmbAMbAOvgLXEhkfnWCC2yUu0L9/OBhEXlDg58wlYnF9AS2JN03Uwmxmopnnr
        bGaQ+RICUzkkZnyDWCwh4CLR3fCLEcIWlnh1fAvU1zIS/3fOZwK5QUKgXmLyJDOI3h5GiW1z
        fkAttpa4c+4XG0gNM9Cd63fpQ5Q7Sqxd5w9h8knceCsIcQGfxKRt05khwrwSHW1CEDNUJNb1
        74GaJyXR+2oF1C0eEg+uTmeawKg4C8lfs5D8Mgth7QJG5lWM4qmlxbnpqcVGeanlesWJucWl
        eel6yfm5mxiByeL0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEV7TvIAEId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rxJW9bECwmkJ5akZqemFqQWwWSZODilGpgSjS7oHLqRPDM/QWzxxJC3/atWa8lZ
        7I+0FpoTmJIeMLmWUbCS0+pMp8M3ri6NFxwSfQFP79+4KrR668JXMfbsKaktX/9cnfZ7m1TF
        687e+4KGs4wO837QnBf+2f7sl7lNN3JvVlwRuXRbW0Ow//60ik//V24rbWmf+KPxft/7te99
        JvDPnLD8TM3fTx4f5K52PuByZnujHRrrfj+Y/cfrP1tmc0atbZn1Jrlr7fIXF1dt2uy/1uHu
        5PMsH9pdZDVX/+/ueCJx813zU5UJPtHfVuy3Wnni0CVFKTdzs53la68uvJRs33pZ83Si9ZXY
        4uV2D40XbKnkjXDuz7ii8aKMV4ZbeedhR6eUCS95RKZVK7EUZyQaajEXFScCAPFMToeFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t/xu7rmcwISDJ5d57PYOGM9q8XNQysY
        LdYeuctuMedKC7sDi0ffllWMHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlvD4yg7XgDUfFgcO9zA2MvexdjJwcEgImEhv2TmDpYuTi
        EBJYyigx7c90ti5GDqCElMTKuekQNcISf651sUHUPGWUeNjxkBUkwSbgKNG/9ASYLSIgJ7F0
        +xOwQcwC+xgl9h9dzA4ySFhAU+LCrSSQGhYBVYk7E5Yxg9i8AtYSGx6dY4FYIC/Rvnw7G0Rc
        UOLkTJA5HEBz1CXWzxMCCfMLaEmsaboOVs4MVN68dTbzBEaBWUg6ZiF0zEJStYCReRWjSGpp
        cW56brGRXnFibnFpXrpecn7uJkZgqG879nPLDsaVrz7qHWJk4mA8xCjBwawkwmuaF5AgxJuS
        WFmVWpQfX1Sak1p8iNEU6IOJzFKiyfnAaMsriTc0MzA1NDGzNDC1NDNWEuc1ObImXkggPbEk
        NTs1tSC1CKaPiYNTqoFp8e7td3azawkF9pXk7Z5/Xit7x5ZXPA9fGB6bJxc9c+Um7sUSx5vk
        2P/Vzl2oU2gmUGF/9sESy2qptCwlr58K3bbRt9Zm5+Qr6u6L3BR6//eP8jzPHzlx6x4/X8zy
        qriJy+dpjaLCrICJb35eXlc46V1pyrcGeY+1Uz72LNL+xbiX8fqS4t6lh69HsPkfYKjXyFPd
        e6j7ffvXBKv5FazF76Z/fVjwwXTB1KfK3S3avJc3KK/9l7v+qpP+0mnTpafrnD97oXzRgsIP
        UrO3745ep7/iV1+u8pn+G3L3SzgbhNOEp9pP0Xnu0tn4bX9QxBquujV3lrzd7/psRzi/Xwfb
        sgunoy5ZuH56W6ohuH5PghJLcUaioRZzUXEiAFN9bsv+AgAA
X-CMS-MailID: 20210316115327eucas1p1735dd1ce566ef851bad9560927198834
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210316115327eucas1p1735dd1ce566ef851bad9560927198834
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210316115327eucas1p1735dd1ce566ef851bad9560927198834
References: <CGME20210316115327eucas1p1735dd1ce566ef851bad9560927198834@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Fixes: 042f62dfc ("[clang-tidy] do not use else after return")
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 sys-utils/hwclock-rtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 163f04e7a..7f1f0b663 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -294,12 +294,12 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 		if (rc == -1)
 			warn(_("ioctl() to %s to turn off update interrupts failed"),
 			     rtc_dev_name);
-		} else if (errno == ENOTTY || errno == EINVAL) {
-			/* rtc ioctl interrupts are unimplemented */
-			ret = busywait_for_rtc_clock_tick(ctl, rtc_fd);
-		} else
-			warn(_("ioctl(%d, RTC_UIE_ON, 0) to %s failed"),
-			     rtc_fd, rtc_dev_name);
+	} else if (errno == ENOTTY || errno == EINVAL) {
+		/* rtc ioctl interrupts are unimplemented */
+		ret = busywait_for_rtc_clock_tick(ctl, rtc_fd);
+	} else
+		warn(_("ioctl(%d, RTC_UIE_ON, 0) to %s failed"),
+		     rtc_fd, rtc_dev_name);
 	return ret;
 }
 
-- 
2.26.2

