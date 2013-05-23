Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:57153 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab3EWK5P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 May 2013 06:57:15 -0400
Message-ID: <519DF601.4090700@bernhard-voelker.de>
Date: Thu, 23 May 2013 12:57:05 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC: 10317@debbugs.gnu.org
Subject: su: -l and -p should not be used together
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

tag 10317 wontfix
close 10317
stop

A while ago, there has been a bug report to coreutils regarding
the unlucky use of the -p and the -l option (or a bare "-") with su:
  http://bugs.gnu.org/10317

As su is not part of coreutils anymore, I'm hereby closing the bug
there, and forward this issue to util-linux where su is now maintained.

@Karel:
do you think it's worth a warning/error?
However, the agreement was that the behaviour should at least
be documented.

Have a nice day,
Berny

