Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:40541 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab3IMAtB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Sep 2013 20:49:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id A0B5733EBB9
	for <util-linux@vger.kernel.org>; Fri, 13 Sep 2013 00:49:00 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] bash-completion: fix typos in mkfs.bfs logic
Date: Thu, 12 Sep 2013 20:49:04 -0400
Message-Id: <1379033344-3616-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no "bfs" command.  Change this file to match the other
mkfs files where we have a "mkfs." prefix.

Reported-by: Michał Górny <mgorny@gentoo.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 bash-completion/mkfs.bfs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bash-completion/mkfs.bfs b/bash-completion/mkfs.bfs
index 8adbc60..4f2923d 100644
--- a/bash-completion/mkfs.bfs
+++ b/bash-completion/mkfs.bfs
@@ -1,4 +1,4 @@
-_bfs_module()
+_mkfs.bfs_module()
 {
 	local cur prev OPTS DEVS
 	COMPREPLY=()
@@ -28,4 +28,4 @@ _bfs_module()
 	COMPREPLY=( $(compgen -W "$DEVS /path/to/file" -- $cur) )
 	return 0
 }
-complete -F _bfs_module bfs
+complete -F _mkfs.bfs_module mkfs.bfs
-- 
1.8.3.2

