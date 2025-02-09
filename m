Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DE6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089467; cv=none; b=Y8rPyHHe5UVdyfk1uhQv9apkSRLtWMNE77FF7j89YQLp2CKsVmMiC0CHJGlLrpexBfjSkbqqIKNFmexVj81CzIoTbicuWKGgziaUQ6WwCocQA+lBhUZJnO0z9ShFLix5S1rnkwDAfHmM5CG0x0qxXafhHAtq40OK1EgzErV2E20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089467; c=relaxed/simple;
	bh=0cMxMWkiulkTWAMQ797WO7tPp5vEW+KIKfwYn0bSX28=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URcQquFxGGeYckKChV8VsdB84qv4+Y+qWFGux6MUPn40qAkfTvdz6TTCQm5RnwrXbhD8a4tUvRqwCLlcbgEfyuG1Rbwdx/5SjKKdOrh+Jnwf9DEFWoP2MSa2nCSIhHHQ7LLdFgS73qaVNGeCMfLC/6V3v/qNohb/xhktFTXIz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=HbCAYP7d; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="HbCAYP7d"
X-KPN-MessageId: 81ea71d8-e6bf-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 81ea71d8-e6bf-11ef-aff5-005056abad63;
	Sun, 09 Feb 2025 09:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=f/ve1m2O28IfnrHI2b1AYPIa6SzmJdE/+Oh8r+CddCs=;
	b=HbCAYP7dn8CTLQUD4edxkD+6Mv6DybWKTpCW+i+lGWAsDEmYTwmMt9KiZpy5jgZY8kmo0a1rzlCbI
	 KDlfLkYy9TZd8G9IjSn9Ds4HVHqAcdhO1YpF/K0zaWVx2m7cfmyhEySPMD27v865rQD3zO3xF1r4rH
	 y7rlFXPHPy2NFhRs=
X-KPN-MID: 33|RzqRuScKuCW/RUvP56pSTYsKHx3PcnlBma91Rkp6ar4PIrHCtH+XRKozklxl9Ur
 PX81n2Y+RXVOvt4umAt+LCnUSq6bYSJhms16KLUx7YXc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ghvXNllP/QZrbf5Y4BMJhFxfq3Mw7Xa8vySPrhTjF453NQe5l0gW9jrwtEaq9mH
 8CV9it9bpGlqy+MN0DdrF/w==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 410adb77-e6bf-11ef-a31b-005056abf0db;
	Sun, 09 Feb 2025 09:24:17 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/14] textual: remove other inconsistent uses of "=" before option argument
Date: Sun,  9 Feb 2025 09:23:20 +0100
Message-ID: <20250209082330.4235-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And remove inconsistent uses of double asterisks too.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 login-utils/lslogins.1.adoc |  4 ++--
 login-utils/su.1.adoc       | 10 +++++-----
 sys-utils/mount.8.adoc      |  2 +-
 sys-utils/wdctl.8.adoc      |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/login-utils/lslogins.1.adoc b/login-utils/lslogins.1.adoc
index 6371c2d00..4aeef7cf8 100644
--- a/login-utils/lslogins.1.adoc
+++ b/login-utils/lslogins.1.adoc
@@ -46,7 +46,7 @@ Display data about the users' last failed login attempts.
 *-G*, *--supp-groups*::
 Show information about supplementary groups.
 
-*-g*, **--groups**=_groups_::
+*-g*, *--groups* _groups_::
 Only show data of users belonging to _groups_. More than one group may be specified; the list has to be comma-separated. Unknown group names are ignored.
 +
 Note that the relation between user and group may be invisible for the primary group if the user is not explicitly specified as group member (e.g., in _/etc/group_). If the command *lslogins* scans for groups then it uses the groups database only, and the user database with primary GID is not used at all.
@@ -54,7 +54,7 @@ Note that the relation between user and group may be invisible for the primary g
 *-L*, *--last*::
 Display data containing information about the users' last login sessions.
 
