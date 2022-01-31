Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0391EC433F5
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350968AbiAaSaL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 31 Jan 2022 13:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350610AbiAaSaL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jan 2022 13:30:11 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jan 2022 10:30:11 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63897C061714
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 10:30:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 703D7203;
        Mon, 31 Jan 2022 19:20:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lV0gjHKFp7Cg; Mon, 31 Jan 2022 19:20:32 +0100 (CET)
Received: from begin.home (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 2A31B1D6;
        Mon, 31 Jan 2022 19:20:32 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.95)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1nEbHy-000BTU-TT;
        Mon, 31 Jan 2022 19:20:30 +0100
Date:   Mon, 31 Jan 2022 19:20:30 +0100
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220131182030.ci3q6puznrwt6vst@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q3tbt4xnhincaacr"
Content-Disposition: inline
In-Reply-To: <20220131151432.mfk62bwskotc6w64@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: +
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Queue-Id: 703D7203
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         CTYPE_MIXED_BOGUS(1.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+];
         RCVD_TLS_LAST(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[]
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--q3tbt4xnhincaacr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Karel Zak, le lun. 31 janv. 2022 16:14:32 +0100, a ecrit:
> The util-linux release v2.38-rc1 is available at
>      
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/

Thanks, here are a few non-Linux portability fixes

With regards,
Samuel

--q3tbt4xnhincaacr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index dc8f7c9eb..e41ced2c3 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -1141,6 +1141,7 @@ done:
  */
 int mnt_tmptgt_unshare(int *old_ns_fd)
 {
+#ifdef USE_LIBMOUNT_SUPPORT_NAMESPACES
 	int rc = 0, fd = -1;
 
 	assert(old_ns_fd);
@@ -1182,6 +1183,9 @@ fail:
 	mnt_tmptgt_cleanup(fd);
 	DBG(UTILS, ul_debug(MNT_PATH_TMPTGT " unshare failed"));
 	return rc;
+#else
+	return -ENOSYS;
+#endif
 }
 
 /*
@@ -1189,6 +1193,7 @@ fail:
  */
 int mnt_tmptgt_cleanup(int old_ns_fd)
 {
+#ifdef USE_LIBMOUNT_SUPPORT_NAMESPACES
 	umount(MNT_PATH_TMPTGT);
 
 	if (old_ns_fd >= 0) {
@@ -1198,6 +1203,9 @@ int mnt_tmptgt_cleanup(int old_ns_fd)
 
 	DBG(UTILS, ul_debug(MNT_PATH_TMPTGT " cleanup done"));
 	return 0;
+#else
+	return -ENOSYS;
+#endif
 }
 
 #ifdef TEST_PROGRAM
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index f71dbf928..3021b88bc 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -980,8 +980,12 @@ static void sanitize_prlimits(void)
 	struct rlimit lm = { .rlim_cur = 0, .rlim_max = 0 };
 
 	/* reset to zero */
+#ifdef RLIMIT_NICE
 	setrlimit(RLIMIT_NICE, &lm);
+#endif
+#ifdef RLIMIT_RTPRIO
 	setrlimit(RLIMIT_RTPRIO, &lm);
+#endif
 
 	/* reset to unlimited */
 	lm.rlim_cur = RLIM_INFINITY;
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 97c6ca951..f1b5baf94 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1154,6 +1154,7 @@ manipulate_epoch(const struct hwclock_control *ctl)
 }
 #endif		/* __linux__ __alpha__ */
 
+#ifdef __linux__
 static int
 manipulate_rtc_param(const struct hwclock_control *ctl)
 {
@@ -1178,6 +1179,7 @@ manipulate_rtc_param(const struct hwclock_control *ctl)
 
 	return 1;
 }
+#endif
 
 static void out_version(void)
 {
@@ -1187,7 +1189,9 @@ static void out_version(void)
 static void __attribute__((__noreturn__))
 usage(void)
 {
+#ifdef __linux__
 	const struct hwclock_param *param = get_hwclock_params();
+#endif
 
 	fputs(USAGE_HEADER, stdout);
 	printf(_(" %s [function] [option...]\n"), program_invocation_short_name);
@@ -1207,8 +1211,10 @@ usage(void)
 	puts(_("     --getepoch                  display the RTC epoch"));
 	puts(_("     --setepoch                  set the RTC epoch according to --epoch"));
 #endif
+#ifdef __linux__
 	puts(_("     --param-get <param>         display the RTC parameter"));
 	puts(_("     --param-set <param>=<value> set the RTC parameter"));
+#endif
 	puts(_("     --predict                   predict the drifted RTC time according to --date"));
 	fputs(USAGE_OPTIONS, stdout);
 	puts(_(" -u, --utc                       the RTC timescale is UTC"));
@@ -1235,6 +1241,7 @@ usage(void)
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(33));
 
+#ifdef __linux__
 	fputs(USAGE_ARGUMENTS, stdout);
 	puts(_(" <param> is either a numeric RTC parameter value or one of these aliases:"));
 
@@ -1242,6 +1249,7 @@ usage(void)
 		printf(_("   - %1$s: %2$s (0x%3$x)\n"), param->name, param->help, param->id);
 		param++;
 	}
+#endif
 
 	puts(_("   See Kernel's include/uapi/linux/rtc.h for parameters and values."));
 	fputs(USAGE_ARG_SEPARATOR, stdout);
@@ -1419,6 +1427,7 @@ int main(int argc, char **argv)
 			ctl.epoch_option = optarg;	/* --epoch */
 			break;
 #endif
+#ifdef __linux__
 		case OPT_PARAM_GET:
 			ctl.param_get_option = optarg;
 			ctl.show = 0;
@@ -1428,6 +1437,7 @@ int main(int argc, char **argv)
 			ctl.show = 0;
 			ctl.hwaudit_on = 1;
 			break;
+#endif
 		case OPT_NOADJFILE:
 			ctl.noadjfile = 1;
 			break;
@@ -1521,12 +1531,14 @@ int main(int argc, char **argv)
 		}
 	}
 
