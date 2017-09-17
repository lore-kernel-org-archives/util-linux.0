Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35282 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdIQStK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Sep 2017 14:49:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id e64so6943627wmi.2
        for <util-linux@vger.kernel.org>; Sun, 17 Sep 2017 11:49:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] bash-completion: update uuidgen, wipefs, tunelp, setpriv, and hwclock
Date: Sun, 17 Sep 2017 19:49:02 +0100
Message-Id: <20170917184902.1218-3-kerolasa@iki.fi>
In-Reply-To: <20170917184902.1218-1-kerolasa@iki.fi>
References: <20170917184902.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

uuidgen: Add hash-based UUIDs to bash-completion.  These were added in
commit c6f1ec68a8b38863efff2a18e30b7272db4fb273.

wipefs: Command started to use libsmartcols, and it got some new options.
Commit d9921b2a128f17aa9a9a110444d5faa43e1b371c.

rename: New option was added in commit fabb90676af89bcb5f429793746f141c0.

tunelp: The --trust-irq was removed it being years broken.  Commit
d52eb4bd9062081c8420b22c029c694f29d036c7.

setpriv: Add --ambient-caps option from commit 0c92194eeee9c1fd58580ef852.
In same go fix 'bash set -u' issue, that is the same as mentioned commit
abbcec4fc9c8d7fb835b4eafd1bc9d82acbf0056.

hwclock: For some reason --get has always been missing from this file.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/hwclock |  1 +
 bash-completion/rename  |  2 +-
 bash-completion/setpriv |  5 +++--
 bash-completion/tunelp  |  3 +--
 bash-completion/uuidgen | 20 +++++++++++++++++++-
 bash-completion/wipefs  | 19 ++++++++++++++++++-
 6 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/bash-completion/hwclock b/bash-completion/hwclock
index b90f00c0c..4bd87e42e 100644
--- a/bash-completion/hwclock
+++ b/bash-completion/hwclock
@@ -27,6 +27,7 @@ _hwclock_module()
 		-*)
 			OPTS="--help
 				--show
+				--get
 				--set
 				--hctosys
 				--systohc
diff --git a/bash-completion/rename b/bash-completion/rename
index 06a7dcd4d..143121976 100644
--- a/bash-completion/rename
+++ b/bash-completion/rename
@@ -11,7 +11,7 @@ _rename_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--verbose --symlink --help --version --no-act"
+			OPTS="--verbose --symlink --help --version --no-act --no-override"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/setpriv b/bash-completion/setpriv
index bdd3b7dab..8ab9e0722 100644
--- a/bash-completion/setpriv
+++ b/bash-completion/setpriv
@@ -5,14 +5,14 @@ _setpriv_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
-		'--inh-caps'|'--bounding-set')
+		'--ambient-caps'|'--inh-caps'|'--bounding-set')
 			local prefix realcur INHERIT_ALL INHERIT
 			realcur="${cur##*,}"
 			prefix="${cur%$realcur}"
 			INHERIT_ALL=$($1 --list-caps| awk '{print $1, "-" $1}')
 			for WORD in $INHERIT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
-					INHERIT="$WORD $INHERIT"
+					INHERIT="$WORD ${INHERIT:-""}"
 				fi
 			done
 			compopt -o nospace
@@ -70,6 +70,7 @@ _setpriv_module()
 		-*)
 			OPTS="--dump
 				--no-new-privs
+				--ambient-caps
 				--inh-caps
 				--bounding-set
 				--ruid
diff --git a/bash-completion/tunelp b/bash-completion/tunelp
index bd2cce2aa..2be3d544d 100644
--- a/bash-completion/tunelp
+++ b/bash-completion/tunelp
@@ -17,7 +17,7 @@ _tunelp_module()
 			COMPREPLY=( $(compgen -W "microseconds" -- $cur) )
 			return 0
 			;;
-		'-a'|'--abort'|'-o'|'--check-status'|'-C'|'--careful'|'-T'|'--trust-irq'|'-q'|'--print-irq')
+		'-a'|'--abort'|'-o'|'--check-status'|'-C'|'--careful'|'-q'|'--print-irq')
 			COMPREPLY=( $(compgen -W "off on" -- $cur) )
 			return 0
 			;;
@@ -35,7 +35,6 @@ _tunelp_module()
 				--check-status
 				--careful
 				--status
-				--trust-irq
 				--reset
 				--print-irq
 				--help
diff --git a/bash-completion/uuidgen b/bash-completion/uuidgen
index 42d95d42f..8e64015c0 100644
--- a/bash-completion/uuidgen
+++ b/bash-completion/uuidgen
@@ -5,13 +5,31 @@ _uuidgen_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-n'|'--namespace')
+			COMPREPLY=( $(compgen -W "@dns @url @oid @x500 @x.500" -- "$cur") )
+			return 0
+			;;
+		'-N'|'--name')
+			COMPREPLY=( $(compgen -W "name" -- "$cur") )
+			return 0
+			;;
 		'-h'|'--help'|'-V'|'--version')
 			return 0
 			;;
 	esac
 	case $cur in
 		-*)
-			OPTS="--random --time --version --help"
+			OPTS="
+				--random
+				--time
+				--namespace
+				--name
+				--md5
+				--sha1
+				--hex
+				--help
+				--version
+			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index 577819182..13568ca32 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -5,6 +5,20 @@ _wipefs_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-O'|'--output')
+			local prefix realcur OUTPUT_ALL OUTPUT
+			realcur="${cur##*,}"
+			prefix="${cur%$realcur}"
+			OUTPUT_ALL="UUID LABEL LENGTH TYPE OFFSET USAGE DEVICE"
+			for WORD in $OUTPUT_ALL; do
+				if ! [[ $prefix == *"$WORD"* ]]; then
+					OUTPUT="$WORD ${OUTPUT:-""}"
+				fi
+			done
+			compopt -o nospace
+			COMPREPLY=( $(compgen -P "$prefix" -W "$OUTPUT" -S ',' -- $realcur) )
+			return 0
+			;;
 		'-o'|'--offset')
 			COMPREPLY=( $(compgen -W "offset" -- $cur) )
 			return 0
@@ -25,12 +39,15 @@ _wipefs_module()
 				--all
 				--backup
 				--force
-				--help
+				--noheadings
+				--json
 				--no-act
 				--offset
+				--output
 				--parsable
 				--quiet
 				--types
+				--help
 				--version
 			"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
-- 
2.14.1

