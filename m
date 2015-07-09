Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.pxnet.com ([89.1.7.7]:37261 "EHLO mail.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbGINbg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Jul 2015 09:31:36 -0400
Message-Id: <cover.1436438005.git.tilman@imap.cc>
From: Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH 0/3] ldattach updates
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Tilman Schmidt <tilman@imap.cc>,
        Paul Bolle <pebolle@tiscali.nl>, Sami Kerola <kerolasa@iki.fi>
Date: Thu,  9 Jul 2015 15:22:32 +0200 (CEST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Please merge the following three patches for ldattach.

Thanks,
Tilman

Tilman Schmidt (3):
  ldattach: adapt print_table column width to widest entry
  ldattach: order line disciplines canonically
  ldattach: always set line speed and format for N_GIGASET_M101

 sys-utils/ldattach.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
1.9.2.459.g68773ac

