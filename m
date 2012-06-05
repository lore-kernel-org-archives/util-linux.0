Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:59827 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2FEPRx (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 5 Jun 2012 11:17:53 -0400
Date: Tue, 5 Jun 2012 17:17:49 +0200 (CEST)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux-ng@vger.kernel.org
Message-ID: <318289300.205241.1338909469539.JavaMail.open-xchange@email.1und1.de>
Subject: make install: some SUID-root programs?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

 Today, only write and wall seem to get SUID/SGID privileges during
"make install". What about others? E.g. login and su would deserve
to be `chmod u+s`-ed, right?
Or is this a task of the distributions?

Have a nice day,
Berny
