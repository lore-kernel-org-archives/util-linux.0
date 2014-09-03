Return-Path: ats@offog.org
Date: Wed, 3 Sep 2014 16:55:54 +0100
From: Adam Sampson <ats@offog.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.25.1
Message-ID: <20140903155554.GS885@cartman.at.offog.org>
References: <20140903105427.GH21325@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f0KYrhQ4vYSV2aJu"
In-Reply-To: <20140903105427.GH21325@x2.net.home>
Sender: Adam Sampson <ats@offog.org>
List-ID: <util-linux.vger.kernel.org>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 12:54:27PM +0200, Karel Zak wrote:
>    - make ipcs limit calculations work when numbers are large

That change isn't right -- it reverses the sense of the test, making the
testcase fail on 3.16 again. Patch attached.

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Fix-the-test-for-shmall-being-too-big-to-show.patch"

>From 1269b6bb74727043c16852bc34727a0c8d0696c7 Mon Sep 17 00:00:00 2001
From: Adam Sampson <ats@offog.org>
Date: Wed, 3 Sep 2014 16:49:40 +0100
Subject: [PATCH] Fix the test for shmall being too big to show.

It was correct when originally introduced, but the shell overflow fix in
3a9ec12d6664527fad9c56347c88f3447d6c0856 accidentally reversed the sense
of the test.

Signed-off-by: Adam Sampson <ats@offog.org>
---
 tests/ts/ipcs/limits2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 1a49c46..19f49fb 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -29,7 +29,7 @@ ts_check_prog "bc"
 
 # TODO https://github.com/karelzak/util-linux/issues/51
 SHMALL=$(</proc/sys/kernel/shmall)
-if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -ne 1 ]; then
+if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -eq 1 ]; then
 	TS_KNOWN_FAIL="yes"
 fi
 
-- 
2.0.4


--f0KYrhQ4vYSV2aJu--
