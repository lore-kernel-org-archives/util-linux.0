Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48024 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaKKWtQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Nov 2014 17:49:16 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so3166774wiv.1
        for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 14:49:15 -0800 (PST)
Date: Tue, 11 Nov 2014 22:49:02 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: kerolasa@gmail.com
cc: Boris Egorov <egorov@linux.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
In-Reply-To: <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
Message-ID: <alpine.LNX.2.03.1411112236560.23899@iki.fi>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi> <5461B803.4050707@linux.com> <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 11 Nov 2014, Sami Kerola wrote:
> I'm running out of ideas.

That was a bit hasty comment. Without '-fsanitize=address' compiler 
option, while keepign '-O0 -g -ggdb' valgrind was able to display another 
leak.  When both leaks were fixed the mkswap started to return zero 
expected way.

The second leak was caused by size_to_human_string() that is coming from 
libcommon.la. Did the ASAN + clang fall over because of libtool static 
library and atexit()? I don't know, and I guess this maillist is wrong 
forum to investigate. I'm just happy if someone who has similar issue 
finds this thread useful.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 11 Nov 2014 21:34:30 +0000
Subject: [PATCH v2] mkswap: remove memory leaks [LeakSanitizer] [valgrind]

==18922==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 8 byte(s) in 1 object(s) allocated from:
     #0 0x49d12b in __interceptor_malloc (/home/src/util-linux/.libs/lt-mkswap+0x49d12b)
     #1 0x7faf2a5069c9 in __GI___strdup (/usr/lib/libc.so.6+0x819c9)
     #2 0xffff96e7e33 (<unknown module>)

SUMMARY: AddressSanitizer: 8 byte(s) leaked in 1 allocation(s).

And another one that valgrind found.

==6316== 8 bytes in 1 blocks are definitely lost in loss record 1 of 1
==6316==    at 0x4C29F90: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==6316==    by 0x5E3F9C9: strdup (in /usr/lib/libc-2.20.so)
==6316==    by 0x43A25F: size_to_human_string (strutils.c:495)
==6316==    by 0x42B35C: main (mkswap.c:488)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  disk-utils/mkswap.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index c4fe8c9..d34e2fd 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -323,6 +323,7 @@ static void wipe_device(struct mkswap_control *ctl)
  			fprintf(stderr, _("        (compiled without libblkid). "));
  		fprintf(stderr, _("Use -f to force.\n"));
  	}
+	free(type);
  #ifdef HAVE_LIBBLKID
  	blkid_free_probe(pr);
  #endif
@@ -488,6 +489,7 @@ int main(int argc, char **argv)

  	printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
  		version, strsz, sz);
+	free(strsz);

  	set_signature(&ctl);
  	set_uuid_and_label(&ctl);
-- 
2.1.3
