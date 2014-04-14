Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:53133 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbaDNQTw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Apr 2014 12:19:52 -0400
Message-ID: <534C096C.2070500@bernhard-voelker.de>
Date: Mon, 14 Apr 2014 18:14:36 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/7] tests: check kill is converting signals names correctly
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>	<1397298524-3364-5-git-send-email-kerolasa@iki.fi>	<534B0E1B.4040208@bernhard-voelker.de>	<CAG27Bk1w81SaDxomfv14cDwZjFi_6nyq3uHHtc+JxV6xB5rp0Q@mail.gmail.com> <CAG27Bk0k46-Vnj5Jonb_xXkW+h_WZTt=YXfOroy8nMvaiwLdCg@mail.gmail.com>
In-Reply-To: <CAG27Bk0k46-Vnj5Jonb_xXkW+h_WZTt=YXfOroy8nMvaiwLdCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/14/2014 05:13 PM, Sami Kerola wrote:
> Here is new set of tests, and they almost work.
>
> https://github.com/kerolasa/lelux-utiliteetit/tree/kill-tests-v2
>
> The 'name_to_number' check[1] is giving random errors, and my wooden
> eyes does not observe where is the problem. Or if the problem is in
> kill itself, and random errors are a real bug. According to helper
> witness file the signal receiver is running, but kill does not find
> it. Some times the check passes without issues, but more often there
> is one that kind of error, sometime two.
>
> [1] https://github.com/kerolasa/lelux-utiliteetit/commit/516fa50baa0daf764a53063e44163e1c3328e110
>
> Ideas, comments, help!

Hi Sami,

thanks.

Looking quickly at the tests, I think I don't understand the idea behind
all that symlinking stuff. I mean for most test cases it would suffice
to kill with the PID instead of the process name.

Re. the test failures of name_to_number: when I change the kill command
to work on $TEST_PID instead of the symlink name, then I don't get the
failures anymore.

BTW: is there a reason why you stick to using $(jobs -p) to get the
TEST_PID instead of the much simpler "$!"?

Thanks & have a nice day,
Berny

