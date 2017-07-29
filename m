Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35794 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752599AbdG2Pff (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 29 Jul 2017 11:35:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so24987830wra.2
        for <util-linux@vger.kernel.org>; Sat, 29 Jul 2017 08:35:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] tunelp: use linux header
Date: Sat, 29 Jul 2017 16:35:30 +0100
Message-Id: <20170729153530.9119-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove use of LPTRUSTIRQ in same go.  The LPTRUSTIRQ provided --trust-irq
option, but it has not worked in nearly 20 years.

Reference: http://repo.or.cz/davej-history.git/blobdiff/1f58336fe0515bc929e4de227eb44b12a4a18998..ac5579c68db87bc21630676c167ee8224267f32c:/include/linux/lp.h
Reference: http://repo.or.cz/davej-history.git/blobdiff/1f58336fe0515bc929e4de227eb44b12a4a18998..ac5579c68db87bc21630676c167ee8224267f32c:/drivers/char/lp.c
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am |  2 +-
 sys-utils/lp.h          | 83 -------------------------------------------------
 sys-utils/tunelp.8      | 24 --------------
 sys-utils/tunelp.c      | 14 ++-------
 4 files changed, 3 insertions(+), 120 deletions(-)
 delete mode 100644 sys-utils/lp.h

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 754f1f44d..66b540874 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -74,7 +74,7 @@ endif
 if BUILD_TUNELP
 usrsbin_exec_PROGRAMS += tunelp
 dist_man_MANS += sys-utils/tunelp.8
-tunelp_SOURCES = sys-utils/tunelp.c sys-utils/lp.h
+tunelp_SOURCES = sys-utils/tunelp.c
 tunelp_LDADD = $(LDADD) libcommon.la
 endif
 
diff --git a/sys-utils/lp.h b/sys-utils/lp.h
deleted file mode 100644
index 7fa83dde2..000000000
--- a/sys-utils/lp.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* Line printer stuff mostly follows the original Centronics printers. See
-   IEEE Std.1284-1994 Standard Signaling Method for a Bi-directional Parallel
-   Peripheral Interface for Personal Computers for 5 modes of data transfer. */
-
-/* Parallel port registers: data (0x3bc, 0x378, 0x278), status=data+1, control=data+2 */
-
-/* Parallel port status register (read only):
-bit 7: NBSY	(1: ready, 0: busy or error or off-line)
-bit 6: NACK	(if NBSY=1, then 1; if NBSY=0 then 1: sending data, 0: ready with data)
-bit 5:  PAP	(1: out-of-paper)
-bit 4: OFON	(1: on-line)
-bit 3: NFEH	(1: OK, 0: printer error)
-bits 2-0: 07
-
-On out-of-paper: PAP=1, OFON=0, NFEH=1.
-
-"When reading the busy status, read twice in a row and use the value
-obtained from the second read. This improves the reliability on some
-parallel ports when the busy line may not be connected and is floating."
-"On some Okidata printers when the busy signal switches from high to low,
-the printer sends a 50 ns glitch on the paper out signal line. Before
-declaring a paper out condition, check the status again."
-(The Undocumented PC, F. van Gilluwe, p. 711)
-*/
-
-/* Parallel port control register (read/write):
-bit 4:  IRQ	(1: we want an interrupt when NACK goes from 1 to 0)
-bit 3:  DSL	(1: activate printer)
-bit 2: NINI	(0: initialise printer)
-bit 1:  ALF	(1: printer performs automatic linefeed after each line)
-bit 0:  STR	(0->1: generate a Strobe pulse: transport data to printer)
-*/
-
-/* Parallel port timing:
-   1. wait for NBSY=1
-   2. outb(data byte, data port)
-   3. wait for at least 0.5us
-   4. read control port, OR with STR=0x1, output to control port - purpose:
-      generate strobe pulse; this will make the busy line go high
-   5. wait for at least 0.5us
-   6. read control port, AND with !STR, output to control port
-   7. wait for at least 0.5us
-   8. in a loop: read status register until NACK bit is 0 or NBSY=1
-      (the printer will keep NACK=0 for at least 0.5us, then NACK=NBSY=1).
-*/
-
-
-/* lp ioctls */
-#define LPCHAR   0x0601  /* specify the number of times we ask for the status
-			    (waiting for ready) before giving up with a timeout
-			    The duration may mainly depend on the timing of an inb. */
-#define LPTIME   0x0602  /* time to sleep after each timeout (in units of 0.01 sec) */
-#define LPABORT  0x0604  /* call with TRUE arg to abort on error,
-			    FALSE to retry.  Default is retry.  */
-#define LPSETIRQ 0x0605  /* call with new IRQ number,
-			    or 0 for polling (no IRQ) */
-#define LPGETIRQ 0x0606  /* get the current IRQ number */
-#define LPWAIT   0x0608  /* #of loops to wait before taking strobe high */
-#define LPCAREFUL   0x0609  /* call with TRUE arg to require out-of-paper, off-
-			    line, and error indicators good on all writes,
-			    FALSE to ignore them.  Default is ignore. */
-#define LPABORTOPEN 0x060a  /* call with TRUE arg to abort open() on error,
-			    FALSE to ignore error.  Default is ignore.  */
-#define LPGETSTATUS 0x060b  /* return LP_S(minor) */
-#define LPRESET     0x060c  /* reset printer */
-#define LPGETFLAGS  0x060e  /* get status flags */
-
-#define LPSTRICT    0x060f  /* enable/disable strict compliance (2.0.36) */
-                            /* Strict: wait until !READY before taking strobe low;
-			       this may be bad for the Epson Stylus 800.
-			       Not strict: wait a constant time as given by LPWAIT */
-#define LPTRUSTIRQ  0x060f  /* set/unset the LP_TRUST_IRQ flag (2.1.131) */
-
-/* 
- * bit defines for 8255 status port
- * base + 1
- * accessed with LP_S(minor), which gets the byte...
- */
-#define LP_PBUSY	0x80  /* inverted input, active high */
-#define LP_PACK		0x40  /* unchanged input, active low */
-#define LP_POUTPA	0x20  /* unchanged input, active high */
-#define LP_PSELECD	0x10  /* unchanged input, active high */
-#define LP_PERRORP	0x08  /* unchanged input, active low */
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index 1798ec978..90db83491 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -96,22 +96,6 @@ This option returns the current printer status, both as a decimal number from
 0..255, and as a list of active flags.  When this option is specified, \-q
 off, turning off the display of the current IRQ, is implied.
 .TP
