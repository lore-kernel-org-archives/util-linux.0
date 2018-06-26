Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40142 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeFZVNs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 Jun 2018 17:13:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id g18-v6so18599356wro.7
        for <util-linux@vger.kernel.org>; Tue, 26 Jun 2018 14:13:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] hwclock: stop supporting alpha cpu architecture
Date: Tue, 26 Jun 2018 22:13:43 +0100
Message-Id: <20180626211343.4675-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Debian has stopped supporting alpha about 10 years ago, but apparently
Gentoo keeps on going.  Then again, logic clearly dictates that the needs of
the many outweigh the needs of the few.  It is time to throw away code that
practically no-one uses, and due lack of hardware cannot be tested.

Reference: https://lists.debian.org/debian-devel-announce/2009/10/msg00000.html
Reference: https://wiki.gentoo.org/wiki/Alpha/FAQ#Isn.27t_the_Alpha_architecture_dead.3F
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/hwclock-cmos.c |  5 ---
 sys-utils/hwclock-rtc.c  | 78 ----------------------------------------
 sys-utils/hwclock.8.in   | 44 ++---------------------
 sys-utils/hwclock.c      | 65 ++-------------------------------
 sys-utils/hwclock.h      | 13 -------
 5 files changed, 5 insertions(+), 200 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index f7e8a1811..bce221dc1 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -95,11 +95,6 @@ static int inb(int c __attribute__((__unused__)))
 
 #define IOPL_NOT_IMPLEMENTED -2
 
