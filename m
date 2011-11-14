Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:60785 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:06 -0500
Message-ID: <4EC07354.8000803@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:04 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 02/15] prlimit: add opt_id array to match short options to
 limit ids
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 02/15] prlimit: add opt_id array to match short options to limit ids

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   54 
++++++++++++++++++++------------------------------
  1 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index fed4f38..525351a 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -482,6 +482,26 @@ int main(int argc, char **argv)
  		{ "verbose",    no_argument, NULL, VERBOSE_OPTION },
  		{ NULL, 0, NULL, 0 }
  	};
+	
+	static const size_t opt_id[] = {
+		['c'] = CORE,
+		['d'] = DATA,
+		['e'] = NICE,
+		['f'] = FSIZE,
+		['i'] = SIGPENDING,
+		['l'] = MEMLOCK,
+		['m'] = RSS,
+		['n'] = NOFILE,
+		['q'] = MSGQUEUE,
+		['r'] = RTPRIO,
+		['s'] = STACK,
+		['t'] = CPU,
+		['u'] = NPROC,
+		['v'] = AS,
+		['x'] = LOCKS,
+		['y'] = RTTIME
+		/* h = help, o = output columns, p = pid, V = version */
+	};

  	setlocale(LC_ALL, "");
  	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -498,53 +518,23 @@ int main(int argc, char **argv)
  				 longopts, NULL)) != -1) {
  		switch(opt) {
  		case 'c':
-			add_prlim(optarg, &lims[n++], CORE);
-			break;
  		case 'd':
-			add_prlim(optarg, &lims[n++], DATA);
-			break;
  		case 'e':
-			add_prlim(optarg, &lims[n++], NICE);
-			break;
  		case 'f':
-			add_prlim(optarg, &lims[n++], FSIZE);
-			break;
  		case 'i':
-			add_prlim(optarg, &lims[n++], SIGPENDING);
-			break;
  		case 'l':
-			add_prlim(optarg, &lims[n++], MEMLOCK);
-			break;
  		case 'm':
-			add_prlim(optarg, &lims[n++], RSS);
-			break;
  		case 'n':
-			add_prlim(optarg, &lims[n++], NOFILE);
-			break;
  		case 'q':
-			add_prlim(optarg, &lims[n++], MSGQUEUE);
-			break;
  		case 'r':
-			add_prlim(optarg, &lims[n++], RTPRIO);
-			break;
  		case 's':
-			add_prlim(optarg, &lims[n++], STACK);
-			break;
  		case 't':
-			add_prlim(optarg, &lims[n++], CPU);
-			break;
  		case 'u':
-			add_prlim(optarg, &lims[n++], NPROC);
-			break;
  		case 'v':
-			add_prlim(optarg, &lims[n++], AS);
-			break;
  		case 'x':
-			add_prlim(optarg, &lims[n++], LOCKS);
-			break;
  		case 'y':
-			add_prlim(optarg, &lims[n++], RTTIME);
-			break;
+				add_prlim(optarg, &lims[n++], opt_id[opt]);
+				break;

  		case 'p':
  			if (pid) /* we only work one pid at a time */
