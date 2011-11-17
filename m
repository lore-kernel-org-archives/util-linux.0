Return-Path: util-linux-owner@vger.kernel.org
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:55899 "HELO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756754Ab1KQRDJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Nov 2011 12:03:09 -0500
Received: by mail-bw0-f53.google.com with SMTP id q10so2501717bka.12
        for <util-linux@vger.kernel.org>; Thu, 17 Nov 2011 09:03:07 -0800 (PST)
Message-ID: <4EC53E48.5010008@invoxia.com>
Date: Thu, 17 Nov 2011 18:03:04 +0100
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: small bug in mkfs.cramfs + patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all.

mkfs.cramfs on version v2.17.2 has a small bug when dealing with very 
small filesystems.
look at upstream code on git, and the issue is still here.

ex:
         $ cd /tmp
         $ mkdir content
         $ echo hello > content/a
         $ echo hello > content/b
         $ mkfs.cramfs content content.cramfs
         not enough space allocated for ROM image (4090 allocated, 4096 
used)


Here is a patch for fixing (simply rounding to page size AFTER 
eleminating doubles)
Regards,
Arnaud


diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 4ffa908..30f6b4b 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -843,6 +843,9 @@ int main(int argc, char **argv)

         root_entry->size = parse_directory(root_entry, dirname, 
&root_entry->child, &fslen_ub);

+       /* find duplicate files */
+       eliminate_doubles(root_entry,root_entry, &fslen_ub);
+
         /* always allocate a multiple of blksize bytes because that's
             what we're going to write later on */
         fslen_ub = ((fslen_ub - 1) | (blksize - 1)) + 1;
@@ -858,9 +861,6 @@ int main(int argc, char **argv)
                 fslen_ub = fslen_max;
         }

-        /* find duplicate files */
-        eliminate_doubles(root_entry,root_entry, &fslen_ub);
-
         /* TODO: Why do we use a private/anonymous mapping here
             followed by a write below, instead of just a shared mapping
             and a couple of ftruncate calls?  Is it just to save us
(
