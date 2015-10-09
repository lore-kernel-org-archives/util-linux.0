Return-Path: util-linux-owner@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:56397 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911AbbJIIbp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Oct 2015 04:31:45 -0400
Received: from probook.fritz.box ([2001:a62:87:fc01:f9dc:1083:91c1:86d1])
	by smtp.strato.de (RZmta 37.13 AUTH)
	with ESMTPSA id q040e5r998PgSTU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <util-linux@vger.kernel.org>;
	Fri, 9 Oct 2015 10:25:42 +0200 (CEST)
Date: Fri, 9 Oct 2015 10:25:41 +0200
From: Olaf Hering <olaf@aepfle.de>
To: util-linux@vger.kernel.org
Subject: regression in logger output to syslog
Message-ID: <20151009082541.GA9068@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I used a script with openSUSE 11.4 which called logger like this:
# logger -t "$l[$PPID] $i" "`sed -n ${c}p < $t`"

The tag was something like "me[123] foo: blah", and the number remained
stable for a single run.

Now with systemd and util-linux-2.26.2 the number does always change. If
I understand the man page correctly this is supposed to achieve the
same, but the $PPID never made it into journalctl -f outout:

logger -t "me"  --id=$PPID "foo: blah"

Instead the pid of the logger processs is used.
How can I restore the old behaviour?

Olaf
