Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CDC43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8174A20672
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="vfQw3FbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8174A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436993AbeKWAWZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:22:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39619 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436977AbeKWAWZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Nov 2018 19:22:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so1365110wra.6
        for <util-linux@vger.kernel.org>; Thu, 22 Nov 2018 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zi52VhWuFqziH8PL9eDEkKfIsH6NMjU9+dsGUBmuxdw=;
        b=vfQw3FbRrEZAzj8HBMJjI21suPol5/Atm0Dao8mMV+QJyzleSd/ikoU7rGJbWTTWww
         nmZLAudBFlKgz9UmohAcFL4hKWp9glJqsW0ollYOrCAehBwebE7G3Y26rSHuUJBmUQmO
         0Px+wysHfcbU3wBscxrfT7qWm1OAcqVSVUYW437z33geHhNwXiadTy9mf8q5G76TjdbG
         8ciLg8f6+UBHrFPCD2+6yzQ99xcY50hWBSoPshK3CxnqrbWCHpCpV61tcUatqTTlTXnL
         Cqz6UI1Z07hVHimMTJbJgHbULcCwniYnhfTl7N8Ed2rPYoCDS52l2+F3qxz4rmhDZCAp
         Y2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zi52VhWuFqziH8PL9eDEkKfIsH6NMjU9+dsGUBmuxdw=;
        b=eSUxTR4t9v/1fFZyiSMD0vOi3cqvdDXG9qjii13N0+a4MChJsLRxqm3a61EyB29dt8
         x2YQvzMQiuME8V0JIjAfauudjxB2qcusxEr+riGOEZs/YsL763XMQXeF19OrbDuAyRW7
         DS1B7wmH2mA1DsIOgSbUMotu6M1yNee6voc4NZSLahmX9va2uYWqJT3PrgNMu8EZU+YK
         9RAeypBDE5L6d9JynXstXyyg5TXM0de0rFuu0J3vWMGTxJM/gwc6lsYisLvVjGbp7uQZ
         diWNO2dJsp5psrufks3lOGbz5umRO8fC3Xw0Ut/KvPHm0AVvSJgph1crDso82SfCtSWP
         qMCQ==
X-Gm-Message-State: AA+aEWY1UWg919LNuSGyogr/kZeX2SWugJaLy8pvZObpiiD+z7C+gnLX
        DqwiUP2bak25eLDbDz3ipZmzliHffR8=
X-Google-Smtp-Source: AFSGD/VCa/j7uEARs2iWubNp3u3ayV/kYkq+DzBgNtRlKrlD57pgvw1CPF9ckMDjlFgzh4J77NAr3w==
X-Received: by 2002:a5d:6249:: with SMTP id m9-v6mr9460235wrv.314.1542894178920;
        Thu, 22 Nov 2018 05:42:58 -0800 (PST)
