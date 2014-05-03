Return-Path: util-linux-owner@vger.kernel.org
Received: from katla.rhi.hi.is ([130.208.165.1]:50065 "EHLO katla.rhi.hi.is"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbaECCcu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 May 2014 22:32:50 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH 17/21] login-utils/chfn.1: Improve the typesetting of the manual
Date: Sat,  3 May 2014 02:32:35 +0000
Message-Id: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change comma (,) to a period (.) as it is the control character

  Use macro RB instead of the reverse one (BR)

  Add missing [ in front of  an (optional) option

  Protect a full stop (.), that begins or ends a string, with \&

  Change '-' to '\-', if it indicates an option

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/chfn.1 |   8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 2c35acd..3b44fb3 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -19,11 +19,11 @@ chfn \- change your finger information
 .IR full-name ]
 .RB [ \-o
 .IR office ]
-,RB [ \-p
+.RB [ \-p
 .IR office-phone ]
 .RB [ \-h
 .IR home-phone ]
-.BR \-u ]
+.RB [ \-u ]
 .RB [ \-v ]
 .RI [ username ]
 .SH DESCRIPTION
@@ -40,7 +40,7 @@ command will display four pieces of information that can be changed by
 your real name, your work room and phone, and your home phone.
 
 .B chfn
-supports non-local entries (kerberos, LDAP, etc.) if linked with libuser,
+supports non-local entries (kerberos, LDAP, etc.\&) if linked with libuser,
 otherwise use ypchsh, lchsh or any other implementation for non-local
 entries.
 .SS COMMAND LINE
@@ -71,7 +71,7 @@ Specify your home phone number.
 .B "\-u, \-\-help"
 Display help text and exit.
 .TP
-.B "-v, \-\-version"
+.B "\-v, \-\-version"
 Display version information and exit.
 .SH "EXIT STATUS"
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
-- 
1.9.0

