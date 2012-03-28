Return-Path: util-linux-owner@vger.kernel.org
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9489 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036Ab2C1VD2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Mar 2012 17:03:28 -0400
Message-ID: <4F737C99.6050500@intellitree.com>
Date: Wed, 28 Mar 2012 17:03:21 -0400
From: Michael Conrad <mconrad@intellitree.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: "Ted Ts'o" <tytso@mit.edu>, util-linux@vger.kernel.org
Subject: Re: blkid -o value
References: <4F71F836.4000103@intellitree.com> <20120327173149.GC10142@thunk.org> <4F71FE73.9010208@intellitree.com> <20120327184345.GA11236@thunk.org> <20120328090038.GB2045@x2.net.home>
In-Reply-To: <20120328090038.GB2045@x2.net.home>
Content-Type: multipart/mixed;
 boundary="------------010808030802000207010800"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010808030802000207010800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 03/28/2012 05:00 AM, Karel Zak wrote:
> On Tue, Mar 27, 2012 at 11:43:45AM -0700, Ted Ts'o wrote:
>> On Tue, Mar 27, 2012 at 01:52:51PM -0400, Michael Conrad wrote:
>>> I see how that could be useful if and only if you use exactly one
>>> "-s", but if you requested more than one "-s" they still come out in
>>> non-stable order.  It's like running a SQL query and having all the
>>> columns shifted because the first one was a NULL.  
>> Actually, it's more like running an SQL query without a SORTED BY and
>> assuming the order of the rows was stable.
Only if the data weren't in any normal form.  I say it's like columns
getting shifted because if you ask for 2 values you expect the field
offset to imply the type of the data.  If one field is NULL, the rows
shift upward, resulting in a value interpreted as the wrong type.

This is why I'm saying the "-o values" is only usable if you use exactly
one "-s", because any other scenario means every value returned has an
indeterminate type, which is garbage data.  IMO a tool should never
output garbage.  It should prevent or warn about illegitimate usage. 
Since the tool has been out there and in use for quite a while, I would
suggest a warning.

(patch attached)

>>> At the very least, I would appreciate it if the man page mentioned
>>> that "-o value" should only ever be used with exactly one "-s".
>> What I would suggest is that blkid explicitly state that the order of
>> fields or file systems (if more than one file system is selected) is
>> not defined, since that's something which is true in general, and not
>> just for "-o value".
>>
>> It might also be useful to have an EXAMPLES section which gives some
>> sample ways that blkid can be used.
>  Good idea. I'll update the man page.
>
>     Karel

Thanks!



--------------010808030802000207010800
Content-Type: text/plain;
 name="blkid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="blkid.patch"

>From 0415f6dcb3c5636a69499b0accdd0e2fae9ac0c3 Mon Sep 17 00:00:00 2001
From: Michael Conrad <mconrad@intellitree.com>
Date: Wed, 28 Mar 2012 16:51:12 -0400
Subject: [PATCH] blkid: added warning about unstable output for '-o values'

 * A warning is now emitted when using 'values' without requesting
   a single tag.

 * Updated man page to describe the reason behind it.
---
 misc-utils/blkid.8 |    3 ++-
 misc-utils/blkid.c |    3 +++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 6bde6bc..f6175b2 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -152,7 +152,8 @@ parameter may be:
 print all tags (the default)
 .TP
 .B value
-print the value of the tags
+print the value of the tags.  The tag order is variable, so you should only
+use this format when selecting a single tag for a single device. (see '-s')
 .TP
 .B list
 print the devices in a user-friendly format; this output format is unsupported
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 1e8073e..4e5b338 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -829,6 +829,9 @@ int main(int argc, char **argv)
 		print_version(stdout);
 		goto exit;
 	}
+	
+	if (output_format == OUTPUT_VALUE_ONLY && numtag != 1)
+		fprintf(stderr, "Warning: '-o value' should only be used when requesting a single tag ('-s')\n");
 
 	/* convert LABEL/UUID lookup to evaluate request */
 	if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
-- 
1.7.1


--------------010808030802000207010800--