Received: from aperol.linbit. (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id m66sm3616642wmd.15.2018.11.22.05.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:42:58 -0800 (PST)
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     util-linux@vger.kernel.org
Cc:     Roland Kammerer <roland.kammerer@linbit.com>
Subject: [PATCH 1/1] tests: add test images for drbd v08/v09
Date:   Thu, 22 Nov 2018 14:42:48 +0100
Message-Id: <20181122134248.8907-1-roland.kammerer@linbit.com>
X-Mailer: git-send-email 2.18.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This adds DRBD meta data images for DRBD versions 8 and 9, as well as
the according expected output.

Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
---
 tests/expected/blkid/low-probe-drbd-v08  |   5 +++++
 tests/expected/blkid/low-probe-drbd-v09  |   5 +++++
 tests/ts/blkid/images-fs/drbd-v08.img.xz | Bin 0 -> 448 bytes
 tests/ts/blkid/images-fs/drbd-v09.img.xz | Bin 0 -> 460 bytes
 4 files changed, 10 insertions(+)
 create mode 100644 tests/expected/blkid/low-probe-drbd-v08
 create mode 100644 tests/expected/blkid/low-probe-drbd-v09
 create mode 100644 tests/ts/blkid/images-fs/drbd-v08.img.xz
 create mode 100644 tests/ts/blkid/images-fs/drbd-v09.img.xz

diff --git a/tests/expected/blkid/low-probe-drbd-v08 b/tests/expected/blkid/low-probe-drbd-v08
new file mode 100644
index 000000000..22b431320
--- /dev/null
+++ b/tests/expected/blkid/low-probe-drbd-v08
@@ -0,0 +1,5 @@
+ID_FS_TYPE=drbd
+ID_FS_USAGE=raid
+ID_FS_UUID=4242424242424242
+ID_FS_UUID_ENC=4242424242424242
+ID_FS_VERSION=v08
diff --git a/tests/expected/blkid/low-probe-drbd-v09 b/tests/expected/blkid/low-probe-drbd-v09
new file mode 100644
index 000000000..0bf0dcfb9
--- /dev/null
+++ b/tests/expected/blkid/low-probe-drbd-v09
@@ -0,0 +1,5 @@
+ID_FS_TYPE=drbd
+ID_FS_USAGE=raid
+ID_FS_UUID=4242424242424242
+ID_FS_UUID_ENC=4242424242424242
+ID_FS_VERSION=v09
diff --git a/tests/ts/blkid/images-fs/drbd-v08.img.xz b/tests/ts/blkid/images-fs/drbd-v08.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..2c8db6b503548fa6a84928835221e56bd50cf21d
GIT binary patch
literal 448
zcmV;x0YCozH+ooF000E$*0e?f03iVu0001VFXf~5fB*r1T>vT?2`6M6hmFeH*o(PS
zp1tm=00zKy=3RzfsZGcrZ>mM$V(L%ml5d06N1~>AxYM85u_9`X_vmT-8`W`TT7sML
zPaqpAoyBG%=5Gz}EYwR@%F<hLyt#qCT5_Izk3posuzX7qV`^v&ie^izY}%0=e%}s5
zWq8OJiY$iY$S*0KPE*0zI{ckQeAQj+hC&lPXP`v*H!Wb@>vFQ>M)p+jh;=M5+rm&(
zks_A{17FE-I~2e&H<+ar0j21p2`cQW|5_%jats!dr@lFlB;jzLrz2nND9eS>m6(ct
zDv|Ohb@v&-2AEBl{n)S7kPpNqQ~33fHZcXIu<mcca7{-H(UB3VtzaFx&ao#LTv>+c
zW>Q$b>2|DH<mFoh2>Hj_t^E5^D|F2sTOdOD-BUgIDP##dfXg9NuJEoKVx8gljQ{VX
z?iCSN(a~RXl-qrn0T4`UiDLo!S%7MlePQ?wJu{b42A3K$U06qpB7EYBTry27Y8V1Y
qt2$Z$0001EiFDCR<%CH90h<GXfLZ{JH_!*M#Ao{g000001X)@i?9ZS8

literal 0
HcmV?d00001

diff --git a/tests/ts/blkid/images-fs/drbd-v09.img.xz b/tests/ts/blkid/images-fs/drbd-v09.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..798042da887a1c4bf9d7644c59378a45ad0c6d05
GIT binary patch
literal 460
zcmV;-0W<#nH+ooF000E$*0e?f03iVu0001VFXf~5fB*rDT>vT?2`6M6hmFeH*o(PS
zp1tm=00zKy=3RzfsZGcrZ>mM$V(L%ml5d06N1~>AxYM85u_9`X_vmT-8`W`TT7sML
zPaqpAoyBG%=5Gz}EYwR@%F<hLyt#qCT5_Izk3posuzX7qV`^v&ie^izY}%0=e%}s5
zWq8OJiY$iY$S*0KPE*0zI{ckQeAQj+hC&lPXP`v*H!Wb@>vFQ>M)p+jh;=M5+rm&(
zks_A{17FE-I~2e&H<+ar0j21p2`cQW|5_%jats!dr@lFlB;jzLrz2nND9eS>m6(ct
zDv|Ohb@v&-2AEBl{n)S7kPpNqQ~33fHZcXIu<mcca7{-H(UB3VtzaFx&ao#LTv>+c
zW>Q$b>2|DH<mFoh2>Hj_t^E5^D|F2sTOdOD-BUgIDP##dfXg9NuJEoKVx8gljQ{VX
z?iCSN(a~RXl-qrn0T4`UiDLo+z?<oXMRDPF4G90lRv5)XCh-EX^N`z?&0M1+*5v3I
zV37IyL|GU)=9T_yM*$@O0000)a<fK4(^F6Y0jC3jfLZ`s@Mv_g#Ao{g000001X)^^
CM%tAC

literal 0
HcmV?d00001

-- 
2.18.0

