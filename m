Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4A9C5519F
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7862E2225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLxZS4Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKNENZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNENY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:24 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8854C0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:24 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so11607476qkb.7
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V1+aJRkX+tO4seTALRDLUFEwrl6nTI1V+nZVa6xDpjM=;
        b=lLxZS4XopG/WOnOWfiq/HcXesLASfUXTnuN5bDbpopZhzIi/cErHseb7Td6EpBQsnT
         AKLXb7eIqRoX4Vzv7WuPcj+MeNrgKiOUXU9hPSRgSKzdXdBcM+25LbPIPg3EhnPNWpc+
         61Gzlgus7Hpaf2H8tyVvurMh0U/LKpO+li8mMZKp3ZEhPjbHVH1kFtdOsClXpXvKYxpY
         Gy/uvzmMvwLntKY2hWAsvX/AmTSAwOQCrx7tY+R/BoHTFkVZjOet6cDBUZrr4IdLMIDa
         KnzZ1Dzi/wYM2X2GHz1XNMBa/t5GYQMLveGtp0bofGh2ufyuXx52gVth8FH0o9iB87Pn
         FJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V1+aJRkX+tO4seTALRDLUFEwrl6nTI1V+nZVa6xDpjM=;
        b=lFrydxjWbDpkGpr7FoyIKrI/VXWYCbnZWxHNJVBgT1LVeRaqDR8TpUXkTmqqBVhVmU
         Pi1PR8GZh5SFKsbwC3lR9+BDAJhTK8VemJo7dfQdZNAbbtDv4RQ3htPPLsiTsxMfu24d
         DejPqFG+Rrqk8jC8aoo3AUcxjsElfnbbegQQLk1JvPAQTRZBNabE6qTkUBJf0/0/42NG
         9GJgh6/pe4NwryTgVd9lXVpvCEjlSc2x/XIZvOiVUJPLsnWnP+8YPNnN2IApO+Kg060g
         145JgniqVzUED7uBJNsbst8GAIWmTL/b7WXJqAqb0kuiN9VA9L45l82Xjhl4u1x2/pgm
         GI0Q==
X-Gm-Message-State: AOAM531hUv3QPFhF9nd/3/E1jl71CI3boaoqyyec/eIhJ/KM5td6RNxM
        ogUowKeP2GzkI2gbY69VXh90nDJDXw==
X-Google-Smtp-Source: ABdhPJzLvkN4Te5GOEEOoPhEKGj1Sb0zz5ffO/lcxD2bkRvkBfcH/P7Sb9vJvTrz8jUkQGOsDlBKVw==
X-Received: by 2002:a05:620a:140d:: with SMTP id d13mr5436802qkj.470.1605327203711;
        Fri, 13 Nov 2020 20:13:23 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id u31sm8595036qtu.87.2020.11.13.20.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:22 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 0/5] lscpu: Fix socket information on aarch64 machine
Date:   Fri, 13 Nov 2020 23:12:24 -0500
Message-Id: <20201114041229.26417-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

lscpu may show the wrong number of physical sockets on aarch64 machine
as 'Socket(s)'.

That is because lscpu uses a sysfs entry (cpu/cpuX/topology/core_siblings) to
get the number of sockets. For aarch64, the sysfs entry is set from MPIDR_EL1
register if the machine doesn't have ACPI PPTT. According to ARM Architecture
Reference Manual, the register shows the topology as the affinity, but doesn't
show the physical socket information.

There are such aarch64 machines because ARM SBBR v1.0 and v1.1 don't require 
ACPI PPTT. SBBR v1.2 requires ACPI PPTT.

For the aarch64 machine, probably 'Cluster(s)' is good instead of 'Socket(s)'
according to linux/arch/arm64/kernel/topology.c:store_cpu_topology().

To get the number of sockets on the machine, SMBIOS Processor information (Type04)
is useful for lscpu because the SMBIOS information is a mandatory
feature for the aarch64 machine which is based on ARM SBBR v1.0 and newer.

With these patches, lscpu shows as following on the machine:

  For unprivileged user:
    $ lscpu 
    Architecture:            aarch64
    ...
        Socket(s):           -
        Cluster(s):          4

  For root:
    # lscpu 
    Architecture:            aarch64
    ...
        Socket(s):           1
        Cluster(s):          4

Changelog:
	v2: Rebased to the latest lscpu

Masayoshi Mizuma (5):
  lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
  lscpu-virt: split hypervisor_from_dmi_table()
  lscpu-dmi: Move some functions related to DMI to lscpu-dmi
  lscpu: add helper to get physical sockets
  lscpu: show the number of physical socket on aarch64 machine without
    ACPI PPTT

 include/c.h             |   1 +
 sys-utils/Makemodule.am |   1 +
 sys-utils/lscpu-arm.c   |  25 ++++++++++
 sys-utils/lscpu-dmi.c   | 108 ++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu-virt.c  |  62 ++++++-----------------
 sys-utils/lscpu.1       |   3 ++
 sys-utils/lscpu.c       |  47 ++++++++++++++---
 sys-utils/lscpu.h       |  39 +++++++--------
 8 files changed, 209 insertions(+), 77 deletions(-)
 create mode 100644 sys-utils/lscpu-dmi.c

-- 
2.27.0

