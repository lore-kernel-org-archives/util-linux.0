Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:51055 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab3KURfw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Nov 2013 12:35:52 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] pylibmount: correctly import from pylibmount.so
Date: Thu, 21 Nov 2013 12:25:27 -0500
Message-Id: <1385054727-20661-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Without this, python is unable to find the module:

$ python -c 'import libmount'
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/usr/lib/python3.3/site-packages/libmount/__init__.py", line 1, in <module>
    from pylibmount import *
ImportError: No module named 'pylibmount'

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/python/libmount/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/python/libmount/__init__.py b/libmount/python/libmount/__init__.py
index 243c639..09104e2 100644
--- a/libmount/python/libmount/__init__.py
+++ b/libmount/python/libmount/__init__.py
@@ -1,2 +1,2 @@
-from pylibmount import *
+from .pylibmount import *
 
-- 
1.8.4.2

