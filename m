Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35480 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaKBU0w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:26:52 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so4960067wid.8
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:26:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/8] mkswap: remove system architecture specific max swap size checks
Date: Sun,  2 Nov 2014 20:26:25 +0000
Message-Id: <1414959991-8369-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since kernel version 2.3.4 (June 1999) all architectures has used
uint32_t as maximum number or pages in a swap device or file, there is no
longer need to support systems earlier than that.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 140 ++--------------------------------------------------
 1 file changed, 3 insertions(+), 137 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 5eb4e6a..a1b864d 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -75,75 +75,6 @@ static int check = 0;
 
 #define SELINUX_SWAPFILE_TYPE	"swapfile_t"
 
-#ifdef __sparc__
-# ifdef __arch64__
-#  define is_sparc64() 1
-#  define is_be64() 1
-# else /* sparc32 */
-static int
-is_sparc64(void)
-{
-	struct utsname un;
-	static int sparc64 = -1;
-
-	if (sparc64 != -1)
-		return sparc64;
-	sparc64 = 0;
-
-	if (uname(&un) < 0)
-		return 0;
-	if (! strcmp(un.machine, "sparc64")) {
-		sparc64 = 1;
-		return 1;
-	}
-	if (strcmp(un.machine, "sparc"))
-		return 0; /* Should not happen */
-
-#ifdef HAVE_PERSONALITY
-	{
-		extern int personality(unsigned long);
-		int oldpers;
-#define PERS_LINUX          0x00000000
-#define PERS_LINUX_32BIT    0x00800000
-#define PERS_LINUX32        0x00000008
-
-		oldpers = personality(PERS_LINUX_32BIT);
-		if (oldpers != -1) {
-			if (personality(PERS_LINUX) != -1) {
-				uname(&un);
-				if (! strcmp(un.machine, "sparc64")) {
-					sparc64 = 1;
-					oldpers = PERS_LINUX32;
-				}
-			}
-			personality(oldpers);
-		}
-	}
-#endif
-
-	return sparc64;
-}
-#  define is_be64() is_sparc64()
-# endif /* sparc32 */
-#else /* !sparc */
-# define is_be64() 0
-#endif
-
-/*
- * The definition of the union swap_header uses the kernel constant PAGE_SIZE.
- * Unfortunately, on some architectures this depends on the hardware model, and
- * can only be found at run time -- we use getpagesize(), so that we do not
- * need separate binaries e.g. for sun4, sun4c/d/m and sun4u.
- *
- * Even more unfortunately, getpagesize() does not always return the right
- * information. For example, libc4, libc5 and glibc 2.0 do not use the system
- * call but invent a value themselves (EXEC_PAGESIZE or NBPG * CLSIZE or NBPC),
- * and thus it may happen that e.g. on a sparc kernel PAGE_SIZE=4096 and
- * getpagesize() returns 8192.
- *
- * What to do? Let us allow the user to specify the pagesize explicitly.
- *
- */
 static unsigned int user_pagesize;
 static unsigned int pagesize;
 static unsigned long *signature_page = NULL;
@@ -214,61 +145,6 @@ write_uuid_and_label(unsigned char *uuid, char *volume_name)
 	}
 }
 
-/*
- * Find out what the maximum amount of swap space is that the kernel will
- * handle.  This wouldn't matter if the kernel just used as much of the
- * swap space as it can handle, but until 2.3.4 it would return an error
- * to swapon() if the swapspace was too large.
- */
-/* Before 2.2.0pre9 */
-#define V1_OLD_MAX_PAGES	((0x7fffffff / pagesize) - 1)
-/* Since 2.2.0pre9, before 2.3.4:
-   error if nr of pages >= SWP_OFFSET(SWP_ENTRY(0,~0UL))
-   with variations on
-	#define SWP_ENTRY(type,offset) (((type) << 1) | ((offset) << 8))
-	#define SWP_OFFSET(entry) ((entry) >> 8)
-   on the various architectures. Below the result - yuk.
-
-   Machine	pagesize	SWP_ENTRY	SWP_OFFSET	bound+1	oldbound+2
-   i386		2^12		o<<8		e>>8		1<<24	1<<19
-   mips		2^12		o<<15		e>>15		1<<17	1<<19
-   alpha	2^13		o<<40		e>>40		1<<24	1<<18
-   m68k		2^12		o<<12		e>>12		1<<20	1<<19
-   sparc	2^{12,13}	(o&0x3ffff)<<9	(e>>9)&0x3ffff	1<<18	1<<{19,18}
-   sparc64	2^13		o<<13		e>>13		1<<51	1<<18
-   ppc		2^12		o<<8		e>>8		1<<24	1<<19
-   armo		2^{13,14,15}	o<<8		e>>8		1<<24	1<<{18,17,16}
-   armv		2^12		o<<9		e>>9		1<<23	1<<19
-
-   assuming that longs have 64 bits on alpha and sparc64 and 32 bits elsewhere.
-
-   The bad part is that we need to know this since the kernel will
-   refuse a swap space if it is too large.
-*/
-/* patch from jj - why does this differ from the above? */
-/* 32bit kernels have a second limitation of 2GB, sparc64 is limited by
-   the size of virtual address space allocation for vmalloc */
-#if defined(__alpha__)
-#define V1_MAX_PAGES           ((1 << 24) - 1)
-#elif defined(__mips__)
-#define V1_MAX_PAGES           ((1 << 17) - 1)
-#elif defined(__sparc__)
-#define V1_MAX_PAGES           (is_sparc64() ? ((3 << 29) - 1) : ((1 << 18) - 1))
-#elif defined(__ia64__)
-/*
- * The actual size will depend on the amount of virtual address space
- * available to vmalloc the swap map.
- */
-#define V1_MAX_PAGES          ((1UL << 54) - 1)
-#else
-#define V1_MAX_PAGES           V1_OLD_MAX_PAGES
-#endif
-/* man page now says:
-The maximum useful size of a swap area now depends on the architecture.
-It is roughly 2GB on i386, PPC, m68k, ARM, 1GB on sparc, 512MB on mips,
-128GB on alpha and 3TB on sparc64.
-*/
-
 #define MAX_BADPAGES	((pagesize-1024-128*sizeof(int)-10)/sizeof(int))
 #define MIN_GOODPAGES	10
 
@@ -442,7 +318,6 @@ main(int argc, char **argv) {
 	struct stat statbuf;
 	struct swap_header_v1_2 *hdr;
 	int c;
-	unsigned long long maxpages;
 	unsigned long long goodpages;
 	unsigned long long sz;
 	off_t offset;
@@ -553,18 +428,9 @@ main(int argc, char **argv) {
 		errx(EXIT_FAILURE,
 		     _("error: swap area needs to be at least %ld KiB"),
 		     (long)(MIN_GOODPAGES * pagesize / 1024));
-
-#ifdef __linux__
-	if (get_linux_version() >= KERNEL_VERSION(2,3,4))
-		maxpages = UINT_MAX + 1ULL;
-	else if (get_linux_version() >= KERNEL_VERSION(2,2,1))
-		maxpages = V1_MAX_PAGES;
-	else
-#endif
-		maxpages = V1_OLD_MAX_PAGES;
-
-	if (PAGES > maxpages) {
-		PAGES = maxpages;
+	if (PAGES > UINT32_MAX) {
+		/* true when swap is bigger than 17.59 terabytes */
+		PAGES = UINT32_MAX;
 		warnx(_("warning: truncating swap area to %llu KiB"),
 			PAGES * pagesize / 1024);
 	}
-- 
2.1.3

