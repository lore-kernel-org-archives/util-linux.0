Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA3C433E2
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC70221ED
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USi+3VUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIKQLe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIKPhk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 11:37:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F36C0617AA
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c18so7883170qtw.5
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rVj7ku69dyuIzn+1DtD9Yn0HeL/5hpkP461+8nAz/Xg=;
        b=USi+3VUqrlOnXp+xGIvl703cpjKOWVFLMuJFq0BQ1E3JpWKORPchKWBdTZ0eSjqYYj
         iCCPXfviN4R3ggVTOWnCogO8+OI59sAMJ91s4ejZeuPiuOnkZWyO5wqo0SlNClUjE6yi
         6TbjZbJNjEK9qvNz8TXuRYarRhvavjK+tzD9HHHB1erSe2VauKTwx/a9QRDEE+fnlocK
         Zdsekh2vJyJocsenAAhOls6DTxSwdBRWDUDRkHg2bY9g91q/L/eUfLsaFI30QbMkaRu1
         tKNPY8S0Bx/5UTmFCPJlUE9OB5gq0NvyYW/BY3RvvYeDu0MAuXgbg2/cU8icDYgYSHVY
         sSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rVj7ku69dyuIzn+1DtD9Yn0HeL/5hpkP461+8nAz/Xg=;
        b=muIjoLdaWGFuPJBFQm17ZALSvlM/3mwJ2FWqDS4TFgstGlhE23wbR2OLJUzdvdi6rh
         irSWK7TEquWOEtwDZoNBVD5ymnv6UOhjHx8pPpCaKOx+4fUMCXOvrCmEGvDifYWS2bQ/
         AJq1cKcXVJfUXtFZTsSFTneZr2nwcP7s8LZKQvZlwuMT4ppjYjy4kOQ9mtuFk4TO1ggC
         TEnDvdZIsRC3n5M+tZp9wjpyzPloDZon5Av27i849qknVPavOUIz7cJnfJnTO9iAOdGn
         3hQ/P16Qs0xilSUxpzOUfpqug29wPH5uLnYl0ZBXzHtoaq2G3e0aDJAUk1nlEzSj/VSI
         /M8A==
X-Gm-Message-State: AOAM530rkyV/NQ51PLjZp5n2VQXgBQQB+b3+V+1P9IivlBeY6tb1AKsj
        w9Hep9YzUTJwdddMosqVyyu4OKDpxw==
X-Google-Smtp-Source: ABdhPJxbSYzi6u8+1aZPJkMenjpFbiJ+5G0fUZVhjsLgR7xEFAJzRGctxfJUE2WpQnB2psRIVS7nTQ==
X-Received: by 2002:aed:2308:: with SMTP id h8mr1963196qtc.65.1599832435590;
        Fri, 11 Sep 2020 06:53:55 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id u66sm3223893qka.136.2020.09.11.06.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:53:55 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH 0/4] lscpu: Fix socket information on aarch64 machine
Date:   Fri, 11 Sep 2020 09:53:24 -0400
Message-Id: <20200911135328.1465-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: util-linux-owner@vger.kernel.org
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

There're such aarch64 machines because ARM SBBR v1.0 and v1.1 don't require 
ACPI PPTT. SBBR v1.2 requires ACPI PPTT.

For the aarch64 machine, probably 'Cluster(s)' is good instead of 'Socket(s)'
according to linux/arch/arm64/kernel/topology.c:store_cpu_topology().

To get the number of sockets on the machine, SMBIOS Processor information (Type04)
is useful for lscpu because the SMBIOS information is a mandatory
feature for the aarch64 machine which is based on ARM SBBR v1.0 and newer.

With these patches, lscpu shows as following on the machine:

  For unprivileged user:
    $ lscpu 
    Architecture:                    aarch64
    ...
    Socket(s):                       -
    Cluster(s):                      4
    ...

  For root:
    # lscpu
    Architecture:                    aarch64
    ...
    Socket(s):                       1
    Cluster(s):                      4

Masayoshi Mizuma (4):
  lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
  lscpu-dmi: split to parse dmi table
  lscpu: add helper to get physical sockets
  lscpu: show physical socket on aarch64 without ACPI PPTT

 sys-utils/lscpu-dmi.c | 90 +++++++++++++++++++++++++++++++++----------
 sys-utils/lscpu.1     |  3 ++
 sys-utils/lscpu.c     | 75 ++++++++++++++++++++++++++++++++----
 sys-utils/lscpu.h     |  1 +
 4 files changed, 142 insertions(+), 27 deletions(-)

-- 
2.27.0
