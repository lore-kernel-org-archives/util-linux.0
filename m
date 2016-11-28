Return-Path: util-linux-owner@vger.kernel.org
Received: from canardo.mork.no ([148.122.252.1]:53645 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcK1QL4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 28 Nov 2016 11:11:56 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 2/2] sulogin: make Control-D break out of the main loop
Date: Mon, 28 Nov 2016 17:11:28 +0100
Message-Id: <20161128161128.2657-3-bjorn@mork.no>
In-Reply-To: <20161128161128.2657-1-bjorn@mork.no>
References: <20161128161128.2657-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

getpasswd() must return NULL to force breaking out of
the main loop.  Anything else will be treated as a password
to be verified, and will end up with

  Login incorrect

and a repeated password prompt.

(unless the root password happened to be Control-D :)

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 login-utils/sulogin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 6a3890e80a16..7fe938150e19 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -695,6 +695,7 @@ static char *getpasswd(struct console *con)
 				ptr--;
 			break;
 		case CEOF:
+			ret = (char*)0;
 			goto quit;
 		default:
 			if ((size_t)(ptr - &pass[0]) >= (sizeof(pass) -1 )) {
-- 
2.10.2

