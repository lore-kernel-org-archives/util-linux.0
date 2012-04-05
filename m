Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44086 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab2DEPuU (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 5 Apr 2012 11:50:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 9A9B61B4013
	for <util-linux-ng@vger.kernel.org>; Thu,  5 Apr 2012 15:50:18 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH 1/3] eject: constify array
Date: Thu,  5 Apr 2012 11:50:44 -0400
Message-Id: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/eject.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 2d8b0cb..68d5e9c 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -64,7 +64,7 @@
 /* eject(1) is able to eject only 'removable' devices (attribute in /sys)
  * _or_ devices connected by hotplug subsystem.
  */
-static const char *hotplug_subsystems[] = {
+static const char * const hotplug_subsystems[] = {
 	"usb",
 	"ieee1394",
 	"pcmcia",
-- 
1.7.8.5

