Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34757 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1KHIBe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 03:01:34 -0500
Received: by iage36 with SMTP id e36so265379iag.19
        for <util-linux@vger.kernel.org>; Tue, 08 Nov 2011 00:01:34 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 8 Nov 2011 17:01:32 +0900
Message-ID: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com>
Subject: behavior of "# mount /dev"
From: KIMURA Masaru <hiyuh.root@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

A user continues to mumble about behavior of "# mount /dev" in this list [1].
He said, he did accidentally type

 # mount /dev

and "ls /dev" shows only initctl under /dev.

"man mount" said,

       If only directory or device is given, for example:

              mount /dir

       then mount looks for a mountpoint and if not found then for a
device in the /etc/fstab file.

so I guess this is an undocumented behavior.

Naohiro Aota explains that this is expected tmpfs' behavior in kernel. [2]
And I think "just don't do such thing."
But this user still doesn't accept this undocumented mount behavior.

any thought?

[1] http://ml.gentoo.gr.jp/users/201111.month/2194.html
[2] http://ml.gentoo.gr.jp/users/201111.month/2195.html
