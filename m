Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2675AC433EF
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 03:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAB660F36
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 03:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhKJDUC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Nov 2021 22:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJDUC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Nov 2021 22:20:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F94FC061764
        for <util-linux@vger.kernel.org>; Tue,  9 Nov 2021 19:17:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v20so1819812plo.7
        for <util-linux@vger.kernel.org>; Tue, 09 Nov 2021 19:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdnDSi/FnSi5+bjlGTdJwbwLAb0MmVEw/6z0dsxaOqQ=;
        b=TrtyklnJG9/LawkF1cEFtsbLXIB3Q4B5+GVC06pCL0+p8y1Lm07Kt6XgqZ+q5Y/dKy
         KrLi3LfmDSAVg++hNqzit3Vv8PtER/db0dD+mTE2dSRQ+Ut/Bsjlh6XDLuA0i8ZKZ3bV
         zCL6aJJcszk1ZotHXwPEty91JDESOq/g+W349FQBWune3KgHdi9rp1SyjYS6gMAbql1K
         ONgU0Tg87PojruV0Qe6dIfKZImS+dEE6iTDwJZ9NNMSq3pJWxY9tgiZ9v4/pGJPCYOWM
         YLoTvuGsIaLs03xS1xpbOBmmT1YmHmOrimYqzu2mWw6h0KuMPlKvrTPvUCa8Ync/+3Dx
         eZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdnDSi/FnSi5+bjlGTdJwbwLAb0MmVEw/6z0dsxaOqQ=;
        b=pc/tJfVhpMaJ+hM178xcFE7GiFJcIeK9nIclimYwnTFyA9wvB9GqzNzOd970RnSkNh
         s4MRhXU5ZiY/eBOemPscXda/LorDoLoblFpW/8OTIcBVnAzE5gKlfJQsAD5U+ktO+yqx
         FQt0ftfhkdOu4MJbHzwiH2hmza78/f4IQZKYQXJbADE9eDL8rJXY6PRkmPJE1sqM6ibj
         nRsyxfLcQ7Qis9Aix8RJmFWuVlskFoTP0+C7mOLvnpMUPyUv2X9fxQF1Z0W4V5ntFVbr
         zodgWKvptbVny8k267QivMoj4zkuMz3aL+F690YkEDjvPRtDATGO2lpxI53FckrreOV7
         77Xw==
X-Gm-Message-State: AOAM53053OgqoO51/TqPWCaXFj+LgYcKwsRcRjOSOVTnuU8jf9dGrqfi
        jmcdR4ZdqTS5IMQj/EMS1/LWKQ==
X-Google-Smtp-Source: ABdhPJyuZF3ebp5FNMqt6P4E7i/hO8ogdoBhuZX/HgbIARUWGz2sR1P6t5RGnNBh4wL9ZYRvSYdnkg==
X-Received: by 2002:a17:902:bd96:b0:142:6dae:37d with SMTP id q22-20020a170902bd9600b001426dae037dmr12212071pls.33.1636514234626;
        Tue, 09 Nov 2021 19:17:14 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id k16sm15646207pfu.183.2021.11.09.19.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 19:17:14 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] irqtop: add -c/--cpus option
Date:   Wed, 10 Nov 2021 11:16:42 +0800
Message-Id: <20211110031642.141240-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since a23aecc1bf("irqtop: add per-cpu stats"), irqtop always shows
per-cpu stats. Test on a modern AMD server with 2 socket(256 CPU),
irqtop shows like following:

irqtop | total: 3301249473 delta: 138816 | n139-121-136 | 2021-11-10 11:10:45+08:00

        cpu0 cpu1 cpu2 cpu3 cpu4 cpu5 cpu6 cpu7 cpu8 cpu9 cpu10 cpu11 cpu12 cpu13 cpu14 cpu15 cpu16 cpu17 cpu18 cp
u19 cpu20 cpu21 cpu22 cpu23 cpu24 cpu25 cpu26 cpu27 cpu28 cpu29 cpu30 cpu31 cpu32 cpu33 cpu34 cpu35 cpu36 cpu37 cp
u38 cpu39 cpu40 cpu41 cpu42 cpu43 cpu44 cpu45 cpu46 cpu47 cpu48 cpu49 cpu50 cpu51 cpu52 cpu53 cpu54 cpu55 cpu56 cp
u57 cpu58 cpu59 cpu60 cpu61 cpu62 cpu63 cpu64 cpu65 cpu66 cpu67 cpu68 cpu69 cpu70 cpu71 cpu72 cpu73 cpu74 cpu75 cp
u76 cpu77 cpu78 cpu79 cpu80 cpu81 cpu82 cpu83 cpu84 cpu85 cpu86 cpu87 cpu88 cpu89 cpu90 cpu91 cpu92 cpu93 cpu94 cp
u95 cpu96 cpu97 cpu98 cpu99 cpu100 cpu101 cpu102 cpu103 cpu104 cpu105 cpu106 cpu107 cpu108 cpu109 cpu110 cpu111 cp
u112 cpu113 cpu114 cpu115 cpu116 cpu117 cpu118 cpu119 cpu120 cpu121 cpu122 cpu123 cpu124 cpu125 cpu126 cpu127 cpu1
28 cpu129 cpu130 cpu131 cpu132 cpu133 cpu134 cpu135 cpu136 cpu137 cpu138 cpu139 cpu140 cpu141 cpu142 cpu143 cpu144
 cpu145 cpu146 cpu147 cpu148 cpu149 cpu150 cpu151 cpu152 cpu153 cpu154 cpu155 cpu156 cpu157 cpu158 cpu159 cpu160 c
