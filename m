Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E650276
	for <util-linux@vger.kernel.org>; Sun,  8 Mar 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772968831; cv=none; b=pyV6PeRLgpBfj0zlSsaLpXxLaW+fyxu2P5AB89uvyVnGUDCGduIQqx6Js5FVPindQgz8mI0U5dFVgWSApBano/aX+uPHk/TU8YMpbyrjgj0AX4WHWmpNKgOpnBTT6hFLG1llpSe/JxY+TURDcpeR08Sb6tMl1LF5ZFggBqw4uC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772968831; c=relaxed/simple;
	bh=eUPYzRxstE1mgmmGoBdnVAIVBPsfUqFzk+c4RJ523Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lf6eX+G8zF1qHSA71ULk3zZTozcBz8xKjHAZVHZ+MLRIF0B548B86m2nwcZDFGDWP/pD9+mT7qVSVlf12duvM1iyBmNg1DfMIqD8mq0mdWepqsDV4H64g3zCDC+9jI8nFIzTgFVONoO3cAOHW9nxclunZhCxp0RFKlyjnzTGWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=RGV3YFdr; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="RGV3YFdr"
X-KPN-MessageId: cbcbfac3-1ae0-11f1-92a5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cbcbfac3-1ae0-11f1-92a5-005056aba152;
	Sun, 08 Mar 2026 12:20:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=+VRZnb1kjdf/Epbplak1r9KUQ4WC0ztuTw8ziUAuIdc=;
	b=RGV3YFdrLo1wZJnyrtEj3Sj9wN1IjZQOskf2BvgvP0GiuMil+Bdjspzu6el7XHqN8rkYxb62ecVxy
	 f1dY5fNKUYbsRiS3YzvVLXwgAIDKNYwgFGhVMPLQ6GloT73yhgewTDUXJ69ku2bpBCao7ToBp93buW
	 RM16uWUnoSGfVEXg=
X-KPN-MID: 33|vOCYXUUn0WjB/uLCFMLVCrUKdSSOSuTdpYnw1dPd2ZzxDeWCeX3GncExjJhaD49
 zPpebHerwX1GM4SzkRbsaxDZqPk1C4iY7BEPXDjoMQ+k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Y+jIcxA3shRZqC/ZsZmePCeoJa6cs/tvqFzhvkXu1FCqFYf3k7HS72z5W4GBeFW
 h68Qfn3Q4F9uqlJpg3nnIBw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id cbc60a1a-1ae0-11f1-a6cb-005056abf0db;
	Sun, 08 Mar 2026 12:20:22 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Xiao Liang <shaw.leon@gmail.com>,
	Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Subject: [PATCH 3/3] nsenter: (man) correct the markup and improve the formatting
Date: Sun,  8 Mar 2026 12:20:04 +0100
Message-ID: <20260308112004.9206-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308112004.9206-1-bensberg@telfort.nl>
References: <20260308112004.9206-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the mistaken angle brackets that were introduced last month
by commit f2a5997869, add the missing equals sign, and put both it
and the subsequent colon in bold as they are literal characters.

Also, indent the list of paths to make it clearer where it ends,
and so that the subsequent paragraph gets indented correctly.

CC: Xiao Liang <shaw.leon@gmail.com>
CC: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/nsenter.1.adoc | 45 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/sys-utils/nsenter.1.adoc b/sys-utils/nsenter.1.adoc
index 9e5bc81da..34fde93ac 100644
--- a/sys-utils/nsenter.1.adoc
+++ b/sys-utils/nsenter.1.adoc
@@ -59,9 +59,10 @@ by namespace-specific options (e.g., **--all --mount=**_path_).
 +
 The user namespace will be ignored if it is the same as the caller's current user namespace. It prevents a caller that has dropped capabilities from regaining those capabilities via a call to *setns*(2). See the man page for more details.
 
-*-t*, *--target* _PID[:inode]_::
+*-t*, *--target* _PID_[**:**_inode_]::
 Specify a target process to get contexts from. The paths to the contexts specified by _PID_ are:
-
++
+____
 _/proc/pid/ns/mnt_;;
 the mount namespace
 _/proc/pid/ns/uts_;;
@@ -82,41 +83,41 @@ _/proc/pid/root_;;
 the root directory
 _/proc/pid/cwd_;;
 the working directory respectively
-
-Optionally, a process can be addressed with the format _PID:inode_. The _inode_
+____
+Optionally, a process can be addressed with the format _PID_**:**_inode_. The _inode_
 identifies the unique process's file descriptor. To retrieve a process's inode
 number you can use the *getino*(1) utility.
 