-/*
- * POSIX uses 1900 as epoch for a struct tm, and 1970 for a time_t.
- */
-#define TM_EPOCH 1900
-
 static unsigned short clock_ctl_addr = 0x70;
 static unsigned short clock_data_addr = 0x71;
 
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index ef95d9807..219ebcb16 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -77,12 +77,6 @@ struct linux_rtc_time {
 # define RTC_UIE_OFF	_IO('p', 0x04)	/* Update int. enable off */
 #endif
 
-/* RTC_EPOCH_READ and RTC_EPOCH_SET are present since 2.0.34 and 2.1.89 */
-#ifndef RTC_EPOCH_READ
-# define RTC_EPOCH_READ	_IOR('p', 0x0d, unsigned long)	/* Read epoch */
-# define RTC_EPOCH_SET	_IOW('p', 0x0e, unsigned long)	/* Set epoch */
-#endif
-
 /*
  * /dev/rtc is conventionally chardev 10/135
  * ia64 uses /dev/efirtc, chardev 10/136
@@ -255,16 +249,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
 	} else {
 		int rc;		/* Return code from ioctl */
 		/* Turn on update interrupts (one per second) */
-#if defined(__alpha__) || defined(__sparc__)
-		/*
-		 * Not all alpha kernels reject RTC_UIE_ON, but probably
-		 * they should.
-		 */
-		rc = -1;
-		errno = EINVAL;
-#else
 		rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
-#endif
 		if (rc != -1) {
 			/*
 			 * Just reading rtc_fd fails on broken hardware: no
@@ -386,66 +371,3 @@ struct clock_ops *probe_for_rtc_clock(const struct hwclock_control *ctl)
 		return NULL;
 	return &rtc_interface;
 }
-
-#ifdef __alpha__
-/*
- * Get the Hardware Clock epoch setting from the kernel.
- */
-int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
-{
-	int rtc_fd;
-
-	rtc_fd = open_rtc(ctl);
-	if (rtc_fd < 0) {
-		warn(_("cannot open %s"), rtc_dev_name);
-		return 1;
-	}
-
-	if (ioctl(rtc_fd, RTC_EPOCH_READ, epoch_p) == -1) {
-		warn(_("ioctl(%d, RTC_EPOCH_READ, epoch_p) to %s failed"),
-		     rtc_fd, rtc_dev_name);
-		return 1;
-	}
-
-	if (ctl->verbose)
-		printf(_("ioctl(%d, RTC_EPOCH_READ, epoch_p) to %s succeeded.\n"),
-		       rtc_fd, rtc_dev_name);
-
-	return 0;
-}
-
-/*
- * Set the Hardware Clock epoch in the kernel.
- */
-int set_epoch_rtc(const struct hwclock_control *ctl)
-{
-	int rtc_fd;
-	unsigned long epoch;
-
-	epoch = strtoul(ctl->epoch_option, NULL, 10);
-
-	/* There were no RTC clocks before 1900. */
-	if (epoch < 1900 || epoch == ULONG_MAX) {
-		warnx(_("invalid epoch '%s'."), ctl->epoch_option);
-		return 1;
-	}
-
-	rtc_fd = open_rtc(ctl);
-	if (rtc_fd < 0) {
-		warn(_("cannot open %s"), rtc_dev_name);
-		return 1;
-	}
-
-	if (ioctl(rtc_fd, RTC_EPOCH_SET, epoch) == -1) {
-		warn(_("ioctl(%d, RTC_EPOCH_SET, %lu) to %s failed"),
-		     rtc_fd, epoch, rtc_dev_name);
-		return 1;
-	}
-
-	if (ctl->verbose)
-		printf(_("ioctl(%d, RTC_EPOCH_SET, %lu) to %s succeeded.\n"),
-		       rtc_fd, epoch, rtc_dev_name);
-
-	return 0;
-}
-#endif	/* __alpha__ */
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index b9f618973..ab9c0a5f3 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -4,7 +4,7 @@
 .\"   Authored new section: DATE-TIME CONFIGURATION.
 .\"   Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
 .\"
-.TH HWCLOCK 8 "July 2017" "util-linux" "System Administration"
+.TH HWCLOCK 8 "June 2018" "util-linux" "System Administration"
 .SH NAME
 hwclock \- time clocks utility
 .SH SYNOPSIS
@@ -18,9 +18,8 @@ is an administration tool for the time clocks.  It can: display the
 Hardware Clock time; set the Hardware Clock to a specified time; set the
 Hardware Clock from the System Clock; set the System Clock from the
 Hardware Clock; compensate for Hardware Clock drift; correct the System
-Clock timescale; set the kernel's timezone, NTP timescale, and epoch
-(Alpha only); and predict future
-Hardware Clock values based on its drift rate.
+Clock timescale; set the kernel's timezone, NTP timescale and predict
+future Hardware Clock values based on its drift rate.
 .PP
 Since v2.26 important changes were made to the
 .B \-\-hctosys
@@ -41,35 +40,6 @@ discussion below, under
 .BR "The Adjust Function" .
 .
 .TP
-.B \-\-getepoch
-.TQ
-.B \-\-setepoch
-These functions are for Alpha machines only, and are only available
-through the Linux kernel RTC driver.
-.sp
-They are used to read and set the kernel's Hardware Clock epoch value.
-Epoch is the number of years into AD to which a zero year value in the
-Hardware Clock refers.  For example, if the machine's BIOS sets the year
-counter in the Hardware Clock to contain the number of full years since
-1952, then the kernel's Hardware Clock epoch value must be 1952.
-.sp
-The \fB\%\-\-setepoch\fR function requires using the
-.B \%\-\-epoch
-option to specify the year.  For example:
-.RS
-.IP "" 4
-.B hwclock\ \-\-setepoch\ \-\-epoch=1952
-.PP
-The RTC driver attempts to guess the correct epoch value, so setting it
-may not be required.
-.PP
-This epoch value is used whenever
-.B \%hwclock
-reads or sets the Hardware Clock on an Alpha machine.  For ISA machines
-the kernel uses the fixed Hardware Clock epoch of 1900.
-.RE
-.
-.TP
 .B \-\-predict
 Predict what the Hardware Clock will read in the future based upon the
 time given by the
@@ -303,14 +273,6 @@ methods fail.  See the
 .BR \-\-rtc " option."
 .
 .TP
-.BI \-\-epoch= year
-This option is required when using the
-.BR \%\-\-setepoch \ function.
-.RI "The minimum " year
-value is 1900. The maximum is system dependent
-.RB ( ULONG_MAX\ -\ 1 ).
-.
-.TP
 .BR \-f , \ \-\-rtc=\fIfilename\fR
 .RB "Override " \%hwclock 's
 default rtc device file name.  Otherwise it will
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index b83e71004..2526721a8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1020,31 +1020,6 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	return EXIT_SUCCESS;
 }
 
-/**
- * Get or set the kernel RTC driver's epoch on Alpha machines.
- * ISA machines are hard coded for 1900.
- */
-#if defined(__linux__) && defined(__alpha__)
-static void
-manipulate_epoch(const struct hwclock_control *ctl)
-{
-	if (ctl->getepoch) {
-		unsigned long epoch;
-
-		if (get_epoch_rtc(ctl, &epoch))
-			warnx(_("unable to read the RTC epoch."));
-		else
-			printf(_("The RTC epoch is set to %lu.\n"), epoch);
-	} else if (ctl->setepoch) {
-		if (!ctl->epoch_option)
-			warnx(_("--epoch is required for --setepoch."));
-		else if (!ctl->testing)
-			if (set_epoch_rtc(ctl))
-				warnx(_("unable to set the RTC epoch."));
-	}
-}
-#endif		/* __linux__ __alpha__ */
-
 static void out_version(void)
 {
 	printf(UTIL_LINUX_VERSION);
@@ -1067,10 +1042,6 @@ usage(void)
 	puts(_(" -w, --systohc        set the RTC from the system time"));
 	puts(_("     --systz          send timescale configurations to the kernel"));
 	puts(_(" -a, --adjust         adjust the RTC to account for systematic drift"));
-#if defined(__linux__) && defined(__alpha__)
-	puts(_("     --getepoch       display the RTC epoch"));
-	puts(_("     --setepoch       set the RTC epoch according to --epoch"));
-#endif
 	puts(_("     --predict        predict the drifted RTC time according to --date"));
 	fputs(USAGE_OPTIONS, stdout);
 	puts(_(" -u, --utc            the RTC timescale is UTC"));
@@ -1082,9 +1053,6 @@ usage(void)
 	printf(_(
 	       "     --directisa      use the ISA bus instead of %1$s access\n"), _PATH_RTC_DEV);
 	puts(_("     --date <time>    date/time input for --set and --predict"));
-#if defined(__linux__) && defined(__alpha__)
-	puts(_("     --epoch <year>   epoch input for --setepoch"));
-#endif
 	puts(_("     --update-drift   update the RTC drift factor"));
 	printf(_(
 	       "     --noadjfile      do not use %1$s\n"), _PATH_ADJTIME);
@@ -1116,13 +1084,10 @@ int main(int argc, char **argv)
 		OPT_ADJFILE = CHAR_MAX + 1,
 		OPT_DATE,
 		OPT_DIRECTISA,
-		OPT_EPOCH,
 		OPT_GET,
-		OPT_GETEPOCH,
 		OPT_NOADJFILE,
 		OPT_PREDICT,
 		OPT_SET,
-		OPT_SETEPOCH,
 		OPT_SYSTZ,
 		OPT_TEST,
 		OPT_UPDATE
@@ -1141,11 +1106,6 @@ int main(int argc, char **argv)
 		{ "ul-debug",     required_argument, NULL, 'd'            },
 		{ "verbose",      no_argument,       NULL, 'v'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
-#if defined(__linux__) && defined(__alpha__)
-		{ "getepoch",     no_argument,       NULL, OPT_GETEPOCH   },
-		{ "setepoch",     no_argument,       NULL, OPT_SETEPOCH   },
-		{ "epoch",        required_argument, NULL, OPT_EPOCH      },
-#endif
 		{ "noadjfile",    no_argument,       NULL, OPT_NOADJFILE  },
 		{ "directisa",    no_argument,       NULL, OPT_DIRECTISA  },
 		{ "test",         no_argument,       NULL, OPT_TEST       },
@@ -1163,8 +1123,8 @@ int main(int argc, char **argv)
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'a','r','s','w',
-		  OPT_GET, OPT_GETEPOCH, OPT_PREDICT,
-		  OPT_SET, OPT_SETEPOCH, OPT_SYSTZ },
+		  OPT_GET, OPT_PREDICT,
+		  OPT_SET, OPT_SYSTZ },
 		{ 'l', 'u' },
 		{ OPT_ADJFILE, OPT_NOADJFILE },
 		{ OPT_NOADJFILE, OPT_UPDATE },
@@ -1244,20 +1204,6 @@ int main(int argc, char **argv)
 			ctl.show = 0;
 			ctl.hwaudit_on = 1;
 			break;
-#if defined(__linux__) && defined(__alpha__)
-		case OPT_GETEPOCH:
-			ctl.getepoch = 1;
-			ctl.show = 0;
-			break;
-		case OPT_SETEPOCH:
-			ctl.setepoch = 1;
-			ctl.show = 0;
-			ctl.hwaudit_on = 1;
-			break;
-		case OPT_EPOCH:
-			ctl.epoch_option = optarg;	/* --epoch */
-			break;
-#endif
 		case OPT_NOADJFILE:
 			ctl.noadjfile = 1;
 			break;
@@ -1337,13 +1283,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-#if defined(__linux__) && defined(__alpha__)
-	if (ctl.getepoch || ctl.setepoch) {
-		manipulate_epoch(&ctl);
-		hwclock_exit(&ctl, EXIT_SUCCESS);
-	}
-#endif
-
 	if (ctl.verbose) {
 		out_version();
 		printf(_("System Time: %ld.%06ld\n"),
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 7bb6ec8bd..373a16f22 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -22,9 +22,6 @@ UL_DEBUG_DECLARE_MASK(hwclock);
 struct hwclock_control {
 	char *date_opt;
 	char *adj_file_name;
-#if defined(__linux__) && defined(__alpha__)
-	char *epoch_option;
-#endif
 #ifdef __linux__
 	char *rtc_dev_name;
 #endif
@@ -35,10 +32,6 @@ struct hwclock_control {
 		hctosys:1,
 		utc:1,
 		systohc:1,
-#if defined(__linux__) && defined(__alpha__)
-		getepoch:1,
-		setepoch:1,
-#endif
 		noadjfile:1,
 		local_opt:1,
 		directisa:1,
@@ -66,12 +59,6 @@ extern struct clock_ops *probe_for_rtc_clock(const struct hwclock_control *ctl);
 /* hwclock.c */
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
 
-/* rtc.c */
-#if defined(__linux__) && defined(__alpha__)
-extern int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch);
-extern int set_epoch_rtc(const struct hwclock_control *ctl);
-#endif
-
 extern void __attribute__((__noreturn__))
 hwclock_exit(const struct hwclock_control *ctl, int status);
 
-- 
2.18.0