+#ifdef __linux__
 	if (ctl.param_get_option || ctl.param_set_option) {
 		if (manipulate_rtc_param(&ctl))
 			hwclock_exit(&ctl, EXIT_FAILURE);
 
 		hwclock_exit(&ctl, EXIT_SUCCESS);
 	}
+#endif
 
 #if defined(__linux__) && defined(__alpha__)
 	if (ctl.getepoch || ctl.setepoch) {
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index ca69ccf98..34f635b1e 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -82,11 +82,15 @@ static struct prlimit_desc prlimit_desc[] =
 	[LOCKS]      = { "LOCKS",      N_("max number of file locks held"),      N_("locks"),     RLIMIT_LOCKS },
 	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), N_("bytes"),     RLIMIT_MEMLOCK },
 	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         N_("bytes"),     RLIMIT_MSGQUEUE },
+#ifdef RLIMIT_NICE
 	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     NULL,            RLIMIT_NICE },
+#endif
 	[NOFILE]     = { "NOFILE",     N_("max number of open files"),           N_("files"),     RLIMIT_NOFILE },
 	[NPROC]      = { "NPROC",      N_("max number of processes"),            N_("processes"), RLIMIT_NPROC },
 	[RSS]        = { "RSS",        N_("max resident set size"),              N_("bytes"),     RLIMIT_RSS },
+#ifdef RLIMIT_RTPRIO
 	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             NULL,            RLIMIT_RTPRIO },
+#endif
 	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        N_("microsecs"), RLIMIT_RTTIME },
 	[SIGPENDING] = { "SIGPENDING", N_("max number of pending signals"),      N_("signals"),   RLIMIT_SIGPENDING },
 	[STACK]      = { "STACK",      N_("max stack size"),                     N_("bytes"),     RLIMIT_STACK }

--q3tbt4xnhincaacr--
