Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:52206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab2FFLuy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 07:50:54 -0400
Message-ID: <4FCF441C.1090400@bernhard-voelker.de>
Date: Wed, 06 Jun 2012 13:50:52 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: su: calling setsid() for -c only if non-root user?
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am playing around with the --command and --session-command options of su,
and I noticed that setsid() is only called iff a non-root new_user is given:

  if (request_same_session || !command || !pw->pw_uid)
    same_session = 1;
  ...
  if (!same_session)
    setsid ();

Why is the setsid() call dependent on the user?

The commit and the bug behind it don't give an answer
(c6a1746b5f5247b2fccaf5c7f68da3852a02e4fc):

    call setsid() when called with -c

    Prevents command injection via TIOCSTI

    https://bugzilla.redhat.com/show_bug.cgi?id=173008

Have a nice day,
Berny