-*-m*, *--mount*[**=**<__file__|:__nsid__>]::
-Enter the mount namespace. If no argument is specified, enter the mount namespace of the target process. If _file_ or :__nsid__ is specified, enter the mount namespace specified by _file_ or _nsid_.
+*-m*, *--mount*[**=**_file_|**=:**_nsid_]::
+Enter the mount namespace. If no argument is specified, enter the mount namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the mount namespace specified by _file_ or _nsid_.
 
-*-u*, *--uts*[**=**<__file__|:__nsid__>]::
-Enter the UTS namespace. If no argument is specified, enter the UTS namespace of the target process. If _file_ or :__nsid__ is specified, enter the UTS namespace specified by _file_ or _nsid_.
+*-u*, *--uts*[**=**_file_|**=:**_nsid_]::
+Enter the UTS namespace. If no argument is specified, enter the UTS namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the UTS namespace specified by _file_ or _nsid_.
 
-*-i*, *--ipc*[**=**<__file__|:__nsid__>]::
-Enter the IPC namespace. If no argument is specified, enter the IPC namespace of the target process. If _file_ or :__nsid__ is specified, enter the IPC namespace specified by _file_ or _nsid_.
+*-i*, *--ipc*[**=**_file_|**=:**_nsid_]::
+Enter the IPC namespace. If no argument is specified, enter the IPC namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the IPC namespace specified by _file_ or _nsid_.
 
-*-n*, *--net*[**=**<__file__|:__nsid__>]::
-Enter the network namespace. If no argument is specified, enter the network namespace of the target process. If _file_ or :__nsid__ is specified, enter the network namespace specified by _file_ or _nsid_.
+*-n*, *--net*[**=**_file_|**=:**_nsid_]::
+Enter the network namespace. If no argument is specified, enter the network namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the network namespace specified by _file_ or _nsid_.
 
 *-N*, *--net-socket* _fd_::
 Enter the network namespace of the target process's socket. It requires *--target* process specified. Supported since Linux 5.6.
 
-*-p*, *--pid*[**=**<__file__|:__nsid__>]::
-Enter the PID namespace. If no argument is specified, enter the PID namespace of the target process. If _file_ or :__nsid__ is specified, enter the PID namespace specified by _file_ or _nsid_.
+*-p*, *--pid*[**=**_file_|**=:**_nsid_]::
+Enter the PID namespace. If no argument is specified, enter the PID namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the PID namespace specified by _file_ or _nsid_.
 
-*-U*, *--user*[**=**<__file__|:__nsid__>]::
-Enter the user namespace. If no argument is specified, enter the user namespace of the target process. If _file_ or :__nsid__ is specified, enter the user namespace specified by _file_ or _nsid_. See also the *--setuid* and *--setgid* options.
+*-U*, *--user*[**=**_file_|**=:**_nsid_]::
+Enter the user namespace. If no argument is specified, enter the user namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the user namespace specified by _file_ or _nsid_. See also the *--setuid* and *--setgid* options.
 
 *--user-parent*::
 Enter the parent user namespace. Parent user namespace will be acquired from any other enabled namespace.
 If combined with *--user* option the parent user namespace will be fetched from the user namespace and replace it.
 
-*-C*, *--cgroup*[**=**<__file__|:__nsid__>]::
-Enter the cgroup namespace. If no argument is specified, enter the cgroup namespace of the target process. If _file_ or :__nsid__ is specified, enter the cgroup namespace specified by _file_ or _nsid_.
+*-C*, *--cgroup*[**=**_file_|**=:**_nsid_]::
+Enter the cgroup namespace. If no argument is specified, enter the cgroup namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the cgroup namespace specified by _file_ or _nsid_.
 
-*-T*, *--time*[**=**<__file__|:__nsid__>]::
-Enter the time namespace. If no argument is specified, enter the time namespace of the target process. If _file_ or :__nsid__ is specified, enter the time namespace specified by _file_ or _nsid_.
+*-T*, *--time*[**=**_file_|**=:**_nsid_]::
+Enter the time namespace. If no argument is specified, enter the time namespace of the target process. If _file_ or **:**_nsid_ is specified, enter the time namespace specified by _file_ or _nsid_.
 
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
@@ -161,8 +162,8 @@ include::man-common/help-version.adoc[]
 
 The *--user-parent* option requires Linux 4.9 or higher, older kernels will raise inappropriate ioctl for device error.
 
-Specifying namespaces by _nsid_ requires Linux 6.19 or higher. If a namespace
-file name starts with a colon, prepend "./" for disambiguation.
+Specifying namespaces by _nsid_ requires Linux 6.19 or higher.
+If a namespace _file_ name starts with a colon, prepend *./* for disambiguation.
 
 == AUTHORS
 
-- 
2.53.0

