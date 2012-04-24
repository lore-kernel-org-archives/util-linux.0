Return-Path: util-linux-owner@vger.kernel.org
Received: from n26.netmark.pl ([94.124.9.61]:41237 "EHLO n26.netmark.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759Ab2DXOk6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 10:40:58 -0400
Received: from afmt137.neoplus.adsl.tpnet.pl ([178.42.71.137]:51768 helo=magazyn-ziarno)
	by n26.netmark.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <Marcin.Szewczyk@wodny.org>)
	id 1SMgvI-001Ls7-0k
	for util-linux@vger.kernel.org; Tue, 24 Apr 2012 16:40:56 +0200
Date: Tue, 24 Apr 2012 16:40:55 +0200
From: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
To: util-linux@vger.kernel.org
Subject: findmnt: parsing mountpoints with spaces
Message-ID: <20120424144055.GB3813@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

is there a way to make findmnt print unambiguous output in case of block
devices/directories/mountpoints whose names contain spaces? I can see
that --raw makes findmnt print undecorated output, but spaces remain not
escaped.

May I request a feature of escaping spaces and possibly other
non-printable characters in a fstab manner (\040 for space)?

-- 
Marcin Szewczyk                       http://wodny.org
mailto:Marcin.Szewczyk@wodny.borg  <- remove b / usuń b
xmpp:wodny@ubuntu.pl                  xmpp:wodny@jabster.pl
