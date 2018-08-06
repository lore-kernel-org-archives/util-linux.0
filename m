Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:45541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbeHFSGN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2018 14:06:13 -0400
Subject: =?UTF-8?Q?Re:_Debian=c2=b4s_change_of_=22su=22_to_the_one_in_util-l?=
 =?UTF-8?Q?inux?=
To: Martin Steigerwald <martin@lichtvoll.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
References: <1734536.DseMWcvaqb@merkaba> <20180805150557.GC26138@thunk.org>
 <1642971.4ZBaquOb5i@merkaba>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <d29b0332-8cdd-2110-1cd5-67c5bc08c729@bernhard-voelker.de>
Date: Mon, 6 Aug 2018 17:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <1642971.4ZBaquOb5i@merkaba>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/06/2018 10:24 AM, Martin Steigerwald wrote:
> Theodore Y. Ts'o - 05.08.18, 17:05:
>> * The PATH might include the current directory, and so a script
> […]
>> So for that reason, it makes sense that a "sudo" or "su" command
>> should default to something safe.
> 
> Thank you, Ted. This is the best explanation I saw so far. I accept it 
> for default.
> 
> In my specific case I still do not see any big issue with that cause the 
> backup script runs on my laptop, the user I "su" from and "root" are 
> both users only I have access to.

If you have sanitized your PATH (and other variables) already outside, then
nothing prevents you from passing them into su or sudo.  E.g. the GNU coreutils
pass PATH and another variable for running the "root-only" testsuite:

  sudo env PATH="$PATH" NON_ROOT_USERNAME=$USER make -k check-root

Can't you do something like that?

Have a nice day,
Berny
