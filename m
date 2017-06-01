Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63274 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbdFAXw4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 19:52:56 -0400
Subject: [PATCH] docs: add information about mailing list rejection
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ae872096-28df-bc31-4a50-734a41ac79b1@gmx.com>
Date: Thu, 1 Jun 2017 19:52:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

The following changes since commit 535a4090b46395d86fa4a1bafb199e56c3968c95:

  lib/pager: don't use pager if command not available (2017-06-01 14:20:20 +0200)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 170601

for you to fetch changes up to b3d41ca07c071cc8be2a2cc089594ecdc43a1a08:

  docs: add information about mailing list rejection (2017-06-01 19:42:21 -0400)

----------------------------------------------------------------
J William Piggott (1):
      docs: add information about mailing list rejection

 Documentation/howto-contribute.txt | 6 ++++--
 README                             | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto-contribute.txt b/Documentation/howto-contribute.txt
index 71b9ed7..245f9ab 100644
--- a/Documentation/howto-contribute.txt
+++ b/Documentation/howto-contribute.txt
@@ -84,8 +84,8 @@ Email Format
 	  Hint: use git commit -s
 
 	  The sign-off is a simple line at the end of the explanation for the
-	  patch, which certifies that you wrote it or otherwise have the
-	  right to pass it on as a open-source patch. The rules are pretty
+	  patch; which certifies that you wrote it or otherwise have the
+	  right to pass it on as an open-source patch. The rules are pretty
 	  simple; if you can certify the following:
 
 	  By making a contribution to this project, I certify that:
@@ -124,6 +124,8 @@ Email Format
 
 	* Followed by the unified diff patch.
 
+	Note: the mailing list will reject certain content. See ../README.
+
 Coding Style
 
 	* the preferred coding style is based on the linux kernel coding-style.
diff --git a/README b/README
index 81e0504..5656932 100644
--- a/README
+++ b/README
@@ -10,6 +10,12 @@ MAILING LIST:
       E-MAIL: util-linux@vger.kernel.org
       URL:    http://vger.kernel.org/vger-lists.html#util-linux
 
+      The mailing list will reject email messages that contain:
+       - more than 100K characters
+       - html
+       - spam phrases/keywords
+      See: http://vger.kernel.org/majordomo-info.html#taboo
+
 IRC CHANNEL:
 
       #util-linux at freenode.net:
