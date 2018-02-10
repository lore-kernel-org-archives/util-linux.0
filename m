Return-Path: util-linux-owner@vger.kernel.org
Received: from hera.aquilenet.fr ([185.233.100.1]:58190 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeBJSXb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 10 Feb 2018 13:23:31 -0500
Date: Sat, 10 Feb 2018 19:13:44 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: ready for v2.32 ?
Message-ID: <20180210181344.dtskxnhpla4btvrr@var.youpi.perso.aquilenet.fr>
References: <20180207094731.cvuyp3txmcom3u3u@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hi3icq3p3k3j4i2f"
In-Reply-To: <20180207094731.cvuyp3txmcom3u3u@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--hi3icq3p3k3j4i2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here is a small build fix for the case where USE_PTY is not defined.

Samuel

--hi3icq3p3k3j4i2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index afd75a1f1..9c6267f25 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -1417,8 +1417,10 @@ int su_main(int argc, char **argv, int mode)
 		setsid();
 	}
 
+#ifdef USE_PTY
 	if (su->pty)
 		pty_init_slave(su);
+#endif
 
 	/* Set environment after pam_open_session, which may put KRB5CCNAME
 	   into the pam_env, etc.  */

--hi3icq3p3k3j4i2f--
