Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34568 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab3C0WI2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:28 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so970339wgg.23
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/10] bash-completion: text-utils
Date: Wed, 27 Mar 2013 22:07:51 +0000
Message-Id: <1364422072-23552-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 shell-completion/col     | 24 ++++++++++++++++++++++++
 shell-completion/colcrt  | 20 ++++++++++++++++++++
 shell-completion/colrm   | 23 +++++++++++++++++++++++
 shell-completion/column  | 34 ++++++++++++++++++++++++++++++++++
 shell-completion/hexdump | 32 ++++++++++++++++++++++++++++++++
 shell-completion/more    | 22 ++++++++++++++++++++++
 shell-completion/pg      | 29 +++++++++++++++++++++++++++++
 shell-completion/rev     | 17 +++++++++++++++++
 shell-completion/tailf   | 24 ++++++++++++++++++++++++
 shell-completion/ul      | 25 +++++++++++++++++++++++++
 10 files changed, 250 insertions(+)
 create mode 100644 shell-completion/col
 create mode 100644 shell-completion/colcrt
 create mode 100644 shell-completion/colrm
 create mode 100644 shell-completion/column
 create mode 100644 shell-completion/hexdump
 create mode 100644 shell-completion/more
 create mode 100644 shell-completion/pg
 create mode 100644 shell-completion/rev
 create mode 100644 shell-completion/tailf
 create mode 100644 shell-completion/ul

diff --git a/shell-completion/col b/shell-completion/col
new file mode 100644
index 0000000..9ad3a67
--- /dev/null
+++ b/shell-completion/col
@@ -0,0 +1,24 @@
+_col_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-l'|'--lines')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+	esac
+	OPTS="-b --no-backspaces
+		-f --fine
+		-p --pass
+		-h --tabs
+		-x --spaces
+		-l --lines
+		-V --version
+		-H --help"
+	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+	return 0
+}
+complete -F _col_module col
diff --git a/shell-completion/colcrt b/shell-completion/colcrt
new file mode 100644
index 0000000..628416e
--- /dev/null
+++ b/shell-completion/colcrt
@@ -0,0 +1,20 @@
+_colcrt_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="	-  --no-underlining
+				-2 --half-lines
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
+complete -F _colcrt_module colcrt
diff --git a/shell-completion/colrm b/shell-completion/colrm
new file mode 100644
index 0000000..aa57c02
--- /dev/null
+++ b/shell-completion/colrm
@@ -0,0 +1,23 @@
+_colrm_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	case $COMP_CWORD in
+		1)
+			COMPREPLY=( $(compgen -W "startcol" -- $cur) )
+			;;
+		2)
+			COMPREPLY=( $(compgen -W "endcol" -- $cur) )
+			;;
+	esac
+	return 0
+}
+complete -F _colrm_module colrm
diff --git a/shell-completion/column b/shell-completion/column
new file mode 100644
index 0000000..94e1a51
--- /dev/null
+++ b/shell-completion/column
@@ -0,0 +1,34 @@
+_column_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-c'|'--columns')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+		'-s'|'--separator'|'-o'|'--output-separator')
+			COMPREPLY=( $(compgen -W "string" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-c --columns
+				-t --table
+				-s --separator
+				-o --output-separator
+				-x --fillrows
+				-h --help
+				-V --version"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _column_module column
diff --git a/shell-completion/hexdump b/shell-completion/hexdump
new file mode 100644
index 0000000..1a6786b
--- /dev/null
+++ b/shell-completion/hexdump
@@ -0,0 +1,32 @@
+_hexdump_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-e')
+			COMPREPLY=( $(compgen -W "format" -- $cur) )
+			return 0
+			;;
+		'-n')
+			COMPREPLY=( $(compgen -W "length" -- $cur) )
+			return 0
+			;;
+		'-s')
+			COMPREPLY=( $(compgen -W "offset" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-b -c -C -d -o -x -e -f -n -s -v -V"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _hexdump_module hexdump
diff --git a/shell-completion/more b/shell-completion/more
new file mode 100644
index 0000000..f32770d
--- /dev/null
+++ b/shell-completion/more
@@ -0,0 +1,22 @@
+_more_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-d -f -l -p -c -u -s -number -V"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+		+*)
+			OPTS="+number +/string"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _more_module more
diff --git a/shell-completion/pg b/shell-completion/pg
new file mode 100644
index 0000000..4ae8887
--- /dev/null
+++ b/shell-completion/pg
@@ -0,0 +1,29 @@
+_pg_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-p')
+			COMPREPLY=( $(compgen -W "prompt" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-number -c -e -f -n -p -r -s -h -V"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+		+*)
+			OPTS="+number +/pattern/"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _pg_module pg
diff --git a/shell-completion/rev b/shell-completion/rev
new file mode 100644
index 0000000..f891f19
--- /dev/null
+++ b/shell-completion/rev
@@ -0,0 +1,17 @@
+_rev_module()
+{
+	local cur OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	case $cur in
+		-*)
+			OPTS="-V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _rev_module rev
diff --git a/shell-completion/tailf b/shell-completion/tailf
new file mode 100644
index 0000000..29c5bed
--- /dev/null
+++ b/shell-completion/tailf
@@ -0,0 +1,24 @@
+_tailf_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-n'|'--lines')
+			COMPREPLY=( $(compgen -W "number" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-n --lines -number -V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _tailf_module tailf
diff --git a/shell-completion/ul b/shell-completion/ul
new file mode 100644
index 0000000..89e2800
--- /dev/null
+++ b/shell-completion/ul
@@ -0,0 +1,25 @@
+_ul_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-t'|'--terminal')
+			# FIXME: terminal type list would be nice
+			COMPREPLY=( $(compgen -W "vt100 xterm linux screen etc" -- $cur) )
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="-t --terminal -i --indicated -V --version -h --help"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	compopt -o filenames
+	COMPREPLY=( $(compgen -f -- $cur) )
+	return 0
+}
+complete -F _ul_module ul
-- 
1.8.2

