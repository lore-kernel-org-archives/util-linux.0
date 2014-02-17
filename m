Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65002 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaBQJF5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 17 Feb 2014 04:05:57 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so15039018pab.37
        for <util-linux@vger.kernel.org>; Mon, 17 Feb 2014 01:05:56 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1496112.KWppGQQCcY@vapier>
References: <1496112.KWppGQQCcY@vapier>
Date: Mon, 17 Feb 2014 09:05:56 +0000
Message-ID: <CAG27Bk3X8zv1oAvBG2hRX6U=SVY8CBtcmtp9ytyyA_Wjhmi4vw@mail.gmail.com>
Subject: Re: last/last test fails
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 February 2014 08:39, Mike Frysinger <vapier@gentoo.org> wrote:
> current git (24b2a479fd5ba138e9b836fa2115939eb3b59dfe) fails this test for me.
> see recent blkid test post for config.log.

Hi Mike,

My bad, when the earlier last(1) change was sent tests were not fixed
in same go, or by in another change immediately afterwards. See below
for late delivery of the test fix.

http://www.spinics.net/lists/util-linux-ng/msg08866.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
