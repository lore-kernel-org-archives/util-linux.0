Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33683 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbDGIA1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Apr 2015 04:00:27 -0400
Received: by wgin8 with SMTP id n8so47368741wgi.0
        for <util-linux@vger.kernel.org>; Tue, 07 Apr 2015 01:00:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <55237AF1.3010004@bernhard-voelker.de>
References: <5521E92D.2090404@fau.de>
	<alpine.LNX.2.03.1504062226540.593@iki.fi>
	<55237AF1.3010004@bernhard-voelker.de>
Date: Tue, 7 Apr 2015 09:00:25 +0100
Message-ID: <CAG27Bk1487WSthzMnX7vbRw-i2ianr15DnEGwK+0FY3Hhem5Xg@mail.gmail.com>
Subject: Re: logger: Segmentation fault when reading from stdin and writing to socket
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Patrick Plagwitz <patrick.plagwitz@fau.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 April 2015 at 07:36, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 04/06/2015 11:50 PM, Sami Kerola wrote:
>> On Mon, 6 Apr 2015, Patrick Plagwitz wrote:
>>> The attached patch does just that.
>
>> The below appears to fix the issue.
>
> Sami, your patch differs from Patrick's just in a newline, and you only
> turned his - already great - description into a commit message.
> Therefore I think setting Patrick as the author would be both correct
> and just fair.
>
> Please note that seeing the own name in the commit log encourages
> people to continue contributing in future.

Hi Bernhard,

Oh, I did not even notice there was an attachment.  What comes to attributing
contributors you are absolutely right. Adjusted change can be found from my
remote branch logger-fix.

https://github.com/kerolasa/lelux-utiliteetit/commit/4a8919a4e5b28a47cd61fc8b774a6eaee943b90e

> BTW: what about the memleak he reported?

Can be fixed. And since starting to look this I took liberty to check
with valgrind
if there are other leaks. One more found from logger_command_line().

https://github.com/kerolasa/lelux-utiliteetit/commit/c3dd2ecd5fcaf30860d5fcfd74edfd70a3dd7603

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
