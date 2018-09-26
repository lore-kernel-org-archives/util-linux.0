Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52281 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbeIZMec (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 08:34:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 07D8721E1C
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:14 -0400 (EDT)
Received: from apu2 (x4db4907c.dyn.telefonica.de [77.180.144.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F48DE47C0
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:13 -0400 (EDT)
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Fixes for v2.33 on musl-based systems
Date: Wed, 26 Sep 2018 08:23:07 +0200
Message-Id: <cover.1537942755.git.ps@pks.im>
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

there are two small issues I discovered in v2.33-rc1 on
musl-based systems. The first patch fixes a compile error, the
second patch fixes a warning.

Regards
Patrick

Patrick Steinhardt (2):
  lsblk: fix unknown type `stat` caused by missing header
  rename: avoid undefined function prototype for `fpurge`

 misc-utils/lsblk.h  | 1 +
 misc-utils/rename.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.19.0
