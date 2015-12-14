Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35750 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbbLNVzN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:13 -0500
Received: by mail-wm0-f49.google.com with SMTP id p66so64836534wmp.0
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 8/8] bash-completion: lsns: add missing completion file
Date: Mon, 14 Dec 2015 21:54:53 +0000
Message-Id: <1450130093-12108-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/lsns          | 39 +++++++++++++++++++++++++++++++++++++++
 sys-utils/lsns.c              |  8 ++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 bash-completion/lsns

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 9479087..56fdd32 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -51,6 +51,9 @@ endif
 if BUILD_LSIPC
 dist_bashcompletion_DATA += bash-completion/lsipc
 endif
+if BUILD_LSNS
+dist_bashcompletion_DATA += bash-completion/lsns
+endif
 if BUILD_MCOOKIE
 dist_bashcompletion_DATA += bash-completion/mcookie
 endif
diff --git a/bash-completion/lsns b/bash-completion/lsns
new file mode 100644
index 0000000..a3b2594
--- /dev/null
+++ b/bash-completion/lsns
@@ -0,0 +1,39 @@
+_lsns_module()
+{
+	local cur prev OPTS LSNS_COLS_ALL
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	LSNS_COLS_ALL="
+		NS TYPE PATH NPROCS PID PPID COMMAND UID USER
+	"
+	case $prev in
+		'-o'|'--output')
+			local prefix realcur LSNS_COLS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $LSNS_COLS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					LSNS_COLS="$WORD $LSNS_COLS"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$LSNS_COLS" -S ',' -- $realcur) )
+			return 0
+			;;
+		'-p'|'--task')
+			COMPREPLY=( $(compgen -W "$(cd /proc && echo [0-9]*)" -- $cur) )
+			return 0
+			;;
+		'-t'|'--type')
+			COMPREPLY=( $(compgen -W "mnt net ipc user pid uts" -- $cur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lsns --print-long-opts)" -- $cur) )
+	return 0
+}
+complete -F _lsns_module lsns
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 7918934..eb7d2d0 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -601,6 +601,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -t, --type <name>      namespace type (mnt, net, ipc, user, pid, uts)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_PRINT_LONG_OPTS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
@@ -621,6 +622,9 @@ int main(int argc, char *argv[])
 	int c;
 	int r = 0;
 	char *outarg = NULL;
+	enum {
+		OPT_PRINT_LONG_OPTS = CHAR_MAX + 1
+	};
 	static const struct option long_opts[] = {
 		{ "json",       no_argument,       NULL, 'J' },
 		{ "task",       required_argument, NULL, 'p' },
@@ -632,6 +636,7 @@ int main(int argc, char *argv[])
 		{ "list",       no_argument,       NULL, 'l' },
 		{ "raw",        no_argument,       NULL, 'r' },
 		{ "type",       required_argument, NULL, 't' },
+		{ "print-long-opts", no_argument, NULL, OPT_PRINT_LONG_OPTS },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -693,6 +698,9 @@ int main(int argc, char *argv[])
 			ls.fltr_ntypes++;
 			break;
 		}
+		case OPT_PRINT_LONG_OPTS:
+			print_long_opts(long_opts);
+			return EXIT_SUCCESS;
 		case '?':
 		default:
 			usage(stderr);
-- 
2.6.4

