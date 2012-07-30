Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60723 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2G3VUP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 30 Jul 2012 17:20:15 -0400
Received: by bkwj10 with SMTP id j10so3017061bkw.19
        for <util-linux@vger.kernel.org>; Mon, 30 Jul 2012 14:20:14 -0700 (PDT)
Date: Tue, 31 Jul 2012 00:20:10 +0300
From: "Mantas M." <grawity@gmail.com>
To: util-linux@vger.kernel.org
Subject: vipw does not work with some editors
Message-ID: <20120730212010.GA56766@rain.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
save" in which the old file is deleted and a new one with the same name
created in its place. When `vipw` is used with such an editor, it never
detects changes, because it compares fstat() on a file descriptor
pointing to the old file.

Can this be fixed in `vipw`, or should I just start configuring Vim to
stop making backups for vipw's temporary files?

-- 
Mantas Mikulėnas <grawity@gmail.com>
