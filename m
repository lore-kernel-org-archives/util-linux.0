Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49960 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbaIFH1h (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 03:27:37 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so394150wid.7
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 00:27:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Ruediger Meier <sweet_f_a@gmx.de>,
        Adam Sampson <ats@offog.org>
Subject: Re: [ANNOUNCE] util-linux v2.25.1
Date: Sat,  6 Sep 2014 08:27:25 +0100
Message-Id: <1409988445-5256-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 September 2014 23:19, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Wednesday 03 September 2014, Adam Sampson wrote:
>> On Wed, Sep 03, 2014 at 12:54:27PM +0200, Karel Zak wrote:
>> >    - make ipcs limit calculations work when numbers are large
>>
>> That change isn't right -- it reverses the sense of the test, making
>> the testcase fail on 3.16 again. Patch attached.
>
> Your patch seems to be correct except that it should be "<=" instead
> of "<":
>   if [ $(bc <<<"2^64 / $PAGE_SIZE <= $SHMALL") -eq 1 ]; then
> to have the same (correct) behavior like before 3a9ec12d.
>
> The mistake in 3a9ec12d happened probably because Sami tried to
> avoid "greater than" relations. but for my brain this line would be
> still more easy to read:
>   if [ $(bc <<<"$SHMALL >= 2^64 / $PAGE_SIZE") -eq 1 ]; then
> Maybe that's why me and others have not noticed the mistake when
> reviewing that patch.

Hi Adam, Rudi, and others,

It was not good summer for me.  This is second totally stupid bug from
me.  This time the reason is I tested the logic by flipping it around to
see it works, and accidentally wrong version end up to submission.

Here is the change from Adams attachment, with CC and Reviewed-by lines,
and round braces to ensure bc does calculation always in correct order.

--->8----
From: Adam Sampson <ats@offog.org>
Date: Wed, 3 Sep 2014 16:49:40 +0100
Subject: tests: fix the ipcs test for shmall being too big to show

It was correct when originally introduced, but the shell overflow fix in
3a9ec12d6664527fad9c56347c88f3447d6c0856 accidentally reversed the sense
of the test.

CC: Ruediger Meier <sweet_f_a@gmx.de>
Reviewed-by: Sami Kerola <kerolasa@iki.if>
Signed-off-by: Adam Sampson <ats@offog.org>
---
 tests/ts/ipcs/limits2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 1a49c46..10f7514 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -29,7 +29,7 @@ ts_check_prog "bc"
 
 # TODO https://github.com/karelzak/util-linux/issues/51
 SHMALL=$(</proc/sys/kernel/shmall)
-if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -ne 1 ]; then
+if [ $(bc <<<"(2^64 / $PAGE_SIZE) < $SHMALL") -eq 1 ]; then
 	TS_KNOWN_FAIL="yes"
 fi
 
-- 
2.1.0

