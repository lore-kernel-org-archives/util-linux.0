Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f52.google.com ([209.85.215.52]:32946 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759716AbbFBR7V (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Jun 2015 13:59:21 -0400
Received: by labpy14 with SMTP id py14so119934772lab.0
        for <util-linux@vger.kernel.org>; Tue, 02 Jun 2015 10:59:20 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 3/3] bash-completion: remove unused variables [shellcheck]
Date: Tue,  2 Jun 2015 23:59:03 +0600
Message-Id: <1433267943-2276-4-git-send-email-egorov@linux.com>
In-Reply-To: <1433267943-2276-1-git-send-email-egorov@linux.com>
References: <1433267943-2276-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix shellcheck SC2034 warnings.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 bash-completion/addpart    | 2 +-
 bash-completion/fsck       | 2 +-
 bash-completion/fsck.minix | 2 +-
 bash-completion/lsblk      | 1 -
 bash-completion/mkfs       | 2 +-
 bash-completion/mkfs.bfs   | 2 +-
 bash-completion/mkfs.minix | 1 -
 7 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/bash-completion/addpart b/bash-completion/addpart
index e9ed793..3179639 100644
--- a/bash-completion/addpart
+++ b/bash-completion/addpart
@@ -1,6 +1,6 @@
 _addpart_module()
 {
-	local cur prev
+	local cur
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	case $COMP_CWORD in
diff --git a/bash-completion/fsck b/bash-completion/fsck
index d61b37f..301bb5d 100644
--- a/bash-completion/fsck
+++ b/bash-completion/fsck
@@ -1,6 +1,6 @@
 _fsck_module()
 {
-	local cur prev OPTS DEVS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
diff --git a/bash-completion/fsck.minix b/bash-completion/fsck.minix
index 4ed5110..b2b2860 100644
--- a/bash-completion/fsck.minix
+++ b/bash-completion/fsck.minix
@@ -1,6 +1,6 @@
 _fsck.minix_module()
 {
-	local cur prev OPTS DEVS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 1692dad..e32f371 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -81,7 +81,6 @@ _lsblk_module()
 			return 0
 			;;
 	esac
-	local DEVS
 	COMPREPLY=( $(compgen -W "$($1 -pnro name)" -- $cur) )
 	return 0
 }
diff --git a/bash-completion/mkfs b/bash-completion/mkfs
index 4edc6f0..a278747 100644
--- a/bash-completion/mkfs
+++ b/bash-completion/mkfs
@@ -1,6 +1,6 @@
 _mkfs_module()
 {
-	local cur prev OPTS DEVS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 1bd67a0..75458bb 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -1,6 +1,6 @@
 _mkfs.bfs_module()
 {
-	local cur prev OPTS DEVS
+	local cur prev OPTS
 	COMPREPLY=()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
diff --git a/bash-completion/mkfs.minix b/bash-completion/mkfs.minix
index c84a237..3a3602e 100644
--- a/bash-completion/mkfs.minix
+++ b/bash-completion/mkfs.minix
@@ -28,7 +28,6 @@ _mkfs.minix_module()
 			return 0
 			;;
 	esac
-	local DEVS
 	COMPREPLY=( $(compgen -W "$(lsblk -pnro name)" -- $cur) )
 	return 0
 }
-- 
2.1.4

