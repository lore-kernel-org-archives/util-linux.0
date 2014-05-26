Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59936 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbaEZPqM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 May 2014 11:46:12 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so7748486pab.17
        for <util-linux@vger.kernel.org>; Mon, 26 May 2014 08:46:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140526101102.GE2968@x2.net.home>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-5-git-send-email-kerolasa@iki.fi>
	<1400935458.18113.121085821.31470970@webmail.messagingengine.com>
	<CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
	<1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
	<CAG27Bk2sEtwwNZPb8=ExxwhRVG0WQrd60W=MJuHaJBNXOpptoQ@mail.gmail.com>
	<20140526101102.GE2968@x2.net.home>
Date: Mon, 26 May 2014 16:46:12 +0100
Message-ID: <CAG27Bk1cbXACiCaoRVQALB874_84tgxac78WcH6iwK0XAw=A+g@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26 May 2014 11:11, Karel Zak <kzak@redhat.com> wrote:
>  BTW, it would be really nice to have per feature/issue branches
>  rather than only branch 2014wk20 with setterm, uuidd and rename
>  changes :-)

Hi Karel,

Here you are. The changes are the same, with one exception; uuidd
--timeout vs --socket-activation exclusion is gone.

git://github.com/kerolasa/lelux-utiliteetit.git uuid
git://github.com/kerolasa/lelux-utiliteetit.git rename
git://github.com/kerolasa/lelux-utiliteetit.git setterm

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
