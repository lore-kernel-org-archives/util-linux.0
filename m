Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37089 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbLNVzL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Dec 2015 16:55:11 -0500
Received: by wmnn186 with SMTP id n186so140643189wmn.0
        for <util-linux@vger.kernel.org>; Mon, 14 Dec 2015 13:55:10 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/8] bash-completion: lslogins: add missing completion file
Date: Mon, 14 Dec 2015 21:54:52 +0000
Message-Id: <1450130093-12108-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/Makemodule.am |  3 +++
 bash-completion/lslogins      | 52 +++++++++++++++++++++++++++++++++++++++++++
 login-utils/lslogins.c        |  8 ++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 bash-completion/lslogins

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index e4196a3..9479087 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -150,6 +150,9 @@ endif
 if BUILD_LAST
 dist_bashcompletion_DATA += bash-completion/last
 endif
+if BUILD_LSLOGINS
+dist_bashcompletion_DATA += bash-completion/lslogins
+endif
 if BUILD_NEWGRP
 dist_bashcompletion_DATA += bash-completion/newgrp
 endif
diff --git a/bash-completion/lslogins b/bash-completion/lslogins
new file mode 100644
index 0000000..6b1d568
--- /dev/null
+++ b/bash-completion/lslogins
@@ -0,0 +1,52 @@
+_lslogins_module()
+{
+	local cur prev OPTS LSLOGINS_COLS_ALL
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	LSLOGINS_COLS_ALL="
+		USER UID GECOS HOMEDIR SHELL NOLOGIN PWD-LOCK PWD-EMPTY
+		PWD-DENY GROUP GID SUPP-GROUPS SUPP-GIDS LAST-LOGIN LAST-TTY
+		LAST-HOSTNAME FAILED-LOGIN FAILED-TTY HUSHED PWD-WARN
+		PWD-CHANGE PWD-MIN PWD-MAX PWD-EXPIR CONTEXT PROC
+	"
+	case $prev in
+		'-g'|'--groups')
+			COMPREPLY=( $(compgen -W "$(getent group | awk -F: '{print $1}')" -- $cur) )
+			return 0
+			;;
+		'-l'|'--logins')
+			COMPREPLY=( $(compgen -W "$(getent passwd | awk -F: '{print $1}')" -- $cur) )
+			return 0
+			;;
+		'--time-format')
+			COMPREPLY=( $(compgen -W "short full iso" -- $cur) )
+			return 0
+			;;
+		'--wtmp-file'|'--btmp-file')
+			local IFS=$'\n'
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-o'|'--output')
+			local prefix realcur LSLOGINS_COLS
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			for WORD in $LSLOGINS_COLS_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					LSLOGINS_COLS="$WORD $LSLOGINS_COLS"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$LSLOGINS_COLS" -S ',' -- $realcur) )
+			return 0
+			;;
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "$(lslogins --print-long-opts)" -- $cur) )
+	return 0
+}
+complete -F _lslogins_module lslogins
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 6512965..54eb162 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1259,6 +1259,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_("     --wtmp-file <path>   set an alternate path for wtmp\n"), out);
 	fputs(_("     --btmp-file <path>   set an alternate path for btmp\n"), out);
 	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_PRINT_LONG_OPTS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
@@ -1283,7 +1284,8 @@ int main(int argc, char *argv[])
 
 	/* long only options. */
 	enum {
-		OPT_WTMP = CHAR_MAX + 1,
+		OPT_PRINT_LONG_OPTS = CHAR_MAX + 1,
+		OPT_WTMP,
 		OPT_BTMP,
 		OPT_NOTRUNC,
 		OPT_NOHEAD,
@@ -1316,6 +1318,7 @@ int main(int argc, char *argv[])
 #ifdef HAVE_LIBSELINUX
 		{ "context",        no_argument,	0, 'Z' },
 #endif
+		{ "print-long-opts", no_argument, NULL, OPT_PRINT_LONG_OPTS },
 		{ NULL,             0, 			0,  0  }
 	};
 
@@ -1452,6 +1455,9 @@ int main(int argc, char *argv[])
 			add_column(columns, ncolumns++, COL_SELINUX);
 			break;
 		}
+		case OPT_PRINT_LONG_OPTS:
+			print_long_opts(longopts);
+			return EXIT_SUCCESS;
 		default:
 			usage(stderr);
 		}
-- 
2.6.4

