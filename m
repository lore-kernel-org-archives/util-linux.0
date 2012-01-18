Return-Path: util-linux-owner@vger.kernel.org
Received: from nm1-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.202]:25744 "HELO
	nm1-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756587Ab2ARCAB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jan 2012 21:00:01 -0500
Message-ID: <4F16279F.3040100@yahoo.com.ar>
Date: Tue, 17 Jan 2012 22:59:59 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>
Subject: Buffer I/O error, with latest losetup on first run
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello

Using (losetup from util-linux 2.20.620-4360-dirty) and Linux-3.2.1.

Using losetup as first time, if loop module is not loaded, losetup -f 
file-equal-or-below-1MiB I get: "Buffer I/O error on device loop0, 
logical block 0" (sometimes get one message, or two or three, ...)

Can be reproducible again if loop module is unloaded then execute losetup.
Does not happen if module is loaded previously to losetup.
Happens independently if /dev/loop0 exists or not.

Does not happen with losetup from 2.20 under the same conditions.

Maybe a race-condition?

-- 
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha = 1

