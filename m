Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59381 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119AbaE2JsH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 May 2014 05:48:07 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so101347pad.37
        for <util-linux@vger.kernel.org>; Thu, 29 May 2014 02:48:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140527144601.GB385@x2.net.home>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
	<1400929696-12548-5-git-send-email-kerolasa@iki.fi>
	<1400935458.18113.121085821.31470970@webmail.messagingengine.com>
	<CAG27Bk2CBYDtF36R-41ZAqQrpzbdqP4=TDQx3m32=hs25GyFZg@mail.gmail.com>
	<1401052223.27518.121405397.106D8440@webmail.messagingengine.com>
	<CAG27Bk2sEtwwNZPb8=ExxwhRVG0WQrd60W=MJuHaJBNXOpptoQ@mail.gmail.com>
	<20140526101102.GE2968@x2.net.home>
	<CAG27Bk1cbXACiCaoRVQALB874_84tgxac78WcH6iwK0XAw=A+g@mail.gmail.com>
	<20140527144601.GB385@x2.net.home>
Date: Thu, 29 May 2014 10:48:06 +0100
Message-ID: <CAG27Bk2FVPQgR8Qd-y3KfN9X9zs7w_jr1GiRqFGtdMjdZNk1Bw@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 May 2014 15:46, Karel Zak <kzak@redhat.com> wrote:
> On Mon, May 26, 2014 at 04:46:12PM +0100, Sami Kerola wrote:
>> git://github.com/kerolasa/lelux-utiliteetit.git rename
>
>  Not merged, it seems that the tests still uses the current directory
>  rather than $TS_OUTDIR, right?

Oh, that's a beginner mistake. Fix is available in same git remote
location. All I did was a cd before file operations in each script,
something like this:

+++ b/tests/ts/rename/basic
@@ -22,6 +22,7 @@ TS_DESC="basic check"
 ts_init "$*"

 ts_check_test_command "$TS_CMD_RENAME"
+cd $TS_OUTDIR

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
