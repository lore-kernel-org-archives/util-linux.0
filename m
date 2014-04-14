Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40449 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaDNPNY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Apr 2014 11:13:24 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so8222534pde.29
        for <util-linux@vger.kernel.org>; Mon, 14 Apr 2014 08:13:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk1w81SaDxomfv14cDwZjFi_6nyq3uHHtc+JxV6xB5rp0Q@mail.gmail.com>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
	<1397298524-3364-5-git-send-email-kerolasa@iki.fi>
	<534B0E1B.4040208@bernhard-voelker.de>
	<CAG27Bk1w81SaDxomfv14cDwZjFi_6nyq3uHHtc+JxV6xB5rp0Q@mail.gmail.com>
Date: Mon, 14 Apr 2014 16:13:23 +0100
Message-ID: <CAG27Bk0k46-Vnj5Jonb_xXkW+h_WZTt=YXfOroy8nMvaiwLdCg@mail.gmail.com>
Subject: Re: [PATCH 4/7] tests: check kill is converting signals names correctly
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 April 2014 08:42, Sami Kerola <kerolasa@iki.fi> wrote:
> On 13 April 2014 23:22, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
>> This is racy. Although this might work in most cases, one can not
>> determine that the SIGRECEIVE process had enough time to startup
>> and register all signal handlers before the signal arrives.
>> Usually this would fail more likely with high system load,
>> e.g. on build servers with massive parallel builds.
>>
>> The only chance is that the SIGRECEIVE program indicates that it
>> has fully come up, e.g. by creating a file which did not exist
>> beforehand. The second part of avoiding unwanted behavior is to
>> wait for such a witness file to appear in the parent test script
>> ... but avoiding to wait infinitely (because other unknown reasons
>> may have prevented the creation of the witness file).
>>
>> In the test-suite of coreutils, there are a few complex (and yet
>> necessary) snippets to do this:
>> a) test case waiting for the inspected program to be ready:
>>   http://git.savannah.gnu.org/cgit/coreutils.git/tree/tests/tail-2/retry.sh#n45
>> b) utility function to retry with increasing delay until a
>> maximum number has reached:
>>   http://git.savannah.gnu.org/cgit/coreutils.git/tree/init.cfg#n597
>>
>> Maybe a solution like the above is too heavy for this situation (unless
>> it could be reused in other tests), so something like the following may
>> suffice here - assuming that $TS_HELPER_SIGRECEIVE will successfully
>> perform a 'creat("witnessfile", mode)':
>>
>>   rm -f witnessfile   || fail=1
>>   test -f witnessfile && fail=1
>>   $TS_HELPER_SIGRECEIVE & TEST_PID=$!
>>   up=0
>>   while i in 0.01 0.1 1 2 ; do
>>     test -f witnessfile && { up=1; break; }
>>     sleep $i
>>   done
>>   test $up = 1 || fail=1
>>   $TS_CMD_KILL -$SIG ${TS_HELPER_SIGRECEIVE##*/} >> $TS_OUTPUT 2>&1
>>   ...
>>
>> WDYT?
>
> Hi Berny,
>
> I wish I had though witnessfile before sending the patches, thanks for
> the idea. I have feeling it might solve various parallel test issues I
> had while doing test runs earlier. Version that used combined with
> mktemp symlinks to sigreive helper to alter name of the killed program
> was an attempt to make parallel runs to work, but it was flaky
> probably due reasons you gave. The symlink approach with witnessfile
> might allow to get rid of flock that makes the kill tests to run
> sequentially. Let me try that.
>
> Karel please for completion of the second try. I will keep these
> patches untouched in
>
> git://github.com/kerolasa/lelux-utiliteetit.git kill-tests
>
> The witnessfile version goes this branch, once I have something to push.
>
> git://github.com/kerolasa/lelux-utiliteetit.git kill-tests-v2

Hi Berny and others,

Here is new set of tests, and they almost work.

https://github.com/kerolasa/lelux-utiliteetit/tree/kill-tests-v2

The 'name_to_number' check[1] is giving random errors, and my wooden
eyes does not observe where is the problem. Or if the problem is in
kill itself, and random errors are a real bug. According to helper
witness file the signal receiver is running, but kill does not find
it. Some times the check passes without issues, but more often there
is one that kind of error, sometime two.

[1] https://github.com/kerolasa/lelux-utiliteetit/commit/516fa50baa0daf764a53063e44163e1c3328e110

Ideas, comments, help!

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
