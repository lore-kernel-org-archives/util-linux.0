Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:44859 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C0WIT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:19 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so970497wgh.25
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/10] bash-completion: schedutils
Date: Wed, 27 Mar 2013 22:07:48 +0000
Message-Id: <1364422072-23552-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 shell-completion/chrt    | 32 ++++++++++++++++++++++++++++++++
 shell-completion/ionice  | 34 ++++++++++++++++++++++++++++++++++
 shell-completion/taskset | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 shell-completion/chrt
 create mode 100644 shell-completion/ionice
 create mode 100644 shell-completion/taskset

diff --git a/shell-completion/chrt b/shell-completion/chrt
new file mode 100644
index 0000000..08912c9
--- /dev/null
+++ b/shell-completion/chrt
@@ -0,0 +1,32 @@
+_chrt_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	# FIXME: -p is ambiguous, it takes either pid or priority as an
+	# argument depending on whether user wanted to get or set the
+	# values.  Perhaps the command interface should be reconsidered.
+	case $cur in
+		-*)
+			OPTS="-b --batch
+				-f --fifo
+				-i --idle
+				-o --other
+				-r --rr
+				-R --reset-on-fork
+				-a --all-tasks
+				-h --help
+				-m --max
+				-p --pid
+				-v --verbose
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local PIDS
+	PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+	COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+	return 0
+}
+complete -F _chrt_module chrt
diff --git a/shell-completion/ionice b/shell-completion/ionice
new file mode 100644
index 0000000..3087c4a
--- /dev/null
+++ b/shell-completion/ionice
@@ -0,0 +1,34 @@
+_ionice_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-c'|'--class')
+			COMPREPLY=( $(compgen -W "$(echo {0..3}) none realtime best-effort idle" -- $cur) )
+			return 0
+			;;
+		'-n'|'--classdata')
+			COMPREPLY=( $(compgen -W "$(echo {0..7})" -- $cur) )
+			return 0
+			;;
+		'-p'|'--pid')
+			local PIDS
+			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-c --class -n --classdata -p --pid -t --ignore -V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _ionice_module ionice
diff --git a/shell-completion/taskset b/shell-completion/taskset
new file mode 100644
index 0000000..81247cd
--- /dev/null
+++ b/shell-completion/taskset
@@ -0,0 +1,38 @@
+_taskset_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-c'|'--cpu-list')
+			local CPULIST
+			# FIXME: will propose only binding to a cpu.
+			# Maybe this should add comma, and continue?
+			CPULIST=$(sed 's/^/{/; s/-/../g; s/,/} {/g; s/$/}/' /sys/devices/system/cpu/online)
+			COMPREPLY=( $(compgen -W "$(eval echo $CPULIST)" -- $cur) )
+			return 0
+			;;
+		'-p'|'--pid')
+			local PIDS
+			# FIXME: the pid argument is ambiguous.  When
+			# setting an affinity the optarg has to be cpu
+			# mask.  The following is good only for getting
+			# affinity.
+			PIDS=$(\ls -d /proc/[0-9]* | sed 's|/proc/||')
+			COMPREPLY=( $(compgen -W "$PIDS" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-a --all-tasks -p --pid -c --cpu-list -h --help -V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o bashdefault
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _taskset_module taskset
-- 
1.8.2

