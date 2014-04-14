Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f47.google.com ([209.85.160.47]:62463 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbaDNTAD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Apr 2014 15:00:03 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so8594783pbc.34
        for <util-linux@vger.kernel.org>; Mon, 14 Apr 2014 12:00:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <534C096C.2070500@bernhard-voelker.de>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
	<1397298524-3364-5-git-send-email-kerolasa@iki.fi>
	<534B0E1B.4040208@bernhard-voelker.de>
	<CAG27Bk1w81SaDxomfv14cDwZjFi_6nyq3uHHtc+JxV6xB5rp0Q@mail.gmail.com>
	<CAG27Bk0k46-Vnj5Jonb_xXkW+h_WZTt=YXfOroy8nMvaiwLdCg@mail.gmail.com>
	<534C096C.2070500@bernhard-voelker.de>
Date: Mon, 14 Apr 2014 20:00:01 +0100
Message-ID: <CAG27Bk1pgj3QeLgcUCP05h0QnLsLXibQVkFj3egQbG1nmxew3Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] tests: check kill is converting signals names correctly
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 April 2014 17:14, Bernhard Voelker <mail@bernhard-voelker.de> wrote:

Hi Berny,

> Looking quickly at the tests, I think I don't understand the idea behind
> all that symlinking stuff. I mean for most test cases it would suffice
> to kill with the PID instead of the process name.
>
> Re. the test failures of name_to_number: when I change the kill command
> to work on $TEST_PID instead of the symlink name, then I don't get the
> failures anymore.

Most of the tests could use pid, but I am afraid there should be at
least one of them using name. Else killing by name remains untested.
Of course simple kill by name test could do the job, but I am not
hugely in favor to simplify tests until they work without
understanding why they fail in first place.

> BTW: is there a reason why you stick to using $(jobs -p) to get the
> TEST_PID instead of the much simpler "$!"?

Not any other reason than I did not know about "$!", which indeed is
better expression. Thank you for tip, I will push the better version
to v2 branch.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
