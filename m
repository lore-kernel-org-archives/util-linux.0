Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:50064 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaECCcu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 May 2014 22:32:50 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 18/21] login-utils/chsh.1: Improve the typesetting of the manual
Date: Sat,  3 May 2014 02:32:36 +0000
Message-Id: <1399084359-28425-2-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Protect a full stop (.), that begins or ends a string, with \&

  Change '-' to '\-', if it indicates an option

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/chsh.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index 5ee0f09..229f5e1 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -29,7 +29,7 @@ If a shell is not given on the command line,
 prompts for one.
 
 .B chsh
-supports non-local entries (kerberos, LDAP, etc.) if linked with libuser,
+supports non-local entries (kerberos, LDAP, etc.\&) if linked with libuser,
 otherwise use ypchsh, lchsh or any other implementation for non-local
 entries.
 .SH OPTIONS
@@ -45,7 +45,7 @@ and exit.
 .B "\-u, \-\-help"
 Display help text and exit.
 .TP
-.B "-v, \-\-version"
+.B "\-v, \-\-version"
 Display version information and exit.
 .SH "VALID SHELLS"
 .B chsh
-- 
1.9.0