pu161 cpu162 cpu163 cpu164 cpu165 cpu166 cpu167 cpu168 cpu169 cpu170 cpu171 cpu172 cpu173 cpu174 cpu175 cpu176 cpu
177 cpu178 cpu179 cpu180 cpu181 cpu182 cpu183 cpu184 cpu185 cpu186 cpu187 cpu188 cpu189 cpu190 cpu191 cpu192 cpu19
3 cpu194 cpu195 cpu196 cpu197 cpu198 cpu199 cpu200 cpu201 cpu202 cpu203 cpu204 cpu205 cpu206 cpu207 cpu208 cpu209
cpu210 cpu211 cpu212 cpu213 cpu214 cpu215 cpu216 cpu217 cpu218 cpu219 cpu220 cpu221 cpu222 cpu223 cpu224 cpu225 cp
u226 cpu227 cpu228 cpu229 cpu230 cpu231 cpu232 cpu233 cpu234 cpu235 cpu236 cpu237 cpu238 cpu239 cpu240 cpu241 cpu2
42 cpu243 cpu244 cpu245 cpu246 cpu247 cpu248 cpu249 cpu250 cpu251 cpu252 cpu253 cpu254 cpu255
  %irq:  1.1  0.9  0.9  0.8  0.7  0.7  0.7  0.6  1.1  1.0   0.9   0.9   0.8   0.8   0.7   0.8   0.9   0.8   0.7
0.7   0.7   0.6   0.6   0.6   0.4   0.4   0.4   0.4   0.4   0.4   0.4   0.4   0.3   0.3   0.4   0.4   0.4   0.3
0.3   0.3   0.3   0.3   0.3   0.3   0.3   0.3   0.3   0.3   0.4   0.4   0.4   0.4   0.3   0.4   0.3   0.3   0.3
0.3   0.3   0.3   0.3   0.3   0.3   0.3   1.2   1.2   1.2   1.1   1.1   1.1   1.1   1.1   0.7   0.7   0.7   0.7
0.7   0.7   0.7   0.7   0.1   0.1   0.1   0.1   0.1   0.1   0.2   0.1   0.1   0.1   0.1   0.1   0.1   0.1   0.1
0.1   0.1   0.1   0.1   0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1
 0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0
.5    0.6    0.5    0.6    0.6    0.6    0.6    0.6    0.7    0.8    0.9    0.8    0.9    0.9    1.0    1.0    0.6
    0.7    0.7    0.7    0.7    0.8    0.8    0.8    0.3    0.3    0.4    0.3    0.4    0.4    0.4    0.4    0.3
  0.3    0.3    0.3    0.3    0.3    0.3    0.3    0.3    0.2    0.3    0.3    0.3    0.3    0.2    0.3    0.3
0.3    0.3    0.3    0.3    0.3    0.4    0.4    0.3    0.2    0.3    0.3    0.3    0.3    0.3    0.3    1.1    1.
1    1.1    1.0    1.0    1.1    1.1    1.1    0.7    0.7    0.7    0.7    0.7    0.7    0.7    0.7    0.1    0.1
   0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1
 0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0
.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1
%delta:  6.1  2.0  0.2  0.9 17.5  9.8  6.9  0.2  0.3  0.1   0.1   0.2   0.6   0.2   0.1   0.0   0.3   0.3   0.2
0.2   0.1   0.1   0.1   0.0   0.1   0.1   0.0   0.2   0.1   0.2   0.4   0.1   0.2   0.1   0.2   0.3   0.1   0.2
0.2   0.4   0.5   0.2   0.4   0.3   0.3   0.3   0.2   0.4   0.1   0.2   0.1   0.3   0.3   0.0   0.4   0.3   0.1
0.2   0.3   0.7   0.3   0.1   0.2   0.1   0.2   0.3   0.2   0.1   0.1   0.1   0.1   0.0   0.0   0.0   0.0   0.0
0.0   0.0   0.0   0.0   0.0   0.3   0.0   0.1   0.2   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0
0.0   0.0   0.0   0.0   0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0
 0.0    0.0    0.0    0.1    0.0    0.0    0.0    0.1    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0