-*-l*, **--logins**=_logins_::
+*-l*, *--logins* _logins_::
 Only show data of users with a login specified in _logins_ (user names or user IDs). More than one login may be specified; the list has to be comma-separated. Unknown login names are ignored.
 
 *-n*, *--newline*::
diff --git a/login-utils/su.1.adoc b/login-utils/su.1.adoc
index 33f45833f..866139755 100644
--- a/login-utils/su.1.adoc
+++ b/login-utils/su.1.adoc
@@ -33,16 +33,16 @@ Since version 2.38 *su* resets process resource limits RLIMIT_NICE, RLIMIT_RTPRI
 
 == OPTIONS
 
-*-c*, **--command**=__command__::
+*-c*, *--command* __command__::
 Pass _command_ to the shell with the *-c* option.
 
 *-f*, *--fast*::
 Pass *-f* to the shell, which may or may not be useful, depending on the shell.
 
-*-g*, **--group**=__group__::
+*-g*, *--group* __group__::
 Specify the primary group. This option is available to the root user only.
 
-*-G*, **--supp-group**=__group__::
+*-G*, *--supp-group* __group__::
 Specify a supplementary group. This option is available to the root user only. The first specified supplementary group is also used as a primary group if the option *--group* is not specified.
 
 *-*, *-l*, *--login*::
@@ -68,7 +68,7 @@ Create a pseudo-terminal for the session. The independent terminal provides bett
 +
 This feature is mostly designed for interactive sessions. If the standard input is not a terminal, but for example a pipe (e.g., *echo "date" | su --pty*), then the *ECHO* flag for the pseudo-terminal is disabled to avoid messy output.
 
-*-s*, **--shell**=__shell__::
+*-s*, *--shell* __shell__::
 Run the specified _shell_ instead of the default. If the target user has a restricted shell (i.e., not listed in _/etc/shells_), the *--shell* option and the *SHELL* environment variables are ignored unless the calling user is root.
 +
 The shell to run is selected according to the following rules, in order:
@@ -85,7 +85,7 @@ Same as *-c*, but do not create a new session. (Discouraged.)
 Do not create a pseudo-terminal, opposite of *--pty* and *-P*.
 Note that running without a pseudo-terminal opens the security risk of privilege escalation through TIOCSTI/TIOCLINUX ioctl command injection.
 
-*-w*, **--whitelist-environment**=__list__::
+*-w*, *--whitelist-environment* __list__::
 Don't reset the environment variables specified in the comma-separated _list_ when clearing the environment for *--login*. The whitelist is ignored for the environment variables *HOME*, *SHELL*, *USER*, *LOGNAME*, and *PATH*.
 
 include::man-common/help-version.adoc[]
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 92ff15dfb..08a2e731c 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -345,7 +345,7 @@ Add the labels in the mount output. *mount* must have permission to read the dis
 *-M*, *--move*::
 Move a subtree to some other place. See above, the subsection *The move operation*.
 
-*-m*, **--mkdir**[=__mode__]::
+*-m*, *--mkdir*[**=**__mode__]::
 Allow to make a target directory (mountpoint) if it does not exist yet. Alias to "-o X-mount.mkdir[=mode]", the default mode is 0755. For more details see *X-mount.mkdir* below.
 
 *--map-groups*, *--map-users* _inner_:_outer_:_count_::
diff --git a/sys-utils/wdctl.8.adoc b/sys-utils/wdctl.8.adoc
index 6eb44e5d8..5fec3584e 100644
--- a/sys-utils/wdctl.8.adoc
+++ b/sys-utils/wdctl.8.adoc
@@ -46,7 +46,7 @@ Print all wanted information on one line in key="value" output format.
 Set the watchdog pre-timeout in seconds. A watchdog pre-timeout is a
 notification generated by the watchdog before the watchdog reset might occur in
 the event the watchdog has not been serviced. This notification is handled by
-the kernel and can be configured to take an action using sysfs or by **--setpregovernor**.
+the kernel and can be configured to take an action using sysfs or by *--setpregovernor*.
 
 *-g*, *--setpregovernor* _governor_::
 Set pre-timeout governor name. For available governors see default **wdctl** output.
-- 
2.48.1

