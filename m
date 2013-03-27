Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43618 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C0WIZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:25 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so999338wgg.35
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/10] bash-completion: term-utils
Date: Wed, 27 Mar 2013 22:07:50 +0000
Message-Id: <1364422072-23552-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 shell-completion/agetty       |  70 +++++++++++++++++++++++++++
 shell-completion/mesg         |  16 +++++++
 shell-completion/script       |  38 +++++++++++++++
 shell-completion/scriptreplay |  28 +++++++++++
 shell-completion/setterm      | 109 ++++++++++++++++++++++++++++++++++++++++++
 shell-completion/wall         |  24 ++++++++++
 shell-completion/write        |  19 ++++++++
 7 files changed, 304 insertions(+)
 create mode 100644 shell-completion/agetty
 create mode 100644 shell-completion/mesg
 create mode 100644 shell-completion/script
 create mode 100644 shell-completion/scriptreplay
 create mode 100644 shell-completion/setterm
 create mode 100644 shell-completion/wall
 create mode 100644 shell-completion/write

diff --git a/shell-completion/agetty b/shell-completion/agetty
new file mode 100644
index 0000000..dc37a68
--- /dev/null
+++ b/shell-completion/agetty
@@ -0,0 +1,70 @@
+_agetty_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-a'|'--autologin')
+			COMPREPLY=( $(compgen -u -- $cur) )
+			return 0
+			;;
+		'-o'|'--issue-file'|'-I'|'--login-program')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-I'|'--init-string'|'--erase-chars'|'--kill-chars')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -W "string" -- $cur) )
+			return 0
+			;;
+		'-o'|'--login-options')
+			COMPREPLY=( $(compgen -W "login-options" -- $cur) )
+			return 0
+			;;
+		'-t'|'--timeout')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-8 --8bits
+				-a --autologin
+				-c --noreset
+				-f --issue-file
+				-h --flow-control
+				-H --host
+				-i --noissue
+				-I --init-string
+				-l --login-program
+				-L --local-line
+				-m --extract-baud
+				-n --skip-login
+				-o --login-options
+				-p --loginpause
+				-R --hangup
+				-s --keep-baud
+				-t --timeout
+				-U --detect-case
+				-w --wait-cr
+				   --nocleardo
+				   --nohintsdo
+				   --nonewlinedo
+				   --no-hostnameno
+				   --long-hostnameshow
+				   --erase-chars
+				   --kill-chars
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local BAUD_RATES
+	BAUD_RATES="75 110 300 1200 2400 4800 9600 19200 38400 57600 115200"
+	COMPREPLY=( $(compgen -W "$BAUD_RATES $(echo /dev/tty*)" -- $cur) )
+	return 0
+}
+complete -F _agetty_module agetty
diff --git a/shell-completion/mesg b/shell-completion/mesg
new file mode 100644
index 0000000..62c98ca
--- /dev/null
+++ b/shell-completion/mesg
@@ -0,0 +1,16 @@
+_mesg_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-v --verbose -V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	COMPREPLY=( $(compgen -W "y n" -- $cur) )
+	return 0
+}
+complete -F _mesg_module mesg
diff --git a/shell-completion/script b/shell-completion/script
new file mode 100644
index 0000000..fb6c106
--- /dev/null
+++ b/shell-completion/script
@@ -0,0 +1,38 @@
+_script_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-c'|'--command')
+			compopt -o bashdefault
+			COMPREPLY=( $(compgen -c -- $cur) )
+			return 0
+			;;
+		'-t'|'--timing')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --append
+				-c --command
+				-e --return
+				-f --flush
+				   --force
+				-q --quiet
+				-t --timing
+				-V --version
+				-h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _script_module script
diff --git a/shell-completion/scriptreplay b/shell-completion/scriptreplay
new file mode 100644
index 0000000..78e5b23
--- /dev/null
+++ b/shell-completion/scriptreplay
@@ -0,0 +1,28 @@
+_scriptreplay_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-d'|'--divisor')
+			COMPREPLY=( $(compgen -W "digit" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-t --timing
+				-s --typescript
+				-d --divisor
+				-V --version
+				-h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _scriptreplay_module scriptreplay
diff --git a/shell-completion/setterm b/shell-completion/setterm
new file mode 100644
index 0000000..a0dff44
--- /dev/null
+++ b/shell-completion/setterm
@@ -0,0 +1,109 @@
+_setterm_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-term')
+			# FIXME: terminal type list would be nice
+			COMPREPLY=( $(compgen -W "vt100 xterm linux screen etc" -- $cur) )
+			return 0
+			;;
+		'-foreground'|'-background'|'-ulcolor'|'-hbcolor')
+			COMPREPLY=( $(compgen -W "default black blue cyan green magenta red white yellow" -- $cur) )
+			return 0
+			;;
+		'-cursor'|'-repeat'|'-appcursorkeys'|'-linewrap'|'-inversescreen'|'-bold'|'-half-bright'|'-blink'|'-reverse'|'-underline'|'-msg')
+			COMPREPLY=( $(compgen -W "off on" -- $cur) )
+			return 0
+			;;
+		'-clear')
+			COMPREPLY=( $(compgen -W "all rest" -- $cur) )
+			return 0
+			;;
+		'-tabs'|'-clrtabs')
+			COMPREPLY=( $(compgen -W "tab1 tab2 tab3 tab160" -- $cur) )
+			return 0
+			;;
+		'-regtabs')
+			COMPREPLY=( $(compgen -W "$(echo {1..160})" -- $cur) )
+			return 0
+			;;
+		'-blank')
+			COMPREPLY=( $(compgen -W "$(echo {0..60}) force poke" -- $cur) )
+			return 0
+			;;
+		'-dump'|'-append')
+			local NUM_CONS
+			NUM_CONS=$(ls /sys/class/tty | wc -l)
+			COMPREPLY=( $(compgen -W "$(echo {1..$NUM_CONS})" -- $cur) )
+			return 0
+			;;
+		'-file')
+			compopt -o filenames
+			COMPREPLY=( $(compgen -f -- $cur) )
+			return 0
+			;;
+		'-msglevel')
+			COMPREPLY=( $(compgen -W "$(echo {1..8})" -- $cur) )
+			return 0
+			;;
+		'-powersave')
+			COMPREPLY=( $(compgen -W "on vsync hsync powerdown off" -- $cur) )
+			return 0
+			;;
+		'-powerdown')
+			COMPREPLY=( $(compgen -W "$(echo {0..60})" -- $cur) )
+			return 0
+			;;
+		'-blength')
+			COMPREPLY=( $(compgen -W "0-2000" -- $cur) )
+			return 0
+			;;
+		'-bfreq')
+			COMPREPLY=( $(compgen -W "freqnumber" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="	-term
+		-reset
+		-initialize
+		-cursor
+		-repeat
+		-appcursorkeys
+		-linewrap
+		-default
+		-foreground
+		-background
+		-ulcolor
+		-hbcolor
+		-ulcolor
+		-hbcolor
+		-inversescreen
+		-bold
+		-half-bright
+		-blink
+		-reverse
+		-underline
+		-store
+		-clear
+		-tabs
+		-clrtabs
+		-regtabs
+		-blank
+		-dump
+		-append
+		-file
+		-msg
+		-msglevel
+		-powersave
+		-powerdown
+		-blength
+		-bfreq
+		-version
+		-help"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _setterm_module setterm
diff --git a/shell-completion/wall b/shell-completion/wall
new file mode 100644
index 0000000..d3cbbd5
--- /dev/null
+++ b/shell-completion/wall
@@ -0,0 +1,24 @@
+_wall_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-t'|'--timeout')
+			COMPREPLY=( $(compgen -W "seconds" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-n --nobanner -t --timeout -V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _wall_module wall
diff --git a/shell-completion/write b/shell-completion/write
new file mode 100644
index 0000000..ba67569
--- /dev/null
+++ b/shell-completion/write
@@ -0,0 +1,19 @@
+_write_module()
+{
+	local cur
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $COMP_CWORD in
+		1)
+			COMPREPLY=( $(compgen -u -- $cur) )
+			return 0
+			;;
+		2)
+			local TERMS=$(for I in $(\ls /sys/class/tty 2>/dev/null); do echo "/dev/$I"; done)
+			COMPREPLY=( $(compgen -W "$TERMS" -- $cur) )
+			return 0
+			;;
+	esac
+	return 0
+}
+complete -F _write_module write
-- 
1.8.2

