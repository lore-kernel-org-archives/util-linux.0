Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f169.google.com ([209.85.220.169]:50617 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbaELJNZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 12 May 2014 05:13:25 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so8592486vcb.0
        for <util-linux@vger.kernel.org>; Mon, 12 May 2014 02:13:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <537072BE.3090301@bernhard-voelker.de>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
	<537072BE.3090301@bernhard-voelker.de>
Date: Mon, 12 May 2014 10:13:24 +0100
Message-ID: <CAG27Bk0_NxE907RusFYVErQ3UHZYGOm60a60mf+CtzNd_mdjjA@mail.gmail.com>
Subject: Re: [PATCH 01/12] tests: check /proc availability, and go-around if
 it is incomplete
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>, Ruediger Meier <sweet_f_a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12 May 2014 08:05, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 05/11/2014 09:26 PM, Sami Kerola wrote:
>> diff --git a/tests/ts/kill/kill_functions.sh b/tests/ts/kill/kill_functions.sh
>> index 73fff05..a2a2483 100644
>> --- a/tests/ts/kill/kill_functions.sh
>> +++ b/tests/ts/kill/kill_functions.sh
>> @@ -1,3 +1,5 @@
>> +# kill tests, or command, will not when /proc is missing.
>> +test /proc || ts_skip "/proc not available"
>
> Ahem, this only ensures that '/proc' is a string, nothing else ...

Hi Berny,

Thank you for getting rid of silly mistake. Fix is available in my git.

https://github.com/kerolasa/lelux-utiliteetit/commit/04af69d0ab20f337a40e72d501f13977d20e4013

>>  # unfortunately we are using gawk features
>>  type gawk >/dev/null 2>&1 || ts_skip "cannot find gawk"
>> @@ -8,6 +10,17 @@ function check_test_sigreceive {
>>       local pid=$1
>>
>>       for i in 0.01 0.1 1 1 1 1; do
>> +             if [ ! -f /proc/$pid/status ]; then
>> +                     # The /proc exists, but not status file. Because
>> +                     # the process already started it is unlikely the
>> +                     # file would appear after any amount of waiting.
>> +                     # Try to sleep for moment and hopefully
>> +                     # test_sigreceive is ready to be killed.
>> +                     echo "kill_functions.sh: /proc/$pid/status: No such file or directory"
>> +                     sleep 2
>> +                     rc=1
>> +                     break
>> +             fi
>>               gawk 'BEGIN { retval=1 }
>>               /^SigCgt/ {
>>                       lbyte = strtonum("0x" substr($2, 16, 16))
>>
>
> Seeing all this /proc stuff going into the tests - it now even
> requires gawk - I still personally think that a simple witness
> file would have done it.
> So Karel, if you really prefer this, then I'm okay with it, of course.

With witness file comes the issue of who can write and where when the
check that runs as root does the 'nobody' process killing. Is that
issue more or less simple to go-around than status file parsing. I'm
not sure, but I am getting a bit tired of these checks.

BTW I had no idea util-linux is tested in environments that something
else but gawk as default awk.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
