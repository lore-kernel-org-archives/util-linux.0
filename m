Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32858 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbcG0PUd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jul 2016 11:20:33 -0400
Received: by mail-oi0-f43.google.com with SMTP id j185so22129945oih.0
        for <util-linux@vger.kernel.org>; Wed, 27 Jul 2016 08:20:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1469618118.1670435.678129761.331B0F49@webmail.messagingengine.com>
References: <20160727103457.3105-1-kerolasa@iki.fi> <1469618118.1670435.678129761.331B0F49@webmail.messagingengine.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 27 Jul 2016 16:20:32 +0100
Message-ID: <CAG27Bk1pZx3AAnJ3kGOvm+ekBJnW1p0Ryme0f_wtntWrRpWBmA@mail.gmail.com>
Subject: Re: [PATCH] getops: improve getopt-parse.bash example
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 July 2016 at 12:15, Benno Schulenberg <bensberg@justemail.net> wrote:
>
> In the subject line: s/ops/opt/.
>
> On Wed, Jul 27, 2016, at 12:34, Sami Kerola wrote:
>> --- a/misc-utils/getopt-parse.bash
>> +++ b/misc-utils/getopt-parse.bash
>> @@ -3,45 +3,73 @@
>>  # A small example program for using the new getopt(1) program.
>>  # This program will only work with bash(1)
>>  # An similar program using the tcsh(1) script language can be found
>
> When here anyway, maybe fix a typo: s/An/A/.
> Add a missing period: s/)/)./.
> And adjust for the times: s/new //.
>
>> -# as parse.tcsh
>> +# as getopt-parse.tcsh
>
> Also add period: s/tcsh/tcsh./
>
> Benno

Thanks Benno.

The example file banner is updated to both of them. I also changed the
example script
to call itself as script rather than a program.

https://github.com/kerolasa/lelux-utiliteetit/commit/d27f5fe770025e456fbd33b87a96968f34c455ed

Karel if/when considering merge the branch name is: getopt

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
