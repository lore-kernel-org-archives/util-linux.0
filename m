Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f182.google.com ([209.85.215.182]:45150 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858Ab3FSOx2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Jun 2013 10:53:28 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so3343905eaj.13
        for <util-linux@vger.kernel.org>; Wed, 19 Jun 2013 07:53:27 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 19 Jun 2013 16:53:27 +0200
Message-ID: <CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com>
Subject: forking in setsid
From: Damien Wyart <damien.wyart@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

While searching information about setsid and daemonization, I came accros
the following "bug" report in Debian :
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495881

Unfortunately, it doesn't seem to have been forwarded upstream after
creation, and never received an answer.

I would be interested in getting your opinions about it and the patch
attached to it.

Thanks in advance

Best regards,

Damien