.1    0.0    0.0    0.0    0.0    3.1    4.6    7.6    0.1    0.1    0.1    0.9    1.0    1.7    0.8    0.2    0.1
    0.2    0.1    0.2    0.7    0.3    0.3    1.2    0.1    0.1    0.1    0.4    0.2    0.2    0.1    0.2    0.2
  0.4    0.2    0.2    0.1    0.1    0.1    0.1    0.2    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.2
0.1    0.1    0.0    0.0    0.0    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.1    0.
0    0.0    0.1    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    5.5    5.7
   0.0    0.0    0.0    0.3    0.0    0.1    0.0    0.3    0.0    0.3    0.0    0.0    0.0    0.0    0.1    0.0
 0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.2    0
.0    0.0    0.0    0.1    0.0    0.0    0.0    0.1    0.0    0.0    0.0    0.0    0.0    0.0

        IRQ      TOTAL      DELTA NAME
        LOC 2506095673     134191 Local timer interrupts
        CAL  707727316        875 Function call interrupts
        TLB   45523042       1497 TLB shootdowns

In this patch, add -c/--cpu option to enable/disable per-cpu stats.
And 'auto' option auto-detect window size, only show per-cpu stats
if the length of per-cpu stats is shorter than the width of window.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 bash-completion/irqtop  |  7 +++++-
 sys-utils/irqtop.1.adoc |  3 +++
 sys-utils/irqtop.c      | 50 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index e34e39100..6dae28924 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -5,6 +5,10 @@ _irqtop_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-c'|'--cpus')
+			COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
+			return 0
+			;;
 		'-d'|'--delay')
 			COMPREPLY=( $(compgen -W "secs" -- $cur) )
 			return 0
@@ -30,7 +34,8 @@ _irqtop_module()
 			return 0
 			;;
 	esac
-	OPTS="	--delay
+	OPTS="	--cpus
+		--delay
 		--sort
 		--output
 		--softirq
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 84f826a42..faf1c318c 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
 *-o*, *--output* _list_::
 Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
 
+*-c*, *--cpus* _option_::
+Show per-cpu statistics by specified option, available options: auto, enable, disable. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enouth to show a full line of statistics.
+
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 1a5cec0cc..b6c36bc9f 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -68,6 +68,12 @@
 
 #define MAX_EVENTS	3
 
+enum irqtop_cpus_table {
+	irqtop_cpus_table_auto,
+	irqtop_cpus_table_enable,
+	irqtop_cpus_table_disable,
+};
+
 /* top control struct */
 struct irqtop_ctl {
 	WINDOW		*win;
@@ -78,6 +84,7 @@ struct irqtop_ctl {
 	struct itimerspec timer;
 	struct irq_stat	*prev_stat;
 
+	enum irqtop_cpus_table cpus;
 	unsigned int request_exit:1;
 	unsigned int softirq:1;
 };
@@ -123,10 +130,31 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	wprintw(ctl->win, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
 			   stat->total_irq, stat->delta_irq, ctl->hostname, timestr);
 
-	/* print cpus table */
-	scols_print_table_to_string(cpus, &data);
-	wprintw(ctl->win, "%s\n\n", data);
-	free(data);
+	/* print cpus table or not by -c option */
+	do {
+		int x, y;
+
+		if (ctl->cpus == irqtop_cpus_table_disable)
+			break;
+
+		scols_print_table_to_string(cpus, &data);
+		if (ctl->cpus == irqtop_cpus_table_auto) {
+			/* detect window size */
+			getmaxyx(ctl->win, y, x);
+			y = y;	/* avoid build warning*/
+			p = strchr(data, '\n');
+			if (p) {
+				/* line is too long */
+				if ((p - data) > x) {
+					free(data);
+					break;
+				}
+			}
+		}
+
+		wprintw(ctl->win, "%s\n\n", data);
+		free(data);
+	} while (0);
 
 	/* print irqs table */
 	scols_print_table_to_string(table, &data0);
@@ -247,6 +275,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	puts(_("Interactive utility to display kernel interrupt information."));
 
 	fputs(USAGE_OPTIONS, stdout);
+	fputs(_(" -c, --cpus <option>  show per-cpu stat, available options: auto(default), enable, disable\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -275,6 +304,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 {
 	const char *outarg = NULL;
 	static const struct option longopts[] = {
+		{"cpus", required_argument, NULL, 'c'},
 		{"delay", required_argument, NULL, 'd'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
@@ -285,8 +315,18 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "d:o:s:ShV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "c:d:o:s:ShV", longopts, NULL)) != -1) {
 		switch (o) {
+		case 'c':
+			if (!strcmp(optarg, "auto"))
+				ctl->cpus = irqtop_cpus_table_auto;
+			else if (!strcmp(optarg, "enable"))
+				ctl->cpus = irqtop_cpus_table_enable;
+			else if (!strcmp(optarg, "disable"))
+				ctl->cpus = irqtop_cpus_table_disable;
+			else
+				usage();
+			break;
 		case 'd':
 			{
 				struct timeval delay;
-- 
2.25.1

