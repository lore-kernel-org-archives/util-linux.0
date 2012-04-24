Return-Path: util-linux-owner@vger.kernel.org
Received: from n26.netmark.pl ([94.124.9.61]:39898 "EHLO n26.netmark.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093Ab2DXP1A (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 11:27:00 -0400
Received: from afmt137.neoplus.adsl.tpnet.pl ([178.42.71.137]:52005 helo=magazyn-ziarno)
	by n26.netmark.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <Marcin.Szewczyk@wodny.org>)
	id 1SMhdq-001NUc-P6
	for util-linux@vger.kernel.org; Tue, 24 Apr 2012 17:26:58 +0200
Date: Tue, 24 Apr 2012 17:26:58 +0200
From: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
To: util-linux@vger.kernel.org
Subject: findmnt: determine mount by pointing to a subdirectory
Message-ID: <20120424152658.GC3813@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi again,

one last issue I have with findmnt is that it seems that it won't show
any output if I point to a subdirectory of a mountpoint. For example
when the whole system is mounted from a single partition and I would
like findmnt to show me some information about / by pointing to
/boot/extlinux.

The idea is based on the df command capability to do such a thing. But
df gives less options in general. I would like to patch one of Debian's
scripts in the extlinux package. Now it uses df to determine drive where
the /boot/extlinux directory resides. It causes problems if / is AUFS.
Findmnt will show the correct block device but I have to loop cutting
off path segments one by one and check if I can find a mount.

Have I missed something? Or is there a possibility of having this kind
of functionality in the future?

-- 
Marcin Szewczyk                       http://wodny.org
mailto:Marcin.Szewczyk@wodny.borg  <- remove b / usuń b
xmpp:wodny@ubuntu.pl                  xmpp:wodny@jabster.pl
