Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59850 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbdDJWzE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 18:55:04 -0400
Subject: [PATCH 2/5] parse-date: remove extraneous form feed
To: Karel Zak <kzak@redhat.com>
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <92ce0b16-4415-f9e5-72c1-8c95c6a29d2f@gmx.com>
Date: Mon, 10 Apr 2017 18:54:53 -0400
MIME-Version: 1.0
In-Reply-To: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* lib/parse-date.y: Remove extraneous form feed (FF, 0x0C, ^L).

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index 7bfdb36..66ec722 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -874,8 +874,6 @@ static table const military_table[] = {
 	{ NULL, 0, 0 }
 };
 
-
-
 /**
  * Convert a time zone expressed as HH:MM into an integer count of
  * minutes.  If MM is negative, then S is of the form HHMM and needs
