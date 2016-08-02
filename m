Return-Path: cmetcalf@mellanox.com
Subject: Re: [PATCH] taskset: clarify that masks are always hex in man page
To: Karel Zak <kzak@redhat.com>
References: <1469808380-3120-1-git-send-email-cmetcalf@mellanox.com>
 <20160802141349.2rwa6turcojnpnif@ws.net.home>
CC: <util-linux@vger.kernel.org>
From: Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <b6cc201b-0169-8549-16cb-58708f622c43@mellanox.com>
Date: Tue, 2 Aug 2016 10:31:27 -0400
MIME-Version: 1.0
In-Reply-To: <20160802141349.2rwa6turcojnpnif@ws.net.home>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 8/2/2016 10:13 AM, Karel Zak wrote:
> On Fri, Jul 29, 2016 at 12:06:20PM -0400, Chris Metcalf wrote:
>> The man page confusingly says that the mask is "typically"
>> hexadecimal, when in fact it is always hexadecimal.  Fix the
>> language, and provide an additional example with no leading "0x".
> Well, we have --cpu-list, then the mask is a list, for example
> 0,5,8-11. Maybe we can make a note about it to the paragraph and to
> the example (now it's in the OPTIONS only).

Something like this?  I removed the "0x00000001" example just so we don't
have too many examples total, and the somewhat misleading "all processors"
language from 0xffffffff (if you have more than 32 processors, it's not "all").

 From eaa556e49ed19dd87afa14d87e31a679a046c4c5 Mon Sep 17 00:00:00 2001
From: Chris Metcalf <cmetcalf@mellanox.com>
Date: Fri, 29 Jul 2016 11:57:01 -0400
Subject: [PATCH] taskset: clarify that masks are always hex in man page

The man page confusingly says that the mask is "typically"
hexadecimal, when in fact it is always hexadecimal.  Fix the
language, and provide an additional example with no leading "0x".

Also, provide an example using the --cpu-list option.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
  schedutils/taskset.1 | 16 +++++++++++-----
  1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 901f9faf5f45..c48e296e4b1c 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -51,17 +51,23 @@ to the last logical CPU.  Not all CPUs may exist on a given system but a mask
  may specify more CPUs than are present.  A retrieved mask will reflect only the
  bits that correspond to CPUs physically on the system.  If an invalid mask is
  given (i.e., one that corresponds to no valid CPUs on the current system) an
-error is returned.  The masks are typically given in hexadecimal.  For example,
+error is returned.  The masks may be specified in hexadecimal (with or without
+a leading "0x"), or as a cpu list with the
+.BR \-\-cpu\-list
+option.  For example,
  .RS 4
  .TP 12
-.BR 0x00000001
-is processor #0,
-.TP
  .BR 0x00000003
  is processors #0 and #1,
  .TP
  .BR 0xFFFFFFFF
-is all processors (#0 through #31).
+is processors #0 through #31,
+.TP
+.BR 32
+is processors #1, #4, and #5,
+.TP
+.BR \-\-cpu\-list\ 0-2,6
+is processors #0, #1, #2, and #6.
  .RE
  .PP
  When
-- 
2.7.2

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
