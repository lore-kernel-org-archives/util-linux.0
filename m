Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60303 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab1KWACs convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Nov 2011 19:02:48 -0500
Received: by bke11 with SMTP id 11so884163bke.19
        for <util-linux@vger.kernel.org>; Tue, 22 Nov 2011 16:02:47 -0800 (PST)
MIME-Version: 1.0
From: Paul Stone <Paul@Stone.org>
Date: Tue, 22 Nov 2011 16:02:26 -0800
Message-ID: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com>
Subject: how can I compile mount and umount as shared object files?
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

I'm trying to build util-linux-ng-2.19.1, specifically to get the
updated mount and umount in order to work around a bug which
interferes with FUSE.  But, building from source with 'make
install-strip' produces executables, as opposed to shared object files
like the ones which are in the /bin directory of my CentOS 6
distribution.  Can anyone enlighten me on how to produce shared object
files for these two utilities?  I also don't know what the distinction
is between SYSV and GNU/Linux in terms of the identification of the
file type.

[root@xxxx .libs]# file *
mount:  setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped
umount: setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped

[root@xxxx .libs]# file /bin/mount /bin/umount
/bin/mount:  setuid ELF 64-bit LSB shared object, x86-64, version 1
(GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
2.6.18, stripped
/bin/umount: setuid ELF 64-bit LSB shared object, x86-64, version 1
(GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
2.6.18, stripped

Thanks and best regards,
Paul Stone
