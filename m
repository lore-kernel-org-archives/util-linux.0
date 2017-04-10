Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdDJW5C (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Apr 2017 18:57:02 -0400
Subject: [PATCH 3/5] docs: parse-date.txt fix whitespace
To: Karel Zak <kzak@redhat.com>
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d83cbd5b-63e7-9427-0f2d-88be0b883622@gmx.com>
Date: Mon, 10 Apr 2017 18:56:53 -0400
MIME-Version: 1.0
In-Reply-To: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/parse-date.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/parse-date.txt b/Documentation/parse-date.txt
index cb06a47..56bed1e 100644
--- a/Documentation/parse-date.txt
+++ b/Documentation/parse-date.txt
@@ -4,7 +4,7 @@ NAME
 
 SYNOPSIS
 	#include "timeutils.h"
-	
+
 	int parse_date(struct timespec *result, char const *p,
 			struct timespec const *now)
 
@@ -15,7 +15,7 @@ DESCRIPTION
 	The string itself is pointed to by *p.  Return 1 if successful.
 	*p can be an incomplete or relative time specification; if so, use
 	*now as the basis for the returned time.
-	
+
 
 This function is based upon gnulib's parse-datetime.y-dd7a871.
 
