Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:63853 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbaFJKIy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Jun 2014 06:08:54 -0400
Received: from tenfore.ga-group.nl ([77.185.92.122]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0MOfQw-1WoFEo0ftW-0066r6 for
 <util-linux@vger.kernel.org>; Tue, 10 Jun 2014 12:08:52 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] next try to update gettext version
Date: Tue, 10 Jun 2014 12:08:50 +0200
Message-Id: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch is just a proposal. Is it not too ugly to do it that way?
For a final patch I would improve shell portability and error
handling.

Ruediger Meier (1):
  build-sys: use gettext 0.18.3 if possible

 autogen.sh   | 31 ++++++++++++++++++++++++++++++-
 configure.ac |  3 ++-
 2 files changed, 32 insertions(+), 2 deletions(-)

-- 
1.8.4.5

