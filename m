Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F4C433B4
	for <util-linux@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D7761289
	for <util-linux@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhDLLXI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhDLLXI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 12 Apr 2021 07:23:08 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Apr 2021 04:22:50 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC0C061574
        for <util-linux@vger.kernel.org>; Mon, 12 Apr 2021 04:22:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C421D2AC;
        Mon, 12 Apr 2021 13:15:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HIeThPGY_BFw; Mon, 12 Apr 2021 13:15:29 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A378DA6;
        Mon, 12 Apr 2021 13:15:29 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1lVuXQ-00EnK3-HH; Mon, 12 Apr 2021 13:15:28 +0200
Date:   Mon, 12 Apr 2021 13:15:28 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.37-rc1
Message-ID: <20210412111528.2xormz5rbn7d7k7s@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20210412103020.aoimejwj5y7aoe4o@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f7xjrc5u3axg6bc5"
Content-Disposition: inline
In-Reply-To: <20210412103020.aoimejwj5y7aoe4o@ws.net.home>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: -
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: C421D2AC
X-Spamd-Result: default: False [-1.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         HAS_ATTACHMENT(0.00)[];
         MIME_GOOD(-0.10)[multipart/mixed,text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         CTYPE_MIXED_BOGUS(1.00)[];
         RCPT_COUNT_TWO(0.00)[2];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--f7xjrc5u3axg6bc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Karel Zak, le lun. 12 avril 2021 12:30:20 +0200, a ecrit:
> The util-linux release v2.37-rc1 is available at
>  
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.37/

I am getting

/usr/bin/ld: schedutils/chrt.o: in function `show_sched_info':
/home/youpi/util-linux/schedutils/chrt.c:218: undefined reference to `proc_open_tasks'
/usr/bin/ld: /home/youpi/util-linux/schedutils/chrt.c:223: undefined reference to `proc_next_tid'
/usr/bin/ld: /home/youpi/util-linux/schedutils/chrt.c:226: undefined reference to `proc_close_tasks'
/usr/bin/ld: schedutils/chrt.o: in function `set_sched':
/home/youpi/util-linux/schedutils/chrt.c:324: undefined reference to `proc_open_tasks'
/usr/bin/ld: /home/youpi/util-linux/schedutils/chrt.c:329: undefined reference to `proc_next_tid'
/usr/bin/ld: /home/youpi/util-linux/schedutils/chrt.c:333: undefined reference to `proc_close_tasks'

/usr/bin/ld: login-utils/lslogins-lslogins.o: in function `get_nprocs':
/home/youpi/util-linux/login-utils/lslogins.c:591: undefined reference to `proc_open_processes'
/usr/bin/ld: /home/youpi/util-linux/login-utils/lslogins.c:593: undefined reference to `proc_processes_filter_by_uid'
/usr/bin/ld: /home/youpi/util-linux/login-utils/lslogins.c:595: undefined reference to `proc_next_pid'
/usr/bin/ld: /home/youpi/util-linux/login-utils/lslogins.c:598: undefined reference to `proc_close_processes'

I have attached a fix.

Samuel

--f7xjrc5u3axg6bc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 5f950758b..660a1a95c 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -249,7 +249,9 @@ static const struct lslogins_coldesc coldescs[] =
 	[COL_PWD_CTIME_MIN] = { "PWD-MIN",	N_("number of days required between changes"), N_("Minimum change time"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_CTIME_MAX] = { "PWD-MAX",	N_("max number of days a password may remain unchanged"), N_("Maximum change time"), 0.1, SCOLS_FL_RIGHT },
 	[COL_SELINUX]       = { "CONTEXT",	N_("the user's security context"), N_("Selinux context"), 0.1 },
+#ifdef __linux__
 	[COL_NPROCS]        = { "PROC",         N_("number of processes run by the user"), N_("Running processes"), 1, SCOLS_FL_RIGHT },
+#endif
 };
 
 struct lslogins_control {
@@ -584,6 +586,7 @@ static int get_sgroups(gid_t **list, size_t *len, struct passwd *pwd)
 	return 0;
 }
 
+#ifdef __linux__
 static int get_nprocs(const uid_t uid)
 {
 	int nprocs = 0;
@@ -598,6 +601,7 @@ static int get_nprocs(const uid_t uid)
 	proc_close_processes(proc);
 	return nprocs;
 }
+#endif
 
 static const char *get_pwd_method(const char *str, const char **next, unsigned int *sz)
 {
@@ -888,9 +892,11 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 				user->context = NULL;
 #endif
 			break;
+#ifdef __linux__
 		case COL_NPROCS:
 			xasprintf(&user->nprocs, "%d", get_nprocs(pwd->pw_uid));
 			break;
+#endif
 		default:
 			/* something went very wrong here */
 			err(EXIT_FAILURE, "fatal: unknown error");
@@ -1209,9 +1215,11 @@ static void fill_table(const void *u, const VISIT which, const int depth __attri
 			rc = scols_line_set_data(ln, n, user->context);
 #endif
 			break;
+#ifdef __linux__
 		case COL_NPROCS:
 			rc = scols_line_set_data(ln, n, user->nprocs);
 			break;
+#endif
 		default:
 			/* something went very wrong here */
 			err(EXIT_FAILURE, _("internal error: unknown column"));
@@ -1622,7 +1630,9 @@ int main(int argc, char *argv[])
 
 	} else if (ncolumns == 2) {
 		/* default columns */
+#ifdef __linux__
 		add_column(columns, ncolumns++, COL_NPROCS);
+#endif
 		add_column(columns, ncolumns++, COL_PWDLOCK);
 		add_column(columns, ncolumns++, COL_PWDDENY);
 		add_column(columns, ncolumns++, COL_LAST_LOGIN);
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 052ad7a1b..b8890b3aa 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -214,6 +214,7 @@ fallback:
 static void show_sched_info(struct chrt_ctl *ctl)
 {
 	if (ctl->all_tasks) {
+#ifdef __linux__
 		pid_t tid;
 		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
 
@@ -224,6 +225,9 @@ static void show_sched_info(struct chrt_ctl *ctl)
 			show_sched_pid_info(ctl, tid);
 
 		proc_close_tasks(ts);
+#else
+		err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
+#endif
 	} else
 		show_sched_pid_info(ctl, ctl->pid);
 }
@@ -320,6 +324,7 @@ static int set_sched_one(struct chrt_ctl *ctl, pid_t pid)
 static void set_sched(struct chrt_ctl *ctl)
 {
 	if (ctl->all_tasks) {
+#ifdef __linux__
 		pid_t tid;
 		struct proc_tasks *ts = proc_open_tasks(ctl->pid);
 
@@ -331,7 +336,9 @@ static void set_sched(struct chrt_ctl *ctl)
 				err(EXIT_FAILURE, _("failed to set tid %d's policy"), tid);
 
 		proc_close_tasks(ts);
-
+#else
+		err(EXIT_FAILURE, _("cannot obtain the list of tasks"));
+#endif
 	} else if (set_sched_one(ctl, ctl->pid) == -1)
 		err(EXIT_FAILURE, _("failed to set pid %d's policy"), ctl->pid);
 

--f7xjrc5u3axg6bc5--
