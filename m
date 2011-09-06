Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40045 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab1IFUvA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Sep 2011 16:51:00 -0400
Received: by bke11 with SMTP id 11so5811089bke.19
        for <util-linux@vger.kernel.org>; Tue, 06 Sep 2011 13:50:58 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 6 Sep 2011 22:50:58 +0200
Message-ID: <CAMFXF50k2Q7JAQH8kkZkqVCf9SM9ava1EmxRmBzqhdhqO8uQLA@mail.gmail.com>
Subject: agetty: double equals sign typo in opentty()
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux <util-linux@vger.kernel.org>
Cc: werner@suse.de
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello.

agetty.c(988): warning #187: use of "=" where "==" may have been intended
        if (ioctl(STDIN_FILENO, TIOCMGET, &serial) < 0 && (errno = EINVAL)) {
                                                          ^
This was spotted by Intel Compiler.

Francesco
