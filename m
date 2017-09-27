Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751016AbdI0RpJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 Sep 2017 13:45:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8RHi2Hi062333
        for <util-linux@vger.kernel.org>; Wed, 27 Sep 2017 13:45:08 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2d8dmm2p3p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 27 Sep 2017 13:45:08 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 27 Sep 2017 18:45:06 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 0/3] lsmem/chmem: add memory zone awareness
Date: Wed, 27 Sep 2017 19:44:43 +0200
Message-Id: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These patches are against lsmem/chmem in util-linux, they add support
for listing and changing memory zone allocation.

Added Michal Hocko and linux-mm on cc, to raise general awareness for
the lsmem/chmem tools, and the new memory zone functionality in
particular. I think this can be quite useful for memory hotplug kernel
development, and if not, sorry for the noise.

Andre Wild (1):
  lsmem/chmem: add memory zone awareness to bash-completion

Gerald Schaefer (2):
  lsmem/chmem: add memory zone awareness
  tests/lsmem: update lsmem test with ZONES column

 bash-completion/chmem                  |   1 +
 bash-completion/lsmem                  |   2 +-
 sys-utils/chmem.8                      |  19 +++++
 sys-utils/chmem.c                      | 136 +++++++++++++++++++++++++++++++--
 sys-utils/lsmem.1                      |   4 +-
 sys-utils/lsmem.c                      |  98 +++++++++++++++++++++++-
 tests/expected/lsmem/lsmem-s390-zvm-6g |  21 +++++
 tests/expected/lsmem/lsmem-x86_64-16g  |  39 ++++++++++
 tests/ts/lsmem/lsmem                   |   1 +
 9 files changed, 309 insertions(+), 12 deletions(-)

-- 
2.13.5

