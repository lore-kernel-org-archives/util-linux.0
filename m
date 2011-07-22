Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:46141 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab1GVIKB convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 04:10:01 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Fri, 22 Jul 2011 10:09:57 +0200
Subject: ionice: requires scheduling since
 7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since 7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510, ionice requires a "scheduling".

  $ schedutils/ionice 123
  ionice: scheduling for the COMMAND not specified

As `ionice` is the sister of `nice`, I question why a certain prio/class is needed.
What's wrong with not passing a certain prio/class?
Second, doesn't this break existing scripts which rely on "123" being executed?

Have a nice day,
Berny


