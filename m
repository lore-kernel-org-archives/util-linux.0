Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34760 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbbLNVzK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:10 -0500
Received: by mail-wm0-f42.google.com with SMTP id p66so83325656wmp.1
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/8] bash-completion: ipcmk: add missing completion file
Date: Mon, 14 Dec 2015 21:54:51 +0000
Message-Id: <1450130093-12108-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/ipcmk         | 27 +++++++++++++++++++++++++++
 sys-utils/ipcmk.c             |  8 ++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 bash-completion/ipcmk

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 5372ed0..e4196a3 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -30,6 +30,9 @@ endif
 if BUILD_HEXDUMP
 dist_bashcompletion_DATA += bash-completion/hexdump
 endif
+if BUILD_IPCMK
+dist_bashcompletion_DATA += bash-completion/ipcmk
+endif
 if BUILD_IPCRM
 dist_bashcompletion_DATA += bash-completion/ipcrm
 endif
diff --git a/bash-completion/ipcmk b/bash-completion/ipcmk
new file mode 100644
index 0000000..f0ea6ad
--- /dev/null
+++ b/bash-completion/ipcmk
@@ -0,0 +1,27 @@
+_ipcmk_module()
+{
+	local cur prev
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-M'|'--shmem')
+			COMPREPLY=( $(compgen -W "size" -- $cur) )
+			return 0
+			;;
+		'-S'|'--semaphore')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-p'|'--mode')
+			COMPREPLY=( $(compgen -W "mode" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version'|'-Q'|'--queue')
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(ipcmk --print-long-opts)" -- $cur) )
+	return 0
+}
+complete -F _ipcmk_module ipcmk
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index d79071c..9b3691a 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -75,6 +75,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -p, --mode <mode>        permission for the resource (default is 0644)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_PRINT_LONG_OPTS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("ipcmk(1)"));
@@ -89,11 +90,15 @@ int main(int argc, char **argv)
 	size_t size = 0;
 	int nsems = 0;
 	int ask_shm = 0, ask_msg = 0, ask_sem = 0;
+	enum {
+		OPT_PRINT_LONG_OPTS = CHAR_MAX + 1
+	};
 	static const struct option longopts[] = {
 		{"shmem", required_argument, NULL, 'M'},
 		{"semaphore", required_argument, NULL, 'S'},
 		{"queue", no_argument, NULL, 'Q'},
 		{"mode", required_argument, NULL, 'p'},
+		{"print-long-opts", no_argument, NULL, OPT_PRINT_LONG_OPTS},
 		{"version", no_argument, NULL, 'V'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
@@ -120,6 +125,9 @@ int main(int argc, char **argv)
 		case 'p':
 			permission = strtoul(optarg, NULL, 8);
 			break;
+		case OPT_PRINT_LONG_OPTS:
+			print_long_opts(longopts);
+			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
 			break;
-- 
2.6.4

