Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34879 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbbBOV1R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Feb 2015 16:27:17 -0500
Received: by mail-ob0-f171.google.com with SMTP id gq1so36483876obb.2
        for <util-linux@vger.kernel.org>; Sun, 15 Feb 2015 13:27:16 -0800 (PST)
Message-ID: <54E10F31.4060004@gmail.com>
Date: Sun, 15 Feb 2015 15:27:13 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>,
        Benno Schulenberg <bensberg@justemail.net>
CC: Karel Zak <kzak@redhat.com>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.26-rc2
References: <20150204115353.GC1238@ws.net.home> <1424030549.2886406.227807181.7F9CF45A@webmail.messagingengine.com> <201502152150.03592.sweet_f_a@gmx.de>
In-Reply-To: <201502152150.03592.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier wrote:
>
>
> On Sunday 15 February 2015, Benno Schulenberg wrote:
>> Running 'make check' here reports the following failures:
>
> A few of them might be fixed already in latest HEAD.
>
> And could you please also show us the test diffs:
> $ find tests/diff/ -type f | xargs -r cat

On my 686, there appears to be an off-by-one error.  Example:

--- /sources/util-linux-2.26-rc2/tests/expected/cal/bigyear     2015-01-06 09:19:600
+++ /sources/util-linux-2.26-rc2/tests/output/cal/bigyear       2015-02-15 14:38:600
@@ -2,248 +2,248 @@
  Gregorian - Monday-based month
   December 2147483646
  Mo Tu We Th Fr Sa Su
-                1  2
- 3  4  5  6  7  8  9
-10 11 12 13 14 15 16
-17 18 19 20 21 22 23
-24 25 26 27 28 29 30
-31
-Gregorian - Sunday-based month
- December 2147483646
-Su Mo Tu We Th Fr Sa
                     1
   2  3  4  5  6  7  8
   9 10 11 12 13 14 15
  16 17 18 19 20 21 22
  23 24 25 26 27 28 29
  30 31
+Gregorian - Sunday-based month
+ December 2147483646
+Su Mo Tu We Th Fr Sa
+ 1  2  3  4  5  6  7
+ 8  9 10 11 12 13 14
+15 16 17 18 19 20 21
+22 23 24 25 26 27 28
+29 30 31
+

   -- Bruce

