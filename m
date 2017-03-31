Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/6] hwclock: remove alpha cmos
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2d8f50fa-6f30-87ba-aae2-7d9f18b6bbc0@gmx.com>
Date: Fri, 31 Mar 2017 10:43:10 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Remove alpha direct I/O access, use RTC instead:
http://marc.info/?l=util-linux-ng&m=141682406902804

Resolves the alpha 2020 issue for util-linux:
http://marc.info/?l=util-linux-ng&m=148387021519787

Now it is only the kernel's RTC problem.

* sys-utils/hwclock.c: remove alpha cmos
* sys-utils/hwclock-cmos.c: same
* sys-utils/hwclock.h: same
* sys-utils/hwclock.8.in: same

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 316 ++++++-----------------------------------------
 sys-utils/hwclock.8.in   | 110 +++++------------
 sys-utils/hwclock.c      |  32 -----
 sys-utils/hwclock.h      |   9 --
 4 files changed, 72 insertions(+), 395 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 4915471..7a9d595 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -76,17 +76,8 @@ static int inb(int c __attribute__((__unused__)))
 	return 0;
 }
 # endif				/* __i386__ __x86_64__ */
-#elif defined(__alpha__)
-# ifdef HAVE_SYS_IO_H
-#  include <sys/io.h>
-# else
-/* <asm/io.h> fails to compile, probably because of u8 etc */
-extern unsigned int inb(unsigned long port);
-extern void outb(unsigned char b, unsigned long port);
-extern int iopl(int level);
-# endif
-#else				/* __alpha__ */
-# warning "disable cmos access - not i386, x86_64, or alpha"
+#else
+# warning "disable cmos access - not i386 or x86_64"
 static void outb(int a __attribute__((__unused__)),
 		 int b __attribute__((__unused__)))
 {
@@ -106,201 +97,18 @@ static int inb(int c __attribute__((__unused__)))
 #define IOPL_NOT_IMPLEMENTED -2
 
 /*
- * The epoch.
- *
- * Unix uses 1900 as epoch for a struct tm, and 1970 for a time_t. But what
- * was written to CMOS?
- *
- * Digital DECstations use 1928 - this is on a mips or alpha Digital Unix
- * uses 1952, e.g. on AXPpxi33. Windows NT uses 1980. The ARC console
- * expects to boot Windows NT and uses 1980. (But a Ruffian uses 1900, just
- * like SRM.) It is reported that ALPHA_PRE_V1_2_SRM_CONSOLE uses 1958.
+ * POSIX uses 1900 as epoch for a struct tm, and 1970 for a time_t.
  */
 #define TM_EPOCH 1900
-static int cmos_epoch = 1900;
 
-/*
- * Martin Ostermann writes:
- *
- * The problem with the Jensen is twofold: First, it has the clock at a
- * different address. Secondly, it has a distinction between "local" and
- * normal bus addresses. The local ones pertain to the hardware integrated
- * into the chipset, like serial/parallel ports and of course, the RTC.
- * Those need to be addressed differently. This is handled fine in the
- * kernel, and it's not a problem, since this usually gets totally optimized
- * by the compile. But the i/o routines of (g)libc lack this support so far.
- * The result of this is, that the old clock program worked only on the
- * Jensen when USE_DEV_PORT was defined, but not with the normal inb/outb
- * functions.
- */
-static int use_dev_port = 0;		/* 1 for Jensen */
-static int dev_port_fd;
-static unsigned short clock_ctl_addr = 0x70;	/* 0x170 for Jensen */
-static unsigned short clock_data_addr = 0x71;	/* 0x171 for Jensen */
+static unsigned short clock_ctl_addr = 0x70;
+static unsigned short clock_data_addr = 0x71;
 
 static int century_byte = 0;		/* 0: don't access a century byte
 					 * 50 (0x32): usual PC value
 					 * 55 (0x37): PS/2
 					 */
 
-#ifdef __alpha__
-static int funkyTOY = 0;		/* 1 for PC164/LX164/SX164 type alpha */
-#endif
-
-#ifdef __alpha
-
-static int is_in_cpuinfo(char *fmt, char *str)
-{
-	FILE *cpuinfo;
-	char field[256];
-	char format[sizeof(field)];
-	int found = 0;
-
-	sprintf(format, "%s : %s", fmt, "%255s");
-
-	cpuinfo = fopen(_PATH_PROC_CPUINFO, "r");
-	if (cpuinfo) {
-		do {
-			if (fscanf(cpuinfo, format, field) == 1) {
-				if (strncmp(field, str, strlen(str)) == 0)
-					found = 1;
-				break;
-			}
-		} while (fgets(field, 256, cpuinfo));
-		fclose(cpuinfo);
-	}
-	return found;
-}
-
-/*
- * Set cmos_epoch, either from user options, or by asking the kernel, or by
- * looking at /proc/cpu_info
- */
-void set_cmos_epoch(const struct hwclock_control *ctl)
-{
-	unsigned long epoch;
-
-	/* Believe the user */
-	if (ctl->epoch_option) {
-		cmos_epoch = ctl->epoch_option;
-		return;
-	}
-
-	if (ctl->ARCconsole)
-		cmos_epoch = 1980;
-
-	if (ctl->ARCconsole || ctl->SRM)
-		return;
-
-#ifdef __linux__
-	/*
-	 * If we can ask the kernel, we don't need guessing from
-	 * /proc/cpuinfo
-	 */
-	if (get_epoch_rtc(ctl, &epoch, 1) == 0) {
-		cmos_epoch = epoch;
-		return;
-	}
-#endif
-
-	/*
-	 * The kernel source today says: read the year.
-	 *
-	 * If it is in  0-19 then the epoch is 2000.
-	 * If it is in 20-47 then the epoch is 1980.
-	 * If it is in 48-69 then the epoch is 1952.
-	 * If it is in 70-99 then the epoch is 1928.
-	 *
-	 * Otherwise the epoch is 1900.
-	 * TODO: Clearly, this must be changed before 2019.
-	 */
-	/*
-	 * See whether we are dealing with SRM or MILO, as they have
-	 * different "epoch" ideas.
-	 */
-	if (is_in_cpuinfo("system serial number", "MILO")) {
-		if (ctl->debug)
-			printf(_("booted from MILO\n"));
-		/*
-		 * See whether we are dealing with a RUFFIAN aka Alpha PC-164
-		 * UX (or BX), as they have REALLY different TOY (TimeOfYear)
-		 * format: BCD, and not an ARC-style epoch.  BCD is detected
-		 * dynamically, but we must NOT adjust like ARC.
-		 */
-		if (is_in_cpuinfo("system type", "Ruffian")) {
-			if (debug)
-				printf(_("Ruffian BCD clock\n"));
-			return;
-		}
-	}
-
-	cmos_epoch = 1980;
-}
-
-void set_cmos_access(const struct hwclock_control *ctl)
-{
-
-	/*
-	 * See whether we're dealing with a Jensen---it has a weird I/O
-	 * system. DEC was just learning how to build Alpha PCs.
-	 */
-	if (ctl->Jensen || is_in_cpuinfo("system type", "Jensen")) {
-		use_dev_port = 1;
-		clock_ctl_addr = 0x170;
-		clock_data_addr = 0x171;
-		if (ctl->debug)
-			printf(_("clockport adjusted to 0x%x\n"),
-			       clock_ctl_addr);
-	}
-
-	/*
-	 * See whether we are dealing with PC164/LX164/SX164, as they have a
-	 * TOY that must be accessed differently to work correctly.
-	 */
-	/* Nautilus stuff reported by Neoklis Kyriazis */
-	if (ctl->funky_toy ||
-	    is_in_cpuinfo("system variation", "PC164") ||
-	    is_in_cpuinfo("system variation", "LX164") ||
-	    is_in_cpuinfo("system variation", "SX164") ||
-	    is_in_cpuinfo("system type", "Nautilus")) {
-		funkyTOY = 1;
-		if (ctl->debug)
-			printf(_("funky TOY!\n"));
-	}
-}
-#endif				/* __alpha */
-
-#ifdef __alpha__
-/*
- * The Alpha doesn't allow user-level code to disable interrupts (for good
- * reasons). Instead, we ensure atomic operation by performing the operation
- * and checking whether the high 32 bits of the cycle counter changed. If
- * they did, a context switch must have occurred and we redo the operation.
- * As long as the operation is reasonably short, it will complete
- * atomically, eventually.
- */
-static unsigned long
-atomic(const char *name,
-       unsigned long (*op) (const struct hwclock_control *ctl, unsigned long),
-       const struct hwclock_control *ctl,
-       unsigned long arg)
-{
-	unsigned long ts1, ts2, n, v;
-
-	for (n = 0; n < 1000; ++n) {
-		asm volatile ("rpcc %0":"r=" (ts1));
-		v = (*op) (ctl, arg);
-		asm volatile ("rpcc %0":"r=" (ts2));
-
-		if ((ts1 ^ ts2) >> 32 == 0) {
-			return v;
-		}
-	}
-	errx(EXIT_FAILURE, _("atomic %s failed for 1000 iterations!"),
-		name);
-}
-#else
-
 /*
  * Hmmh, this isn't very atomic. Maybe we should force an error instead?
  *
@@ -315,68 +123,37 @@ atomic(const char *name __attribute__ ((__unused__)),
 	return (*op) (ctl, arg);
 }
 
-#endif
+/*
+ * We only want to read CMOS data, but unfortunately writing to bit 7
+ * disables (1) or enables (0) NMI; since this bit is read-only we have
+ * to guess the old status. Various docs suggest that one should disable
+ * NMI while reading/writing CMOS data, and enable it again afterwards.
+ * This would yield the sequence
+ *
+ *  outb (reg | 0x80, 0x70);
+ *  val = inb(0x71);
+ *  outb (0x0d, 0x70);  // 0x0d: random read-only location
+ *
+ * Other docs state that "any write to 0x70 should be followed by an
+ * action to 0x71 or the RTC will be left in an unknown state". Most
+ * docs say that it doesn't matter at all what one does.
+ *
+ * bit 0x80: disable NMI while reading - should we? Let us follow the
+ * kernel and not disable. Called only with 0 <= reg < 128
+ */
 
 static inline unsigned long cmos_read(const struct hwclock_control *ctl,
 				      unsigned long reg)
 {
-	if (use_dev_port) {
-		unsigned char v = reg | 0x80;
-		lseek(dev_port_fd, clock_ctl_addr, 0);
-		if (write(dev_port_fd, &v, 1) == -1 && ctl->debug)
-			warn(_("cmos_read(): write to control address %X failed"),
-			       clock_ctl_addr);
-		lseek(dev_port_fd, clock_data_addr, 0);
-		if (read(dev_port_fd, &v, 1) == -1 && ctl->debug)
-			warn(_("cmos_read(): read from data address %X failed"),
-			       clock_data_addr);
-		return v;
-	} else {
-		/*
-		 * We only want to read CMOS data, but unfortunately writing
-		 * to bit 7 disables (1) or enables (0) NMI; since this bit
-		 * is read-only we have to guess the old status. Various
-		 * docs suggest that one should disable NMI while
-		 * reading/writing CMOS data, and enable it again
-		 * afterwards. This would yield the sequence
-		 *
-		 *  outb (reg | 0x80, 0x70);
-		 *  val = inb(0x71);
-		 *  outb (0x0d, 0x70);  // 0x0d: random read-only location
-		 *
-		 * Other docs state that "any write to 0x70 should be
-		 * followed by an action to 0x71 or the RTC will be left in
-		 * an unknown state". Most docs say that it doesn't matter at
-		 * all what one does.
-		 */
-		/*
-		 * bit 0x80: disable NMI while reading - should we? Let us
-		 * follow the kernel and not disable. Called only with 0 <=
-		 * reg < 128
-		 */
-		outb(reg, clock_ctl_addr);
-		return inb(clock_data_addr);
-	}
+	outb(reg, clock_ctl_addr);
+	return inb(clock_data_addr);
 }
 
 static inline unsigned long cmos_write(const struct hwclock_control *ctl,
 				       unsigned long reg, unsigned long val)
 {
-	if (use_dev_port) {
-		unsigned char v = reg | 0x80;
-		lseek(dev_port_fd, clock_ctl_addr, 0);
-		if (write(dev_port_fd, &v, 1) == -1 && ctl->debug)
-			warn(_("cmos_write(): write to control address %X failed"),
-			       clock_ctl_addr);
-		v = (val & 0xff);
-		lseek(dev_port_fd, clock_data_addr, 0);
-		if (write(dev_port_fd, &v, 1) == -1 && ctl->debug)
-			warn(_("cmos_write(): write to data address %X failed"),
-			       clock_data_addr);
-	} else {
-		outb(reg, clock_ctl_addr);
-		outb(val, clock_data_addr);
-	}
+	outb(reg, clock_ctl_addr);
+	outb(val, clock_data_addr);
 	return 0;
 }
 
@@ -409,9 +186,7 @@ static unsigned long cmos_set_time(const struct hwclock_control *ctl,
 	save_freq_select = cmos_read(ctl, 10);	/* stop and reset prescaler */
 	cmos_write(ctl, 10, (save_freq_select | 0x70));
 
-	tm.tm_year += TM_EPOCH;
-	century = tm.tm_year / 100;
-	tm.tm_year -= cmos_epoch;
+	century = (tm.tm_year + TM_EPOCH) / 100;
 	tm.tm_year %= 100;
 	tm.tm_mon += 1;
 	tm.tm_wday += 1;
@@ -475,10 +250,6 @@ static void hclock_set_time(const struct hwclock_control *ctl, const struct tm *
 static inline int cmos_clock_busy(const struct hwclock_control *ctl)
 {
 	return
-#ifdef __alpha__
-	    /* poll bit 4 (UF) of Control Register C */
-	    funkyTOY ? (hclock_read(ctl, 12) & 0x10) :
-#endif
 	    /* poll bit 7 (UIP) of Control Register A */
 	    (hclock_read(ctl, 10) & 0x80);
 }
@@ -594,7 +365,6 @@ static int read_hardware_clock_cmos(const struct hwclock_control *ctl
 	 */
 	tm->tm_wday -= 1;
 	tm->tm_mon -= 1;
-	tm->tm_year += (cmos_epoch - TM_EPOCH);
 	if (tm->tm_year < 69)
 		tm->tm_year += 100;
 	if (pmbit) {
@@ -616,7 +386,7 @@ static int set_hardware_clock_cmos(const struct hwclock_control *ctl
 	return 0;
 }
 
-#if defined(__i386__) || defined(__alpha__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__)
 # if defined(HAVE_IOPL)
 static int i386_iopl(const int level)
 {
@@ -640,23 +410,15 @@ static int get_permissions_cmos(void)
 {
 	int rc;
 
-	if (use_dev_port) {
-		if ((dev_port_fd = open(_PATH_DEV_PORT, O_RDWR)) < 0) {
-			warn(_("cannot open %s"), _PATH_DEV_PORT);
-			rc = 1;
-		} else
-			rc = 0;
-	} else {
-		rc = i386_iopl(3);
-		if (rc == IOPL_NOT_IMPLEMENTED) {
-			warnx(_("I failed to get permission because I didn't try."));
-		} else if (rc != 0) {
-			rc = errno;
-			warn(_("unable to get I/O port access:  "
-			       "the iopl(3) call failed"));
-			if (rc == EPERM && geteuid())
-				warnx(_("Probably you need root privileges.\n"));
-		}
+	rc = i386_iopl(3);
+	if (rc == IOPL_NOT_IMPLEMENTED) {
+		warnx(_("I failed to get permission because I didn't try."));
+	} else if (rc != 0) {
+		rc = errno;
+		warn(_("unable to get I/O port access:  "
+		       "the iopl(3) call failed"));
+		if (rc == EPERM && geteuid())
+			warnx(_("Probably you need root privileges.\n"));
 	}
 	return rc ? 1 : 0;
 }
@@ -676,7 +438,7 @@ static struct clock_ops cmos_interface = {
 struct clock_ops *probe_for_cmos_clock(void)
 {
 	static const int have_cmos =
-#if defined(__i386__) || defined(__alpha__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__)
 	    TRUE;
 #else
 	    FALSE;
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index d1e8027..80a579f 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -44,22 +44,30 @@ discussion below, under
 .B \-\-getepoch
 .TQ
 .B \-\-setepoch
-These functions are for Alpha machines only.
+These functions are for Alpha machines only, and are only available
+through the Linux kernel RTC driver.
 .sp
-Read and set the kernel's Hardware Clock epoch value.
+They are used to read and set the kernel's Hardware Clock epoch value.
 Epoch is the number of years into AD to which a zero year value in the
-Hardware Clock refers.  For example, if you are using the convention
-that the year counter in your Hardware Clock contains the number of
-full years since 1952, then the kernel's Hardware Clock epoch value
-must be 1952.
+Hardware Clock refers.  For example, if the machine's BIOS sets the year
+counter in the Hardware Clock to contain the number of full years since
+1952, then the kernel's Hardware Clock epoch value must be 1952.
 .sp
 The \fB\%\-\-setepoch\fR function requires using the
 .B \%\-\-epoch
-option to specify the year.
-.sp
+option to specify the year.  For example:
+.RS
+.IP "" 4
+.B hwclock\ \-\-setepoch\ \-\-epoch=1952
+.PP
+The RTC driver attempts to guess the correct epoch value, so setting it
+may not be required.
+.PP
 This epoch value is used whenever
 .B \%hwclock
-reads or sets the Hardware Clock.
+reads or sets the Hardware Clock on an Alpha machine.  For ISA machines
+the kernel uses the fixed Hardware Clock epoch of 1900.
+.RE
 .
 .TP
 .B \-\-predict
@@ -278,23 +286,27 @@ can help you understand how the program works.
 .
 .TP
 .B \-\-directisa
-This option is meaningful for: ISA compatible machines including x86, and
-x86_64; and Alpha (which has a similar Hardware Clock interface).  For other
-machines, it has no effect.  This option tells
+This option is meaningful for ISA compatible machines in the x86 and
+x86_64 family.  For other machines, it has no effect.  This option tells
 .B \%hwclock
 to use explicit I/O instructions to access the Hardware Clock.
 Without this option,
 .B \%hwclock
-will use the rtc device, which it assumes to be driven by the RTC device
-driver.  As of v2.26 it will no longer automatically use directisa when
-the rtc driver is unavailable; this was causing an unsafe condition that
-could allow two processes to access the Hardware Clock at the same time.
-Direct hardware access from userspace should only be used for testing,
-troubleshooting, and as a last resort when all other methods fail.  See
-the
+will use the rtc device file, which it assumes to be driven by the Linux
+RTC device driver.  As of v2.26 it will no longer automatically use
+directisa when the rtc driver is unavailable; this was causing an unsafe
+condition that could allow two processes to access the Hardware Clock at
+the same time.  Direct hardware access from userspace should only be
+used for testing, troubleshooting, and as a last resort when all other
+methods fail.  See the
 .BR \-\-rtc " option."
 .
 .TP
+.BI \-\-epoch= year
+This option is required when using the
+.BR \%\-\-setepoch \ function.
+.
+.TP
 .BR \-f , \ \-\-rtc=\fIfilename\fR
 .RB "Override " \%hwclock 's
 default rtc device file name.  Otherwise it will
@@ -402,55 +414,6 @@ option to be used.  See the discussion below, under
 .BR "The Adjust Function" .
 .RE
 .
-.SH OPTIONS FOR ALPHA MACHINES ONLY
-.
-.TP
-.B \-\-arc
-This option is equivalent to
-.B \%\-\-epoch=1980
-and is used to specify the most common epoch on Alphas
-with an ARC console (although Ruffians have an epoch of 1900).
-.
-.TP
-.BI \-\-epoch= year
-Specifies the year which is the beginning of the Hardware Clock's epoch,
-that is the number of years into AD to which a zero value in the
-Hardware Clock's year counter refers.  It is used together with the
-.B \%\-\-setepoch
-option to set the kernel's idea of the epoch of the Hardware Clock.
-.sp
-For example, on a Digital Unix machine:
-.RS
-.IP "" 4
-.B hwclock\ \-\-setepoch\ \-\-epoch=1952
-.RE
-.
-.TP
-.B \-\-funky\-toy
-.TQ
-.B \-\-jensen
-These two options specify what kind of Alpha machine you have.  They
-are invalid if you do not have an Alpha and are usually unnecessary
-if you do;
-.B \%hwclock
-should be able to determine what it is running on when
-.I \%/proc
-is mounted.
-.sp
-.RB "The " \%\-\-jensen
-option is used for Jensen models;
-.B \%\-\-funky\-toy
-means that the machine requires the UF bit instead of the UIP bit in
-the Hardware Clock to detect a time transition.  The "toy" in the option
-name refers to the Time Of Year facility of the machine.
-.
-.TP
-.B \-\-srm
-This option is equivalent to
-.B \%\-\-epoch=1900
-and is used to specify the most common epoch on Alphas
-with an SRM console.
-.
 .SH NOTES
 .
 .SS Clocks in a Linux System
@@ -566,15 +529,8 @@ reasons that userspace programs are generally not supposed to do
 direct I/O and disable interrupts.
 .B \%hwclock
 provides it for testing, troubleshooting, and  because it may be the
-only method available on ISA compatible and Alpha systems which do not
-have a working rtc device driver.
-.PP
-In the case of a Jensen Alpha, there is no way for
-.B \%hwclock
-to execute those I/O instructions, and so it uses instead the
-.I \%/dev/port
-device special file, which provides almost as low-level an interface to
-the I/O subsystem.
+only method available on ISA systems which do not have a working rtc
+device driver.
 .PP
 On an m68k system,
 .B \%hwclock
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index bd2a057..8914f94 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1279,11 +1279,6 @@ static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
 		"                        the default is %1$s\n"), _PATH_ADJTIME);
 	fputs(_("     --test           do not update anything, just show what would happen\n"
 		" -D, --debug          debugging mode\n" "\n"), usageto);
-#ifdef __alpha__
-	fputs(_(" -J|--jensen, -A|--arc, -S|--srm, -F|--funky-toy\n"
-		"      tell hwclock the type of Alpha you have (see hwclock(8))\n"
-		 "\n"), usageto);
-#endif
 
 	if (fmt) {
 		va_start(ap, fmt);
@@ -1344,15 +1339,6 @@ int main(int argc, char **argv)
 		{ "version",      no_argument,       NULL, 'v'            },
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
-#ifdef __alpha__
-		{ "ARC",          no_argument,       NULL, 'A'            },
-		{ "arc",          no_argument,       NULL, 'A'            },
-		{ "Jensen",       no_argument,       NULL, 'J'            },
-		{ "jensen",       no_argument,       NULL, 'J'            },
-		{ "SRM",          no_argument,       NULL, 'S'            },
-		{ "srm",          no_argument,       NULL, 'S'            },
-		{ "funky-toy",    no_argument,       NULL, 'F'            },
-#endif
 		{ "set",          no_argument,       NULL, OPT_SET        },
 #ifdef __linux__
 		{ "getepoch",     no_argument,       NULL, OPT_GETEPOCH   },
@@ -1438,20 +1424,6 @@ int main(int argc, char **argv)
 		case 'w':
 			ctl.systohc = 1;
 			break;
-#ifdef __alpha__
-		case 'A':
-			ctl.ARCconsole = 1;
-			break;
-		case 'J':
-			ctl.Jensen = 1;
-			break;
-		case 'S':
-			ctl.SRM = 1;
-			break;
-		case 'F':
-			ctl.funky_toy = 1;
-			break;
-#endif
 		case OPT_SET:
 			ctl.set = 1;
 			break;
@@ -1538,10 +1510,6 @@ int main(int argc, char **argv)
 			"either --utc or --localtime"));
 		hwclock_exit(&ctl, EX_USAGE);
 	}
-#ifdef __alpha__
-	set_cmos_epoch(&ctl);
-	set_cmos_access(&ctl);
-#endif
 
 	if (ctl.set || ctl.predict) {
 		if (parse_date(&when, ctl.date_opt, NULL))
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 383b970..f090ed7 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -32,12 +32,6 @@ struct hwclock_control {
 		hctosys:1,
 		utc:1,
 		systohc:1,
-#ifdef __alpha__
-		ARCconsole:1,
-		Jensen:1,
-		SRM:1,
-		funky_toy:1,
-#endif
 #ifdef __linux__
 		getepoch:1,
 		setepoch:1,
@@ -71,9 +65,6 @@ typedef int bool;
 extern int debug;
 extern unsigned long epoch_option;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
-/* cmos.c */
-extern void set_cmos_epoch(const struct hwclock_control *ctl);
-extern void set_cmos_access(const struct hwclock_control *ctl);
 
 /* rtc.c */
 extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch, int silent);
