Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50204 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeABO76 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 2 Jan 2018 09:59:58 -0500
Subject: [v3 PATCH 07/11] cal: update mutually exclusive options
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <34823c08-b6c2-1513-e2e3-aa5148a369d9@gmx.com>
Date: Tue, 2 Jan 2018 09:59:56 -0500
MIME-Version: 1.0
In-Reply-To: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 02283bc04..00c00ebc0 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -300,7 +300,9 @@ int main(int argc, char **argv)
 	};
 
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
-		{ 'Y','n','y' },
+		{ '1', '3', 'Y', 'n', 'y' },
+		{ 'm', 's' },
+		{ OPT_1752_REFORM, OPT_CAESAR },
 		{ 0 }
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
