Return-Path: olaf@aepfle.de
Date: Thu, 30 Jun 2011 13:00:12 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Karel Zak <kzak@redhat.com>
Cc: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't try to chgrp write or wall if they are not built
Message-ID: <20110630110012.GA10923@aepfle.de>
References: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
 <20110630085327.GA8274@aepfle.de>
 <20110630103325.GN6418@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110630103325.GN6418@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 30, Karel Zak wrote:

>  Why do you expect that everyone uses any packaging system? The "make
>  install" result should be usable. Note that this all is controlled by
>  --disable-makeinstall-chown and --disable-makeinstall-setuid options.

Karel,

after I sent the mail I noticed the if MAKEINSTALL_DO_CHOWN,
so all should be fine.

Olaf
