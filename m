Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94425C5519F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B49A2236F
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxhdrnwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKTFGX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgKTFGX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:23 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF2C0613CF
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:21 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id f5so6579715ilj.9
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SmsDv2B9QWZsWQuKVJW0DIF+b0gLhcDUf/MmFxstbIE=;
        b=TxhdrnwCVhEw54potTjtMCzAYgY+r3dRP3/7LZ7CVw6Ex62sySOsespSvkbsLkdRwy
         9y+XUBi/aGfq4pgQUUj4ChoGbA2hM2IdurO2TqL8gA55eCbLXW/i39ljm3PyUDh3rvqi
         57d1aCuTj94QFwOFJEEnz0SN68qqgqkINpVIr7HAKRdM/B8bL15X9UUZ5vVX9/UhqGU+
         rmeXYq3sfltOy5pC02q6z9C8XgRAn4o9+Y5NXcpP5mKMKtiEPj4zcfzsgrBOWWUCoj5g
         D1iIWqXTeTMWBRcqFXuDGGCQCN1MbfnDN8Bd/zHmURA8nIdxmHjQ8HiFs5+wAMQvmAoP
         2G8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SmsDv2B9QWZsWQuKVJW0DIF+b0gLhcDUf/MmFxstbIE=;
        b=gxE5BHdtbnG3fBsajl4pQwig/XeQXxDvhsuKmtzngdTb7gMitb86BsYNqTlrq+lQU7
         zyS/TKYmAthqoIldEwPc3bMCY4j+c5gaAYKI3RPVKemD2xzpHmjpAbsFPszRXlBwAYil
         4k0SdquzSukALskK0xJ4S2wsevFALXbnwHBTdvy5hFJl1DMW/A5GrG+X94CR8JAAmWKX
         7D8O6Uwu7dLZG5j4iVrU2QRUyB7wk0t8HxQNW9YIt8Y95Lf9AsWiKDTOeS5DusgSixBK
         /NAzl21MGxNz3wLdAqrPXo0fxGHlySeTFuONlj9M+FcMn9dIOKU1OvtmHAiIHRqUEeBC
         y8oA==
X-Gm-Message-State: AOAM532t5GgmvpWfDNl4IEU8/UaHGIJj6DMZWQbGTdKsIpvQh3PodVwt
        sE+6WuYQ0s66E4Fu9Kv97kDBBEJT3A==
X-Google-Smtp-Source: ABdhPJwzX31ULFYMrDy06yY7twtP5ktGdIQJIirhyv5DaarVqpKOvh6jJ88y37qnz4zOg0pNjgyNhg==
X-Received: by 2002:a05:6e02:ea5:: with SMTP id u5mr8397099ilj.188.1605848781088;
        Thu, 19 Nov 2020 21:06:21 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k18sm776985iow.4.2020.11.19.21.06.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:20 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH v3 0/5] lscpu: Fix socket information on aarch64 machine
Date:   Fri, 20 Nov 2020 00:06:04 -0500
Message-Id: <20201120050609.17409-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

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
        v3: Remove cluster/socket column checking. Make lscpu_is_cluster_arm()
            static (0001 patch)
	v2: Rebased to the latest lscpu

Masayoshi Mizuma (5):
  lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
  lscpu-virt: split hypervisor_from_dmi_table()
  lscpu-dmi: Move some functions related to DMI to lscpu-dmi
  lscpu: add helper to get physical sockets
  lscpu: show the number of physical socket on aarch64 machine without
    ACPI PPTT

 sys-utils/Makemodule.am |   1 +
 sys-utils/lscpu-arm.c   |  15 ++++++
 sys-utils/lscpu-dmi.c   | 108 ++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu-virt.c  |  62 ++++++-----------------
 sys-utils/lscpu.1       |   3 ++
 sys-utils/lscpu.c       |  39 ++++++++++++---
 sys-utils/lscpu.h       |  38 ++++++--------
 7 files changed, 190 insertions(+), 76 deletions(-)
 create mode 100644 sys-utils/lscpu-dmi.c

-- 
2.27.0

