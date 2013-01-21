Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49922 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab3AUGil (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jan 2013 01:38:41 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 0/5] nsenter,unshare: small usability improvements
Date: Mon, 21 Jan 2013 01:38:00 -0500
Message-Id: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

those patches are ON TOP OF SAMI KREOLA'S SERIES
(nsenter: trivial adjustments).

Zbigniew Jędrzejewski-Szmek (5):
  nsenter: allow arguments to be specified in any order
  nsenter: add --all meaning all namespaces and cwd and root
  nsenter: respect --exec no matter where it appears
  nsenter: rename --exec/-e to --no-fork/-F
  unshare: add --all meaning all namespaces

 sys-utils/nsenter.1 |   7 +++-
 sys-utils/nsenter.c | 104 ++++++++++++++++++++++++++++++++++++++++------------
 sys-utils/unshare.1 |   3 ++
 sys-utils/unshare.c |   9 ++++-
 4 files changed, 98 insertions(+), 25 deletions(-)

-- 
1.7.11.7