-\fB\-T\fR, \fB\-\-trust\-irq\fR \fI<on|off>\fR
-This option is obsolete. It was added in Linux 2.1.131, and removed again in
-Linux 2.3.10.  The below is for these old kernels only.
-.IP
-This option tells the lp driver to trust or not the IRQ.  This option makes
-sense only if you are using interrupts.  If you tell the lp driver to trust
-the irq, then, when the lp driver will get an irq, it will send the next
-pending character to the printer unconditionally, even if the printer still
-claims to be BUSY.  This is the only way to sleep on interrupt (and so the
-handle the irq printing efficiently) at least on Epson Stylus Color Printers.
-The lp driver automagically detects if you could get improved performance by
-setting this flag, and in such case it will warn you with a kernel message.
-.IP
-NOTE: Trusting the irq is reported to corrupt the printing on some hardware,
-you must try to know if your printer will work or not...
-.TP
 \fB\-r\fR, \fB\-\-reset\fR
 This option resets the port.  It requires a Linux kernel version of 1.1.80 or
 later.
@@ -127,14 +111,6 @@ all require a Linux kernel version of 1.1.76 or later.
 .PP
 .B \-C
 requires a Linux version prior to 2.1.131.
-.PP
-.B \-T
-requires a Linux version of 2.1.131 or later.
-.SH BUGS
-By some unfortunate coincidence the ioctl LPSTRICT of 2.0.36 has the same
-number as the ioctl LPTRUSTIRQ introduced in 2.1.131.  So, use of the \-T
-option on a 2.0.36 kernel with an tunelp compiled under 2.1.131 or later may
-have unexpected effects.
 .SH FILES
 .I /dev/lp?
 .br
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index c6bdc66e9..fe261f393 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -69,7 +69,8 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "lp.h"
+#include <linux/lp.h>
+
 #include "nls.h"
 #include "closestream.h"
 #include "strutils.h"
@@ -108,7 +109,6 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -o, --check-status <on|off>  check printer status before printing\n"), out);
 	fputs(_(" -C, --careful <on|off>       extra checking to status check\n"), out);
 	fputs(_(" -s, --status                 query printer status\n"), out);
-	fputs(_(" -T, --trust-irq <on|off>     make driver to trust irq\n"), out);
 	fputs(_(" -r, --reset                  reset the port\n"), out);
 	fputs(_(" -q, --print-irq <on|off>     display current irq setting\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -229,16 +229,6 @@ int main(int argc, char **argv)
 			cmds = cmds->next;
 			cmds->next = NULL;
 			break;
-		case 'T':
-			/* Note: this will do the wrong thing on
-			 * 2.0.36 when compiled under 2.2.x
-			 */
-			cmds->op = LPTRUSTIRQ;
-			cmds->val = parse_switch(optarg, _("argument error"), "on", "off", NULL);
-			cmds->next = xmalloc(sizeof(struct command));
-			cmds = cmds->next;
-			cmds->next = NULL;
-			break;
 		case 'v':
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
-- 
2.13.3

