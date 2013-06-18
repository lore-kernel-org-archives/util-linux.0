Return-Path: util-linux-owner@vger.kernel.org
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:52311
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3FRFVW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 18 Jun 2013 01:21:22 -0400
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by snark.thyrsus.com (Postfix) with ESMTP id 36DA3417C5
	for <util-linux@vger.kernel.org>; Tue, 18 Jun 2013 01:14:02 -0400 (EDT)
Content-Type: multipart/mixed; boundary="===============7769751279321074495=="
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Problems in logger.1
Message-Id: <20130618051402.36DA3417C5@snark.thyrsus.com>
Date: Tue, 18 Jun 2013 01:14:02 -0400 (EDT)
From: esr@thyrsus.com
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--===============7769751279321074495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automatically generated email about markup problems in a man
page for which you appear to be responsible.  If you are not the right
person or list, please tell me so I can correct my database.

See http://catb.org/~esr/doclifter/bugs.html for details on how and
why these patches were generated.  Feel free to email me with any
questions.  Note: These patches do not change the modification date of
any manual page.  You may wish to do that by hand.

I apologize if this message seems spammy or impersonal. The volume of
markup bugs I am tracking is over five hundred - there is no real
alternative to generating bugmail from a database and template.

--
                             Eric S. Raymond

--===============7769751279321074495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Problems with logger.1:

My records indicate that you have accepted this patch, so this is just
a reminder.

Wrong order of arguments in .Dd macro.

--- logger.1-unpatched	2012-06-29 10:17:28.914062782 -0400
+++ logger.1	2012-06-29 10:18:16.278061896 -0400
@@ -33,7 +33,7 @@
 .\"
 .\" Section on valid facility and level strings added by
 .\" and1000@debian.org, 26 Oct 1997.
-.Dd August 2011 "  "
+.Dd August "  " 2011 
 .Dt LOGGER(1) "" "User Commands"
 .Os util-linux
 .Sh NAME

--===============7769751279321074495==--
